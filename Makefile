TARGET ?= mbedtls-lk
KERNEL ?= /lib/modules/$(shell uname -r)/build

MBEDTLS = $(PWD)/mbedtls
MBEDTLS_CFLAGS = -I$(MBEDTLS)/include -I$(MBEDTLS)/mbedtls/include \
	-include $(MBEDTLS)/lk.h -DMBEDTLS_CONFIG_FILE='"$(MBEDTLS)/config.h"'
export MBEDTLS MBEDTLS_CFLAGS

obj-m = $(TARGET).o
obj-y = mbedtls/

ccflags-y = $(MBEDTLS_CFLAGS)
$(TARGET)-y = main.o selftest.o mbedtls/built-in.o

all:
	$(MAKE) -C $(KERNEL) M=$(PWD)

clean:
	$(MAKE) -C $(KERNEL) M=$(PWD) clean
