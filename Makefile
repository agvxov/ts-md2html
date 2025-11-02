CFLAGS  := -Isource/ -Ilibrary/
LDFLAGS := -ltree-sitter -ltree-sitter-markdown -lpcre

OUT := ts-md2html

ifeq (${DEBUG}, 1)
  LFLAGS   += --debug --trace
  YFLAGS   += --debug

  CPPFLAGS += -DDEBUG

  CFLAGS.D += -Wall -Wextra -Wpedantic
  CFLAGS.D += -O0 -ggdb -fno-inline
  CFLAGS.D += -fsanitize=address,undefined
  CFLAGS   += ${CFLAGS.D}
  CXXFLAGS += ${CFLAGS.D}
else
  CFLAGS += -O3 -flto=auto -fno-stack-protector
endif

main: source/main.tbsp
	tbsp -o object/main.tb.c source/main.tbsp
	${CC} ${CFLAGS} -o ${OUT} object/main.tb.c library/sds.c ${LDFLAGS}

test:
	ts-md2html test/max.md

clean:
	-${RM} object/*.c
	-${RM} ${OUT}

.PHONY: test clean
