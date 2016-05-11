/**
 * .
 */
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>


static const char *file_id="$Id: pmc-ecc.c 7 2013-01-03 18:13:39Z joymarquis@gmail.com $";

void usage_exit(int errno, char *me)
{
	if (me) {
		printf(
				"Usage: \n"
				"  %s create OUT_FILE <ecc|ff> LEN_HEX\n"
				"  %s fill PART_FILE OFF_BEGIN_HEX OFF_END_HEX\n"
				"\n"
				"Generate/update block for ECC enabled flash image\n"
				"\n"
				"Example:\n"
				"  %s create block.dat 0x003e0000\n"
				"  %s fill block.dat boot_cfg.part 0x00200000 0x0020ffff\n"
				"  %s fill block.dat boot_mips.part 0x00000000 0x00017fff\n"
				"  %s fill block.dat istr_flash.part 0x00020000 0x0002ffff\n"
				"  %s fill block.dat istr_flash.part 0x00220000 0x0022ffff\n"
				"  %s fill block.dat sxp_evbd_rom.part 0x00040000 0x001dffff\n"
				"  %s fill block.dat sxp_evbd_rom.part 0x00240000 0x003dffff\n"
				"\n"
				"\t%s\n",
				me, me,
				me, me, me, me, me, me, me,
				file_id);
	}
	exit(errno);
}

void err_msg(char *msg)
{
	if (msg) {
		printf("Error: %s\n", msg);
	}
}

void hexdump(unsigned char *buf, int buf_len, int cols, int group, char *info)
{
	int i;

return;
	if (info) {
		printf("hexdump: %s (%d)\n", info, buf_len);
	}

	for (i = 0; i < buf_len; i++) {
		if (i != 0) {
			if (i % group == 0) {
				printf(" ");
			}
			if (i % cols == 0) {
				printf("\n");
			}
		}
		printf("%02x", buf[i]);
	}
	printf("\n");
}

unsigned long la2pa(unsigned long la)
{
	unsigned long pa;

	pa = ((la % 24) / 4) * 5 + (la / 24) * 32;
	return pa;
}

unsigned long pa2la(unsigned long pa)
{
	unsigned long la;

	la = (pa / 32) * 24 + ((pa % 32) / 5) * 4;
	return la;
}

unsigned long ecc_table[7] = {
	0x4b2e4b2e, 0x15571557,
	0xa699a699, 0x38e338e3,
	0xc0fcc0fc, 0xff00ff00,
	0xff0000ff,
};


unsigned char ecc_calc(unsigned long data)
{
	unsigned char ecc = 0;
	unsigned long bit_cnt;
	int i;
	int j;

	for (i = 0; i < 7; i++) {
		bit_cnt = 0;
		for (j = 0; j < 32; j++) {
			if (ecc_table[i] & ( 1 << j)) {
				bit_cnt ^= (data >> j) & 0x1;
			}
			//		printf("    %x-%d(%d)\n", data, ecc, bit_cnt);
		}
		//		printf("  %x-%d(%d)\n", data, ecc, bit_cnt);
		ecc |= bit_cnt << i;
	}

	return ecc;
}

int ecc_calc_self_test(void)
{
	int ret = 0;
	unsigned char ecc;

	ecc = ecc_calc(0x40096000);	// 77
	if (ecc != 0x77) {
		err_msg("self_test failed");
		ret++;
	}
	ecc = ecc_calc(0x3c080008);	// 49
	if (ecc != 0x49) {
		err_msg("self_test failed");
		ret++;
	}
	ecc = ecc_calc(0x01094024);	// 43
	if (ecc != 0x43) {
		err_msg("self_test failed");
		ret++;
	}
	ecc = ecc_calc(0x11000004);	// 5a
	if (ecc != 0x5a) {
		err_msg("self_test failed");
		ret++;
	}

	return ret;
}

/* block_len shall be 24 aligned, error if not */
int ecc_block_fill(unsigned char *ecc_block, unsigned int ecc_block_len,
		unsigned char *part, unsigned int part_len,
		unsigned int off_begin, unsigned int off_end)
{
	unsigned int ecc_off_begin = la2pa(off_begin);
	unsigned int ecc_off_curr;
	unsigned long data;
	unsigned char tmp;
	int ret = 0;
	int i;
	int j;

	if ((off_begin % 8 != 0) || (off_end + 1) % 8 != 0) {
		err_msg("offset bondary should be 8 bytes aligned");
		ret--;
	}
	if (off_end + 1 > pa2la(ecc_block_len)) {
		err_msg("partition end offset out of range");
		ret--;
	}
	if (off_begin > off_end) {
		err_msg("partition begin offset larger than end offset");
		ret--;
	}
	if (part_len != (off_end - off_begin + 1)) {
		err_msg("partition data and size mismatch");
		ret--;
	}

	if (ret) {
		return ret;
	}

	/* fill 0xffff in ecc_block for data in range */
	for (i = ecc_off_begin / 32 * 32; i < la2pa(off_end + 1) / 32 * 32; i += 32) {
		if (i + 31 < ecc_block_len) {
			ecc_block[i + 30] = 0xff;
			ecc_block[i + 31] = 0xff;
		}
	}

	/* add ecc in ecc_block for part */
	for (i = 0; i < part_len; i += 4) {
		data = part[i];
		data += part[i + 1] << 8;
		data += part[i + 2] << 16;
		data += part[i + 3] << 24;
		tmp = ecc_calc(data);
		ecc_off_curr = la2pa(off_begin + i);
		for (j = 0; j < 4; j++) {
			ecc_block[ecc_off_curr + j] = part[i + j];
		}
		ecc_block[ecc_off_curr + 4] = tmp;
	}

	hexdump(ecc_block, ecc_block_len, 32, 4, "ecc_block");

	return 0;
}

int main(int argc, char *argv[])
{
	int ret;
	int ecc_fd;
	int part_fd;
	struct stat s;
	unsigned char *ecc_block;
	int ecc_block_len;
	unsigned char *tmp_block;
	int tmp_block_len;
	unsigned char *part;
	int part_len;
	int off_begin;
	int off_end;

	if (argc < 4) {
		usage_exit(1, argv[0]);
	}

	ret = 0;
	ecc_fd = 0;
	part_fd = 0;

	do {
		if (strcmp(argv[1], "create") == 0) {
			if (argc != 4) {
				ret = -1;
				break;
			}
			ecc_fd = open(argv[2], O_RDWR | O_CREAT | O_TRUNC, S_IRWXU|S_IRWXG);
			if (ecc_fd <= 0) {
				err_msg("failed open file");
				ret = -1;
				break;
			}
			tmp_block_len = strtol(argv[3], NULL, 16);
			if (tmp_block_len <= 0) {
				err_msg("incorrect length");
				ret = -1;
				break;
			}
			ecc_block_len = la2pa(tmp_block_len);
			tmp_block = malloc(tmp_block_len);
			ecc_block = malloc(ecc_block_len);
			memset(tmp_block, 0xff, tmp_block_len);
			memset(ecc_block, 0x00, ecc_block_len);

			ecc_block_fill(ecc_block, ecc_block_len, tmp_block, tmp_block_len, 0, tmp_block_len - 1);
			write(ecc_fd, ecc_block, ecc_block_len);
		} else if (strcmp(argv[1], "fill") == 0) {
			ecc_fd = open(argv[2], O_RDWR);
			if (ecc_fd <= 0) {
				err_msg("failed open file");
				ret = -1;
				break;
			}
			part_fd = open(argv[3], O_RDONLY);
			if (part_fd <= 0) {
				err_msg("failed open file");
				ret = -1;
				break;
			}

			ret = fstat(ecc_fd, &s);
			if (ret != 0) {
				err_msg("fstat ecc fd failed");
				ret = -1;
				break;
			}
			ecc_block_len = s.st_size;
			ecc_block = malloc(ecc_block_len);
			ret = read(ecc_fd, ecc_block, ecc_block_len);
			if (ret != ecc_block_len) {
				err_msg("read ecc block failed");
				ret = -1;
				break;
			}
			
			ret = fstat(part_fd, &s);
			if (ret != 0) {
				err_msg("fstat part fd failed");
				ret = -1;
				break;
			}
			part_len = s.st_size;
			part = malloc(part_len);
			ret = read(part_fd, part, part_len);
			if (ret != part_len) {
				err_msg("read part failed");
				ret = -1;
				break;
			}
			off_begin = strtol(argv[4], NULL, 16);
			off_end = strtol(argv[5], NULL, 16);
			if ((off_begin < 0) || (off_end < 0)) {
				err_msg("incorrect offset");
				ret = -1;
				break;
			}
			ecc_block_fill(ecc_block, ecc_block_len, part, part_len, off_begin, off_end);
			lseek(ecc_fd, 0, SEEK_SET);
			write(ecc_fd, ecc_block, ecc_block_len);
		} else {
			usage_exit(1, argv[0]);
		}
	} while (0);

	if (ecc_fd > 0) {
		close(ecc_fd);
	}
	if (part_fd > 0) {
		close(part_fd);
	}
	return ret;



	{
		unsigned char *tmp_block;
		int tmp_block_len = 24;
		unsigned char *ecc_block;
		int ecc_block_len = la2pa(tmp_block_len);
		unsigned char *part;
		int part_len = 8;
		int i;

		tmp_block = malloc(tmp_block_len);
		ecc_block = malloc(ecc_block_len);
		part = malloc(part_len);
		memset(tmp_block, 0xaa, tmp_block_len);
		memset(ecc_block, 0x00, ecc_block_len);
		memset(part, 0x1e, part_len);
		for (i = 0; i < part_len; i += 4) {
			part[i + 0] = 0x00;
			part[i + 1] = 0x60;
			part[i + 2] = 0x09;
			part[i + 3] = 0x40;
		}
		ecc_block_fill(ecc_block, ecc_block_len, tmp_block, tmp_block_len, 0, tmp_block_len - 1);
		ecc_block_fill(ecc_block, ecc_block_len, part, part_len, 16, 23);
	}

	return 0;
}
