#include <linux/kernel.h>
#include <linux/module.h>

MODULE_LICENSE("GPLv2");

extern int mbedtls_selftest_main(int argc, char *argv[]);

static int mod_init(void)
{
	mbedtls_selftest_main(0, NULL);
	return -EINVAL;
}

static void mod_exit(void)
{
}

module_init(mod_init);
module_exit(mod_exit);
