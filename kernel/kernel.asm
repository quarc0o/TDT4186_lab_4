
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	b2010113          	addi	sp,sp,-1248 # 80008b20 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	076000ef          	jal	ra,8000008c <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <timerinit>:
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    8000001c:	1141                	addi	sp,sp,-16
    8000001e:	e422                	sd	s0,8(sp)
    80000020:	0800                	addi	s0,sp,16
// which hart (core) is this?
static inline uint64
r_mhartid()
{
  uint64 x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80000022:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80000026:	0007859b          	sext.w	a1,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    8000002a:	0037979b          	slliw	a5,a5,0x3
    8000002e:	02004737          	lui	a4,0x2004
    80000032:	97ba                	add	a5,a5,a4
    80000034:	0200c737          	lui	a4,0x200c
    80000038:	ff873703          	ld	a4,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000003c:	000f4637          	lui	a2,0xf4
    80000040:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80000044:	9732                	add	a4,a4,a2
    80000046:	e398                	sd	a4,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80000048:	00259693          	slli	a3,a1,0x2
    8000004c:	96ae                	add	a3,a3,a1
    8000004e:	068e                	slli	a3,a3,0x3
    80000050:	00009717          	auipc	a4,0x9
    80000054:	99070713          	addi	a4,a4,-1648 # 800089e0 <timer_scratch>
    80000058:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    8000005a:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    8000005c:	f310                	sd	a2,32(a4)
}

static inline void 
w_mscratch(uint64 x)
{
  asm volatile("csrw mscratch, %0" : : "r" (x));
    8000005e:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80000062:	00006797          	auipc	a5,0x6
    80000066:	06e78793          	addi	a5,a5,110 # 800060d0 <timervec>
    8000006a:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    8000006e:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80000072:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80000076:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    8000007a:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    8000007e:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80000082:	30479073          	csrw	mie,a5
}
    80000086:	6422                	ld	s0,8(sp)
    80000088:	0141                	addi	sp,sp,16
    8000008a:	8082                	ret

000000008000008c <start>:
{
    8000008c:	1141                	addi	sp,sp,-16
    8000008e:	e406                	sd	ra,8(sp)
    80000090:	e022                	sd	s0,0(sp)
    80000092:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80000094:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80000098:	7779                	lui	a4,0xffffe
    8000009a:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffdc7af>
    8000009e:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    800000a0:	6705                	lui	a4,0x1
    800000a2:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800000a6:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800000a8:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    800000ac:	00001797          	auipc	a5,0x1
    800000b0:	e0c78793          	addi	a5,a5,-500 # 80000eb8 <main>
    800000b4:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    800000b8:	4781                	li	a5,0
    800000ba:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800000be:	67c1                	lui	a5,0x10
    800000c0:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800000c2:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    800000c6:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    800000ca:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    800000ce:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    800000d2:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    800000d6:	57fd                	li	a5,-1
    800000d8:	83a9                	srli	a5,a5,0xa
    800000da:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    800000de:	47bd                	li	a5,15
    800000e0:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    800000e4:	00000097          	auipc	ra,0x0
    800000e8:	f38080e7          	jalr	-200(ra) # 8000001c <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800000ec:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    800000f0:	2781                	sext.w	a5,a5
}

static inline void 
w_tp(uint64 x)
{
  asm volatile("mv tp, %0" : : "r" (x));
    800000f2:	823e                	mv	tp,a5
  asm volatile("mret");
    800000f4:	30200073          	mret
}
    800000f8:	60a2                	ld	ra,8(sp)
    800000fa:	6402                	ld	s0,0(sp)
    800000fc:	0141                	addi	sp,sp,16
    800000fe:	8082                	ret

0000000080000100 <consolewrite>:

//
// user write()s to the console go here.
//
int consolewrite(int user_src, uint64 src, int n)
{
    80000100:	715d                	addi	sp,sp,-80
    80000102:	e486                	sd	ra,72(sp)
    80000104:	e0a2                	sd	s0,64(sp)
    80000106:	fc26                	sd	s1,56(sp)
    80000108:	f84a                	sd	s2,48(sp)
    8000010a:	f44e                	sd	s3,40(sp)
    8000010c:	f052                	sd	s4,32(sp)
    8000010e:	ec56                	sd	s5,24(sp)
    80000110:	0880                	addi	s0,sp,80
    int i;

    for (i = 0; i < n; i++)
    80000112:	04c05763          	blez	a2,80000160 <consolewrite+0x60>
    80000116:	8a2a                	mv	s4,a0
    80000118:	84ae                	mv	s1,a1
    8000011a:	89b2                	mv	s3,a2
    8000011c:	4901                	li	s2,0
    {
        char c;
        if (either_copyin(&c, user_src, src + i, 1) == -1)
    8000011e:	5afd                	li	s5,-1
    80000120:	4685                	li	a3,1
    80000122:	8626                	mv	a2,s1
    80000124:	85d2                	mv	a1,s4
    80000126:	fbf40513          	addi	a0,s0,-65
    8000012a:	00002097          	auipc	ra,0x2
    8000012e:	74c080e7          	jalr	1868(ra) # 80002876 <either_copyin>
    80000132:	01550d63          	beq	a0,s5,8000014c <consolewrite+0x4c>
            break;
        uartputc(c);
    80000136:	fbf44503          	lbu	a0,-65(s0)
    8000013a:	00000097          	auipc	ra,0x0
    8000013e:	7c6080e7          	jalr	1990(ra) # 80000900 <uartputc>
    for (i = 0; i < n; i++)
    80000142:	2905                	addiw	s2,s2,1
    80000144:	0485                	addi	s1,s1,1
    80000146:	fd299de3          	bne	s3,s2,80000120 <consolewrite+0x20>
    8000014a:	894e                	mv	s2,s3
    }

    return i;
}
    8000014c:	854a                	mv	a0,s2
    8000014e:	60a6                	ld	ra,72(sp)
    80000150:	6406                	ld	s0,64(sp)
    80000152:	74e2                	ld	s1,56(sp)
    80000154:	7942                	ld	s2,48(sp)
    80000156:	79a2                	ld	s3,40(sp)
    80000158:	7a02                	ld	s4,32(sp)
    8000015a:	6ae2                	ld	s5,24(sp)
    8000015c:	6161                	addi	sp,sp,80
    8000015e:	8082                	ret
    for (i = 0; i < n; i++)
    80000160:	4901                	li	s2,0
    80000162:	b7ed                	j	8000014c <consolewrite+0x4c>

0000000080000164 <consoleread>:
// copy (up to) a whole input line to dst.
// user_dist indicates whether dst is a user
// or kernel address.
//
int consoleread(int user_dst, uint64 dst, int n)
{
    80000164:	711d                	addi	sp,sp,-96
    80000166:	ec86                	sd	ra,88(sp)
    80000168:	e8a2                	sd	s0,80(sp)
    8000016a:	e4a6                	sd	s1,72(sp)
    8000016c:	e0ca                	sd	s2,64(sp)
    8000016e:	fc4e                	sd	s3,56(sp)
    80000170:	f852                	sd	s4,48(sp)
    80000172:	f456                	sd	s5,40(sp)
    80000174:	f05a                	sd	s6,32(sp)
    80000176:	ec5e                	sd	s7,24(sp)
    80000178:	1080                	addi	s0,sp,96
    8000017a:	8aaa                	mv	s5,a0
    8000017c:	8a2e                	mv	s4,a1
    8000017e:	89b2                	mv	s3,a2
    uint target;
    int c;
    char cbuf;

    target = n;
    80000180:	00060b1b          	sext.w	s6,a2
    acquire(&cons.lock);
    80000184:	00011517          	auipc	a0,0x11
    80000188:	99c50513          	addi	a0,a0,-1636 # 80010b20 <cons>
    8000018c:	00001097          	auipc	ra,0x1
    80000190:	a8c080e7          	jalr	-1396(ra) # 80000c18 <acquire>
    while (n > 0)
    {
        // wait until interrupt handler has put some
        // input into cons.buffer.
        while (cons.r == cons.w)
    80000194:	00011497          	auipc	s1,0x11
    80000198:	98c48493          	addi	s1,s1,-1652 # 80010b20 <cons>
            if (killed(myproc()))
            {
                release(&cons.lock);
                return -1;
            }
            sleep(&cons.r, &cons.lock);
    8000019c:	00011917          	auipc	s2,0x11
    800001a0:	a1c90913          	addi	s2,s2,-1508 # 80010bb8 <cons+0x98>
    while (n > 0)
    800001a4:	09305263          	blez	s3,80000228 <consoleread+0xc4>
        while (cons.r == cons.w)
    800001a8:	0984a783          	lw	a5,152(s1)
    800001ac:	09c4a703          	lw	a4,156(s1)
    800001b0:	02f71763          	bne	a4,a5,800001de <consoleread+0x7a>
            if (killed(myproc()))
    800001b4:	00002097          	auipc	ra,0x2
    800001b8:	aa0080e7          	jalr	-1376(ra) # 80001c54 <myproc>
    800001bc:	00002097          	auipc	ra,0x2
    800001c0:	504080e7          	jalr	1284(ra) # 800026c0 <killed>
    800001c4:	ed2d                	bnez	a0,8000023e <consoleread+0xda>
            sleep(&cons.r, &cons.lock);
    800001c6:	85a6                	mv	a1,s1
    800001c8:	854a                	mv	a0,s2
    800001ca:	00002097          	auipc	ra,0x2
    800001ce:	24e080e7          	jalr	590(ra) # 80002418 <sleep>
        while (cons.r == cons.w)
    800001d2:	0984a783          	lw	a5,152(s1)
    800001d6:	09c4a703          	lw	a4,156(s1)
    800001da:	fcf70de3          	beq	a4,a5,800001b4 <consoleread+0x50>
        }

        c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    800001de:	00011717          	auipc	a4,0x11
    800001e2:	94270713          	addi	a4,a4,-1726 # 80010b20 <cons>
    800001e6:	0017869b          	addiw	a3,a5,1
    800001ea:	08d72c23          	sw	a3,152(a4)
    800001ee:	07f7f693          	andi	a3,a5,127
    800001f2:	9736                	add	a4,a4,a3
    800001f4:	01874703          	lbu	a4,24(a4)
    800001f8:	00070b9b          	sext.w	s7,a4

        if (c == C('D'))
    800001fc:	4691                	li	a3,4
    800001fe:	06db8463          	beq	s7,a3,80000266 <consoleread+0x102>
            }
            break;
        }

        // copy the input byte to the user-space buffer.
        cbuf = c;
    80000202:	fae407a3          	sb	a4,-81(s0)
        if (either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80000206:	4685                	li	a3,1
    80000208:	faf40613          	addi	a2,s0,-81
    8000020c:	85d2                	mv	a1,s4
    8000020e:	8556                	mv	a0,s5
    80000210:	00002097          	auipc	ra,0x2
    80000214:	610080e7          	jalr	1552(ra) # 80002820 <either_copyout>
    80000218:	57fd                	li	a5,-1
    8000021a:	00f50763          	beq	a0,a5,80000228 <consoleread+0xc4>
            break;

        dst++;
    8000021e:	0a05                	addi	s4,s4,1
        --n;
    80000220:	39fd                	addiw	s3,s3,-1

        if (c == '\n')
    80000222:	47a9                	li	a5,10
    80000224:	f8fb90e3          	bne	s7,a5,800001a4 <consoleread+0x40>
            // a whole line has arrived, return to
            // the user-level read().
            break;
        }
    }
    release(&cons.lock);
    80000228:	00011517          	auipc	a0,0x11
    8000022c:	8f850513          	addi	a0,a0,-1800 # 80010b20 <cons>
    80000230:	00001097          	auipc	ra,0x1
    80000234:	a9c080e7          	jalr	-1380(ra) # 80000ccc <release>

    return target - n;
    80000238:	413b053b          	subw	a0,s6,s3
    8000023c:	a811                	j	80000250 <consoleread+0xec>
                release(&cons.lock);
    8000023e:	00011517          	auipc	a0,0x11
    80000242:	8e250513          	addi	a0,a0,-1822 # 80010b20 <cons>
    80000246:	00001097          	auipc	ra,0x1
    8000024a:	a86080e7          	jalr	-1402(ra) # 80000ccc <release>
                return -1;
    8000024e:	557d                	li	a0,-1
}
    80000250:	60e6                	ld	ra,88(sp)
    80000252:	6446                	ld	s0,80(sp)
    80000254:	64a6                	ld	s1,72(sp)
    80000256:	6906                	ld	s2,64(sp)
    80000258:	79e2                	ld	s3,56(sp)
    8000025a:	7a42                	ld	s4,48(sp)
    8000025c:	7aa2                	ld	s5,40(sp)
    8000025e:	7b02                	ld	s6,32(sp)
    80000260:	6be2                	ld	s7,24(sp)
    80000262:	6125                	addi	sp,sp,96
    80000264:	8082                	ret
            if (n < target)
    80000266:	0009871b          	sext.w	a4,s3
    8000026a:	fb677fe3          	bgeu	a4,s6,80000228 <consoleread+0xc4>
                cons.r--;
    8000026e:	00011717          	auipc	a4,0x11
    80000272:	94f72523          	sw	a5,-1718(a4) # 80010bb8 <cons+0x98>
    80000276:	bf4d                	j	80000228 <consoleread+0xc4>

0000000080000278 <consputc>:
{
    80000278:	1141                	addi	sp,sp,-16
    8000027a:	e406                	sd	ra,8(sp)
    8000027c:	e022                	sd	s0,0(sp)
    8000027e:	0800                	addi	s0,sp,16
    if (c == BACKSPACE)
    80000280:	10000793          	li	a5,256
    80000284:	00f50a63          	beq	a0,a5,80000298 <consputc+0x20>
        uartputc_sync(c);
    80000288:	00000097          	auipc	ra,0x0
    8000028c:	5a6080e7          	jalr	1446(ra) # 8000082e <uartputc_sync>
}
    80000290:	60a2                	ld	ra,8(sp)
    80000292:	6402                	ld	s0,0(sp)
    80000294:	0141                	addi	sp,sp,16
    80000296:	8082                	ret
        uartputc_sync('\b');
    80000298:	4521                	li	a0,8
    8000029a:	00000097          	auipc	ra,0x0
    8000029e:	594080e7          	jalr	1428(ra) # 8000082e <uartputc_sync>
        uartputc_sync(' ');
    800002a2:	02000513          	li	a0,32
    800002a6:	00000097          	auipc	ra,0x0
    800002aa:	588080e7          	jalr	1416(ra) # 8000082e <uartputc_sync>
        uartputc_sync('\b');
    800002ae:	4521                	li	a0,8
    800002b0:	00000097          	auipc	ra,0x0
    800002b4:	57e080e7          	jalr	1406(ra) # 8000082e <uartputc_sync>
    800002b8:	bfe1                	j	80000290 <consputc+0x18>

00000000800002ba <consoleintr>:
// uartintr() calls this for input character.
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void consoleintr(int c)
{
    800002ba:	1101                	addi	sp,sp,-32
    800002bc:	ec06                	sd	ra,24(sp)
    800002be:	e822                	sd	s0,16(sp)
    800002c0:	e426                	sd	s1,8(sp)
    800002c2:	e04a                	sd	s2,0(sp)
    800002c4:	1000                	addi	s0,sp,32
    800002c6:	84aa                	mv	s1,a0
    acquire(&cons.lock);
    800002c8:	00011517          	auipc	a0,0x11
    800002cc:	85850513          	addi	a0,a0,-1960 # 80010b20 <cons>
    800002d0:	00001097          	auipc	ra,0x1
    800002d4:	948080e7          	jalr	-1720(ra) # 80000c18 <acquire>

    switch (c)
    800002d8:	47c1                	li	a5,16
    800002da:	08f48e63          	beq	s1,a5,80000376 <consoleintr+0xbc>
    800002de:	0297ce63          	blt	a5,s1,8000031a <consoleintr+0x60>
    800002e2:	478d                	li	a5,3
    800002e4:	0af48b63          	beq	s1,a5,8000039a <consoleintr+0xe0>
    800002e8:	47a1                	li	a5,8
    800002ea:	0ef49963          	bne	s1,a5,800003dc <consoleintr+0x122>
            setkilled(current_proc);
    }
    break;
    case C('H'): // Backspace
    case '\x7f': // Delete key
        if (cons.e != cons.w)
    800002ee:	00011717          	auipc	a4,0x11
    800002f2:	83270713          	addi	a4,a4,-1998 # 80010b20 <cons>
    800002f6:	0a072783          	lw	a5,160(a4)
    800002fa:	09c72703          	lw	a4,156(a4)
    800002fe:	08f70063          	beq	a4,a5,8000037e <consoleintr+0xc4>
        {
            cons.e--;
    80000302:	37fd                	addiw	a5,a5,-1
    80000304:	00011717          	auipc	a4,0x11
    80000308:	8af72e23          	sw	a5,-1860(a4) # 80010bc0 <cons+0xa0>
            consputc(BACKSPACE);
    8000030c:	10000513          	li	a0,256
    80000310:	00000097          	auipc	ra,0x0
    80000314:	f68080e7          	jalr	-152(ra) # 80000278 <consputc>
    80000318:	a09d                	j	8000037e <consoleintr+0xc4>
    switch (c)
    8000031a:	47d5                	li	a5,21
    8000031c:	00f48763          	beq	s1,a5,8000032a <consoleintr+0x70>
    80000320:	07f00793          	li	a5,127
    80000324:	fcf485e3          	beq	s1,a5,800002ee <consoleintr+0x34>
    80000328:	a85d                	j	800003de <consoleintr+0x124>
        while (cons.e != cons.w &&
    8000032a:	00010717          	auipc	a4,0x10
    8000032e:	7f670713          	addi	a4,a4,2038 # 80010b20 <cons>
    80000332:	0a072783          	lw	a5,160(a4)
    80000336:	09c72703          	lw	a4,156(a4)
               cons.buf[(cons.e - 1) % INPUT_BUF_SIZE] != '\n')
    8000033a:	00010497          	auipc	s1,0x10
    8000033e:	7e648493          	addi	s1,s1,2022 # 80010b20 <cons>
        while (cons.e != cons.w &&
    80000342:	4929                	li	s2,10
    80000344:	02f70d63          	beq	a4,a5,8000037e <consoleintr+0xc4>
               cons.buf[(cons.e - 1) % INPUT_BUF_SIZE] != '\n')
    80000348:	37fd                	addiw	a5,a5,-1
    8000034a:	07f7f713          	andi	a4,a5,127
    8000034e:	9726                	add	a4,a4,s1
        while (cons.e != cons.w &&
    80000350:	01874703          	lbu	a4,24(a4)
    80000354:	03270563          	beq	a4,s2,8000037e <consoleintr+0xc4>
            cons.e--;
    80000358:	0af4a023          	sw	a5,160(s1)
            consputc(BACKSPACE);
    8000035c:	10000513          	li	a0,256
    80000360:	00000097          	auipc	ra,0x0
    80000364:	f18080e7          	jalr	-232(ra) # 80000278 <consputc>
        while (cons.e != cons.w &&
    80000368:	0a04a783          	lw	a5,160(s1)
    8000036c:	09c4a703          	lw	a4,156(s1)
    80000370:	fcf71ce3          	bne	a4,a5,80000348 <consoleintr+0x8e>
    80000374:	a029                	j	8000037e <consoleintr+0xc4>
        procdump();
    80000376:	00002097          	auipc	ra,0x2
    8000037a:	556080e7          	jalr	1366(ra) # 800028cc <procdump>
            }
        }
        break;
    }

    release(&cons.lock);
    8000037e:	00010517          	auipc	a0,0x10
    80000382:	7a250513          	addi	a0,a0,1954 # 80010b20 <cons>
    80000386:	00001097          	auipc	ra,0x1
    8000038a:	946080e7          	jalr	-1722(ra) # 80000ccc <release>
}
    8000038e:	60e2                	ld	ra,24(sp)
    80000390:	6442                	ld	s0,16(sp)
    80000392:	64a2                	ld	s1,8(sp)
    80000394:	6902                	ld	s2,0(sp)
    80000396:	6105                	addi	sp,sp,32
    80000398:	8082                	ret
        struct proc *p = proc;
    8000039a:	00011797          	auipc	a5,0x11
    8000039e:	cd678793          	addi	a5,a5,-810 # 80011070 <proc>
        struct proc *current_proc = proc;
    800003a2:	853e                	mv	a0,a5
        for (; p < &proc[NPROC]; ++p)
    800003a4:	00017697          	auipc	a3,0x17
    800003a8:	8cc68693          	addi	a3,a3,-1844 # 80016c70 <tickslock>
    800003ac:	a029                	j	800003b6 <consoleintr+0xfc>
    800003ae:	17078793          	addi	a5,a5,368
    800003b2:	00d78a63          	beq	a5,a3,800003c6 <consoleintr+0x10c>
            if (p->state != UNUSED && p->pid > current_proc->pid)
    800003b6:	4f98                	lw	a4,24(a5)
    800003b8:	db7d                	beqz	a4,800003ae <consoleintr+0xf4>
    800003ba:	5b90                	lw	a2,48(a5)
    800003bc:	5918                	lw	a4,48(a0)
    800003be:	fec758e3          	bge	a4,a2,800003ae <consoleintr+0xf4>
    800003c2:	853e                	mv	a0,a5
    800003c4:	b7ed                	j	800003ae <consoleintr+0xf4>
        if (!current_proc)
    800003c6:	dd45                	beqz	a0,8000037e <consoleintr+0xc4>
        if (current_proc->parent->pid != 1)
    800003c8:	613c                	ld	a5,64(a0)
    800003ca:	5b98                	lw	a4,48(a5)
    800003cc:	4785                	li	a5,1
    800003ce:	faf708e3          	beq	a4,a5,8000037e <consoleintr+0xc4>
            setkilled(current_proc);
    800003d2:	00002097          	auipc	ra,0x2
    800003d6:	2c2080e7          	jalr	706(ra) # 80002694 <setkilled>
    800003da:	b755                	j	8000037e <consoleintr+0xc4>
        if (c != 0 && cons.e - cons.r < INPUT_BUF_SIZE)
    800003dc:	d0cd                	beqz	s1,8000037e <consoleintr+0xc4>
    800003de:	00010717          	auipc	a4,0x10
    800003e2:	74270713          	addi	a4,a4,1858 # 80010b20 <cons>
    800003e6:	0a072783          	lw	a5,160(a4)
    800003ea:	09872703          	lw	a4,152(a4)
    800003ee:	9f99                	subw	a5,a5,a4
    800003f0:	07f00713          	li	a4,127
    800003f4:	f8f765e3          	bltu	a4,a5,8000037e <consoleintr+0xc4>
            c = (c == '\r') ? '\n' : c;
    800003f8:	47b5                	li	a5,13
    800003fa:	04f48863          	beq	s1,a5,8000044a <consoleintr+0x190>
            consputc(c);
    800003fe:	8526                	mv	a0,s1
    80000400:	00000097          	auipc	ra,0x0
    80000404:	e78080e7          	jalr	-392(ra) # 80000278 <consputc>
            cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80000408:	00010797          	auipc	a5,0x10
    8000040c:	71878793          	addi	a5,a5,1816 # 80010b20 <cons>
    80000410:	0a07a683          	lw	a3,160(a5)
    80000414:	0016871b          	addiw	a4,a3,1
    80000418:	0007061b          	sext.w	a2,a4
    8000041c:	0ae7a023          	sw	a4,160(a5)
    80000420:	07f6f693          	andi	a3,a3,127
    80000424:	97b6                	add	a5,a5,a3
    80000426:	00978c23          	sb	s1,24(a5)
            if (c == '\n' || c == C('D') || cons.e - cons.r == INPUT_BUF_SIZE)
    8000042a:	47a9                	li	a5,10
    8000042c:	04f48663          	beq	s1,a5,80000478 <consoleintr+0x1be>
    80000430:	4791                	li	a5,4
    80000432:	04f48363          	beq	s1,a5,80000478 <consoleintr+0x1be>
    80000436:	00010797          	auipc	a5,0x10
    8000043a:	7827a783          	lw	a5,1922(a5) # 80010bb8 <cons+0x98>
    8000043e:	9f1d                	subw	a4,a4,a5
    80000440:	08000793          	li	a5,128
    80000444:	f2f71de3          	bne	a4,a5,8000037e <consoleintr+0xc4>
    80000448:	a805                	j	80000478 <consoleintr+0x1be>
            consputc(c);
    8000044a:	4529                	li	a0,10
    8000044c:	00000097          	auipc	ra,0x0
    80000450:	e2c080e7          	jalr	-468(ra) # 80000278 <consputc>
            cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80000454:	00010797          	auipc	a5,0x10
    80000458:	6cc78793          	addi	a5,a5,1740 # 80010b20 <cons>
    8000045c:	0a07a703          	lw	a4,160(a5)
    80000460:	0017069b          	addiw	a3,a4,1
    80000464:	0006861b          	sext.w	a2,a3
    80000468:	0ad7a023          	sw	a3,160(a5)
    8000046c:	07f77713          	andi	a4,a4,127
    80000470:	97ba                	add	a5,a5,a4
    80000472:	4729                	li	a4,10
    80000474:	00e78c23          	sb	a4,24(a5)
                cons.w = cons.e;
    80000478:	00010797          	auipc	a5,0x10
    8000047c:	74c7a223          	sw	a2,1860(a5) # 80010bbc <cons+0x9c>
                wakeup(&cons.r);
    80000480:	00010517          	auipc	a0,0x10
    80000484:	73850513          	addi	a0,a0,1848 # 80010bb8 <cons+0x98>
    80000488:	00002097          	auipc	ra,0x2
    8000048c:	ff4080e7          	jalr	-12(ra) # 8000247c <wakeup>
    80000490:	b5fd                	j	8000037e <consoleintr+0xc4>

0000000080000492 <consoleinit>:

void consoleinit(void)
{
    80000492:	1141                	addi	sp,sp,-16
    80000494:	e406                	sd	ra,8(sp)
    80000496:	e022                	sd	s0,0(sp)
    80000498:	0800                	addi	s0,sp,16
    initlock(&cons.lock, "cons");
    8000049a:	00008597          	auipc	a1,0x8
    8000049e:	b7658593          	addi	a1,a1,-1162 # 80008010 <etext+0x10>
    800004a2:	00010517          	auipc	a0,0x10
    800004a6:	67e50513          	addi	a0,a0,1662 # 80010b20 <cons>
    800004aa:	00000097          	auipc	ra,0x0
    800004ae:	6de080e7          	jalr	1758(ra) # 80000b88 <initlock>

    uartinit();
    800004b2:	00000097          	auipc	ra,0x0
    800004b6:	32c080e7          	jalr	812(ra) # 800007de <uartinit>

    // connect read and write system calls
    // to consoleread and consolewrite.
    devsw[CONSOLE].read = consoleread;
    800004ba:	00021797          	auipc	a5,0x21
    800004be:	9fe78793          	addi	a5,a5,-1538 # 80020eb8 <devsw>
    800004c2:	00000717          	auipc	a4,0x0
    800004c6:	ca270713          	addi	a4,a4,-862 # 80000164 <consoleread>
    800004ca:	eb98                	sd	a4,16(a5)
    devsw[CONSOLE].write = consolewrite;
    800004cc:	00000717          	auipc	a4,0x0
    800004d0:	c3470713          	addi	a4,a4,-972 # 80000100 <consolewrite>
    800004d4:	ef98                	sd	a4,24(a5)
}
    800004d6:	60a2                	ld	ra,8(sp)
    800004d8:	6402                	ld	s0,0(sp)
    800004da:	0141                	addi	sp,sp,16
    800004dc:	8082                	ret

00000000800004de <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    800004de:	7179                	addi	sp,sp,-48
    800004e0:	f406                	sd	ra,40(sp)
    800004e2:	f022                	sd	s0,32(sp)
    800004e4:	ec26                	sd	s1,24(sp)
    800004e6:	e84a                	sd	s2,16(sp)
    800004e8:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    800004ea:	c219                	beqz	a2,800004f0 <printint+0x12>
    800004ec:	08054763          	bltz	a0,8000057a <printint+0x9c>
    x = -xx;
  else
    x = xx;
    800004f0:	2501                	sext.w	a0,a0
    800004f2:	4881                	li	a7,0
    800004f4:	fd040693          	addi	a3,s0,-48

  i = 0;
    800004f8:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    800004fa:	2581                	sext.w	a1,a1
    800004fc:	00008617          	auipc	a2,0x8
    80000500:	b4460613          	addi	a2,a2,-1212 # 80008040 <digits>
    80000504:	883a                	mv	a6,a4
    80000506:	2705                	addiw	a4,a4,1
    80000508:	02b577bb          	remuw	a5,a0,a1
    8000050c:	1782                	slli	a5,a5,0x20
    8000050e:	9381                	srli	a5,a5,0x20
    80000510:	97b2                	add	a5,a5,a2
    80000512:	0007c783          	lbu	a5,0(a5)
    80000516:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    8000051a:	0005079b          	sext.w	a5,a0
    8000051e:	02b5553b          	divuw	a0,a0,a1
    80000522:	0685                	addi	a3,a3,1
    80000524:	feb7f0e3          	bgeu	a5,a1,80000504 <printint+0x26>

  if(sign)
    80000528:	00088c63          	beqz	a7,80000540 <printint+0x62>
    buf[i++] = '-';
    8000052c:	fe070793          	addi	a5,a4,-32
    80000530:	00878733          	add	a4,a5,s0
    80000534:	02d00793          	li	a5,45
    80000538:	fef70823          	sb	a5,-16(a4)
    8000053c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    80000540:	02e05763          	blez	a4,8000056e <printint+0x90>
    80000544:	fd040793          	addi	a5,s0,-48
    80000548:	00e784b3          	add	s1,a5,a4
    8000054c:	fff78913          	addi	s2,a5,-1
    80000550:	993a                	add	s2,s2,a4
    80000552:	377d                	addiw	a4,a4,-1
    80000554:	1702                	slli	a4,a4,0x20
    80000556:	9301                	srli	a4,a4,0x20
    80000558:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    8000055c:	fff4c503          	lbu	a0,-1(s1)
    80000560:	00000097          	auipc	ra,0x0
    80000564:	d18080e7          	jalr	-744(ra) # 80000278 <consputc>
  while(--i >= 0)
    80000568:	14fd                	addi	s1,s1,-1
    8000056a:	ff2499e3          	bne	s1,s2,8000055c <printint+0x7e>
}
    8000056e:	70a2                	ld	ra,40(sp)
    80000570:	7402                	ld	s0,32(sp)
    80000572:	64e2                	ld	s1,24(sp)
    80000574:	6942                	ld	s2,16(sp)
    80000576:	6145                	addi	sp,sp,48
    80000578:	8082                	ret
    x = -xx;
    8000057a:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    8000057e:	4885                	li	a7,1
    x = -xx;
    80000580:	bf95                	j	800004f4 <printint+0x16>

0000000080000582 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80000582:	1101                	addi	sp,sp,-32
    80000584:	ec06                	sd	ra,24(sp)
    80000586:	e822                	sd	s0,16(sp)
    80000588:	e426                	sd	s1,8(sp)
    8000058a:	1000                	addi	s0,sp,32
    8000058c:	84aa                	mv	s1,a0
  pr.locking = 0;
    8000058e:	00010797          	auipc	a5,0x10
    80000592:	6407a923          	sw	zero,1618(a5) # 80010be0 <pr+0x18>
  printf("panic: ");
    80000596:	00008517          	auipc	a0,0x8
    8000059a:	a8250513          	addi	a0,a0,-1406 # 80008018 <etext+0x18>
    8000059e:	00000097          	auipc	ra,0x0
    800005a2:	02e080e7          	jalr	46(ra) # 800005cc <printf>
  printf(s);
    800005a6:	8526                	mv	a0,s1
    800005a8:	00000097          	auipc	ra,0x0
    800005ac:	024080e7          	jalr	36(ra) # 800005cc <printf>
  printf("\n");
    800005b0:	00008517          	auipc	a0,0x8
    800005b4:	b1850513          	addi	a0,a0,-1256 # 800080c8 <digits+0x88>
    800005b8:	00000097          	auipc	ra,0x0
    800005bc:	014080e7          	jalr	20(ra) # 800005cc <printf>
  panicked = 1; // freeze uart output from other CPUs
    800005c0:	4785                	li	a5,1
    800005c2:	00008717          	auipc	a4,0x8
    800005c6:	3cf72f23          	sw	a5,990(a4) # 800089a0 <panicked>
  for(;;)
    800005ca:	a001                	j	800005ca <panic+0x48>

00000000800005cc <printf>:
{
    800005cc:	7131                	addi	sp,sp,-192
    800005ce:	fc86                	sd	ra,120(sp)
    800005d0:	f8a2                	sd	s0,112(sp)
    800005d2:	f4a6                	sd	s1,104(sp)
    800005d4:	f0ca                	sd	s2,96(sp)
    800005d6:	ecce                	sd	s3,88(sp)
    800005d8:	e8d2                	sd	s4,80(sp)
    800005da:	e4d6                	sd	s5,72(sp)
    800005dc:	e0da                	sd	s6,64(sp)
    800005de:	fc5e                	sd	s7,56(sp)
    800005e0:	f862                	sd	s8,48(sp)
    800005e2:	f466                	sd	s9,40(sp)
    800005e4:	f06a                	sd	s10,32(sp)
    800005e6:	ec6e                	sd	s11,24(sp)
    800005e8:	0100                	addi	s0,sp,128
    800005ea:	8a2a                	mv	s4,a0
    800005ec:	e40c                	sd	a1,8(s0)
    800005ee:	e810                	sd	a2,16(s0)
    800005f0:	ec14                	sd	a3,24(s0)
    800005f2:	f018                	sd	a4,32(s0)
    800005f4:	f41c                	sd	a5,40(s0)
    800005f6:	03043823          	sd	a6,48(s0)
    800005fa:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    800005fe:	00010d97          	auipc	s11,0x10
    80000602:	5e2dad83          	lw	s11,1506(s11) # 80010be0 <pr+0x18>
  if(locking)
    80000606:	020d9b63          	bnez	s11,8000063c <printf+0x70>
  if (fmt == 0)
    8000060a:	040a0263          	beqz	s4,8000064e <printf+0x82>
  va_start(ap, fmt);
    8000060e:	00840793          	addi	a5,s0,8
    80000612:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000616:	000a4503          	lbu	a0,0(s4)
    8000061a:	14050f63          	beqz	a0,80000778 <printf+0x1ac>
    8000061e:	4981                	li	s3,0
    if(c != '%'){
    80000620:	02500a93          	li	s5,37
    switch(c){
    80000624:	07000b93          	li	s7,112
  consputc('x');
    80000628:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    8000062a:	00008b17          	auipc	s6,0x8
    8000062e:	a16b0b13          	addi	s6,s6,-1514 # 80008040 <digits>
    switch(c){
    80000632:	07300c93          	li	s9,115
    80000636:	06400c13          	li	s8,100
    8000063a:	a82d                	j	80000674 <printf+0xa8>
    acquire(&pr.lock);
    8000063c:	00010517          	auipc	a0,0x10
    80000640:	58c50513          	addi	a0,a0,1420 # 80010bc8 <pr>
    80000644:	00000097          	auipc	ra,0x0
    80000648:	5d4080e7          	jalr	1492(ra) # 80000c18 <acquire>
    8000064c:	bf7d                	j	8000060a <printf+0x3e>
    panic("null fmt");
    8000064e:	00008517          	auipc	a0,0x8
    80000652:	9da50513          	addi	a0,a0,-1574 # 80008028 <etext+0x28>
    80000656:	00000097          	auipc	ra,0x0
    8000065a:	f2c080e7          	jalr	-212(ra) # 80000582 <panic>
      consputc(c);
    8000065e:	00000097          	auipc	ra,0x0
    80000662:	c1a080e7          	jalr	-998(ra) # 80000278 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000666:	2985                	addiw	s3,s3,1
    80000668:	013a07b3          	add	a5,s4,s3
    8000066c:	0007c503          	lbu	a0,0(a5)
    80000670:	10050463          	beqz	a0,80000778 <printf+0x1ac>
    if(c != '%'){
    80000674:	ff5515e3          	bne	a0,s5,8000065e <printf+0x92>
    c = fmt[++i] & 0xff;
    80000678:	2985                	addiw	s3,s3,1
    8000067a:	013a07b3          	add	a5,s4,s3
    8000067e:	0007c783          	lbu	a5,0(a5)
    80000682:	0007849b          	sext.w	s1,a5
    if(c == 0)
    80000686:	cbed                	beqz	a5,80000778 <printf+0x1ac>
    switch(c){
    80000688:	05778a63          	beq	a5,s7,800006dc <printf+0x110>
    8000068c:	02fbf663          	bgeu	s7,a5,800006b8 <printf+0xec>
    80000690:	09978863          	beq	a5,s9,80000720 <printf+0x154>
    80000694:	07800713          	li	a4,120
    80000698:	0ce79563          	bne	a5,a4,80000762 <printf+0x196>
      printint(va_arg(ap, int), 16, 1);
    8000069c:	f8843783          	ld	a5,-120(s0)
    800006a0:	00878713          	addi	a4,a5,8
    800006a4:	f8e43423          	sd	a4,-120(s0)
    800006a8:	4605                	li	a2,1
    800006aa:	85ea                	mv	a1,s10
    800006ac:	4388                	lw	a0,0(a5)
    800006ae:	00000097          	auipc	ra,0x0
    800006b2:	e30080e7          	jalr	-464(ra) # 800004de <printint>
      break;
    800006b6:	bf45                	j	80000666 <printf+0x9a>
    switch(c){
    800006b8:	09578f63          	beq	a5,s5,80000756 <printf+0x18a>
    800006bc:	0b879363          	bne	a5,s8,80000762 <printf+0x196>
      printint(va_arg(ap, int), 10, 1);
    800006c0:	f8843783          	ld	a5,-120(s0)
    800006c4:	00878713          	addi	a4,a5,8
    800006c8:	f8e43423          	sd	a4,-120(s0)
    800006cc:	4605                	li	a2,1
    800006ce:	45a9                	li	a1,10
    800006d0:	4388                	lw	a0,0(a5)
    800006d2:	00000097          	auipc	ra,0x0
    800006d6:	e0c080e7          	jalr	-500(ra) # 800004de <printint>
      break;
    800006da:	b771                	j	80000666 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    800006dc:	f8843783          	ld	a5,-120(s0)
    800006e0:	00878713          	addi	a4,a5,8
    800006e4:	f8e43423          	sd	a4,-120(s0)
    800006e8:	0007b903          	ld	s2,0(a5)
  consputc('0');
    800006ec:	03000513          	li	a0,48
    800006f0:	00000097          	auipc	ra,0x0
    800006f4:	b88080e7          	jalr	-1144(ra) # 80000278 <consputc>
  consputc('x');
    800006f8:	07800513          	li	a0,120
    800006fc:	00000097          	auipc	ra,0x0
    80000700:	b7c080e7          	jalr	-1156(ra) # 80000278 <consputc>
    80000704:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80000706:	03c95793          	srli	a5,s2,0x3c
    8000070a:	97da                	add	a5,a5,s6
    8000070c:	0007c503          	lbu	a0,0(a5)
    80000710:	00000097          	auipc	ra,0x0
    80000714:	b68080e7          	jalr	-1176(ra) # 80000278 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80000718:	0912                	slli	s2,s2,0x4
    8000071a:	34fd                	addiw	s1,s1,-1
    8000071c:	f4ed                	bnez	s1,80000706 <printf+0x13a>
    8000071e:	b7a1                	j	80000666 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    80000720:	f8843783          	ld	a5,-120(s0)
    80000724:	00878713          	addi	a4,a5,8
    80000728:	f8e43423          	sd	a4,-120(s0)
    8000072c:	6384                	ld	s1,0(a5)
    8000072e:	cc89                	beqz	s1,80000748 <printf+0x17c>
      for(; *s; s++)
    80000730:	0004c503          	lbu	a0,0(s1)
    80000734:	d90d                	beqz	a0,80000666 <printf+0x9a>
        consputc(*s);
    80000736:	00000097          	auipc	ra,0x0
    8000073a:	b42080e7          	jalr	-1214(ra) # 80000278 <consputc>
      for(; *s; s++)
    8000073e:	0485                	addi	s1,s1,1
    80000740:	0004c503          	lbu	a0,0(s1)
    80000744:	f96d                	bnez	a0,80000736 <printf+0x16a>
    80000746:	b705                	j	80000666 <printf+0x9a>
        s = "(null)";
    80000748:	00008497          	auipc	s1,0x8
    8000074c:	8d848493          	addi	s1,s1,-1832 # 80008020 <etext+0x20>
      for(; *s; s++)
    80000750:	02800513          	li	a0,40
    80000754:	b7cd                	j	80000736 <printf+0x16a>
      consputc('%');
    80000756:	8556                	mv	a0,s5
    80000758:	00000097          	auipc	ra,0x0
    8000075c:	b20080e7          	jalr	-1248(ra) # 80000278 <consputc>
      break;
    80000760:	b719                	j	80000666 <printf+0x9a>
      consputc('%');
    80000762:	8556                	mv	a0,s5
    80000764:	00000097          	auipc	ra,0x0
    80000768:	b14080e7          	jalr	-1260(ra) # 80000278 <consputc>
      consputc(c);
    8000076c:	8526                	mv	a0,s1
    8000076e:	00000097          	auipc	ra,0x0
    80000772:	b0a080e7          	jalr	-1270(ra) # 80000278 <consputc>
      break;
    80000776:	bdc5                	j	80000666 <printf+0x9a>
  if(locking)
    80000778:	020d9163          	bnez	s11,8000079a <printf+0x1ce>
}
    8000077c:	70e6                	ld	ra,120(sp)
    8000077e:	7446                	ld	s0,112(sp)
    80000780:	74a6                	ld	s1,104(sp)
    80000782:	7906                	ld	s2,96(sp)
    80000784:	69e6                	ld	s3,88(sp)
    80000786:	6a46                	ld	s4,80(sp)
    80000788:	6aa6                	ld	s5,72(sp)
    8000078a:	6b06                	ld	s6,64(sp)
    8000078c:	7be2                	ld	s7,56(sp)
    8000078e:	7c42                	ld	s8,48(sp)
    80000790:	7ca2                	ld	s9,40(sp)
    80000792:	7d02                	ld	s10,32(sp)
    80000794:	6de2                	ld	s11,24(sp)
    80000796:	6129                	addi	sp,sp,192
    80000798:	8082                	ret
    release(&pr.lock);
    8000079a:	00010517          	auipc	a0,0x10
    8000079e:	42e50513          	addi	a0,a0,1070 # 80010bc8 <pr>
    800007a2:	00000097          	auipc	ra,0x0
    800007a6:	52a080e7          	jalr	1322(ra) # 80000ccc <release>
}
    800007aa:	bfc9                	j	8000077c <printf+0x1b0>

00000000800007ac <printfinit>:
    ;
}

void
printfinit(void)
{
    800007ac:	1101                	addi	sp,sp,-32
    800007ae:	ec06                	sd	ra,24(sp)
    800007b0:	e822                	sd	s0,16(sp)
    800007b2:	e426                	sd	s1,8(sp)
    800007b4:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    800007b6:	00010497          	auipc	s1,0x10
    800007ba:	41248493          	addi	s1,s1,1042 # 80010bc8 <pr>
    800007be:	00008597          	auipc	a1,0x8
    800007c2:	87a58593          	addi	a1,a1,-1926 # 80008038 <etext+0x38>
    800007c6:	8526                	mv	a0,s1
    800007c8:	00000097          	auipc	ra,0x0
    800007cc:	3c0080e7          	jalr	960(ra) # 80000b88 <initlock>
  pr.locking = 1;
    800007d0:	4785                	li	a5,1
    800007d2:	cc9c                	sw	a5,24(s1)
}
    800007d4:	60e2                	ld	ra,24(sp)
    800007d6:	6442                	ld	s0,16(sp)
    800007d8:	64a2                	ld	s1,8(sp)
    800007da:	6105                	addi	sp,sp,32
    800007dc:	8082                	ret

00000000800007de <uartinit>:

void uartstart();

void
uartinit(void)
{
    800007de:	1141                	addi	sp,sp,-16
    800007e0:	e406                	sd	ra,8(sp)
    800007e2:	e022                	sd	s0,0(sp)
    800007e4:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    800007e6:	100007b7          	lui	a5,0x10000
    800007ea:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    800007ee:	f8000713          	li	a4,-128
    800007f2:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800007f6:	470d                	li	a4,3
    800007f8:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800007fc:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80000800:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80000804:	469d                	li	a3,7
    80000806:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    8000080a:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    8000080e:	00008597          	auipc	a1,0x8
    80000812:	84a58593          	addi	a1,a1,-1974 # 80008058 <digits+0x18>
    80000816:	00010517          	auipc	a0,0x10
    8000081a:	3d250513          	addi	a0,a0,978 # 80010be8 <uart_tx_lock>
    8000081e:	00000097          	auipc	ra,0x0
    80000822:	36a080e7          	jalr	874(ra) # 80000b88 <initlock>
}
    80000826:	60a2                	ld	ra,8(sp)
    80000828:	6402                	ld	s0,0(sp)
    8000082a:	0141                	addi	sp,sp,16
    8000082c:	8082                	ret

000000008000082e <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    8000082e:	1101                	addi	sp,sp,-32
    80000830:	ec06                	sd	ra,24(sp)
    80000832:	e822                	sd	s0,16(sp)
    80000834:	e426                	sd	s1,8(sp)
    80000836:	1000                	addi	s0,sp,32
    80000838:	84aa                	mv	s1,a0
  push_off();
    8000083a:	00000097          	auipc	ra,0x0
    8000083e:	392080e7          	jalr	914(ra) # 80000bcc <push_off>

  if(panicked){
    80000842:	00008797          	auipc	a5,0x8
    80000846:	15e7a783          	lw	a5,350(a5) # 800089a0 <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    8000084a:	10000737          	lui	a4,0x10000
  if(panicked){
    8000084e:	c391                	beqz	a5,80000852 <uartputc_sync+0x24>
    for(;;)
    80000850:	a001                	j	80000850 <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000852:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80000856:	0207f793          	andi	a5,a5,32
    8000085a:	dfe5                	beqz	a5,80000852 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    8000085c:	0ff4f513          	zext.b	a0,s1
    80000860:	100007b7          	lui	a5,0x10000
    80000864:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80000868:	00000097          	auipc	ra,0x0
    8000086c:	404080e7          	jalr	1028(ra) # 80000c6c <pop_off>
}
    80000870:	60e2                	ld	ra,24(sp)
    80000872:	6442                	ld	s0,16(sp)
    80000874:	64a2                	ld	s1,8(sp)
    80000876:	6105                	addi	sp,sp,32
    80000878:	8082                	ret

000000008000087a <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    8000087a:	00008797          	auipc	a5,0x8
    8000087e:	12e7b783          	ld	a5,302(a5) # 800089a8 <uart_tx_r>
    80000882:	00008717          	auipc	a4,0x8
    80000886:	12e73703          	ld	a4,302(a4) # 800089b0 <uart_tx_w>
    8000088a:	06f70a63          	beq	a4,a5,800008fe <uartstart+0x84>
{
    8000088e:	7139                	addi	sp,sp,-64
    80000890:	fc06                	sd	ra,56(sp)
    80000892:	f822                	sd	s0,48(sp)
    80000894:	f426                	sd	s1,40(sp)
    80000896:	f04a                	sd	s2,32(sp)
    80000898:	ec4e                	sd	s3,24(sp)
    8000089a:	e852                	sd	s4,16(sp)
    8000089c:	e456                	sd	s5,8(sp)
    8000089e:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    800008a0:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    800008a4:	00010a17          	auipc	s4,0x10
    800008a8:	344a0a13          	addi	s4,s4,836 # 80010be8 <uart_tx_lock>
    uart_tx_r += 1;
    800008ac:	00008497          	auipc	s1,0x8
    800008b0:	0fc48493          	addi	s1,s1,252 # 800089a8 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    800008b4:	00008997          	auipc	s3,0x8
    800008b8:	0fc98993          	addi	s3,s3,252 # 800089b0 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    800008bc:	00594703          	lbu	a4,5(s2) # 10000005 <_entry-0x6ffffffb>
    800008c0:	02077713          	andi	a4,a4,32
    800008c4:	c705                	beqz	a4,800008ec <uartstart+0x72>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    800008c6:	01f7f713          	andi	a4,a5,31
    800008ca:	9752                	add	a4,a4,s4
    800008cc:	01874a83          	lbu	s5,24(a4)
    uart_tx_r += 1;
    800008d0:	0785                	addi	a5,a5,1
    800008d2:	e09c                	sd	a5,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    800008d4:	8526                	mv	a0,s1
    800008d6:	00002097          	auipc	ra,0x2
    800008da:	ba6080e7          	jalr	-1114(ra) # 8000247c <wakeup>
    
    WriteReg(THR, c);
    800008de:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    800008e2:	609c                	ld	a5,0(s1)
    800008e4:	0009b703          	ld	a4,0(s3)
    800008e8:	fcf71ae3          	bne	a4,a5,800008bc <uartstart+0x42>
  }
}
    800008ec:	70e2                	ld	ra,56(sp)
    800008ee:	7442                	ld	s0,48(sp)
    800008f0:	74a2                	ld	s1,40(sp)
    800008f2:	7902                	ld	s2,32(sp)
    800008f4:	69e2                	ld	s3,24(sp)
    800008f6:	6a42                	ld	s4,16(sp)
    800008f8:	6aa2                	ld	s5,8(sp)
    800008fa:	6121                	addi	sp,sp,64
    800008fc:	8082                	ret
    800008fe:	8082                	ret

0000000080000900 <uartputc>:
{
    80000900:	7179                	addi	sp,sp,-48
    80000902:	f406                	sd	ra,40(sp)
    80000904:	f022                	sd	s0,32(sp)
    80000906:	ec26                	sd	s1,24(sp)
    80000908:	e84a                	sd	s2,16(sp)
    8000090a:	e44e                	sd	s3,8(sp)
    8000090c:	e052                	sd	s4,0(sp)
    8000090e:	1800                	addi	s0,sp,48
    80000910:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    80000912:	00010517          	auipc	a0,0x10
    80000916:	2d650513          	addi	a0,a0,726 # 80010be8 <uart_tx_lock>
    8000091a:	00000097          	auipc	ra,0x0
    8000091e:	2fe080e7          	jalr	766(ra) # 80000c18 <acquire>
  if(panicked){
    80000922:	00008797          	auipc	a5,0x8
    80000926:	07e7a783          	lw	a5,126(a5) # 800089a0 <panicked>
    8000092a:	e7c9                	bnez	a5,800009b4 <uartputc+0xb4>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000092c:	00008717          	auipc	a4,0x8
    80000930:	08473703          	ld	a4,132(a4) # 800089b0 <uart_tx_w>
    80000934:	00008797          	auipc	a5,0x8
    80000938:	0747b783          	ld	a5,116(a5) # 800089a8 <uart_tx_r>
    8000093c:	02078793          	addi	a5,a5,32
    sleep(&uart_tx_r, &uart_tx_lock);
    80000940:	00010997          	auipc	s3,0x10
    80000944:	2a898993          	addi	s3,s3,680 # 80010be8 <uart_tx_lock>
    80000948:	00008497          	auipc	s1,0x8
    8000094c:	06048493          	addi	s1,s1,96 # 800089a8 <uart_tx_r>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000950:	00008917          	auipc	s2,0x8
    80000954:	06090913          	addi	s2,s2,96 # 800089b0 <uart_tx_w>
    80000958:	00e79f63          	bne	a5,a4,80000976 <uartputc+0x76>
    sleep(&uart_tx_r, &uart_tx_lock);
    8000095c:	85ce                	mv	a1,s3
    8000095e:	8526                	mv	a0,s1
    80000960:	00002097          	auipc	ra,0x2
    80000964:	ab8080e7          	jalr	-1352(ra) # 80002418 <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000968:	00093703          	ld	a4,0(s2)
    8000096c:	609c                	ld	a5,0(s1)
    8000096e:	02078793          	addi	a5,a5,32
    80000972:	fee785e3          	beq	a5,a4,8000095c <uartputc+0x5c>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80000976:	00010497          	auipc	s1,0x10
    8000097a:	27248493          	addi	s1,s1,626 # 80010be8 <uart_tx_lock>
    8000097e:	01f77793          	andi	a5,a4,31
    80000982:	97a6                	add	a5,a5,s1
    80000984:	01478c23          	sb	s4,24(a5)
  uart_tx_w += 1;
    80000988:	0705                	addi	a4,a4,1
    8000098a:	00008797          	auipc	a5,0x8
    8000098e:	02e7b323          	sd	a4,38(a5) # 800089b0 <uart_tx_w>
  uartstart();
    80000992:	00000097          	auipc	ra,0x0
    80000996:	ee8080e7          	jalr	-280(ra) # 8000087a <uartstart>
  release(&uart_tx_lock);
    8000099a:	8526                	mv	a0,s1
    8000099c:	00000097          	auipc	ra,0x0
    800009a0:	330080e7          	jalr	816(ra) # 80000ccc <release>
}
    800009a4:	70a2                	ld	ra,40(sp)
    800009a6:	7402                	ld	s0,32(sp)
    800009a8:	64e2                	ld	s1,24(sp)
    800009aa:	6942                	ld	s2,16(sp)
    800009ac:	69a2                	ld	s3,8(sp)
    800009ae:	6a02                	ld	s4,0(sp)
    800009b0:	6145                	addi	sp,sp,48
    800009b2:	8082                	ret
    for(;;)
    800009b4:	a001                	j	800009b4 <uartputc+0xb4>

00000000800009b6 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    800009b6:	1141                	addi	sp,sp,-16
    800009b8:	e422                	sd	s0,8(sp)
    800009ba:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    800009bc:	100007b7          	lui	a5,0x10000
    800009c0:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800009c4:	8b85                	andi	a5,a5,1
    800009c6:	cb81                	beqz	a5,800009d6 <uartgetc+0x20>
    // input data is ready.
    return ReadReg(RHR);
    800009c8:	100007b7          	lui	a5,0x10000
    800009cc:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    800009d0:	6422                	ld	s0,8(sp)
    800009d2:	0141                	addi	sp,sp,16
    800009d4:	8082                	ret
    return -1;
    800009d6:	557d                	li	a0,-1
    800009d8:	bfe5                	j	800009d0 <uartgetc+0x1a>

00000000800009da <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    800009da:	1101                	addi	sp,sp,-32
    800009dc:	ec06                	sd	ra,24(sp)
    800009de:	e822                	sd	s0,16(sp)
    800009e0:	e426                	sd	s1,8(sp)
    800009e2:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    800009e4:	54fd                	li	s1,-1
    800009e6:	a029                	j	800009f0 <uartintr+0x16>
      break;
    consoleintr(c);
    800009e8:	00000097          	auipc	ra,0x0
    800009ec:	8d2080e7          	jalr	-1838(ra) # 800002ba <consoleintr>
    int c = uartgetc();
    800009f0:	00000097          	auipc	ra,0x0
    800009f4:	fc6080e7          	jalr	-58(ra) # 800009b6 <uartgetc>
    if(c == -1)
    800009f8:	fe9518e3          	bne	a0,s1,800009e8 <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800009fc:	00010497          	auipc	s1,0x10
    80000a00:	1ec48493          	addi	s1,s1,492 # 80010be8 <uart_tx_lock>
    80000a04:	8526                	mv	a0,s1
    80000a06:	00000097          	auipc	ra,0x0
    80000a0a:	212080e7          	jalr	530(ra) # 80000c18 <acquire>
  uartstart();
    80000a0e:	00000097          	auipc	ra,0x0
    80000a12:	e6c080e7          	jalr	-404(ra) # 8000087a <uartstart>
  release(&uart_tx_lock);
    80000a16:	8526                	mv	a0,s1
    80000a18:	00000097          	auipc	ra,0x0
    80000a1c:	2b4080e7          	jalr	692(ra) # 80000ccc <release>
}
    80000a20:	60e2                	ld	ra,24(sp)
    80000a22:	6442                	ld	s0,16(sp)
    80000a24:	64a2                	ld	s1,8(sp)
    80000a26:	6105                	addi	sp,sp,32
    80000a28:	8082                	ret

0000000080000a2a <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    80000a2a:	1101                	addi	sp,sp,-32
    80000a2c:	ec06                	sd	ra,24(sp)
    80000a2e:	e822                	sd	s0,16(sp)
    80000a30:	e426                	sd	s1,8(sp)
    80000a32:	e04a                	sd	s2,0(sp)
    80000a34:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000a36:	03451793          	slli	a5,a0,0x34
    80000a3a:	ebb9                	bnez	a5,80000a90 <kfree+0x66>
    80000a3c:	84aa                	mv	s1,a0
    80000a3e:	00021797          	auipc	a5,0x21
    80000a42:	61278793          	addi	a5,a5,1554 # 80022050 <end>
    80000a46:	04f56563          	bltu	a0,a5,80000a90 <kfree+0x66>
    80000a4a:	47c5                	li	a5,17
    80000a4c:	07ee                	slli	a5,a5,0x1b
    80000a4e:	04f57163          	bgeu	a0,a5,80000a90 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000a52:	6605                	lui	a2,0x1
    80000a54:	4585                	li	a1,1
    80000a56:	00000097          	auipc	ra,0x0
    80000a5a:	2be080e7          	jalr	702(ra) # 80000d14 <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000a5e:	00010917          	auipc	s2,0x10
    80000a62:	1c290913          	addi	s2,s2,450 # 80010c20 <kmem>
    80000a66:	854a                	mv	a0,s2
    80000a68:	00000097          	auipc	ra,0x0
    80000a6c:	1b0080e7          	jalr	432(ra) # 80000c18 <acquire>
  r->next = kmem.freelist;
    80000a70:	01893783          	ld	a5,24(s2)
    80000a74:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000a76:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    80000a7a:	854a                	mv	a0,s2
    80000a7c:	00000097          	auipc	ra,0x0
    80000a80:	250080e7          	jalr	592(ra) # 80000ccc <release>
}
    80000a84:	60e2                	ld	ra,24(sp)
    80000a86:	6442                	ld	s0,16(sp)
    80000a88:	64a2                	ld	s1,8(sp)
    80000a8a:	6902                	ld	s2,0(sp)
    80000a8c:	6105                	addi	sp,sp,32
    80000a8e:	8082                	ret
    panic("kfree");
    80000a90:	00007517          	auipc	a0,0x7
    80000a94:	5d050513          	addi	a0,a0,1488 # 80008060 <digits+0x20>
    80000a98:	00000097          	auipc	ra,0x0
    80000a9c:	aea080e7          	jalr	-1302(ra) # 80000582 <panic>

0000000080000aa0 <freerange>:
{
    80000aa0:	7179                	addi	sp,sp,-48
    80000aa2:	f406                	sd	ra,40(sp)
    80000aa4:	f022                	sd	s0,32(sp)
    80000aa6:	ec26                	sd	s1,24(sp)
    80000aa8:	e84a                	sd	s2,16(sp)
    80000aaa:	e44e                	sd	s3,8(sp)
    80000aac:	e052                	sd	s4,0(sp)
    80000aae:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    80000ab0:	6785                	lui	a5,0x1
    80000ab2:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    80000ab6:	00e504b3          	add	s1,a0,a4
    80000aba:	777d                	lui	a4,0xfffff
    80000abc:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000abe:	94be                	add	s1,s1,a5
    80000ac0:	0095ee63          	bltu	a1,s1,80000adc <freerange+0x3c>
    80000ac4:	892e                	mv	s2,a1
    kfree(p);
    80000ac6:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000ac8:	6985                	lui	s3,0x1
    kfree(p);
    80000aca:	01448533          	add	a0,s1,s4
    80000ace:	00000097          	auipc	ra,0x0
    80000ad2:	f5c080e7          	jalr	-164(ra) # 80000a2a <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000ad6:	94ce                	add	s1,s1,s3
    80000ad8:	fe9979e3          	bgeu	s2,s1,80000aca <freerange+0x2a>
}
    80000adc:	70a2                	ld	ra,40(sp)
    80000ade:	7402                	ld	s0,32(sp)
    80000ae0:	64e2                	ld	s1,24(sp)
    80000ae2:	6942                	ld	s2,16(sp)
    80000ae4:	69a2                	ld	s3,8(sp)
    80000ae6:	6a02                	ld	s4,0(sp)
    80000ae8:	6145                	addi	sp,sp,48
    80000aea:	8082                	ret

0000000080000aec <kinit>:
{
    80000aec:	1141                	addi	sp,sp,-16
    80000aee:	e406                	sd	ra,8(sp)
    80000af0:	e022                	sd	s0,0(sp)
    80000af2:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80000af4:	00007597          	auipc	a1,0x7
    80000af8:	57458593          	addi	a1,a1,1396 # 80008068 <digits+0x28>
    80000afc:	00010517          	auipc	a0,0x10
    80000b00:	12450513          	addi	a0,a0,292 # 80010c20 <kmem>
    80000b04:	00000097          	auipc	ra,0x0
    80000b08:	084080e7          	jalr	132(ra) # 80000b88 <initlock>
  freerange(end, (void*)PHYSTOP);
    80000b0c:	45c5                	li	a1,17
    80000b0e:	05ee                	slli	a1,a1,0x1b
    80000b10:	00021517          	auipc	a0,0x21
    80000b14:	54050513          	addi	a0,a0,1344 # 80022050 <end>
    80000b18:	00000097          	auipc	ra,0x0
    80000b1c:	f88080e7          	jalr	-120(ra) # 80000aa0 <freerange>
}
    80000b20:	60a2                	ld	ra,8(sp)
    80000b22:	6402                	ld	s0,0(sp)
    80000b24:	0141                	addi	sp,sp,16
    80000b26:	8082                	ret

0000000080000b28 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000b28:	1101                	addi	sp,sp,-32
    80000b2a:	ec06                	sd	ra,24(sp)
    80000b2c:	e822                	sd	s0,16(sp)
    80000b2e:	e426                	sd	s1,8(sp)
    80000b30:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000b32:	00010497          	auipc	s1,0x10
    80000b36:	0ee48493          	addi	s1,s1,238 # 80010c20 <kmem>
    80000b3a:	8526                	mv	a0,s1
    80000b3c:	00000097          	auipc	ra,0x0
    80000b40:	0dc080e7          	jalr	220(ra) # 80000c18 <acquire>
  r = kmem.freelist;
    80000b44:	6c84                	ld	s1,24(s1)
  if(r)
    80000b46:	c885                	beqz	s1,80000b76 <kalloc+0x4e>
    kmem.freelist = r->next;
    80000b48:	609c                	ld	a5,0(s1)
    80000b4a:	00010517          	auipc	a0,0x10
    80000b4e:	0d650513          	addi	a0,a0,214 # 80010c20 <kmem>
    80000b52:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000b54:	00000097          	auipc	ra,0x0
    80000b58:	178080e7          	jalr	376(ra) # 80000ccc <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    80000b5c:	6605                	lui	a2,0x1
    80000b5e:	4595                	li	a1,5
    80000b60:	8526                	mv	a0,s1
    80000b62:	00000097          	auipc	ra,0x0
    80000b66:	1b2080e7          	jalr	434(ra) # 80000d14 <memset>
  return (void*)r;
}
    80000b6a:	8526                	mv	a0,s1
    80000b6c:	60e2                	ld	ra,24(sp)
    80000b6e:	6442                	ld	s0,16(sp)
    80000b70:	64a2                	ld	s1,8(sp)
    80000b72:	6105                	addi	sp,sp,32
    80000b74:	8082                	ret
  release(&kmem.lock);
    80000b76:	00010517          	auipc	a0,0x10
    80000b7a:	0aa50513          	addi	a0,a0,170 # 80010c20 <kmem>
    80000b7e:	00000097          	auipc	ra,0x0
    80000b82:	14e080e7          	jalr	334(ra) # 80000ccc <release>
  if(r)
    80000b86:	b7d5                	j	80000b6a <kalloc+0x42>

0000000080000b88 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80000b88:	1141                	addi	sp,sp,-16
    80000b8a:	e422                	sd	s0,8(sp)
    80000b8c:	0800                	addi	s0,sp,16
  lk->name = name;
    80000b8e:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80000b90:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80000b94:	00053823          	sd	zero,16(a0)
}
    80000b98:	6422                	ld	s0,8(sp)
    80000b9a:	0141                	addi	sp,sp,16
    80000b9c:	8082                	ret

0000000080000b9e <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80000b9e:	411c                	lw	a5,0(a0)
    80000ba0:	e399                	bnez	a5,80000ba6 <holding+0x8>
    80000ba2:	4501                	li	a0,0
  return r;
}
    80000ba4:	8082                	ret
{
    80000ba6:	1101                	addi	sp,sp,-32
    80000ba8:	ec06                	sd	ra,24(sp)
    80000baa:	e822                	sd	s0,16(sp)
    80000bac:	e426                	sd	s1,8(sp)
    80000bae:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80000bb0:	6904                	ld	s1,16(a0)
    80000bb2:	00001097          	auipc	ra,0x1
    80000bb6:	086080e7          	jalr	134(ra) # 80001c38 <mycpu>
    80000bba:	40a48533          	sub	a0,s1,a0
    80000bbe:	00153513          	seqz	a0,a0
}
    80000bc2:	60e2                	ld	ra,24(sp)
    80000bc4:	6442                	ld	s0,16(sp)
    80000bc6:	64a2                	ld	s1,8(sp)
    80000bc8:	6105                	addi	sp,sp,32
    80000bca:	8082                	ret

0000000080000bcc <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80000bcc:	1101                	addi	sp,sp,-32
    80000bce:	ec06                	sd	ra,24(sp)
    80000bd0:	e822                	sd	s0,16(sp)
    80000bd2:	e426                	sd	s1,8(sp)
    80000bd4:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000bd6:	100024f3          	csrr	s1,sstatus
    80000bda:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80000bde:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000be0:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80000be4:	00001097          	auipc	ra,0x1
    80000be8:	054080e7          	jalr	84(ra) # 80001c38 <mycpu>
    80000bec:	5d3c                	lw	a5,120(a0)
    80000bee:	cf89                	beqz	a5,80000c08 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80000bf0:	00001097          	auipc	ra,0x1
    80000bf4:	048080e7          	jalr	72(ra) # 80001c38 <mycpu>
    80000bf8:	5d3c                	lw	a5,120(a0)
    80000bfa:	2785                	addiw	a5,a5,1
    80000bfc:	dd3c                	sw	a5,120(a0)
}
    80000bfe:	60e2                	ld	ra,24(sp)
    80000c00:	6442                	ld	s0,16(sp)
    80000c02:	64a2                	ld	s1,8(sp)
    80000c04:	6105                	addi	sp,sp,32
    80000c06:	8082                	ret
    mycpu()->intena = old;
    80000c08:	00001097          	auipc	ra,0x1
    80000c0c:	030080e7          	jalr	48(ra) # 80001c38 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80000c10:	8085                	srli	s1,s1,0x1
    80000c12:	8885                	andi	s1,s1,1
    80000c14:	dd64                	sw	s1,124(a0)
    80000c16:	bfe9                	j	80000bf0 <push_off+0x24>

0000000080000c18 <acquire>:
{
    80000c18:	1101                	addi	sp,sp,-32
    80000c1a:	ec06                	sd	ra,24(sp)
    80000c1c:	e822                	sd	s0,16(sp)
    80000c1e:	e426                	sd	s1,8(sp)
    80000c20:	1000                	addi	s0,sp,32
    80000c22:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80000c24:	00000097          	auipc	ra,0x0
    80000c28:	fa8080e7          	jalr	-88(ra) # 80000bcc <push_off>
  if(holding(lk))
    80000c2c:	8526                	mv	a0,s1
    80000c2e:	00000097          	auipc	ra,0x0
    80000c32:	f70080e7          	jalr	-144(ra) # 80000b9e <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000c36:	4705                	li	a4,1
  if(holding(lk))
    80000c38:	e115                	bnez	a0,80000c5c <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000c3a:	87ba                	mv	a5,a4
    80000c3c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80000c40:	2781                	sext.w	a5,a5
    80000c42:	ffe5                	bnez	a5,80000c3a <acquire+0x22>
  __sync_synchronize();
    80000c44:	0ff0000f          	fence
  lk->cpu = mycpu();
    80000c48:	00001097          	auipc	ra,0x1
    80000c4c:	ff0080e7          	jalr	-16(ra) # 80001c38 <mycpu>
    80000c50:	e888                	sd	a0,16(s1)
}
    80000c52:	60e2                	ld	ra,24(sp)
    80000c54:	6442                	ld	s0,16(sp)
    80000c56:	64a2                	ld	s1,8(sp)
    80000c58:	6105                	addi	sp,sp,32
    80000c5a:	8082                	ret
    panic("acquire");
    80000c5c:	00007517          	auipc	a0,0x7
    80000c60:	41450513          	addi	a0,a0,1044 # 80008070 <digits+0x30>
    80000c64:	00000097          	auipc	ra,0x0
    80000c68:	91e080e7          	jalr	-1762(ra) # 80000582 <panic>

0000000080000c6c <pop_off>:

void
pop_off(void)
{
    80000c6c:	1141                	addi	sp,sp,-16
    80000c6e:	e406                	sd	ra,8(sp)
    80000c70:	e022                	sd	s0,0(sp)
    80000c72:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80000c74:	00001097          	auipc	ra,0x1
    80000c78:	fc4080e7          	jalr	-60(ra) # 80001c38 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000c7c:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80000c80:	8b89                	andi	a5,a5,2
  if(intr_get())
    80000c82:	e78d                	bnez	a5,80000cac <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80000c84:	5d3c                	lw	a5,120(a0)
    80000c86:	02f05b63          	blez	a5,80000cbc <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    80000c8a:	37fd                	addiw	a5,a5,-1
    80000c8c:	0007871b          	sext.w	a4,a5
    80000c90:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80000c92:	eb09                	bnez	a4,80000ca4 <pop_off+0x38>
    80000c94:	5d7c                	lw	a5,124(a0)
    80000c96:	c799                	beqz	a5,80000ca4 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000c98:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80000c9c:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000ca0:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80000ca4:	60a2                	ld	ra,8(sp)
    80000ca6:	6402                	ld	s0,0(sp)
    80000ca8:	0141                	addi	sp,sp,16
    80000caa:	8082                	ret
    panic("pop_off - interruptible");
    80000cac:	00007517          	auipc	a0,0x7
    80000cb0:	3cc50513          	addi	a0,a0,972 # 80008078 <digits+0x38>
    80000cb4:	00000097          	auipc	ra,0x0
    80000cb8:	8ce080e7          	jalr	-1842(ra) # 80000582 <panic>
    panic("pop_off");
    80000cbc:	00007517          	auipc	a0,0x7
    80000cc0:	3d450513          	addi	a0,a0,980 # 80008090 <digits+0x50>
    80000cc4:	00000097          	auipc	ra,0x0
    80000cc8:	8be080e7          	jalr	-1858(ra) # 80000582 <panic>

0000000080000ccc <release>:
{
    80000ccc:	1101                	addi	sp,sp,-32
    80000cce:	ec06                	sd	ra,24(sp)
    80000cd0:	e822                	sd	s0,16(sp)
    80000cd2:	e426                	sd	s1,8(sp)
    80000cd4:	1000                	addi	s0,sp,32
    80000cd6:	84aa                	mv	s1,a0
  if(!holding(lk))
    80000cd8:	00000097          	auipc	ra,0x0
    80000cdc:	ec6080e7          	jalr	-314(ra) # 80000b9e <holding>
    80000ce0:	c115                	beqz	a0,80000d04 <release+0x38>
  lk->cpu = 0;
    80000ce2:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80000ce6:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80000cea:	0f50000f          	fence	iorw,ow
    80000cee:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80000cf2:	00000097          	auipc	ra,0x0
    80000cf6:	f7a080e7          	jalr	-134(ra) # 80000c6c <pop_off>
}
    80000cfa:	60e2                	ld	ra,24(sp)
    80000cfc:	6442                	ld	s0,16(sp)
    80000cfe:	64a2                	ld	s1,8(sp)
    80000d00:	6105                	addi	sp,sp,32
    80000d02:	8082                	ret
    panic("release");
    80000d04:	00007517          	auipc	a0,0x7
    80000d08:	39450513          	addi	a0,a0,916 # 80008098 <digits+0x58>
    80000d0c:	00000097          	auipc	ra,0x0
    80000d10:	876080e7          	jalr	-1930(ra) # 80000582 <panic>

0000000080000d14 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000d14:	1141                	addi	sp,sp,-16
    80000d16:	e422                	sd	s0,8(sp)
    80000d18:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000d1a:	ca19                	beqz	a2,80000d30 <memset+0x1c>
    80000d1c:	87aa                	mv	a5,a0
    80000d1e:	1602                	slli	a2,a2,0x20
    80000d20:	9201                	srli	a2,a2,0x20
    80000d22:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80000d26:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000d2a:	0785                	addi	a5,a5,1
    80000d2c:	fee79de3          	bne	a5,a4,80000d26 <memset+0x12>
  }
  return dst;
}
    80000d30:	6422                	ld	s0,8(sp)
    80000d32:	0141                	addi	sp,sp,16
    80000d34:	8082                	ret

0000000080000d36 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000d36:	1141                	addi	sp,sp,-16
    80000d38:	e422                	sd	s0,8(sp)
    80000d3a:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    80000d3c:	ca05                	beqz	a2,80000d6c <memcmp+0x36>
    80000d3e:	fff6069b          	addiw	a3,a2,-1 # fff <_entry-0x7ffff001>
    80000d42:	1682                	slli	a3,a3,0x20
    80000d44:	9281                	srli	a3,a3,0x20
    80000d46:	0685                	addi	a3,a3,1
    80000d48:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    80000d4a:	00054783          	lbu	a5,0(a0)
    80000d4e:	0005c703          	lbu	a4,0(a1)
    80000d52:	00e79863          	bne	a5,a4,80000d62 <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    80000d56:	0505                	addi	a0,a0,1
    80000d58:	0585                	addi	a1,a1,1
  while(n-- > 0){
    80000d5a:	fed518e3          	bne	a0,a3,80000d4a <memcmp+0x14>
  }

  return 0;
    80000d5e:	4501                	li	a0,0
    80000d60:	a019                	j	80000d66 <memcmp+0x30>
      return *s1 - *s2;
    80000d62:	40e7853b          	subw	a0,a5,a4
}
    80000d66:	6422                	ld	s0,8(sp)
    80000d68:	0141                	addi	sp,sp,16
    80000d6a:	8082                	ret
  return 0;
    80000d6c:	4501                	li	a0,0
    80000d6e:	bfe5                	j	80000d66 <memcmp+0x30>

0000000080000d70 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80000d70:	1141                	addi	sp,sp,-16
    80000d72:	e422                	sd	s0,8(sp)
    80000d74:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    80000d76:	c205                	beqz	a2,80000d96 <memmove+0x26>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    80000d78:	02a5e263          	bltu	a1,a0,80000d9c <memmove+0x2c>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    80000d7c:	1602                	slli	a2,a2,0x20
    80000d7e:	9201                	srli	a2,a2,0x20
    80000d80:	00c587b3          	add	a5,a1,a2
{
    80000d84:	872a                	mv	a4,a0
      *d++ = *s++;
    80000d86:	0585                	addi	a1,a1,1
    80000d88:	0705                	addi	a4,a4,1 # fffffffffffff001 <end+0xffffffff7ffdcfb1>
    80000d8a:	fff5c683          	lbu	a3,-1(a1)
    80000d8e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    80000d92:	fef59ae3          	bne	a1,a5,80000d86 <memmove+0x16>

  return dst;
}
    80000d96:	6422                	ld	s0,8(sp)
    80000d98:	0141                	addi	sp,sp,16
    80000d9a:	8082                	ret
  if(s < d && s + n > d){
    80000d9c:	02061693          	slli	a3,a2,0x20
    80000da0:	9281                	srli	a3,a3,0x20
    80000da2:	00d58733          	add	a4,a1,a3
    80000da6:	fce57be3          	bgeu	a0,a4,80000d7c <memmove+0xc>
    d += n;
    80000daa:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000dac:	fff6079b          	addiw	a5,a2,-1
    80000db0:	1782                	slli	a5,a5,0x20
    80000db2:	9381                	srli	a5,a5,0x20
    80000db4:	fff7c793          	not	a5,a5
    80000db8:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000dba:	177d                	addi	a4,a4,-1
    80000dbc:	16fd                	addi	a3,a3,-1
    80000dbe:	00074603          	lbu	a2,0(a4)
    80000dc2:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000dc6:	fee79ae3          	bne	a5,a4,80000dba <memmove+0x4a>
    80000dca:	b7f1                	j	80000d96 <memmove+0x26>

0000000080000dcc <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000dcc:	1141                	addi	sp,sp,-16
    80000dce:	e406                	sd	ra,8(sp)
    80000dd0:	e022                	sd	s0,0(sp)
    80000dd2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000dd4:	00000097          	auipc	ra,0x0
    80000dd8:	f9c080e7          	jalr	-100(ra) # 80000d70 <memmove>
}
    80000ddc:	60a2                	ld	ra,8(sp)
    80000dde:	6402                	ld	s0,0(sp)
    80000de0:	0141                	addi	sp,sp,16
    80000de2:	8082                	ret

0000000080000de4 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000de4:	1141                	addi	sp,sp,-16
    80000de6:	e422                	sd	s0,8(sp)
    80000de8:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000dea:	ce11                	beqz	a2,80000e06 <strncmp+0x22>
    80000dec:	00054783          	lbu	a5,0(a0)
    80000df0:	cf89                	beqz	a5,80000e0a <strncmp+0x26>
    80000df2:	0005c703          	lbu	a4,0(a1)
    80000df6:	00f71a63          	bne	a4,a5,80000e0a <strncmp+0x26>
    n--, p++, q++;
    80000dfa:	367d                	addiw	a2,a2,-1
    80000dfc:	0505                	addi	a0,a0,1
    80000dfe:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000e00:	f675                	bnez	a2,80000dec <strncmp+0x8>
  if(n == 0)
    return 0;
    80000e02:	4501                	li	a0,0
    80000e04:	a809                	j	80000e16 <strncmp+0x32>
    80000e06:	4501                	li	a0,0
    80000e08:	a039                	j	80000e16 <strncmp+0x32>
  if(n == 0)
    80000e0a:	ca09                	beqz	a2,80000e1c <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000e0c:	00054503          	lbu	a0,0(a0)
    80000e10:	0005c783          	lbu	a5,0(a1)
    80000e14:	9d1d                	subw	a0,a0,a5
}
    80000e16:	6422                	ld	s0,8(sp)
    80000e18:	0141                	addi	sp,sp,16
    80000e1a:	8082                	ret
    return 0;
    80000e1c:	4501                	li	a0,0
    80000e1e:	bfe5                	j	80000e16 <strncmp+0x32>

0000000080000e20 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000e20:	1141                	addi	sp,sp,-16
    80000e22:	e422                	sd	s0,8(sp)
    80000e24:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000e26:	87aa                	mv	a5,a0
    80000e28:	86b2                	mv	a3,a2
    80000e2a:	367d                	addiw	a2,a2,-1
    80000e2c:	00d05963          	blez	a3,80000e3e <strncpy+0x1e>
    80000e30:	0785                	addi	a5,a5,1
    80000e32:	0005c703          	lbu	a4,0(a1)
    80000e36:	fee78fa3          	sb	a4,-1(a5)
    80000e3a:	0585                	addi	a1,a1,1
    80000e3c:	f775                	bnez	a4,80000e28 <strncpy+0x8>
    ;
  while(n-- > 0)
    80000e3e:	873e                	mv	a4,a5
    80000e40:	9fb5                	addw	a5,a5,a3
    80000e42:	37fd                	addiw	a5,a5,-1
    80000e44:	00c05963          	blez	a2,80000e56 <strncpy+0x36>
    *s++ = 0;
    80000e48:	0705                	addi	a4,a4,1
    80000e4a:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    80000e4e:	40e786bb          	subw	a3,a5,a4
    80000e52:	fed04be3          	bgtz	a3,80000e48 <strncpy+0x28>
  return os;
}
    80000e56:	6422                	ld	s0,8(sp)
    80000e58:	0141                	addi	sp,sp,16
    80000e5a:	8082                	ret

0000000080000e5c <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80000e5c:	1141                	addi	sp,sp,-16
    80000e5e:	e422                	sd	s0,8(sp)
    80000e60:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    80000e62:	02c05363          	blez	a2,80000e88 <safestrcpy+0x2c>
    80000e66:	fff6069b          	addiw	a3,a2,-1
    80000e6a:	1682                	slli	a3,a3,0x20
    80000e6c:	9281                	srli	a3,a3,0x20
    80000e6e:	96ae                	add	a3,a3,a1
    80000e70:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    80000e72:	00d58963          	beq	a1,a3,80000e84 <safestrcpy+0x28>
    80000e76:	0585                	addi	a1,a1,1
    80000e78:	0785                	addi	a5,a5,1
    80000e7a:	fff5c703          	lbu	a4,-1(a1)
    80000e7e:	fee78fa3          	sb	a4,-1(a5)
    80000e82:	fb65                	bnez	a4,80000e72 <safestrcpy+0x16>
    ;
  *s = 0;
    80000e84:	00078023          	sb	zero,0(a5)
  return os;
}
    80000e88:	6422                	ld	s0,8(sp)
    80000e8a:	0141                	addi	sp,sp,16
    80000e8c:	8082                	ret

0000000080000e8e <strlen>:

int
strlen(const char *s)
{
    80000e8e:	1141                	addi	sp,sp,-16
    80000e90:	e422                	sd	s0,8(sp)
    80000e92:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000e94:	00054783          	lbu	a5,0(a0)
    80000e98:	cf91                	beqz	a5,80000eb4 <strlen+0x26>
    80000e9a:	0505                	addi	a0,a0,1
    80000e9c:	87aa                	mv	a5,a0
    80000e9e:	86be                	mv	a3,a5
    80000ea0:	0785                	addi	a5,a5,1
    80000ea2:	fff7c703          	lbu	a4,-1(a5)
    80000ea6:	ff65                	bnez	a4,80000e9e <strlen+0x10>
    80000ea8:	40a6853b          	subw	a0,a3,a0
    80000eac:	2505                	addiw	a0,a0,1
    ;
  return n;
}
    80000eae:	6422                	ld	s0,8(sp)
    80000eb0:	0141                	addi	sp,sp,16
    80000eb2:	8082                	ret
  for(n = 0; s[n]; n++)
    80000eb4:	4501                	li	a0,0
    80000eb6:	bfe5                	j	80000eae <strlen+0x20>

0000000080000eb8 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000eb8:	1141                	addi	sp,sp,-16
    80000eba:	e406                	sd	ra,8(sp)
    80000ebc:	e022                	sd	s0,0(sp)
    80000ebe:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80000ec0:	00001097          	auipc	ra,0x1
    80000ec4:	d68080e7          	jalr	-664(ra) # 80001c28 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000ec8:	00008717          	auipc	a4,0x8
    80000ecc:	af070713          	addi	a4,a4,-1296 # 800089b8 <started>
  if(cpuid() == 0){
    80000ed0:	c139                	beqz	a0,80000f16 <main+0x5e>
    while(started == 0)
    80000ed2:	431c                	lw	a5,0(a4)
    80000ed4:	2781                	sext.w	a5,a5
    80000ed6:	dff5                	beqz	a5,80000ed2 <main+0x1a>
      ;
    __sync_synchronize();
    80000ed8:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    80000edc:	00001097          	auipc	ra,0x1
    80000ee0:	d4c080e7          	jalr	-692(ra) # 80001c28 <cpuid>
    80000ee4:	85aa                	mv	a1,a0
    80000ee6:	00007517          	auipc	a0,0x7
    80000eea:	1d250513          	addi	a0,a0,466 # 800080b8 <digits+0x78>
    80000eee:	fffff097          	auipc	ra,0xfffff
    80000ef2:	6de080e7          	jalr	1758(ra) # 800005cc <printf>
    kvminithart();    // turn on paging
    80000ef6:	00000097          	auipc	ra,0x0
    80000efa:	0d8080e7          	jalr	216(ra) # 80000fce <kvminithart>
    trapinithart();   // install kernel trap vector
    80000efe:	00002097          	auipc	ra,0x2
    80000f02:	c3e080e7          	jalr	-962(ra) # 80002b3c <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000f06:	00005097          	auipc	ra,0x5
    80000f0a:	20a080e7          	jalr	522(ra) # 80006110 <plicinithart>
  }

  scheduler();        
    80000f0e:	00001097          	auipc	ra,0x1
    80000f12:	394080e7          	jalr	916(ra) # 800022a2 <scheduler>
    consoleinit();
    80000f16:	fffff097          	auipc	ra,0xfffff
    80000f1a:	57c080e7          	jalr	1404(ra) # 80000492 <consoleinit>
    printfinit();
    80000f1e:	00000097          	auipc	ra,0x0
    80000f22:	88e080e7          	jalr	-1906(ra) # 800007ac <printfinit>
    printf("\n");
    80000f26:	00007517          	auipc	a0,0x7
    80000f2a:	1a250513          	addi	a0,a0,418 # 800080c8 <digits+0x88>
    80000f2e:	fffff097          	auipc	ra,0xfffff
    80000f32:	69e080e7          	jalr	1694(ra) # 800005cc <printf>
    printf("xv6 kernel is booting\n");
    80000f36:	00007517          	auipc	a0,0x7
    80000f3a:	16a50513          	addi	a0,a0,362 # 800080a0 <digits+0x60>
    80000f3e:	fffff097          	auipc	ra,0xfffff
    80000f42:	68e080e7          	jalr	1678(ra) # 800005cc <printf>
    printf("\n");
    80000f46:	00007517          	auipc	a0,0x7
    80000f4a:	18250513          	addi	a0,a0,386 # 800080c8 <digits+0x88>
    80000f4e:	fffff097          	auipc	ra,0xfffff
    80000f52:	67e080e7          	jalr	1662(ra) # 800005cc <printf>
    kinit();         // physical page allocator
    80000f56:	00000097          	auipc	ra,0x0
    80000f5a:	b96080e7          	jalr	-1130(ra) # 80000aec <kinit>
    kvminit();       // create kernel page table
    80000f5e:	00000097          	auipc	ra,0x0
    80000f62:	326080e7          	jalr	806(ra) # 80001284 <kvminit>
    kvminithart();   // turn on paging
    80000f66:	00000097          	auipc	ra,0x0
    80000f6a:	068080e7          	jalr	104(ra) # 80000fce <kvminithart>
    procinit();      // process table
    80000f6e:	00001097          	auipc	ra,0x1
    80000f72:	be2080e7          	jalr	-1054(ra) # 80001b50 <procinit>
    trapinit();      // trap vectors
    80000f76:	00002097          	auipc	ra,0x2
    80000f7a:	b9e080e7          	jalr	-1122(ra) # 80002b14 <trapinit>
    trapinithart();  // install kernel trap vector
    80000f7e:	00002097          	auipc	ra,0x2
    80000f82:	bbe080e7          	jalr	-1090(ra) # 80002b3c <trapinithart>
    plicinit();      // set up interrupt controller
    80000f86:	00005097          	auipc	ra,0x5
    80000f8a:	174080e7          	jalr	372(ra) # 800060fa <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000f8e:	00005097          	auipc	ra,0x5
    80000f92:	182080e7          	jalr	386(ra) # 80006110 <plicinithart>
    binit();         // buffer cache
    80000f96:	00002097          	auipc	ra,0x2
    80000f9a:	378080e7          	jalr	888(ra) # 8000330e <binit>
    iinit();         // inode table
    80000f9e:	00003097          	auipc	ra,0x3
    80000fa2:	a16080e7          	jalr	-1514(ra) # 800039b4 <iinit>
    fileinit();      // file table
    80000fa6:	00004097          	auipc	ra,0x4
    80000faa:	98c080e7          	jalr	-1652(ra) # 80004932 <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000fae:	00005097          	auipc	ra,0x5
    80000fb2:	26a080e7          	jalr	618(ra) # 80006218 <virtio_disk_init>
    userinit();      // first user process
    80000fb6:	00001097          	auipc	ra,0x1
    80000fba:	f7e080e7          	jalr	-130(ra) # 80001f34 <userinit>
    __sync_synchronize();
    80000fbe:	0ff0000f          	fence
    started = 1;
    80000fc2:	4785                	li	a5,1
    80000fc4:	00008717          	auipc	a4,0x8
    80000fc8:	9ef72a23          	sw	a5,-1548(a4) # 800089b8 <started>
    80000fcc:	b789                	j	80000f0e <main+0x56>

0000000080000fce <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80000fce:	1141                	addi	sp,sp,-16
    80000fd0:	e422                	sd	s0,8(sp)
    80000fd2:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000fd4:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    80000fd8:	00008797          	auipc	a5,0x8
    80000fdc:	9e87b783          	ld	a5,-1560(a5) # 800089c0 <kernel_pagetable>
    80000fe0:	83b1                	srli	a5,a5,0xc
    80000fe2:	577d                	li	a4,-1
    80000fe4:	177e                	slli	a4,a4,0x3f
    80000fe6:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80000fe8:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    80000fec:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    80000ff0:	6422                	ld	s0,8(sp)
    80000ff2:	0141                	addi	sp,sp,16
    80000ff4:	8082                	ret

0000000080000ff6 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000ff6:	7139                	addi	sp,sp,-64
    80000ff8:	fc06                	sd	ra,56(sp)
    80000ffa:	f822                	sd	s0,48(sp)
    80000ffc:	f426                	sd	s1,40(sp)
    80000ffe:	f04a                	sd	s2,32(sp)
    80001000:	ec4e                	sd	s3,24(sp)
    80001002:	e852                	sd	s4,16(sp)
    80001004:	e456                	sd	s5,8(sp)
    80001006:	e05a                	sd	s6,0(sp)
    80001008:	0080                	addi	s0,sp,64
    8000100a:	84aa                	mv	s1,a0
    8000100c:	89ae                	mv	s3,a1
    8000100e:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    80001010:	57fd                	li	a5,-1
    80001012:	83e9                	srli	a5,a5,0x1a
    80001014:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80001016:	4b31                	li	s6,12
  if(va >= MAXVA)
    80001018:	04b7f263          	bgeu	a5,a1,8000105c <walk+0x66>
    panic("walk");
    8000101c:	00007517          	auipc	a0,0x7
    80001020:	0b450513          	addi	a0,a0,180 # 800080d0 <digits+0x90>
    80001024:	fffff097          	auipc	ra,0xfffff
    80001028:	55e080e7          	jalr	1374(ra) # 80000582 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    8000102c:	060a8663          	beqz	s5,80001098 <walk+0xa2>
    80001030:	00000097          	auipc	ra,0x0
    80001034:	af8080e7          	jalr	-1288(ra) # 80000b28 <kalloc>
    80001038:	84aa                	mv	s1,a0
    8000103a:	c529                	beqz	a0,80001084 <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    8000103c:	6605                	lui	a2,0x1
    8000103e:	4581                	li	a1,0
    80001040:	00000097          	auipc	ra,0x0
    80001044:	cd4080e7          	jalr	-812(ra) # 80000d14 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80001048:	00c4d793          	srli	a5,s1,0xc
    8000104c:	07aa                	slli	a5,a5,0xa
    8000104e:	0017e793          	ori	a5,a5,1
    80001052:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    80001056:	3a5d                	addiw	s4,s4,-9 # ffffffffffffeff7 <end+0xffffffff7ffdcfa7>
    80001058:	036a0063          	beq	s4,s6,80001078 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    8000105c:	0149d933          	srl	s2,s3,s4
    80001060:	1ff97913          	andi	s2,s2,511
    80001064:	090e                	slli	s2,s2,0x3
    80001066:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    80001068:	00093483          	ld	s1,0(s2)
    8000106c:	0014f793          	andi	a5,s1,1
    80001070:	dfd5                	beqz	a5,8000102c <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80001072:	80a9                	srli	s1,s1,0xa
    80001074:	04b2                	slli	s1,s1,0xc
    80001076:	b7c5                	j	80001056 <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    80001078:	00c9d513          	srli	a0,s3,0xc
    8000107c:	1ff57513          	andi	a0,a0,511
    80001080:	050e                	slli	a0,a0,0x3
    80001082:	9526                	add	a0,a0,s1
}
    80001084:	70e2                	ld	ra,56(sp)
    80001086:	7442                	ld	s0,48(sp)
    80001088:	74a2                	ld	s1,40(sp)
    8000108a:	7902                	ld	s2,32(sp)
    8000108c:	69e2                	ld	s3,24(sp)
    8000108e:	6a42                	ld	s4,16(sp)
    80001090:	6aa2                	ld	s5,8(sp)
    80001092:	6b02                	ld	s6,0(sp)
    80001094:	6121                	addi	sp,sp,64
    80001096:	8082                	ret
        return 0;
    80001098:	4501                	li	a0,0
    8000109a:	b7ed                	j	80001084 <walk+0x8e>

000000008000109c <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    8000109c:	57fd                	li	a5,-1
    8000109e:	83e9                	srli	a5,a5,0x1a
    800010a0:	00b7f463          	bgeu	a5,a1,800010a8 <walkaddr+0xc>
    return 0;
    800010a4:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    800010a6:	8082                	ret
{
    800010a8:	1141                	addi	sp,sp,-16
    800010aa:	e406                	sd	ra,8(sp)
    800010ac:	e022                	sd	s0,0(sp)
    800010ae:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    800010b0:	4601                	li	a2,0
    800010b2:	00000097          	auipc	ra,0x0
    800010b6:	f44080e7          	jalr	-188(ra) # 80000ff6 <walk>
  if(pte == 0)
    800010ba:	c105                	beqz	a0,800010da <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    800010bc:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    800010be:	0117f693          	andi	a3,a5,17
    800010c2:	4745                	li	a4,17
    return 0;
    800010c4:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    800010c6:	00e68663          	beq	a3,a4,800010d2 <walkaddr+0x36>
}
    800010ca:	60a2                	ld	ra,8(sp)
    800010cc:	6402                	ld	s0,0(sp)
    800010ce:	0141                	addi	sp,sp,16
    800010d0:	8082                	ret
  pa = PTE2PA(*pte);
    800010d2:	83a9                	srli	a5,a5,0xa
    800010d4:	00c79513          	slli	a0,a5,0xc
  return pa;
    800010d8:	bfcd                	j	800010ca <walkaddr+0x2e>
    return 0;
    800010da:	4501                	li	a0,0
    800010dc:	b7fd                	j	800010ca <walkaddr+0x2e>

00000000800010de <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    800010de:	715d                	addi	sp,sp,-80
    800010e0:	e486                	sd	ra,72(sp)
    800010e2:	e0a2                	sd	s0,64(sp)
    800010e4:	fc26                	sd	s1,56(sp)
    800010e6:	f84a                	sd	s2,48(sp)
    800010e8:	f44e                	sd	s3,40(sp)
    800010ea:	f052                	sd	s4,32(sp)
    800010ec:	ec56                	sd	s5,24(sp)
    800010ee:	e85a                	sd	s6,16(sp)
    800010f0:	e45e                	sd	s7,8(sp)
    800010f2:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    800010f4:	c639                	beqz	a2,80001142 <mappages+0x64>
    800010f6:	8aaa                	mv	s5,a0
    800010f8:	8b3a                	mv	s6,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    800010fa:	777d                	lui	a4,0xfffff
    800010fc:	00e5f7b3          	and	a5,a1,a4
  last = PGROUNDDOWN(va + size - 1);
    80001100:	fff58993          	addi	s3,a1,-1
    80001104:	99b2                	add	s3,s3,a2
    80001106:	00e9f9b3          	and	s3,s3,a4
  a = PGROUNDDOWN(va);
    8000110a:	893e                	mv	s2,a5
    8000110c:	40f68a33          	sub	s4,a3,a5
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    80001110:	6b85                	lui	s7,0x1
    80001112:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    80001116:	4605                	li	a2,1
    80001118:	85ca                	mv	a1,s2
    8000111a:	8556                	mv	a0,s5
    8000111c:	00000097          	auipc	ra,0x0
    80001120:	eda080e7          	jalr	-294(ra) # 80000ff6 <walk>
    80001124:	cd1d                	beqz	a0,80001162 <mappages+0x84>
    if(*pte & PTE_V)
    80001126:	611c                	ld	a5,0(a0)
    80001128:	8b85                	andi	a5,a5,1
    8000112a:	e785                	bnez	a5,80001152 <mappages+0x74>
    *pte = PA2PTE(pa) | perm | PTE_V;
    8000112c:	80b1                	srli	s1,s1,0xc
    8000112e:	04aa                	slli	s1,s1,0xa
    80001130:	0164e4b3          	or	s1,s1,s6
    80001134:	0014e493          	ori	s1,s1,1
    80001138:	e104                	sd	s1,0(a0)
    if(a == last)
    8000113a:	05390063          	beq	s2,s3,8000117a <mappages+0x9c>
    a += PGSIZE;
    8000113e:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    80001140:	bfc9                	j	80001112 <mappages+0x34>
    panic("mappages: size");
    80001142:	00007517          	auipc	a0,0x7
    80001146:	f9650513          	addi	a0,a0,-106 # 800080d8 <digits+0x98>
    8000114a:	fffff097          	auipc	ra,0xfffff
    8000114e:	438080e7          	jalr	1080(ra) # 80000582 <panic>
      panic("mappages: remap");
    80001152:	00007517          	auipc	a0,0x7
    80001156:	f9650513          	addi	a0,a0,-106 # 800080e8 <digits+0xa8>
    8000115a:	fffff097          	auipc	ra,0xfffff
    8000115e:	428080e7          	jalr	1064(ra) # 80000582 <panic>
      return -1;
    80001162:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    80001164:	60a6                	ld	ra,72(sp)
    80001166:	6406                	ld	s0,64(sp)
    80001168:	74e2                	ld	s1,56(sp)
    8000116a:	7942                	ld	s2,48(sp)
    8000116c:	79a2                	ld	s3,40(sp)
    8000116e:	7a02                	ld	s4,32(sp)
    80001170:	6ae2                	ld	s5,24(sp)
    80001172:	6b42                	ld	s6,16(sp)
    80001174:	6ba2                	ld	s7,8(sp)
    80001176:	6161                	addi	sp,sp,80
    80001178:	8082                	ret
  return 0;
    8000117a:	4501                	li	a0,0
    8000117c:	b7e5                	j	80001164 <mappages+0x86>

000000008000117e <kvmmap>:
{
    8000117e:	1141                	addi	sp,sp,-16
    80001180:	e406                	sd	ra,8(sp)
    80001182:	e022                	sd	s0,0(sp)
    80001184:	0800                	addi	s0,sp,16
    80001186:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80001188:	86b2                	mv	a3,a2
    8000118a:	863e                	mv	a2,a5
    8000118c:	00000097          	auipc	ra,0x0
    80001190:	f52080e7          	jalr	-174(ra) # 800010de <mappages>
    80001194:	e509                	bnez	a0,8000119e <kvmmap+0x20>
}
    80001196:	60a2                	ld	ra,8(sp)
    80001198:	6402                	ld	s0,0(sp)
    8000119a:	0141                	addi	sp,sp,16
    8000119c:	8082                	ret
    panic("kvmmap");
    8000119e:	00007517          	auipc	a0,0x7
    800011a2:	f5a50513          	addi	a0,a0,-166 # 800080f8 <digits+0xb8>
    800011a6:	fffff097          	auipc	ra,0xfffff
    800011aa:	3dc080e7          	jalr	988(ra) # 80000582 <panic>

00000000800011ae <kvmmake>:
{
    800011ae:	1101                	addi	sp,sp,-32
    800011b0:	ec06                	sd	ra,24(sp)
    800011b2:	e822                	sd	s0,16(sp)
    800011b4:	e426                	sd	s1,8(sp)
    800011b6:	e04a                	sd	s2,0(sp)
    800011b8:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    800011ba:	00000097          	auipc	ra,0x0
    800011be:	96e080e7          	jalr	-1682(ra) # 80000b28 <kalloc>
    800011c2:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    800011c4:	6605                	lui	a2,0x1
    800011c6:	4581                	li	a1,0
    800011c8:	00000097          	auipc	ra,0x0
    800011cc:	b4c080e7          	jalr	-1204(ra) # 80000d14 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    800011d0:	4719                	li	a4,6
    800011d2:	6685                	lui	a3,0x1
    800011d4:	10000637          	lui	a2,0x10000
    800011d8:	100005b7          	lui	a1,0x10000
    800011dc:	8526                	mv	a0,s1
    800011de:	00000097          	auipc	ra,0x0
    800011e2:	fa0080e7          	jalr	-96(ra) # 8000117e <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    800011e6:	4719                	li	a4,6
    800011e8:	6685                	lui	a3,0x1
    800011ea:	10001637          	lui	a2,0x10001
    800011ee:	100015b7          	lui	a1,0x10001
    800011f2:	8526                	mv	a0,s1
    800011f4:	00000097          	auipc	ra,0x0
    800011f8:	f8a080e7          	jalr	-118(ra) # 8000117e <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    800011fc:	4719                	li	a4,6
    800011fe:	004006b7          	lui	a3,0x400
    80001202:	0c000637          	lui	a2,0xc000
    80001206:	0c0005b7          	lui	a1,0xc000
    8000120a:	8526                	mv	a0,s1
    8000120c:	00000097          	auipc	ra,0x0
    80001210:	f72080e7          	jalr	-142(ra) # 8000117e <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    80001214:	00007917          	auipc	s2,0x7
    80001218:	dec90913          	addi	s2,s2,-532 # 80008000 <etext>
    8000121c:	4729                	li	a4,10
    8000121e:	80007697          	auipc	a3,0x80007
    80001222:	de268693          	addi	a3,a3,-542 # 8000 <_entry-0x7fff8000>
    80001226:	4605                	li	a2,1
    80001228:	067e                	slli	a2,a2,0x1f
    8000122a:	85b2                	mv	a1,a2
    8000122c:	8526                	mv	a0,s1
    8000122e:	00000097          	auipc	ra,0x0
    80001232:	f50080e7          	jalr	-176(ra) # 8000117e <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    80001236:	4719                	li	a4,6
    80001238:	46c5                	li	a3,17
    8000123a:	06ee                	slli	a3,a3,0x1b
    8000123c:	412686b3          	sub	a3,a3,s2
    80001240:	864a                	mv	a2,s2
    80001242:	85ca                	mv	a1,s2
    80001244:	8526                	mv	a0,s1
    80001246:	00000097          	auipc	ra,0x0
    8000124a:	f38080e7          	jalr	-200(ra) # 8000117e <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    8000124e:	4729                	li	a4,10
    80001250:	6685                	lui	a3,0x1
    80001252:	00006617          	auipc	a2,0x6
    80001256:	dae60613          	addi	a2,a2,-594 # 80007000 <_trampoline>
    8000125a:	040005b7          	lui	a1,0x4000
    8000125e:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001260:	05b2                	slli	a1,a1,0xc
    80001262:	8526                	mv	a0,s1
    80001264:	00000097          	auipc	ra,0x0
    80001268:	f1a080e7          	jalr	-230(ra) # 8000117e <kvmmap>
  proc_mapstacks(kpgtbl);
    8000126c:	8526                	mv	a0,s1
    8000126e:	00001097          	auipc	ra,0x1
    80001272:	84c080e7          	jalr	-1972(ra) # 80001aba <proc_mapstacks>
}
    80001276:	8526                	mv	a0,s1
    80001278:	60e2                	ld	ra,24(sp)
    8000127a:	6442                	ld	s0,16(sp)
    8000127c:	64a2                	ld	s1,8(sp)
    8000127e:	6902                	ld	s2,0(sp)
    80001280:	6105                	addi	sp,sp,32
    80001282:	8082                	ret

0000000080001284 <kvminit>:
{
    80001284:	1141                	addi	sp,sp,-16
    80001286:	e406                	sd	ra,8(sp)
    80001288:	e022                	sd	s0,0(sp)
    8000128a:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    8000128c:	00000097          	auipc	ra,0x0
    80001290:	f22080e7          	jalr	-222(ra) # 800011ae <kvmmake>
    80001294:	00007797          	auipc	a5,0x7
    80001298:	72a7b623          	sd	a0,1836(a5) # 800089c0 <kernel_pagetable>
}
    8000129c:	60a2                	ld	ra,8(sp)
    8000129e:	6402                	ld	s0,0(sp)
    800012a0:	0141                	addi	sp,sp,16
    800012a2:	8082                	ret

00000000800012a4 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    800012a4:	715d                	addi	sp,sp,-80
    800012a6:	e486                	sd	ra,72(sp)
    800012a8:	e0a2                	sd	s0,64(sp)
    800012aa:	fc26                	sd	s1,56(sp)
    800012ac:	f84a                	sd	s2,48(sp)
    800012ae:	f44e                	sd	s3,40(sp)
    800012b0:	f052                	sd	s4,32(sp)
    800012b2:	ec56                	sd	s5,24(sp)
    800012b4:	e85a                	sd	s6,16(sp)
    800012b6:	e45e                	sd	s7,8(sp)
    800012b8:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    800012ba:	03459793          	slli	a5,a1,0x34
    800012be:	e795                	bnez	a5,800012ea <uvmunmap+0x46>
    800012c0:	8a2a                	mv	s4,a0
    800012c2:	892e                	mv	s2,a1
    800012c4:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800012c6:	0632                	slli	a2,a2,0xc
    800012c8:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    800012cc:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800012ce:	6b05                	lui	s6,0x1
    800012d0:	0735e263          	bltu	a1,s3,80001334 <uvmunmap+0x90>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    800012d4:	60a6                	ld	ra,72(sp)
    800012d6:	6406                	ld	s0,64(sp)
    800012d8:	74e2                	ld	s1,56(sp)
    800012da:	7942                	ld	s2,48(sp)
    800012dc:	79a2                	ld	s3,40(sp)
    800012de:	7a02                	ld	s4,32(sp)
    800012e0:	6ae2                	ld	s5,24(sp)
    800012e2:	6b42                	ld	s6,16(sp)
    800012e4:	6ba2                	ld	s7,8(sp)
    800012e6:	6161                	addi	sp,sp,80
    800012e8:	8082                	ret
    panic("uvmunmap: not aligned");
    800012ea:	00007517          	auipc	a0,0x7
    800012ee:	e1650513          	addi	a0,a0,-490 # 80008100 <digits+0xc0>
    800012f2:	fffff097          	auipc	ra,0xfffff
    800012f6:	290080e7          	jalr	656(ra) # 80000582 <panic>
      panic("uvmunmap: walk");
    800012fa:	00007517          	auipc	a0,0x7
    800012fe:	e1e50513          	addi	a0,a0,-482 # 80008118 <digits+0xd8>
    80001302:	fffff097          	auipc	ra,0xfffff
    80001306:	280080e7          	jalr	640(ra) # 80000582 <panic>
      panic("uvmunmap: not mapped");
    8000130a:	00007517          	auipc	a0,0x7
    8000130e:	e1e50513          	addi	a0,a0,-482 # 80008128 <digits+0xe8>
    80001312:	fffff097          	auipc	ra,0xfffff
    80001316:	270080e7          	jalr	624(ra) # 80000582 <panic>
      panic("uvmunmap: not a leaf");
    8000131a:	00007517          	auipc	a0,0x7
    8000131e:	e2650513          	addi	a0,a0,-474 # 80008140 <digits+0x100>
    80001322:	fffff097          	auipc	ra,0xfffff
    80001326:	260080e7          	jalr	608(ra) # 80000582 <panic>
    *pte = 0;
    8000132a:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000132e:	995a                	add	s2,s2,s6
    80001330:	fb3972e3          	bgeu	s2,s3,800012d4 <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    80001334:	4601                	li	a2,0
    80001336:	85ca                	mv	a1,s2
    80001338:	8552                	mv	a0,s4
    8000133a:	00000097          	auipc	ra,0x0
    8000133e:	cbc080e7          	jalr	-836(ra) # 80000ff6 <walk>
    80001342:	84aa                	mv	s1,a0
    80001344:	d95d                	beqz	a0,800012fa <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    80001346:	6108                	ld	a0,0(a0)
    80001348:	00157793          	andi	a5,a0,1
    8000134c:	dfdd                	beqz	a5,8000130a <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    8000134e:	3ff57793          	andi	a5,a0,1023
    80001352:	fd7784e3          	beq	a5,s7,8000131a <uvmunmap+0x76>
    if(do_free){
    80001356:	fc0a8ae3          	beqz	s5,8000132a <uvmunmap+0x86>
      uint64 pa = PTE2PA(*pte);
    8000135a:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    8000135c:	0532                	slli	a0,a0,0xc
    8000135e:	fffff097          	auipc	ra,0xfffff
    80001362:	6cc080e7          	jalr	1740(ra) # 80000a2a <kfree>
    80001366:	b7d1                	j	8000132a <uvmunmap+0x86>

0000000080001368 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80001368:	1101                	addi	sp,sp,-32
    8000136a:	ec06                	sd	ra,24(sp)
    8000136c:	e822                	sd	s0,16(sp)
    8000136e:	e426                	sd	s1,8(sp)
    80001370:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80001372:	fffff097          	auipc	ra,0xfffff
    80001376:	7b6080e7          	jalr	1974(ra) # 80000b28 <kalloc>
    8000137a:	84aa                	mv	s1,a0
  if(pagetable == 0)
    8000137c:	c519                	beqz	a0,8000138a <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    8000137e:	6605                	lui	a2,0x1
    80001380:	4581                	li	a1,0
    80001382:	00000097          	auipc	ra,0x0
    80001386:	992080e7          	jalr	-1646(ra) # 80000d14 <memset>
  return pagetable;
}
    8000138a:	8526                	mv	a0,s1
    8000138c:	60e2                	ld	ra,24(sp)
    8000138e:	6442                	ld	s0,16(sp)
    80001390:	64a2                	ld	s1,8(sp)
    80001392:	6105                	addi	sp,sp,32
    80001394:	8082                	ret

0000000080001396 <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    80001396:	7179                	addi	sp,sp,-48
    80001398:	f406                	sd	ra,40(sp)
    8000139a:	f022                	sd	s0,32(sp)
    8000139c:	ec26                	sd	s1,24(sp)
    8000139e:	e84a                	sd	s2,16(sp)
    800013a0:	e44e                	sd	s3,8(sp)
    800013a2:	e052                	sd	s4,0(sp)
    800013a4:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    800013a6:	6785                	lui	a5,0x1
    800013a8:	04f67863          	bgeu	a2,a5,800013f8 <uvmfirst+0x62>
    800013ac:	8a2a                	mv	s4,a0
    800013ae:	89ae                	mv	s3,a1
    800013b0:	84b2                	mv	s1,a2
    panic("uvmfirst: more than a page");
  mem = kalloc();
    800013b2:	fffff097          	auipc	ra,0xfffff
    800013b6:	776080e7          	jalr	1910(ra) # 80000b28 <kalloc>
    800013ba:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    800013bc:	6605                	lui	a2,0x1
    800013be:	4581                	li	a1,0
    800013c0:	00000097          	auipc	ra,0x0
    800013c4:	954080e7          	jalr	-1708(ra) # 80000d14 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    800013c8:	4779                	li	a4,30
    800013ca:	86ca                	mv	a3,s2
    800013cc:	6605                	lui	a2,0x1
    800013ce:	4581                	li	a1,0
    800013d0:	8552                	mv	a0,s4
    800013d2:	00000097          	auipc	ra,0x0
    800013d6:	d0c080e7          	jalr	-756(ra) # 800010de <mappages>
  memmove(mem, src, sz);
    800013da:	8626                	mv	a2,s1
    800013dc:	85ce                	mv	a1,s3
    800013de:	854a                	mv	a0,s2
    800013e0:	00000097          	auipc	ra,0x0
    800013e4:	990080e7          	jalr	-1648(ra) # 80000d70 <memmove>
}
    800013e8:	70a2                	ld	ra,40(sp)
    800013ea:	7402                	ld	s0,32(sp)
    800013ec:	64e2                	ld	s1,24(sp)
    800013ee:	6942                	ld	s2,16(sp)
    800013f0:	69a2                	ld	s3,8(sp)
    800013f2:	6a02                	ld	s4,0(sp)
    800013f4:	6145                	addi	sp,sp,48
    800013f6:	8082                	ret
    panic("uvmfirst: more than a page");
    800013f8:	00007517          	auipc	a0,0x7
    800013fc:	d6050513          	addi	a0,a0,-672 # 80008158 <digits+0x118>
    80001400:	fffff097          	auipc	ra,0xfffff
    80001404:	182080e7          	jalr	386(ra) # 80000582 <panic>

0000000080001408 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80001408:	1101                	addi	sp,sp,-32
    8000140a:	ec06                	sd	ra,24(sp)
    8000140c:	e822                	sd	s0,16(sp)
    8000140e:	e426                	sd	s1,8(sp)
    80001410:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    80001412:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    80001414:	00b67d63          	bgeu	a2,a1,8000142e <uvmdealloc+0x26>
    80001418:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    8000141a:	6785                	lui	a5,0x1
    8000141c:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000141e:	00f60733          	add	a4,a2,a5
    80001422:	76fd                	lui	a3,0xfffff
    80001424:	8f75                	and	a4,a4,a3
    80001426:	97ae                	add	a5,a5,a1
    80001428:	8ff5                	and	a5,a5,a3
    8000142a:	00f76863          	bltu	a4,a5,8000143a <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    8000142e:	8526                	mv	a0,s1
    80001430:	60e2                	ld	ra,24(sp)
    80001432:	6442                	ld	s0,16(sp)
    80001434:	64a2                	ld	s1,8(sp)
    80001436:	6105                	addi	sp,sp,32
    80001438:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    8000143a:	8f99                	sub	a5,a5,a4
    8000143c:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    8000143e:	4685                	li	a3,1
    80001440:	0007861b          	sext.w	a2,a5
    80001444:	85ba                	mv	a1,a4
    80001446:	00000097          	auipc	ra,0x0
    8000144a:	e5e080e7          	jalr	-418(ra) # 800012a4 <uvmunmap>
    8000144e:	b7c5                	j	8000142e <uvmdealloc+0x26>

0000000080001450 <uvmalloc>:
  if(newsz < oldsz)
    80001450:	0ab66563          	bltu	a2,a1,800014fa <uvmalloc+0xaa>
{
    80001454:	7139                	addi	sp,sp,-64
    80001456:	fc06                	sd	ra,56(sp)
    80001458:	f822                	sd	s0,48(sp)
    8000145a:	f426                	sd	s1,40(sp)
    8000145c:	f04a                	sd	s2,32(sp)
    8000145e:	ec4e                	sd	s3,24(sp)
    80001460:	e852                	sd	s4,16(sp)
    80001462:	e456                	sd	s5,8(sp)
    80001464:	e05a                	sd	s6,0(sp)
    80001466:	0080                	addi	s0,sp,64
    80001468:	8aaa                	mv	s5,a0
    8000146a:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    8000146c:	6785                	lui	a5,0x1
    8000146e:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80001470:	95be                	add	a1,a1,a5
    80001472:	77fd                	lui	a5,0xfffff
    80001474:	00f5f9b3          	and	s3,a1,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    80001478:	08c9f363          	bgeu	s3,a2,800014fe <uvmalloc+0xae>
    8000147c:	894e                	mv	s2,s3
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    8000147e:	0126eb13          	ori	s6,a3,18
    mem = kalloc();
    80001482:	fffff097          	auipc	ra,0xfffff
    80001486:	6a6080e7          	jalr	1702(ra) # 80000b28 <kalloc>
    8000148a:	84aa                	mv	s1,a0
    if(mem == 0){
    8000148c:	c51d                	beqz	a0,800014ba <uvmalloc+0x6a>
    memset(mem, 0, PGSIZE);
    8000148e:	6605                	lui	a2,0x1
    80001490:	4581                	li	a1,0
    80001492:	00000097          	auipc	ra,0x0
    80001496:	882080e7          	jalr	-1918(ra) # 80000d14 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    8000149a:	875a                	mv	a4,s6
    8000149c:	86a6                	mv	a3,s1
    8000149e:	6605                	lui	a2,0x1
    800014a0:	85ca                	mv	a1,s2
    800014a2:	8556                	mv	a0,s5
    800014a4:	00000097          	auipc	ra,0x0
    800014a8:	c3a080e7          	jalr	-966(ra) # 800010de <mappages>
    800014ac:	e90d                	bnez	a0,800014de <uvmalloc+0x8e>
  for(a = oldsz; a < newsz; a += PGSIZE){
    800014ae:	6785                	lui	a5,0x1
    800014b0:	993e                	add	s2,s2,a5
    800014b2:	fd4968e3          	bltu	s2,s4,80001482 <uvmalloc+0x32>
  return newsz;
    800014b6:	8552                	mv	a0,s4
    800014b8:	a809                	j	800014ca <uvmalloc+0x7a>
      uvmdealloc(pagetable, a, oldsz);
    800014ba:	864e                	mv	a2,s3
    800014bc:	85ca                	mv	a1,s2
    800014be:	8556                	mv	a0,s5
    800014c0:	00000097          	auipc	ra,0x0
    800014c4:	f48080e7          	jalr	-184(ra) # 80001408 <uvmdealloc>
      return 0;
    800014c8:	4501                	li	a0,0
}
    800014ca:	70e2                	ld	ra,56(sp)
    800014cc:	7442                	ld	s0,48(sp)
    800014ce:	74a2                	ld	s1,40(sp)
    800014d0:	7902                	ld	s2,32(sp)
    800014d2:	69e2                	ld	s3,24(sp)
    800014d4:	6a42                	ld	s4,16(sp)
    800014d6:	6aa2                	ld	s5,8(sp)
    800014d8:	6b02                	ld	s6,0(sp)
    800014da:	6121                	addi	sp,sp,64
    800014dc:	8082                	ret
      kfree(mem);
    800014de:	8526                	mv	a0,s1
    800014e0:	fffff097          	auipc	ra,0xfffff
    800014e4:	54a080e7          	jalr	1354(ra) # 80000a2a <kfree>
      uvmdealloc(pagetable, a, oldsz);
    800014e8:	864e                	mv	a2,s3
    800014ea:	85ca                	mv	a1,s2
    800014ec:	8556                	mv	a0,s5
    800014ee:	00000097          	auipc	ra,0x0
    800014f2:	f1a080e7          	jalr	-230(ra) # 80001408 <uvmdealloc>
      return 0;
    800014f6:	4501                	li	a0,0
    800014f8:	bfc9                	j	800014ca <uvmalloc+0x7a>
    return oldsz;
    800014fa:	852e                	mv	a0,a1
}
    800014fc:	8082                	ret
  return newsz;
    800014fe:	8532                	mv	a0,a2
    80001500:	b7e9                	j	800014ca <uvmalloc+0x7a>

0000000080001502 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80001502:	7179                	addi	sp,sp,-48
    80001504:	f406                	sd	ra,40(sp)
    80001506:	f022                	sd	s0,32(sp)
    80001508:	ec26                	sd	s1,24(sp)
    8000150a:	e84a                	sd	s2,16(sp)
    8000150c:	e44e                	sd	s3,8(sp)
    8000150e:	e052                	sd	s4,0(sp)
    80001510:	1800                	addi	s0,sp,48
    80001512:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80001514:	84aa                	mv	s1,a0
    80001516:	6905                	lui	s2,0x1
    80001518:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    8000151a:	4985                	li	s3,1
    8000151c:	a829                	j	80001536 <freewalk+0x34>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    8000151e:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    80001520:	00c79513          	slli	a0,a5,0xc
    80001524:	00000097          	auipc	ra,0x0
    80001528:	fde080e7          	jalr	-34(ra) # 80001502 <freewalk>
      pagetable[i] = 0;
    8000152c:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    80001530:	04a1                	addi	s1,s1,8
    80001532:	03248163          	beq	s1,s2,80001554 <freewalk+0x52>
    pte_t pte = pagetable[i];
    80001536:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80001538:	00f7f713          	andi	a4,a5,15
    8000153c:	ff3701e3          	beq	a4,s3,8000151e <freewalk+0x1c>
    } else if(pte & PTE_V){
    80001540:	8b85                	andi	a5,a5,1
    80001542:	d7fd                	beqz	a5,80001530 <freewalk+0x2e>
      panic("freewalk: leaf");
    80001544:	00007517          	auipc	a0,0x7
    80001548:	c3450513          	addi	a0,a0,-972 # 80008178 <digits+0x138>
    8000154c:	fffff097          	auipc	ra,0xfffff
    80001550:	036080e7          	jalr	54(ra) # 80000582 <panic>
    }
  }
  kfree((void*)pagetable);
    80001554:	8552                	mv	a0,s4
    80001556:	fffff097          	auipc	ra,0xfffff
    8000155a:	4d4080e7          	jalr	1236(ra) # 80000a2a <kfree>
}
    8000155e:	70a2                	ld	ra,40(sp)
    80001560:	7402                	ld	s0,32(sp)
    80001562:	64e2                	ld	s1,24(sp)
    80001564:	6942                	ld	s2,16(sp)
    80001566:	69a2                	ld	s3,8(sp)
    80001568:	6a02                	ld	s4,0(sp)
    8000156a:	6145                	addi	sp,sp,48
    8000156c:	8082                	ret

000000008000156e <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    8000156e:	1101                	addi	sp,sp,-32
    80001570:	ec06                	sd	ra,24(sp)
    80001572:	e822                	sd	s0,16(sp)
    80001574:	e426                	sd	s1,8(sp)
    80001576:	1000                	addi	s0,sp,32
    80001578:	84aa                	mv	s1,a0
  if(sz > 0)
    8000157a:	e999                	bnez	a1,80001590 <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    8000157c:	8526                	mv	a0,s1
    8000157e:	00000097          	auipc	ra,0x0
    80001582:	f84080e7          	jalr	-124(ra) # 80001502 <freewalk>
}
    80001586:	60e2                	ld	ra,24(sp)
    80001588:	6442                	ld	s0,16(sp)
    8000158a:	64a2                	ld	s1,8(sp)
    8000158c:	6105                	addi	sp,sp,32
    8000158e:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80001590:	6785                	lui	a5,0x1
    80001592:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80001594:	95be                	add	a1,a1,a5
    80001596:	4685                	li	a3,1
    80001598:	00c5d613          	srli	a2,a1,0xc
    8000159c:	4581                	li	a1,0
    8000159e:	00000097          	auipc	ra,0x0
    800015a2:	d06080e7          	jalr	-762(ra) # 800012a4 <uvmunmap>
    800015a6:	bfd9                	j	8000157c <uvmfree+0xe>

00000000800015a8 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    800015a8:	c679                	beqz	a2,80001676 <uvmcopy+0xce>
{
    800015aa:	715d                	addi	sp,sp,-80
    800015ac:	e486                	sd	ra,72(sp)
    800015ae:	e0a2                	sd	s0,64(sp)
    800015b0:	fc26                	sd	s1,56(sp)
    800015b2:	f84a                	sd	s2,48(sp)
    800015b4:	f44e                	sd	s3,40(sp)
    800015b6:	f052                	sd	s4,32(sp)
    800015b8:	ec56                	sd	s5,24(sp)
    800015ba:	e85a                	sd	s6,16(sp)
    800015bc:	e45e                	sd	s7,8(sp)
    800015be:	0880                	addi	s0,sp,80
    800015c0:	8b2a                	mv	s6,a0
    800015c2:	8aae                	mv	s5,a1
    800015c4:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    800015c6:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    800015c8:	4601                	li	a2,0
    800015ca:	85ce                	mv	a1,s3
    800015cc:	855a                	mv	a0,s6
    800015ce:	00000097          	auipc	ra,0x0
    800015d2:	a28080e7          	jalr	-1496(ra) # 80000ff6 <walk>
    800015d6:	c531                	beqz	a0,80001622 <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    800015d8:	6118                	ld	a4,0(a0)
    800015da:	00177793          	andi	a5,a4,1
    800015de:	cbb1                	beqz	a5,80001632 <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    800015e0:	00a75593          	srli	a1,a4,0xa
    800015e4:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    800015e8:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    800015ec:	fffff097          	auipc	ra,0xfffff
    800015f0:	53c080e7          	jalr	1340(ra) # 80000b28 <kalloc>
    800015f4:	892a                	mv	s2,a0
    800015f6:	c939                	beqz	a0,8000164c <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    800015f8:	6605                	lui	a2,0x1
    800015fa:	85de                	mv	a1,s7
    800015fc:	fffff097          	auipc	ra,0xfffff
    80001600:	774080e7          	jalr	1908(ra) # 80000d70 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80001604:	8726                	mv	a4,s1
    80001606:	86ca                	mv	a3,s2
    80001608:	6605                	lui	a2,0x1
    8000160a:	85ce                	mv	a1,s3
    8000160c:	8556                	mv	a0,s5
    8000160e:	00000097          	auipc	ra,0x0
    80001612:	ad0080e7          	jalr	-1328(ra) # 800010de <mappages>
    80001616:	e515                	bnez	a0,80001642 <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    80001618:	6785                	lui	a5,0x1
    8000161a:	99be                	add	s3,s3,a5
    8000161c:	fb49e6e3          	bltu	s3,s4,800015c8 <uvmcopy+0x20>
    80001620:	a081                	j	80001660 <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    80001622:	00007517          	auipc	a0,0x7
    80001626:	b6650513          	addi	a0,a0,-1178 # 80008188 <digits+0x148>
    8000162a:	fffff097          	auipc	ra,0xfffff
    8000162e:	f58080e7          	jalr	-168(ra) # 80000582 <panic>
      panic("uvmcopy: page not present");
    80001632:	00007517          	auipc	a0,0x7
    80001636:	b7650513          	addi	a0,a0,-1162 # 800081a8 <digits+0x168>
    8000163a:	fffff097          	auipc	ra,0xfffff
    8000163e:	f48080e7          	jalr	-184(ra) # 80000582 <panic>
      kfree(mem);
    80001642:	854a                	mv	a0,s2
    80001644:	fffff097          	auipc	ra,0xfffff
    80001648:	3e6080e7          	jalr	998(ra) # 80000a2a <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    8000164c:	4685                	li	a3,1
    8000164e:	00c9d613          	srli	a2,s3,0xc
    80001652:	4581                	li	a1,0
    80001654:	8556                	mv	a0,s5
    80001656:	00000097          	auipc	ra,0x0
    8000165a:	c4e080e7          	jalr	-946(ra) # 800012a4 <uvmunmap>
  return -1;
    8000165e:	557d                	li	a0,-1
}
    80001660:	60a6                	ld	ra,72(sp)
    80001662:	6406                	ld	s0,64(sp)
    80001664:	74e2                	ld	s1,56(sp)
    80001666:	7942                	ld	s2,48(sp)
    80001668:	79a2                	ld	s3,40(sp)
    8000166a:	7a02                	ld	s4,32(sp)
    8000166c:	6ae2                	ld	s5,24(sp)
    8000166e:	6b42                	ld	s6,16(sp)
    80001670:	6ba2                	ld	s7,8(sp)
    80001672:	6161                	addi	sp,sp,80
    80001674:	8082                	ret
  return 0;
    80001676:	4501                	li	a0,0
}
    80001678:	8082                	ret

000000008000167a <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    8000167a:	1141                	addi	sp,sp,-16
    8000167c:	e406                	sd	ra,8(sp)
    8000167e:	e022                	sd	s0,0(sp)
    80001680:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80001682:	4601                	li	a2,0
    80001684:	00000097          	auipc	ra,0x0
    80001688:	972080e7          	jalr	-1678(ra) # 80000ff6 <walk>
  if(pte == 0)
    8000168c:	c901                	beqz	a0,8000169c <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    8000168e:	611c                	ld	a5,0(a0)
    80001690:	9bbd                	andi	a5,a5,-17
    80001692:	e11c                	sd	a5,0(a0)
}
    80001694:	60a2                	ld	ra,8(sp)
    80001696:	6402                	ld	s0,0(sp)
    80001698:	0141                	addi	sp,sp,16
    8000169a:	8082                	ret
    panic("uvmclear");
    8000169c:	00007517          	auipc	a0,0x7
    800016a0:	b2c50513          	addi	a0,a0,-1236 # 800081c8 <digits+0x188>
    800016a4:	fffff097          	auipc	ra,0xfffff
    800016a8:	ede080e7          	jalr	-290(ra) # 80000582 <panic>

00000000800016ac <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    800016ac:	c6bd                	beqz	a3,8000171a <copyout+0x6e>
{
    800016ae:	715d                	addi	sp,sp,-80
    800016b0:	e486                	sd	ra,72(sp)
    800016b2:	e0a2                	sd	s0,64(sp)
    800016b4:	fc26                	sd	s1,56(sp)
    800016b6:	f84a                	sd	s2,48(sp)
    800016b8:	f44e                	sd	s3,40(sp)
    800016ba:	f052                	sd	s4,32(sp)
    800016bc:	ec56                	sd	s5,24(sp)
    800016be:	e85a                	sd	s6,16(sp)
    800016c0:	e45e                	sd	s7,8(sp)
    800016c2:	e062                	sd	s8,0(sp)
    800016c4:	0880                	addi	s0,sp,80
    800016c6:	8b2a                	mv	s6,a0
    800016c8:	8c2e                	mv	s8,a1
    800016ca:	8a32                	mv	s4,a2
    800016cc:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    800016ce:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    800016d0:	6a85                	lui	s5,0x1
    800016d2:	a015                	j	800016f6 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    800016d4:	9562                	add	a0,a0,s8
    800016d6:	0004861b          	sext.w	a2,s1
    800016da:	85d2                	mv	a1,s4
    800016dc:	41250533          	sub	a0,a0,s2
    800016e0:	fffff097          	auipc	ra,0xfffff
    800016e4:	690080e7          	jalr	1680(ra) # 80000d70 <memmove>

    len -= n;
    800016e8:	409989b3          	sub	s3,s3,s1
    src += n;
    800016ec:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    800016ee:	01590c33          	add	s8,s2,s5
  while(len > 0){
    800016f2:	02098263          	beqz	s3,80001716 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    800016f6:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    800016fa:	85ca                	mv	a1,s2
    800016fc:	855a                	mv	a0,s6
    800016fe:	00000097          	auipc	ra,0x0
    80001702:	99e080e7          	jalr	-1634(ra) # 8000109c <walkaddr>
    if(pa0 == 0)
    80001706:	cd01                	beqz	a0,8000171e <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80001708:	418904b3          	sub	s1,s2,s8
    8000170c:	94d6                	add	s1,s1,s5
    8000170e:	fc99f3e3          	bgeu	s3,s1,800016d4 <copyout+0x28>
    80001712:	84ce                	mv	s1,s3
    80001714:	b7c1                	j	800016d4 <copyout+0x28>
  }
  return 0;
    80001716:	4501                	li	a0,0
    80001718:	a021                	j	80001720 <copyout+0x74>
    8000171a:	4501                	li	a0,0
}
    8000171c:	8082                	ret
      return -1;
    8000171e:	557d                	li	a0,-1
}
    80001720:	60a6                	ld	ra,72(sp)
    80001722:	6406                	ld	s0,64(sp)
    80001724:	74e2                	ld	s1,56(sp)
    80001726:	7942                	ld	s2,48(sp)
    80001728:	79a2                	ld	s3,40(sp)
    8000172a:	7a02                	ld	s4,32(sp)
    8000172c:	6ae2                	ld	s5,24(sp)
    8000172e:	6b42                	ld	s6,16(sp)
    80001730:	6ba2                	ld	s7,8(sp)
    80001732:	6c02                	ld	s8,0(sp)
    80001734:	6161                	addi	sp,sp,80
    80001736:	8082                	ret

0000000080001738 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80001738:	caa5                	beqz	a3,800017a8 <copyin+0x70>
{
    8000173a:	715d                	addi	sp,sp,-80
    8000173c:	e486                	sd	ra,72(sp)
    8000173e:	e0a2                	sd	s0,64(sp)
    80001740:	fc26                	sd	s1,56(sp)
    80001742:	f84a                	sd	s2,48(sp)
    80001744:	f44e                	sd	s3,40(sp)
    80001746:	f052                	sd	s4,32(sp)
    80001748:	ec56                	sd	s5,24(sp)
    8000174a:	e85a                	sd	s6,16(sp)
    8000174c:	e45e                	sd	s7,8(sp)
    8000174e:	e062                	sd	s8,0(sp)
    80001750:	0880                	addi	s0,sp,80
    80001752:	8b2a                	mv	s6,a0
    80001754:	8a2e                	mv	s4,a1
    80001756:	8c32                	mv	s8,a2
    80001758:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    8000175a:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    8000175c:	6a85                	lui	s5,0x1
    8000175e:	a01d                	j	80001784 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80001760:	018505b3          	add	a1,a0,s8
    80001764:	0004861b          	sext.w	a2,s1
    80001768:	412585b3          	sub	a1,a1,s2
    8000176c:	8552                	mv	a0,s4
    8000176e:	fffff097          	auipc	ra,0xfffff
    80001772:	602080e7          	jalr	1538(ra) # 80000d70 <memmove>

    len -= n;
    80001776:	409989b3          	sub	s3,s3,s1
    dst += n;
    8000177a:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    8000177c:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80001780:	02098263          	beqz	s3,800017a4 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80001784:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80001788:	85ca                	mv	a1,s2
    8000178a:	855a                	mv	a0,s6
    8000178c:	00000097          	auipc	ra,0x0
    80001790:	910080e7          	jalr	-1776(ra) # 8000109c <walkaddr>
    if(pa0 == 0)
    80001794:	cd01                	beqz	a0,800017ac <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80001796:	418904b3          	sub	s1,s2,s8
    8000179a:	94d6                	add	s1,s1,s5
    8000179c:	fc99f2e3          	bgeu	s3,s1,80001760 <copyin+0x28>
    800017a0:	84ce                	mv	s1,s3
    800017a2:	bf7d                	j	80001760 <copyin+0x28>
  }
  return 0;
    800017a4:	4501                	li	a0,0
    800017a6:	a021                	j	800017ae <copyin+0x76>
    800017a8:	4501                	li	a0,0
}
    800017aa:	8082                	ret
      return -1;
    800017ac:	557d                	li	a0,-1
}
    800017ae:	60a6                	ld	ra,72(sp)
    800017b0:	6406                	ld	s0,64(sp)
    800017b2:	74e2                	ld	s1,56(sp)
    800017b4:	7942                	ld	s2,48(sp)
    800017b6:	79a2                	ld	s3,40(sp)
    800017b8:	7a02                	ld	s4,32(sp)
    800017ba:	6ae2                	ld	s5,24(sp)
    800017bc:	6b42                	ld	s6,16(sp)
    800017be:	6ba2                	ld	s7,8(sp)
    800017c0:	6c02                	ld	s8,0(sp)
    800017c2:	6161                	addi	sp,sp,80
    800017c4:	8082                	ret

00000000800017c6 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    800017c6:	c2dd                	beqz	a3,8000186c <copyinstr+0xa6>
{
    800017c8:	715d                	addi	sp,sp,-80
    800017ca:	e486                	sd	ra,72(sp)
    800017cc:	e0a2                	sd	s0,64(sp)
    800017ce:	fc26                	sd	s1,56(sp)
    800017d0:	f84a                	sd	s2,48(sp)
    800017d2:	f44e                	sd	s3,40(sp)
    800017d4:	f052                	sd	s4,32(sp)
    800017d6:	ec56                	sd	s5,24(sp)
    800017d8:	e85a                	sd	s6,16(sp)
    800017da:	e45e                	sd	s7,8(sp)
    800017dc:	0880                	addi	s0,sp,80
    800017de:	8a2a                	mv	s4,a0
    800017e0:	8b2e                	mv	s6,a1
    800017e2:	8bb2                	mv	s7,a2
    800017e4:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    800017e6:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    800017e8:	6985                	lui	s3,0x1
    800017ea:	a02d                	j	80001814 <copyinstr+0x4e>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    800017ec:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    800017f0:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    800017f2:	37fd                	addiw	a5,a5,-1
    800017f4:	0007851b          	sext.w	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    800017f8:	60a6                	ld	ra,72(sp)
    800017fa:	6406                	ld	s0,64(sp)
    800017fc:	74e2                	ld	s1,56(sp)
    800017fe:	7942                	ld	s2,48(sp)
    80001800:	79a2                	ld	s3,40(sp)
    80001802:	7a02                	ld	s4,32(sp)
    80001804:	6ae2                	ld	s5,24(sp)
    80001806:	6b42                	ld	s6,16(sp)
    80001808:	6ba2                	ld	s7,8(sp)
    8000180a:	6161                	addi	sp,sp,80
    8000180c:	8082                	ret
    srcva = va0 + PGSIZE;
    8000180e:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    80001812:	c8a9                	beqz	s1,80001864 <copyinstr+0x9e>
    va0 = PGROUNDDOWN(srcva);
    80001814:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80001818:	85ca                	mv	a1,s2
    8000181a:	8552                	mv	a0,s4
    8000181c:	00000097          	auipc	ra,0x0
    80001820:	880080e7          	jalr	-1920(ra) # 8000109c <walkaddr>
    if(pa0 == 0)
    80001824:	c131                	beqz	a0,80001868 <copyinstr+0xa2>
    n = PGSIZE - (srcva - va0);
    80001826:	417906b3          	sub	a3,s2,s7
    8000182a:	96ce                	add	a3,a3,s3
    8000182c:	00d4f363          	bgeu	s1,a3,80001832 <copyinstr+0x6c>
    80001830:	86a6                	mv	a3,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80001832:	955e                	add	a0,a0,s7
    80001834:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80001838:	daf9                	beqz	a3,8000180e <copyinstr+0x48>
    8000183a:	87da                	mv	a5,s6
    8000183c:	885a                	mv	a6,s6
      if(*p == '\0'){
    8000183e:	41650633          	sub	a2,a0,s6
    while(n > 0){
    80001842:	96da                	add	a3,a3,s6
    80001844:	85be                	mv	a1,a5
      if(*p == '\0'){
    80001846:	00f60733          	add	a4,a2,a5
    8000184a:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <end+0xffffffff7ffdcfb0>
    8000184e:	df59                	beqz	a4,800017ec <copyinstr+0x26>
        *dst = *p;
    80001850:	00e78023          	sb	a4,0(a5)
      dst++;
    80001854:	0785                	addi	a5,a5,1
    while(n > 0){
    80001856:	fed797e3          	bne	a5,a3,80001844 <copyinstr+0x7e>
    8000185a:	14fd                	addi	s1,s1,-1
    8000185c:	94c2                	add	s1,s1,a6
      --max;
    8000185e:	8c8d                	sub	s1,s1,a1
      dst++;
    80001860:	8b3e                	mv	s6,a5
    80001862:	b775                	j	8000180e <copyinstr+0x48>
    80001864:	4781                	li	a5,0
    80001866:	b771                	j	800017f2 <copyinstr+0x2c>
      return -1;
    80001868:	557d                	li	a0,-1
    8000186a:	b779                	j	800017f8 <copyinstr+0x32>
  int got_null = 0;
    8000186c:	4781                	li	a5,0
  if(got_null){
    8000186e:	37fd                	addiw	a5,a5,-1
    80001870:	0007851b          	sext.w	a0,a5
}
    80001874:	8082                	ret

0000000080001876 <rr_scheduler>:
        (*sched_pointer)();
    }
}

void rr_scheduler(void)
{
    80001876:	7139                	addi	sp,sp,-64
    80001878:	fc06                	sd	ra,56(sp)
    8000187a:	f822                	sd	s0,48(sp)
    8000187c:	f426                	sd	s1,40(sp)
    8000187e:	f04a                	sd	s2,32(sp)
    80001880:	ec4e                	sd	s3,24(sp)
    80001882:	e852                	sd	s4,16(sp)
    80001884:	e456                	sd	s5,8(sp)
    80001886:	e05a                	sd	s6,0(sp)
    80001888:	0080                	addi	s0,sp,64
  asm volatile("mv %0, tp" : "=r" (x) );
    8000188a:	8792                	mv	a5,tp
    int id = r_tp();
    8000188c:	2781                	sext.w	a5,a5
    struct proc *p;
    struct cpu *c = mycpu();

    c->proc = 0;
    8000188e:	0000fa97          	auipc	s5,0xf
    80001892:	3b2a8a93          	addi	s5,s5,946 # 80010c40 <cpus>
    80001896:	00779713          	slli	a4,a5,0x7
    8000189a:	00ea86b3          	add	a3,s5,a4
    8000189e:	0006b023          	sd	zero,0(a3) # fffffffffffff000 <end+0xffffffff7ffdcfb0>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800018a2:	100026f3          	csrr	a3,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800018a6:	0026e693          	ori	a3,a3,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800018aa:	10069073          	csrw	sstatus,a3
            // Switch to chosen process.  It is the process's job
            // to release its lock and then reacquire it
            // before jumping back to us.
            p->state = RUNNING;
            c->proc = p;
            swtch(&c->context, &p->context);
    800018ae:	0721                	addi	a4,a4,8
    800018b0:	9aba                	add	s5,s5,a4
    for (p = proc; p < &proc[NPROC]; p++)
    800018b2:	0000f497          	auipc	s1,0xf
    800018b6:	7be48493          	addi	s1,s1,1982 # 80011070 <proc>
        if (p->state == RUNNABLE)
    800018ba:	498d                	li	s3,3
            p->state = RUNNING;
    800018bc:	4b11                	li	s6,4
            c->proc = p;
    800018be:	079e                	slli	a5,a5,0x7
    800018c0:	0000fa17          	auipc	s4,0xf
    800018c4:	380a0a13          	addi	s4,s4,896 # 80010c40 <cpus>
    800018c8:	9a3e                	add	s4,s4,a5
    for (p = proc; p < &proc[NPROC]; p++)
    800018ca:	00015917          	auipc	s2,0x15
    800018ce:	3a690913          	addi	s2,s2,934 # 80016c70 <tickslock>
    800018d2:	a811                	j	800018e6 <rr_scheduler+0x70>

            // Process is done running for now.
            // It should have changed its p->state before coming back.
            c->proc = 0;
        }
        release(&p->lock);
    800018d4:	8526                	mv	a0,s1
    800018d6:	fffff097          	auipc	ra,0xfffff
    800018da:	3f6080e7          	jalr	1014(ra) # 80000ccc <release>
    for (p = proc; p < &proc[NPROC]; p++)
    800018de:	17048493          	addi	s1,s1,368
    800018e2:	03248863          	beq	s1,s2,80001912 <rr_scheduler+0x9c>
        acquire(&p->lock);
    800018e6:	8526                	mv	a0,s1
    800018e8:	fffff097          	auipc	ra,0xfffff
    800018ec:	330080e7          	jalr	816(ra) # 80000c18 <acquire>
        if (p->state == RUNNABLE)
    800018f0:	4c9c                	lw	a5,24(s1)
    800018f2:	ff3791e3          	bne	a5,s3,800018d4 <rr_scheduler+0x5e>
            p->state = RUNNING;
    800018f6:	0164ac23          	sw	s6,24(s1)
            c->proc = p;
    800018fa:	009a3023          	sd	s1,0(s4)
            swtch(&c->context, &p->context);
    800018fe:	06848593          	addi	a1,s1,104
    80001902:	8556                	mv	a0,s5
    80001904:	00001097          	auipc	ra,0x1
    80001908:	1a6080e7          	jalr	422(ra) # 80002aaa <swtch>
            c->proc = 0;
    8000190c:	000a3023          	sd	zero,0(s4)
    80001910:	b7d1                	j	800018d4 <rr_scheduler+0x5e>
    }
}
    80001912:	70e2                	ld	ra,56(sp)
    80001914:	7442                	ld	s0,48(sp)
    80001916:	74a2                	ld	s1,40(sp)
    80001918:	7902                	ld	s2,32(sp)
    8000191a:	69e2                	ld	s3,24(sp)
    8000191c:	6a42                	ld	s4,16(sp)
    8000191e:	6aa2                	ld	s5,8(sp)
    80001920:	6b02                	ld	s6,0(sp)
    80001922:	6121                	addi	sp,sp,64
    80001924:	8082                	ret

0000000080001926 <mlfq_scheduler>:

void mlfq_scheduler(void)
{
    80001926:	711d                	addi	sp,sp,-96
    80001928:	ec86                	sd	ra,88(sp)
    8000192a:	e8a2                	sd	s0,80(sp)
    8000192c:	e4a6                	sd	s1,72(sp)
    8000192e:	e0ca                	sd	s2,64(sp)
    80001930:	fc4e                	sd	s3,56(sp)
    80001932:	f852                	sd	s4,48(sp)
    80001934:	f456                	sd	s5,40(sp)
    80001936:	f05a                	sd	s6,32(sp)
    80001938:	ec5e                	sd	s7,24(sp)
    8000193a:	e862                	sd	s8,16(sp)
    8000193c:	e466                	sd	s9,8(sp)
    8000193e:	e06a                	sd	s10,0(sp)
    80001940:	1080                	addi	s0,sp,96
  asm volatile("mv %0, tp" : "=r" (x) );
    80001942:	8d12                	mv	s10,tp
    int id = r_tp();
    80001944:	2d01                	sext.w	s10,s10
    struct proc *p;
    struct cpu *c = mycpu();

    c->proc = 0;
    80001946:	0000fa97          	auipc	s5,0xf
    8000194a:	2faa8a93          	addi	s5,s5,762 # 80010c40 <cpus>
    8000194e:	007d1793          	slli	a5,s10,0x7
    80001952:	00fa8733          	add	a4,s5,a5
    80001956:	00073023          	sd	zero,0(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000195a:	10002773          	csrr	a4,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000195e:	00276713          	ori	a4,a4,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001962:	10071073          	csrw	sstatus,a4
                // Switch to chosen process.  It is the process's job
                // to release its lock and then reacquire it
                // before jumping back to us.
                p->state = RUNNING;
                c->proc = p;
                swtch(&c->context, &p->context);
    80001966:	07a1                	addi	a5,a5,8
    80001968:	9abe                	add	s5,s5,a5
                c->proc = p;
    8000196a:	007d1793          	slli	a5,s10,0x7
    8000196e:	0000fa17          	auipc	s4,0xf
    80001972:	2d2a0a13          	addi	s4,s4,722 # 80010c40 <cpus>
    80001976:	9a3e                	add	s4,s4,a5
                // check if we are still the right scheduler
                if (sched_pointer != &mlfq_scheduler)
    80001978:	00007c97          	auipc	s9,0x7
    8000197c:	f90c8c93          	addi	s9,s9,-112 # 80008908 <sched_pointer>
    80001980:	00000c17          	auipc	s8,0x0
    80001984:	fa6c0c13          	addi	s8,s8,-90 # 80001926 <mlfq_scheduler>
        high_avail = 0;
    80001988:	4b01                	li	s6,0
        for (p = proc; p < &proc[NPROC]; p++)
    8000198a:	0000f497          	auipc	s1,0xf
    8000198e:	6e648493          	addi	s1,s1,1766 # 80011070 <proc>
            if (p->state == RUNNABLE)
    80001992:	498d                	li	s3,3
                p->state = RUNNING;
    80001994:	4b91                	li	s7,4
        for (p = proc; p < &proc[NPROC]; p++)
    80001996:	00015917          	auipc	s2,0x15
    8000199a:	2da90913          	addi	s2,s2,730 # 80016c70 <tickslock>
    8000199e:	a099                	j	800019e4 <mlfq_scheduler+0xbe>
                release(&p->lock);
    800019a0:	8526                	mv	a0,s1
    800019a2:	fffff097          	auipc	ra,0xfffff
    800019a6:	32a080e7          	jalr	810(ra) # 80000ccc <release>
                continue;
    800019aa:	a80d                	j	800019dc <mlfq_scheduler+0xb6>
                {
                    release(&p->lock);
    800019ac:	8526                	mv	a0,s1
    800019ae:	fffff097          	auipc	ra,0xfffff
    800019b2:	31e080e7          	jalr	798(ra) # 80000ccc <release>
            // It should have changed its p->state before coming back.
            c->proc = 0;
        }
        release(&p->lock);
    }
}
    800019b6:	60e6                	ld	ra,88(sp)
    800019b8:	6446                	ld	s0,80(sp)
    800019ba:	64a6                	ld	s1,72(sp)
    800019bc:	6906                	ld	s2,64(sp)
    800019be:	79e2                	ld	s3,56(sp)
    800019c0:	7a42                	ld	s4,48(sp)
    800019c2:	7aa2                	ld	s5,40(sp)
    800019c4:	7b02                	ld	s6,32(sp)
    800019c6:	6be2                	ld	s7,24(sp)
    800019c8:	6c42                	ld	s8,16(sp)
    800019ca:	6ca2                	ld	s9,8(sp)
    800019cc:	6d02                	ld	s10,0(sp)
    800019ce:	6125                	addi	sp,sp,96
    800019d0:	8082                	ret
            release(&p->lock);
    800019d2:	8526                	mv	a0,s1
    800019d4:	fffff097          	auipc	ra,0xfffff
    800019d8:	2f8080e7          	jalr	760(ra) # 80000ccc <release>
        for (p = proc; p < &proc[NPROC]; p++)
    800019dc:	17048493          	addi	s1,s1,368
    800019e0:	03248f63          	beq	s1,s2,80001a1e <mlfq_scheduler+0xf8>
            acquire(&p->lock);
    800019e4:	8526                	mv	a0,s1
    800019e6:	fffff097          	auipc	ra,0xfffff
    800019ea:	232080e7          	jalr	562(ra) # 80000c18 <acquire>
            if (p->priority > 0)
    800019ee:	58dc                	lw	a5,52(s1)
    800019f0:	fbc5                	bnez	a5,800019a0 <mlfq_scheduler+0x7a>
            if (p->state == RUNNABLE)
    800019f2:	4c9c                	lw	a5,24(s1)
    800019f4:	fd379fe3          	bne	a5,s3,800019d2 <mlfq_scheduler+0xac>
                p->state = RUNNING;
    800019f8:	0174ac23          	sw	s7,24(s1)
                c->proc = p;
    800019fc:	009a3023          	sd	s1,0(s4)
                swtch(&c->context, &p->context);
    80001a00:	06848593          	addi	a1,s1,104
    80001a04:	8556                	mv	a0,s5
    80001a06:	00001097          	auipc	ra,0x1
    80001a0a:	0a4080e7          	jalr	164(ra) # 80002aaa <swtch>
                if (sched_pointer != &mlfq_scheduler)
    80001a0e:	000cb783          	ld	a5,0(s9)
    80001a12:	f9879de3          	bne	a5,s8,800019ac <mlfq_scheduler+0x86>
                c->proc = 0;
    80001a16:	000a3023          	sd	zero,0(s4)
                high_avail = 1;
    80001a1a:	4b05                	li	s6,1
    80001a1c:	bf5d                	j	800019d2 <mlfq_scheduler+0xac>
    } while (high_avail);
    80001a1e:	f60b15e3          	bnez	s6,80001988 <mlfq_scheduler+0x62>
    for (p = proc; p < &proc[NPROC]; p++)
    80001a22:	0000f497          	auipc	s1,0xf
    80001a26:	64e48493          	addi	s1,s1,1614 # 80011070 <proc>
        if (p->state == RUNNABLE)
    80001a2a:	490d                	li	s2,3
            p->state = RUNNING;
    80001a2c:	4b11                	li	s6,4
            c->proc = p;
    80001a2e:	0d1e                	slli	s10,s10,0x7
    80001a30:	0000fa17          	auipc	s4,0xf
    80001a34:	210a0a13          	addi	s4,s4,528 # 80010c40 <cpus>
    80001a38:	9a6a                	add	s4,s4,s10
            if (sched_pointer != &mlfq_scheduler)
    80001a3a:	00007c17          	auipc	s8,0x7
    80001a3e:	ecec0c13          	addi	s8,s8,-306 # 80008908 <sched_pointer>
    80001a42:	00000b97          	auipc	s7,0x0
    80001a46:	ee4b8b93          	addi	s7,s7,-284 # 80001926 <mlfq_scheduler>
    for (p = proc; p < &proc[NPROC]; p++)
    80001a4a:	00015997          	auipc	s3,0x15
    80001a4e:	22698993          	addi	s3,s3,550 # 80016c70 <tickslock>
    80001a52:	a835                	j	80001a8e <mlfq_scheduler+0x168>
        if (p->state == RUNNABLE)
    80001a54:	4c9c                	lw	a5,24(s1)
    80001a56:	03279363          	bne	a5,s2,80001a7c <mlfq_scheduler+0x156>
            p->state = RUNNING;
    80001a5a:	0164ac23          	sw	s6,24(s1)
            c->proc = p;
    80001a5e:	009a3023          	sd	s1,0(s4)
            swtch(&c->context, &p->context);
    80001a62:	06848593          	addi	a1,s1,104
    80001a66:	8556                	mv	a0,s5
    80001a68:	00001097          	auipc	ra,0x1
    80001a6c:	042080e7          	jalr	66(ra) # 80002aaa <swtch>
            if (sched_pointer != &mlfq_scheduler)
    80001a70:	000c3783          	ld	a5,0(s8)
    80001a74:	03779d63          	bne	a5,s7,80001aae <mlfq_scheduler+0x188>
            c->proc = 0;
    80001a78:	000a3023          	sd	zero,0(s4)
        release(&p->lock);
    80001a7c:	8526                	mv	a0,s1
    80001a7e:	fffff097          	auipc	ra,0xfffff
    80001a82:	24e080e7          	jalr	590(ra) # 80000ccc <release>
    for (p = proc; p < &proc[NPROC]; p++)
    80001a86:	17048493          	addi	s1,s1,368
    80001a8a:	f33486e3          	beq	s1,s3,800019b6 <mlfq_scheduler+0x90>
        acquire(&p->lock);
    80001a8e:	8526                	mv	a0,s1
    80001a90:	fffff097          	auipc	ra,0xfffff
    80001a94:	188080e7          	jalr	392(ra) # 80000c18 <acquire>
        if (p->priority == 0 && p->state == RUNNABLE)
    80001a98:	58dc                	lw	a5,52(s1)
    80001a9a:	ffcd                	bnez	a5,80001a54 <mlfq_scheduler+0x12e>
    80001a9c:	4c9c                	lw	a5,24(s1)
    80001a9e:	fd279fe3          	bne	a5,s2,80001a7c <mlfq_scheduler+0x156>
            release(&p->lock);
    80001aa2:	8526                	mv	a0,s1
    80001aa4:	fffff097          	auipc	ra,0xfffff
    80001aa8:	228080e7          	jalr	552(ra) # 80000ccc <release>
            break;
    80001aac:	b729                	j	800019b6 <mlfq_scheduler+0x90>
                release(&p->lock);
    80001aae:	8526                	mv	a0,s1
    80001ab0:	fffff097          	auipc	ra,0xfffff
    80001ab4:	21c080e7          	jalr	540(ra) # 80000ccc <release>
                return;
    80001ab8:	bdfd                	j	800019b6 <mlfq_scheduler+0x90>

0000000080001aba <proc_mapstacks>:
{
    80001aba:	7139                	addi	sp,sp,-64
    80001abc:	fc06                	sd	ra,56(sp)
    80001abe:	f822                	sd	s0,48(sp)
    80001ac0:	f426                	sd	s1,40(sp)
    80001ac2:	f04a                	sd	s2,32(sp)
    80001ac4:	ec4e                	sd	s3,24(sp)
    80001ac6:	e852                	sd	s4,16(sp)
    80001ac8:	e456                	sd	s5,8(sp)
    80001aca:	e05a                	sd	s6,0(sp)
    80001acc:	0080                	addi	s0,sp,64
    80001ace:	89aa                	mv	s3,a0
    for (p = proc; p < &proc[NPROC]; p++)
    80001ad0:	0000f497          	auipc	s1,0xf
    80001ad4:	5a048493          	addi	s1,s1,1440 # 80011070 <proc>
        uint64 va = KSTACK((int)(p - proc));
    80001ad8:	8b26                	mv	s6,s1
    80001ada:	00006a97          	auipc	s5,0x6
    80001ade:	526a8a93          	addi	s5,s5,1318 # 80008000 <etext>
    80001ae2:	04000937          	lui	s2,0x4000
    80001ae6:	197d                	addi	s2,s2,-1 # 3ffffff <_entry-0x7c000001>
    80001ae8:	0932                	slli	s2,s2,0xc
    for (p = proc; p < &proc[NPROC]; p++)
    80001aea:	00015a17          	auipc	s4,0x15
    80001aee:	186a0a13          	addi	s4,s4,390 # 80016c70 <tickslock>
        char *pa = kalloc();
    80001af2:	fffff097          	auipc	ra,0xfffff
    80001af6:	036080e7          	jalr	54(ra) # 80000b28 <kalloc>
    80001afa:	862a                	mv	a2,a0
        if (pa == 0)
    80001afc:	c131                	beqz	a0,80001b40 <proc_mapstacks+0x86>
        uint64 va = KSTACK((int)(p - proc));
    80001afe:	416485b3          	sub	a1,s1,s6
    80001b02:	8591                	srai	a1,a1,0x4
    80001b04:	000ab783          	ld	a5,0(s5)
    80001b08:	02f585b3          	mul	a1,a1,a5
    80001b0c:	2585                	addiw	a1,a1,1
    80001b0e:	00d5959b          	slliw	a1,a1,0xd
        kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80001b12:	4719                	li	a4,6
    80001b14:	6685                	lui	a3,0x1
    80001b16:	40b905b3          	sub	a1,s2,a1
    80001b1a:	854e                	mv	a0,s3
    80001b1c:	fffff097          	auipc	ra,0xfffff
    80001b20:	662080e7          	jalr	1634(ra) # 8000117e <kvmmap>
    for (p = proc; p < &proc[NPROC]; p++)
    80001b24:	17048493          	addi	s1,s1,368
    80001b28:	fd4495e3          	bne	s1,s4,80001af2 <proc_mapstacks+0x38>
}
    80001b2c:	70e2                	ld	ra,56(sp)
    80001b2e:	7442                	ld	s0,48(sp)
    80001b30:	74a2                	ld	s1,40(sp)
    80001b32:	7902                	ld	s2,32(sp)
    80001b34:	69e2                	ld	s3,24(sp)
    80001b36:	6a42                	ld	s4,16(sp)
    80001b38:	6aa2                	ld	s5,8(sp)
    80001b3a:	6b02                	ld	s6,0(sp)
    80001b3c:	6121                	addi	sp,sp,64
    80001b3e:	8082                	ret
            panic("kalloc");
    80001b40:	00006517          	auipc	a0,0x6
    80001b44:	69850513          	addi	a0,a0,1688 # 800081d8 <digits+0x198>
    80001b48:	fffff097          	auipc	ra,0xfffff
    80001b4c:	a3a080e7          	jalr	-1478(ra) # 80000582 <panic>

0000000080001b50 <procinit>:
{
    80001b50:	7139                	addi	sp,sp,-64
    80001b52:	fc06                	sd	ra,56(sp)
    80001b54:	f822                	sd	s0,48(sp)
    80001b56:	f426                	sd	s1,40(sp)
    80001b58:	f04a                	sd	s2,32(sp)
    80001b5a:	ec4e                	sd	s3,24(sp)
    80001b5c:	e852                	sd	s4,16(sp)
    80001b5e:	e456                	sd	s5,8(sp)
    80001b60:	e05a                	sd	s6,0(sp)
    80001b62:	0080                	addi	s0,sp,64
    initlock(&pid_lock, "nextpid");
    80001b64:	00006597          	auipc	a1,0x6
    80001b68:	67c58593          	addi	a1,a1,1660 # 800081e0 <digits+0x1a0>
    80001b6c:	0000f517          	auipc	a0,0xf
    80001b70:	4d450513          	addi	a0,a0,1236 # 80011040 <pid_lock>
    80001b74:	fffff097          	auipc	ra,0xfffff
    80001b78:	014080e7          	jalr	20(ra) # 80000b88 <initlock>
    initlock(&wait_lock, "wait_lock");
    80001b7c:	00006597          	auipc	a1,0x6
    80001b80:	66c58593          	addi	a1,a1,1644 # 800081e8 <digits+0x1a8>
    80001b84:	0000f517          	auipc	a0,0xf
    80001b88:	4d450513          	addi	a0,a0,1236 # 80011058 <wait_lock>
    80001b8c:	fffff097          	auipc	ra,0xfffff
    80001b90:	ffc080e7          	jalr	-4(ra) # 80000b88 <initlock>
    for (p = proc; p < &proc[NPROC]; p++)
    80001b94:	0000f497          	auipc	s1,0xf
    80001b98:	4dc48493          	addi	s1,s1,1244 # 80011070 <proc>
        initlock(&p->lock, "proc");
    80001b9c:	00006b17          	auipc	s6,0x6
    80001ba0:	65cb0b13          	addi	s6,s6,1628 # 800081f8 <digits+0x1b8>
        p->kstack = KSTACK((int)(p - proc));
    80001ba4:	8aa6                	mv	s5,s1
    80001ba6:	00006a17          	auipc	s4,0x6
    80001baa:	45aa0a13          	addi	s4,s4,1114 # 80008000 <etext>
    80001bae:	04000937          	lui	s2,0x4000
    80001bb2:	197d                	addi	s2,s2,-1 # 3ffffff <_entry-0x7c000001>
    80001bb4:	0932                	slli	s2,s2,0xc
    for (p = proc; p < &proc[NPROC]; p++)
    80001bb6:	00015997          	auipc	s3,0x15
    80001bba:	0ba98993          	addi	s3,s3,186 # 80016c70 <tickslock>
        initlock(&p->lock, "proc");
    80001bbe:	85da                	mv	a1,s6
    80001bc0:	8526                	mv	a0,s1
    80001bc2:	fffff097          	auipc	ra,0xfffff
    80001bc6:	fc6080e7          	jalr	-58(ra) # 80000b88 <initlock>
        p->state = UNUSED;
    80001bca:	0004ac23          	sw	zero,24(s1)
        p->kstack = KSTACK((int)(p - proc));
    80001bce:	415487b3          	sub	a5,s1,s5
    80001bd2:	8791                	srai	a5,a5,0x4
    80001bd4:	000a3703          	ld	a4,0(s4)
    80001bd8:	02e787b3          	mul	a5,a5,a4
    80001bdc:	2785                	addiw	a5,a5,1
    80001bde:	00d7979b          	slliw	a5,a5,0xd
    80001be2:	40f907b3          	sub	a5,s2,a5
    80001be6:	e4bc                	sd	a5,72(s1)
    for (p = proc; p < &proc[NPROC]; p++)
    80001be8:	17048493          	addi	s1,s1,368
    80001bec:	fd3499e3          	bne	s1,s3,80001bbe <procinit+0x6e>
}
    80001bf0:	70e2                	ld	ra,56(sp)
    80001bf2:	7442                	ld	s0,48(sp)
    80001bf4:	74a2                	ld	s1,40(sp)
    80001bf6:	7902                	ld	s2,32(sp)
    80001bf8:	69e2                	ld	s3,24(sp)
    80001bfa:	6a42                	ld	s4,16(sp)
    80001bfc:	6aa2                	ld	s5,8(sp)
    80001bfe:	6b02                	ld	s6,0(sp)
    80001c00:	6121                	addi	sp,sp,64
    80001c02:	8082                	ret

0000000080001c04 <copy_array>:
{
    80001c04:	1141                	addi	sp,sp,-16
    80001c06:	e422                	sd	s0,8(sp)
    80001c08:	0800                	addi	s0,sp,16
    for (int i = 0; i < len; i++)
    80001c0a:	00c05c63          	blez	a2,80001c22 <copy_array+0x1e>
    80001c0e:	87aa                	mv	a5,a0
    80001c10:	9532                	add	a0,a0,a2
        dst[i] = src[i];
    80001c12:	0007c703          	lbu	a4,0(a5)
    80001c16:	00e58023          	sb	a4,0(a1)
    for (int i = 0; i < len; i++)
    80001c1a:	0785                	addi	a5,a5,1
    80001c1c:	0585                	addi	a1,a1,1
    80001c1e:	fea79ae3          	bne	a5,a0,80001c12 <copy_array+0xe>
}
    80001c22:	6422                	ld	s0,8(sp)
    80001c24:	0141                	addi	sp,sp,16
    80001c26:	8082                	ret

0000000080001c28 <cpuid>:
{
    80001c28:	1141                	addi	sp,sp,-16
    80001c2a:	e422                	sd	s0,8(sp)
    80001c2c:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80001c2e:	8512                	mv	a0,tp
}
    80001c30:	2501                	sext.w	a0,a0
    80001c32:	6422                	ld	s0,8(sp)
    80001c34:	0141                	addi	sp,sp,16
    80001c36:	8082                	ret

0000000080001c38 <mycpu>:
{
    80001c38:	1141                	addi	sp,sp,-16
    80001c3a:	e422                	sd	s0,8(sp)
    80001c3c:	0800                	addi	s0,sp,16
    80001c3e:	8792                	mv	a5,tp
    struct cpu *c = &cpus[id];
    80001c40:	2781                	sext.w	a5,a5
    80001c42:	079e                	slli	a5,a5,0x7
}
    80001c44:	0000f517          	auipc	a0,0xf
    80001c48:	ffc50513          	addi	a0,a0,-4 # 80010c40 <cpus>
    80001c4c:	953e                	add	a0,a0,a5
    80001c4e:	6422                	ld	s0,8(sp)
    80001c50:	0141                	addi	sp,sp,16
    80001c52:	8082                	ret

0000000080001c54 <myproc>:
{
    80001c54:	1101                	addi	sp,sp,-32
    80001c56:	ec06                	sd	ra,24(sp)
    80001c58:	e822                	sd	s0,16(sp)
    80001c5a:	e426                	sd	s1,8(sp)
    80001c5c:	1000                	addi	s0,sp,32
    push_off();
    80001c5e:	fffff097          	auipc	ra,0xfffff
    80001c62:	f6e080e7          	jalr	-146(ra) # 80000bcc <push_off>
    80001c66:	8792                	mv	a5,tp
    struct proc *p = c->proc;
    80001c68:	2781                	sext.w	a5,a5
    80001c6a:	079e                	slli	a5,a5,0x7
    80001c6c:	0000f717          	auipc	a4,0xf
    80001c70:	fd470713          	addi	a4,a4,-44 # 80010c40 <cpus>
    80001c74:	97ba                	add	a5,a5,a4
    80001c76:	6384                	ld	s1,0(a5)
    pop_off();
    80001c78:	fffff097          	auipc	ra,0xfffff
    80001c7c:	ff4080e7          	jalr	-12(ra) # 80000c6c <pop_off>
}
    80001c80:	8526                	mv	a0,s1
    80001c82:	60e2                	ld	ra,24(sp)
    80001c84:	6442                	ld	s0,16(sp)
    80001c86:	64a2                	ld	s1,8(sp)
    80001c88:	6105                	addi	sp,sp,32
    80001c8a:	8082                	ret

0000000080001c8c <forkret>:
}

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void forkret(void)
{
    80001c8c:	1141                	addi	sp,sp,-16
    80001c8e:	e406                	sd	ra,8(sp)
    80001c90:	e022                	sd	s0,0(sp)
    80001c92:	0800                	addi	s0,sp,16
    static int first = 1;

    // Still holding p->lock from scheduler.
    release(&myproc()->lock);
    80001c94:	00000097          	auipc	ra,0x0
    80001c98:	fc0080e7          	jalr	-64(ra) # 80001c54 <myproc>
    80001c9c:	fffff097          	auipc	ra,0xfffff
    80001ca0:	030080e7          	jalr	48(ra) # 80000ccc <release>

    if (first)
    80001ca4:	00007797          	auipc	a5,0x7
    80001ca8:	c5c7a783          	lw	a5,-932(a5) # 80008900 <first.1>
    80001cac:	eb89                	bnez	a5,80001cbe <forkret+0x32>
        // be run from main().
        first = 0;
        fsinit(ROOTDEV);
    }

    usertrapret();
    80001cae:	00001097          	auipc	ra,0x1
    80001cb2:	ea6080e7          	jalr	-346(ra) # 80002b54 <usertrapret>
}
    80001cb6:	60a2                	ld	ra,8(sp)
    80001cb8:	6402                	ld	s0,0(sp)
    80001cba:	0141                	addi	sp,sp,16
    80001cbc:	8082                	ret
        first = 0;
    80001cbe:	00007797          	auipc	a5,0x7
    80001cc2:	c407a123          	sw	zero,-958(a5) # 80008900 <first.1>
        fsinit(ROOTDEV);
    80001cc6:	4505                	li	a0,1
    80001cc8:	00002097          	auipc	ra,0x2
    80001ccc:	c6c080e7          	jalr	-916(ra) # 80003934 <fsinit>
    80001cd0:	bff9                	j	80001cae <forkret+0x22>

0000000080001cd2 <allocpid>:
{
    80001cd2:	1101                	addi	sp,sp,-32
    80001cd4:	ec06                	sd	ra,24(sp)
    80001cd6:	e822                	sd	s0,16(sp)
    80001cd8:	e426                	sd	s1,8(sp)
    80001cda:	e04a                	sd	s2,0(sp)
    80001cdc:	1000                	addi	s0,sp,32
    acquire(&pid_lock);
    80001cde:	0000f917          	auipc	s2,0xf
    80001ce2:	36290913          	addi	s2,s2,866 # 80011040 <pid_lock>
    80001ce6:	854a                	mv	a0,s2
    80001ce8:	fffff097          	auipc	ra,0xfffff
    80001cec:	f30080e7          	jalr	-208(ra) # 80000c18 <acquire>
    pid = nextpid;
    80001cf0:	00007797          	auipc	a5,0x7
    80001cf4:	c2078793          	addi	a5,a5,-992 # 80008910 <nextpid>
    80001cf8:	4384                	lw	s1,0(a5)
    nextpid = nextpid + 1;
    80001cfa:	0014871b          	addiw	a4,s1,1
    80001cfe:	c398                	sw	a4,0(a5)
    release(&pid_lock);
    80001d00:	854a                	mv	a0,s2
    80001d02:	fffff097          	auipc	ra,0xfffff
    80001d06:	fca080e7          	jalr	-54(ra) # 80000ccc <release>
}
    80001d0a:	8526                	mv	a0,s1
    80001d0c:	60e2                	ld	ra,24(sp)
    80001d0e:	6442                	ld	s0,16(sp)
    80001d10:	64a2                	ld	s1,8(sp)
    80001d12:	6902                	ld	s2,0(sp)
    80001d14:	6105                	addi	sp,sp,32
    80001d16:	8082                	ret

0000000080001d18 <proc_pagetable>:
{
    80001d18:	1101                	addi	sp,sp,-32
    80001d1a:	ec06                	sd	ra,24(sp)
    80001d1c:	e822                	sd	s0,16(sp)
    80001d1e:	e426                	sd	s1,8(sp)
    80001d20:	e04a                	sd	s2,0(sp)
    80001d22:	1000                	addi	s0,sp,32
    80001d24:	892a                	mv	s2,a0
    pagetable = uvmcreate();
    80001d26:	fffff097          	auipc	ra,0xfffff
    80001d2a:	642080e7          	jalr	1602(ra) # 80001368 <uvmcreate>
    80001d2e:	84aa                	mv	s1,a0
    if (pagetable == 0)
    80001d30:	c121                	beqz	a0,80001d70 <proc_pagetable+0x58>
    if (mappages(pagetable, TRAMPOLINE, PGSIZE,
    80001d32:	4729                	li	a4,10
    80001d34:	00005697          	auipc	a3,0x5
    80001d38:	2cc68693          	addi	a3,a3,716 # 80007000 <_trampoline>
    80001d3c:	6605                	lui	a2,0x1
    80001d3e:	040005b7          	lui	a1,0x4000
    80001d42:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001d44:	05b2                	slli	a1,a1,0xc
    80001d46:	fffff097          	auipc	ra,0xfffff
    80001d4a:	398080e7          	jalr	920(ra) # 800010de <mappages>
    80001d4e:	02054863          	bltz	a0,80001d7e <proc_pagetable+0x66>
    if (mappages(pagetable, TRAPFRAME, PGSIZE,
    80001d52:	4719                	li	a4,6
    80001d54:	06093683          	ld	a3,96(s2)
    80001d58:	6605                	lui	a2,0x1
    80001d5a:	020005b7          	lui	a1,0x2000
    80001d5e:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001d60:	05b6                	slli	a1,a1,0xd
    80001d62:	8526                	mv	a0,s1
    80001d64:	fffff097          	auipc	ra,0xfffff
    80001d68:	37a080e7          	jalr	890(ra) # 800010de <mappages>
    80001d6c:	02054163          	bltz	a0,80001d8e <proc_pagetable+0x76>
}
    80001d70:	8526                	mv	a0,s1
    80001d72:	60e2                	ld	ra,24(sp)
    80001d74:	6442                	ld	s0,16(sp)
    80001d76:	64a2                	ld	s1,8(sp)
    80001d78:	6902                	ld	s2,0(sp)
    80001d7a:	6105                	addi	sp,sp,32
    80001d7c:	8082                	ret
        uvmfree(pagetable, 0);
    80001d7e:	4581                	li	a1,0
    80001d80:	8526                	mv	a0,s1
    80001d82:	fffff097          	auipc	ra,0xfffff
    80001d86:	7ec080e7          	jalr	2028(ra) # 8000156e <uvmfree>
        return 0;
    80001d8a:	4481                	li	s1,0
    80001d8c:	b7d5                	j	80001d70 <proc_pagetable+0x58>
        uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001d8e:	4681                	li	a3,0
    80001d90:	4605                	li	a2,1
    80001d92:	040005b7          	lui	a1,0x4000
    80001d96:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001d98:	05b2                	slli	a1,a1,0xc
    80001d9a:	8526                	mv	a0,s1
    80001d9c:	fffff097          	auipc	ra,0xfffff
    80001da0:	508080e7          	jalr	1288(ra) # 800012a4 <uvmunmap>
        uvmfree(pagetable, 0);
    80001da4:	4581                	li	a1,0
    80001da6:	8526                	mv	a0,s1
    80001da8:	fffff097          	auipc	ra,0xfffff
    80001dac:	7c6080e7          	jalr	1990(ra) # 8000156e <uvmfree>
        return 0;
    80001db0:	4481                	li	s1,0
    80001db2:	bf7d                	j	80001d70 <proc_pagetable+0x58>

0000000080001db4 <proc_freepagetable>:
{
    80001db4:	1101                	addi	sp,sp,-32
    80001db6:	ec06                	sd	ra,24(sp)
    80001db8:	e822                	sd	s0,16(sp)
    80001dba:	e426                	sd	s1,8(sp)
    80001dbc:	e04a                	sd	s2,0(sp)
    80001dbe:	1000                	addi	s0,sp,32
    80001dc0:	84aa                	mv	s1,a0
    80001dc2:	892e                	mv	s2,a1
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001dc4:	4681                	li	a3,0
    80001dc6:	4605                	li	a2,1
    80001dc8:	040005b7          	lui	a1,0x4000
    80001dcc:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001dce:	05b2                	slli	a1,a1,0xc
    80001dd0:	fffff097          	auipc	ra,0xfffff
    80001dd4:	4d4080e7          	jalr	1236(ra) # 800012a4 <uvmunmap>
    uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80001dd8:	4681                	li	a3,0
    80001dda:	4605                	li	a2,1
    80001ddc:	020005b7          	lui	a1,0x2000
    80001de0:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001de2:	05b6                	slli	a1,a1,0xd
    80001de4:	8526                	mv	a0,s1
    80001de6:	fffff097          	auipc	ra,0xfffff
    80001dea:	4be080e7          	jalr	1214(ra) # 800012a4 <uvmunmap>
    uvmfree(pagetable, sz);
    80001dee:	85ca                	mv	a1,s2
    80001df0:	8526                	mv	a0,s1
    80001df2:	fffff097          	auipc	ra,0xfffff
    80001df6:	77c080e7          	jalr	1916(ra) # 8000156e <uvmfree>
}
    80001dfa:	60e2                	ld	ra,24(sp)
    80001dfc:	6442                	ld	s0,16(sp)
    80001dfe:	64a2                	ld	s1,8(sp)
    80001e00:	6902                	ld	s2,0(sp)
    80001e02:	6105                	addi	sp,sp,32
    80001e04:	8082                	ret

0000000080001e06 <freeproc>:
{
    80001e06:	1101                	addi	sp,sp,-32
    80001e08:	ec06                	sd	ra,24(sp)
    80001e0a:	e822                	sd	s0,16(sp)
    80001e0c:	e426                	sd	s1,8(sp)
    80001e0e:	1000                	addi	s0,sp,32
    80001e10:	84aa                	mv	s1,a0
    if (p->trapframe)
    80001e12:	7128                	ld	a0,96(a0)
    80001e14:	c509                	beqz	a0,80001e1e <freeproc+0x18>
        kfree((void *)p->trapframe);
    80001e16:	fffff097          	auipc	ra,0xfffff
    80001e1a:	c14080e7          	jalr	-1004(ra) # 80000a2a <kfree>
    p->trapframe = 0;
    80001e1e:	0604b023          	sd	zero,96(s1)
    if (p->pagetable)
    80001e22:	6ca8                	ld	a0,88(s1)
    80001e24:	c511                	beqz	a0,80001e30 <freeproc+0x2a>
        proc_freepagetable(p->pagetable, p->sz);
    80001e26:	68ac                	ld	a1,80(s1)
    80001e28:	00000097          	auipc	ra,0x0
    80001e2c:	f8c080e7          	jalr	-116(ra) # 80001db4 <proc_freepagetable>
    p->pagetable = 0;
    80001e30:	0404bc23          	sd	zero,88(s1)
    p->sz = 0;
    80001e34:	0404b823          	sd	zero,80(s1)
    p->pid = 0;
    80001e38:	0204a823          	sw	zero,48(s1)
    p->parent = 0;
    80001e3c:	0404b023          	sd	zero,64(s1)
    p->name[0] = 0;
    80001e40:	16048023          	sb	zero,352(s1)
    p->chan = 0;
    80001e44:	0204b023          	sd	zero,32(s1)
    p->killed = 0;
    80001e48:	0204a423          	sw	zero,40(s1)
    p->xstate = 0;
    80001e4c:	0204a623          	sw	zero,44(s1)
    p->state = UNUSED;
    80001e50:	0004ac23          	sw	zero,24(s1)
}
    80001e54:	60e2                	ld	ra,24(sp)
    80001e56:	6442                	ld	s0,16(sp)
    80001e58:	64a2                	ld	s1,8(sp)
    80001e5a:	6105                	addi	sp,sp,32
    80001e5c:	8082                	ret

0000000080001e5e <allocproc>:
{
    80001e5e:	1101                	addi	sp,sp,-32
    80001e60:	ec06                	sd	ra,24(sp)
    80001e62:	e822                	sd	s0,16(sp)
    80001e64:	e426                	sd	s1,8(sp)
    80001e66:	e04a                	sd	s2,0(sp)
    80001e68:	1000                	addi	s0,sp,32
    for (p = proc; p < &proc[NPROC]; p++)
    80001e6a:	0000f497          	auipc	s1,0xf
    80001e6e:	20648493          	addi	s1,s1,518 # 80011070 <proc>
    80001e72:	00015917          	auipc	s2,0x15
    80001e76:	dfe90913          	addi	s2,s2,-514 # 80016c70 <tickslock>
        acquire(&p->lock);
    80001e7a:	8526                	mv	a0,s1
    80001e7c:	fffff097          	auipc	ra,0xfffff
    80001e80:	d9c080e7          	jalr	-612(ra) # 80000c18 <acquire>
        if (p->state == UNUSED)
    80001e84:	4c9c                	lw	a5,24(s1)
    80001e86:	cf81                	beqz	a5,80001e9e <allocproc+0x40>
            release(&p->lock);
    80001e88:	8526                	mv	a0,s1
    80001e8a:	fffff097          	auipc	ra,0xfffff
    80001e8e:	e42080e7          	jalr	-446(ra) # 80000ccc <release>
    for (p = proc; p < &proc[NPROC]; p++)
    80001e92:	17048493          	addi	s1,s1,368
    80001e96:	ff2492e3          	bne	s1,s2,80001e7a <allocproc+0x1c>
    return 0;
    80001e9a:	4481                	li	s1,0
    80001e9c:	a8a9                	j	80001ef6 <allocproc+0x98>
    p->pid = allocpid();
    80001e9e:	00000097          	auipc	ra,0x0
    80001ea2:	e34080e7          	jalr	-460(ra) # 80001cd2 <allocpid>
    80001ea6:	d888                	sw	a0,48(s1)
    p->state = USED;
    80001ea8:	4785                	li	a5,1
    80001eaa:	cc9c                	sw	a5,24(s1)
    p->priority = 0;
    80001eac:	0204aa23          	sw	zero,52(s1)
    p->promotion_timer = 0;
    80001eb0:	0204ac23          	sw	zero,56(s1)
    if ((p->trapframe = (struct trapframe *)kalloc()) == 0)
    80001eb4:	fffff097          	auipc	ra,0xfffff
    80001eb8:	c74080e7          	jalr	-908(ra) # 80000b28 <kalloc>
    80001ebc:	892a                	mv	s2,a0
    80001ebe:	f0a8                	sd	a0,96(s1)
    80001ec0:	c131                	beqz	a0,80001f04 <allocproc+0xa6>
    p->pagetable = proc_pagetable(p);
    80001ec2:	8526                	mv	a0,s1
    80001ec4:	00000097          	auipc	ra,0x0
    80001ec8:	e54080e7          	jalr	-428(ra) # 80001d18 <proc_pagetable>
    80001ecc:	892a                	mv	s2,a0
    80001ece:	eca8                	sd	a0,88(s1)
    if (p->pagetable == 0)
    80001ed0:	c531                	beqz	a0,80001f1c <allocproc+0xbe>
    memset(&p->context, 0, sizeof(p->context));
    80001ed2:	07000613          	li	a2,112
    80001ed6:	4581                	li	a1,0
    80001ed8:	06848513          	addi	a0,s1,104
    80001edc:	fffff097          	auipc	ra,0xfffff
    80001ee0:	e38080e7          	jalr	-456(ra) # 80000d14 <memset>
    p->context.ra = (uint64)forkret;
    80001ee4:	00000797          	auipc	a5,0x0
    80001ee8:	da878793          	addi	a5,a5,-600 # 80001c8c <forkret>
    80001eec:	f4bc                	sd	a5,104(s1)
    p->context.sp = p->kstack + PGSIZE;
    80001eee:	64bc                	ld	a5,72(s1)
    80001ef0:	6705                	lui	a4,0x1
    80001ef2:	97ba                	add	a5,a5,a4
    80001ef4:	f8bc                	sd	a5,112(s1)
}
    80001ef6:	8526                	mv	a0,s1
    80001ef8:	60e2                	ld	ra,24(sp)
    80001efa:	6442                	ld	s0,16(sp)
    80001efc:	64a2                	ld	s1,8(sp)
    80001efe:	6902                	ld	s2,0(sp)
    80001f00:	6105                	addi	sp,sp,32
    80001f02:	8082                	ret
        freeproc(p);
    80001f04:	8526                	mv	a0,s1
    80001f06:	00000097          	auipc	ra,0x0
    80001f0a:	f00080e7          	jalr	-256(ra) # 80001e06 <freeproc>
        release(&p->lock);
    80001f0e:	8526                	mv	a0,s1
    80001f10:	fffff097          	auipc	ra,0xfffff
    80001f14:	dbc080e7          	jalr	-580(ra) # 80000ccc <release>
        return 0;
    80001f18:	84ca                	mv	s1,s2
    80001f1a:	bff1                	j	80001ef6 <allocproc+0x98>
        freeproc(p);
    80001f1c:	8526                	mv	a0,s1
    80001f1e:	00000097          	auipc	ra,0x0
    80001f22:	ee8080e7          	jalr	-280(ra) # 80001e06 <freeproc>
        release(&p->lock);
    80001f26:	8526                	mv	a0,s1
    80001f28:	fffff097          	auipc	ra,0xfffff
    80001f2c:	da4080e7          	jalr	-604(ra) # 80000ccc <release>
        return 0;
    80001f30:	84ca                	mv	s1,s2
    80001f32:	b7d1                	j	80001ef6 <allocproc+0x98>

0000000080001f34 <userinit>:
{
    80001f34:	1101                	addi	sp,sp,-32
    80001f36:	ec06                	sd	ra,24(sp)
    80001f38:	e822                	sd	s0,16(sp)
    80001f3a:	e426                	sd	s1,8(sp)
    80001f3c:	1000                	addi	s0,sp,32
    p = allocproc();
    80001f3e:	00000097          	auipc	ra,0x0
    80001f42:	f20080e7          	jalr	-224(ra) # 80001e5e <allocproc>
    80001f46:	84aa                	mv	s1,a0
    initproc = p;
    80001f48:	00007797          	auipc	a5,0x7
    80001f4c:	a8a7b023          	sd	a0,-1408(a5) # 800089c8 <initproc>
    uvmfirst(p->pagetable, initcode, sizeof(initcode));
    80001f50:	03400613          	li	a2,52
    80001f54:	00007597          	auipc	a1,0x7
    80001f58:	9cc58593          	addi	a1,a1,-1588 # 80008920 <initcode>
    80001f5c:	6d28                	ld	a0,88(a0)
    80001f5e:	fffff097          	auipc	ra,0xfffff
    80001f62:	438080e7          	jalr	1080(ra) # 80001396 <uvmfirst>
    p->sz = PGSIZE;
    80001f66:	6785                	lui	a5,0x1
    80001f68:	e8bc                	sd	a5,80(s1)
    p->trapframe->epc = 0;     // user program counter
    80001f6a:	70b8                	ld	a4,96(s1)
    80001f6c:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
    p->trapframe->sp = PGSIZE; // user stack pointer
    80001f70:	70b8                	ld	a4,96(s1)
    80001f72:	fb1c                	sd	a5,48(a4)
    safestrcpy(p->name, "initcode", sizeof(p->name));
    80001f74:	4641                	li	a2,16
    80001f76:	00006597          	auipc	a1,0x6
    80001f7a:	28a58593          	addi	a1,a1,650 # 80008200 <digits+0x1c0>
    80001f7e:	16048513          	addi	a0,s1,352
    80001f82:	fffff097          	auipc	ra,0xfffff
    80001f86:	eda080e7          	jalr	-294(ra) # 80000e5c <safestrcpy>
    p->cwd = namei("/");
    80001f8a:	00006517          	auipc	a0,0x6
    80001f8e:	28650513          	addi	a0,a0,646 # 80008210 <digits+0x1d0>
    80001f92:	00002097          	auipc	ra,0x2
    80001f96:	3c0080e7          	jalr	960(ra) # 80004352 <namei>
    80001f9a:	14a4bc23          	sd	a0,344(s1)
    p->state = RUNNABLE;
    80001f9e:	478d                	li	a5,3
    80001fa0:	cc9c                	sw	a5,24(s1)
    release(&p->lock);
    80001fa2:	8526                	mv	a0,s1
    80001fa4:	fffff097          	auipc	ra,0xfffff
    80001fa8:	d28080e7          	jalr	-728(ra) # 80000ccc <release>
}
    80001fac:	60e2                	ld	ra,24(sp)
    80001fae:	6442                	ld	s0,16(sp)
    80001fb0:	64a2                	ld	s1,8(sp)
    80001fb2:	6105                	addi	sp,sp,32
    80001fb4:	8082                	ret

0000000080001fb6 <growproc>:
{
    80001fb6:	1101                	addi	sp,sp,-32
    80001fb8:	ec06                	sd	ra,24(sp)
    80001fba:	e822                	sd	s0,16(sp)
    80001fbc:	e426                	sd	s1,8(sp)
    80001fbe:	e04a                	sd	s2,0(sp)
    80001fc0:	1000                	addi	s0,sp,32
    80001fc2:	892a                	mv	s2,a0
    struct proc *p = myproc();
    80001fc4:	00000097          	auipc	ra,0x0
    80001fc8:	c90080e7          	jalr	-880(ra) # 80001c54 <myproc>
    80001fcc:	84aa                	mv	s1,a0
    sz = p->sz;
    80001fce:	692c                	ld	a1,80(a0)
    if (n > 0)
    80001fd0:	01204c63          	bgtz	s2,80001fe8 <growproc+0x32>
    else if (n < 0)
    80001fd4:	02094663          	bltz	s2,80002000 <growproc+0x4a>
    p->sz = sz;
    80001fd8:	e8ac                	sd	a1,80(s1)
    return 0;
    80001fda:	4501                	li	a0,0
}
    80001fdc:	60e2                	ld	ra,24(sp)
    80001fde:	6442                	ld	s0,16(sp)
    80001fe0:	64a2                	ld	s1,8(sp)
    80001fe2:	6902                	ld	s2,0(sp)
    80001fe4:	6105                	addi	sp,sp,32
    80001fe6:	8082                	ret
        if ((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0)
    80001fe8:	4691                	li	a3,4
    80001fea:	00b90633          	add	a2,s2,a1
    80001fee:	6d28                	ld	a0,88(a0)
    80001ff0:	fffff097          	auipc	ra,0xfffff
    80001ff4:	460080e7          	jalr	1120(ra) # 80001450 <uvmalloc>
    80001ff8:	85aa                	mv	a1,a0
    80001ffa:	fd79                	bnez	a0,80001fd8 <growproc+0x22>
            return -1;
    80001ffc:	557d                	li	a0,-1
    80001ffe:	bff9                	j	80001fdc <growproc+0x26>
        sz = uvmdealloc(p->pagetable, sz, sz + n);
    80002000:	00b90633          	add	a2,s2,a1
    80002004:	6d28                	ld	a0,88(a0)
    80002006:	fffff097          	auipc	ra,0xfffff
    8000200a:	402080e7          	jalr	1026(ra) # 80001408 <uvmdealloc>
    8000200e:	85aa                	mv	a1,a0
    80002010:	b7e1                	j	80001fd8 <growproc+0x22>

0000000080002012 <ps>:
{
    80002012:	715d                	addi	sp,sp,-80
    80002014:	e486                	sd	ra,72(sp)
    80002016:	e0a2                	sd	s0,64(sp)
    80002018:	fc26                	sd	s1,56(sp)
    8000201a:	f84a                	sd	s2,48(sp)
    8000201c:	f44e                	sd	s3,40(sp)
    8000201e:	f052                	sd	s4,32(sp)
    80002020:	ec56                	sd	s5,24(sp)
    80002022:	e85a                	sd	s6,16(sp)
    80002024:	e45e                	sd	s7,8(sp)
    80002026:	e062                	sd	s8,0(sp)
    80002028:	0880                	addi	s0,sp,80
    8000202a:	84aa                	mv	s1,a0
    8000202c:	8bae                	mv	s7,a1
    void *result = (void *)myproc()->sz;
    8000202e:	00000097          	auipc	ra,0x0
    80002032:	c26080e7          	jalr	-986(ra) # 80001c54 <myproc>
    if (count == 0)
    80002036:	120b8063          	beqz	s7,80002156 <ps+0x144>
    void *result = (void *)myproc()->sz;
    8000203a:	05053b03          	ld	s6,80(a0)
    if (growproc(count * sizeof(struct user_proc)) < 0)
    8000203e:	003b951b          	slliw	a0,s7,0x3
    80002042:	0175053b          	addw	a0,a0,s7
    80002046:	0025151b          	slliw	a0,a0,0x2
    8000204a:	00000097          	auipc	ra,0x0
    8000204e:	f6c080e7          	jalr	-148(ra) # 80001fb6 <growproc>
    80002052:	10054463          	bltz	a0,8000215a <ps+0x148>
    struct user_proc loc_result[count];
    80002056:	003b9a13          	slli	s4,s7,0x3
    8000205a:	9a5e                	add	s4,s4,s7
    8000205c:	0a0a                	slli	s4,s4,0x2
    8000205e:	00fa0793          	addi	a5,s4,15
    80002062:	8391                	srli	a5,a5,0x4
    80002064:	0792                	slli	a5,a5,0x4
    80002066:	40f10133          	sub	sp,sp,a5
    8000206a:	8a8a                	mv	s5,sp
    struct proc *p = proc + (start * sizeof(proc));
    8000206c:	008447b7          	lui	a5,0x844
    80002070:	02f484b3          	mul	s1,s1,a5
    80002074:	0000f797          	auipc	a5,0xf
    80002078:	ffc78793          	addi	a5,a5,-4 # 80011070 <proc>
    8000207c:	94be                	add	s1,s1,a5
    if (p >= &proc[NPROC])
    8000207e:	00015797          	auipc	a5,0x15
    80002082:	bf278793          	addi	a5,a5,-1038 # 80016c70 <tickslock>
    80002086:	0cf4fc63          	bgeu	s1,a5,8000215e <ps+0x14c>
        if (localCount == count)
    8000208a:	014a8913          	addi	s2,s5,20
    uint8 localCount = 0;
    8000208e:	4981                	li	s3,0
    for (; p < &proc[NPROC]; p++)
    80002090:	8c3e                	mv	s8,a5
    80002092:	a069                	j	8000211c <ps+0x10a>
            loc_result[localCount].state = UNUSED;
    80002094:	00399793          	slli	a5,s3,0x3
    80002098:	97ce                	add	a5,a5,s3
    8000209a:	078a                	slli	a5,a5,0x2
    8000209c:	97d6                	add	a5,a5,s5
    8000209e:	0007a023          	sw	zero,0(a5)
            release(&p->lock);
    800020a2:	8526                	mv	a0,s1
    800020a4:	fffff097          	auipc	ra,0xfffff
    800020a8:	c28080e7          	jalr	-984(ra) # 80000ccc <release>
    if (localCount < count)
    800020ac:	0179f963          	bgeu	s3,s7,800020be <ps+0xac>
        loc_result[localCount].state = UNUSED; // if we reach the end of processes
    800020b0:	00399793          	slli	a5,s3,0x3
    800020b4:	97ce                	add	a5,a5,s3
    800020b6:	078a                	slli	a5,a5,0x2
    800020b8:	97d6                	add	a5,a5,s5
    800020ba:	0007a023          	sw	zero,0(a5)
    void *result = (void *)myproc()->sz;
    800020be:	84da                	mv	s1,s6
    copyout(myproc()->pagetable, (uint64)result, (void *)loc_result, count * sizeof(struct user_proc));
    800020c0:	00000097          	auipc	ra,0x0
    800020c4:	b94080e7          	jalr	-1132(ra) # 80001c54 <myproc>
    800020c8:	86d2                	mv	a3,s4
    800020ca:	8656                	mv	a2,s5
    800020cc:	85da                	mv	a1,s6
    800020ce:	6d28                	ld	a0,88(a0)
    800020d0:	fffff097          	auipc	ra,0xfffff
    800020d4:	5dc080e7          	jalr	1500(ra) # 800016ac <copyout>
}
    800020d8:	8526                	mv	a0,s1
    800020da:	fb040113          	addi	sp,s0,-80
    800020de:	60a6                	ld	ra,72(sp)
    800020e0:	6406                	ld	s0,64(sp)
    800020e2:	74e2                	ld	s1,56(sp)
    800020e4:	7942                	ld	s2,48(sp)
    800020e6:	79a2                	ld	s3,40(sp)
    800020e8:	7a02                	ld	s4,32(sp)
    800020ea:	6ae2                	ld	s5,24(sp)
    800020ec:	6b42                	ld	s6,16(sp)
    800020ee:	6ba2                	ld	s7,8(sp)
    800020f0:	6c02                	ld	s8,0(sp)
    800020f2:	6161                	addi	sp,sp,80
    800020f4:	8082                	ret
            loc_result[localCount].parent_id = p->parent->pid;
    800020f6:	5b9c                	lw	a5,48(a5)
    800020f8:	fef92e23          	sw	a5,-4(s2)
        release(&p->lock);
    800020fc:	8526                	mv	a0,s1
    800020fe:	fffff097          	auipc	ra,0xfffff
    80002102:	bce080e7          	jalr	-1074(ra) # 80000ccc <release>
        localCount++;
    80002106:	2985                	addiw	s3,s3,1
    80002108:	0ff9f993          	zext.b	s3,s3
    for (; p < &proc[NPROC]; p++)
    8000210c:	17048493          	addi	s1,s1,368
    80002110:	f984fee3          	bgeu	s1,s8,800020ac <ps+0x9a>
        if (localCount == count)
    80002114:	02490913          	addi	s2,s2,36
    80002118:	fb3b83e3          	beq	s7,s3,800020be <ps+0xac>
        acquire(&p->lock);
    8000211c:	8526                	mv	a0,s1
    8000211e:	fffff097          	auipc	ra,0xfffff
    80002122:	afa080e7          	jalr	-1286(ra) # 80000c18 <acquire>
        if (p->state == UNUSED)
    80002126:	4c9c                	lw	a5,24(s1)
    80002128:	d7b5                	beqz	a5,80002094 <ps+0x82>
        loc_result[localCount].state = p->state;
    8000212a:	fef92623          	sw	a5,-20(s2)
        loc_result[localCount].killed = p->killed;
    8000212e:	549c                	lw	a5,40(s1)
    80002130:	fef92823          	sw	a5,-16(s2)
        loc_result[localCount].xstate = p->xstate;
    80002134:	54dc                	lw	a5,44(s1)
    80002136:	fef92a23          	sw	a5,-12(s2)
        loc_result[localCount].pid = p->pid;
    8000213a:	589c                	lw	a5,48(s1)
    8000213c:	fef92c23          	sw	a5,-8(s2)
        copy_array(p->name, loc_result[localCount].name, 16);
    80002140:	4641                	li	a2,16
    80002142:	85ca                	mv	a1,s2
    80002144:	16048513          	addi	a0,s1,352
    80002148:	00000097          	auipc	ra,0x0
    8000214c:	abc080e7          	jalr	-1348(ra) # 80001c04 <copy_array>
        if (p->parent != 0) // init
    80002150:	60bc                	ld	a5,64(s1)
    80002152:	f3d5                	bnez	a5,800020f6 <ps+0xe4>
    80002154:	b765                	j	800020fc <ps+0xea>
        return 0;
    80002156:	4481                	li	s1,0
    80002158:	b741                	j	800020d8 <ps+0xc6>
        return 0;
    8000215a:	4481                	li	s1,0
    8000215c:	bfb5                	j	800020d8 <ps+0xc6>
        return result;
    8000215e:	4481                	li	s1,0
    80002160:	bfa5                	j	800020d8 <ps+0xc6>

0000000080002162 <fork>:
{
    80002162:	7139                	addi	sp,sp,-64
    80002164:	fc06                	sd	ra,56(sp)
    80002166:	f822                	sd	s0,48(sp)
    80002168:	f426                	sd	s1,40(sp)
    8000216a:	f04a                	sd	s2,32(sp)
    8000216c:	ec4e                	sd	s3,24(sp)
    8000216e:	e852                	sd	s4,16(sp)
    80002170:	e456                	sd	s5,8(sp)
    80002172:	0080                	addi	s0,sp,64
    struct proc *p = myproc();
    80002174:	00000097          	auipc	ra,0x0
    80002178:	ae0080e7          	jalr	-1312(ra) # 80001c54 <myproc>
    8000217c:	8aaa                	mv	s5,a0
    if ((np = allocproc()) == 0)
    8000217e:	00000097          	auipc	ra,0x0
    80002182:	ce0080e7          	jalr	-800(ra) # 80001e5e <allocproc>
    80002186:	10050c63          	beqz	a0,8000229e <fork+0x13c>
    8000218a:	8a2a                	mv	s4,a0
    if (uvmcopy(p->pagetable, np->pagetable, p->sz) < 0)
    8000218c:	050ab603          	ld	a2,80(s5)
    80002190:	6d2c                	ld	a1,88(a0)
    80002192:	058ab503          	ld	a0,88(s5)
    80002196:	fffff097          	auipc	ra,0xfffff
    8000219a:	412080e7          	jalr	1042(ra) # 800015a8 <uvmcopy>
    8000219e:	04054863          	bltz	a0,800021ee <fork+0x8c>
    np->sz = p->sz;
    800021a2:	050ab783          	ld	a5,80(s5)
    800021a6:	04fa3823          	sd	a5,80(s4)
    *(np->trapframe) = *(p->trapframe);
    800021aa:	060ab683          	ld	a3,96(s5)
    800021ae:	87b6                	mv	a5,a3
    800021b0:	060a3703          	ld	a4,96(s4)
    800021b4:	12068693          	addi	a3,a3,288
    800021b8:	0007b803          	ld	a6,0(a5)
    800021bc:	6788                	ld	a0,8(a5)
    800021be:	6b8c                	ld	a1,16(a5)
    800021c0:	6f90                	ld	a2,24(a5)
    800021c2:	01073023          	sd	a6,0(a4)
    800021c6:	e708                	sd	a0,8(a4)
    800021c8:	eb0c                	sd	a1,16(a4)
    800021ca:	ef10                	sd	a2,24(a4)
    800021cc:	02078793          	addi	a5,a5,32
    800021d0:	02070713          	addi	a4,a4,32
    800021d4:	fed792e3          	bne	a5,a3,800021b8 <fork+0x56>
    np->trapframe->a0 = 0;
    800021d8:	060a3783          	ld	a5,96(s4)
    800021dc:	0607b823          	sd	zero,112(a5)
    for (i = 0; i < NOFILE; i++)
    800021e0:	0d8a8493          	addi	s1,s5,216
    800021e4:	0d8a0913          	addi	s2,s4,216
    800021e8:	158a8993          	addi	s3,s5,344
    800021ec:	a00d                	j	8000220e <fork+0xac>
        freeproc(np);
    800021ee:	8552                	mv	a0,s4
    800021f0:	00000097          	auipc	ra,0x0
    800021f4:	c16080e7          	jalr	-1002(ra) # 80001e06 <freeproc>
        release(&np->lock);
    800021f8:	8552                	mv	a0,s4
    800021fa:	fffff097          	auipc	ra,0xfffff
    800021fe:	ad2080e7          	jalr	-1326(ra) # 80000ccc <release>
        return -1;
    80002202:	597d                	li	s2,-1
    80002204:	a059                	j	8000228a <fork+0x128>
    for (i = 0; i < NOFILE; i++)
    80002206:	04a1                	addi	s1,s1,8
    80002208:	0921                	addi	s2,s2,8
    8000220a:	01348b63          	beq	s1,s3,80002220 <fork+0xbe>
        if (p->ofile[i])
    8000220e:	6088                	ld	a0,0(s1)
    80002210:	d97d                	beqz	a0,80002206 <fork+0xa4>
            np->ofile[i] = filedup(p->ofile[i]);
    80002212:	00002097          	auipc	ra,0x2
    80002216:	7b2080e7          	jalr	1970(ra) # 800049c4 <filedup>
    8000221a:	00a93023          	sd	a0,0(s2)
    8000221e:	b7e5                	j	80002206 <fork+0xa4>
    np->cwd = idup(p->cwd);
    80002220:	158ab503          	ld	a0,344(s5)
    80002224:	00002097          	auipc	ra,0x2
    80002228:	94a080e7          	jalr	-1718(ra) # 80003b6e <idup>
    8000222c:	14aa3c23          	sd	a0,344(s4)
    safestrcpy(np->name, p->name, sizeof(p->name));
    80002230:	4641                	li	a2,16
    80002232:	160a8593          	addi	a1,s5,352
    80002236:	160a0513          	addi	a0,s4,352
    8000223a:	fffff097          	auipc	ra,0xfffff
    8000223e:	c22080e7          	jalr	-990(ra) # 80000e5c <safestrcpy>
    pid = np->pid;
    80002242:	030a2903          	lw	s2,48(s4)
    release(&np->lock);
    80002246:	8552                	mv	a0,s4
    80002248:	fffff097          	auipc	ra,0xfffff
    8000224c:	a84080e7          	jalr	-1404(ra) # 80000ccc <release>
    acquire(&wait_lock);
    80002250:	0000f497          	auipc	s1,0xf
    80002254:	e0848493          	addi	s1,s1,-504 # 80011058 <wait_lock>
    80002258:	8526                	mv	a0,s1
    8000225a:	fffff097          	auipc	ra,0xfffff
    8000225e:	9be080e7          	jalr	-1602(ra) # 80000c18 <acquire>
    np->parent = p;
    80002262:	055a3023          	sd	s5,64(s4)
    release(&wait_lock);
    80002266:	8526                	mv	a0,s1
    80002268:	fffff097          	auipc	ra,0xfffff
    8000226c:	a64080e7          	jalr	-1436(ra) # 80000ccc <release>
    acquire(&np->lock);
    80002270:	8552                	mv	a0,s4
    80002272:	fffff097          	auipc	ra,0xfffff
    80002276:	9a6080e7          	jalr	-1626(ra) # 80000c18 <acquire>
    np->state = RUNNABLE;
    8000227a:	478d                	li	a5,3
    8000227c:	00fa2c23          	sw	a5,24(s4)
    release(&np->lock);
    80002280:	8552                	mv	a0,s4
    80002282:	fffff097          	auipc	ra,0xfffff
    80002286:	a4a080e7          	jalr	-1462(ra) # 80000ccc <release>
}
    8000228a:	854a                	mv	a0,s2
    8000228c:	70e2                	ld	ra,56(sp)
    8000228e:	7442                	ld	s0,48(sp)
    80002290:	74a2                	ld	s1,40(sp)
    80002292:	7902                	ld	s2,32(sp)
    80002294:	69e2                	ld	s3,24(sp)
    80002296:	6a42                	ld	s4,16(sp)
    80002298:	6aa2                	ld	s5,8(sp)
    8000229a:	6121                	addi	sp,sp,64
    8000229c:	8082                	ret
        return -1;
    8000229e:	597d                	li	s2,-1
    800022a0:	b7ed                	j	8000228a <fork+0x128>

00000000800022a2 <scheduler>:
{
    800022a2:	1101                	addi	sp,sp,-32
    800022a4:	ec06                	sd	ra,24(sp)
    800022a6:	e822                	sd	s0,16(sp)
    800022a8:	e426                	sd	s1,8(sp)
    800022aa:	1000                	addi	s0,sp,32
        (*sched_pointer)();
    800022ac:	00006497          	auipc	s1,0x6
    800022b0:	65c48493          	addi	s1,s1,1628 # 80008908 <sched_pointer>
    800022b4:	609c                	ld	a5,0(s1)
    800022b6:	9782                	jalr	a5
    while (1)
    800022b8:	bff5                	j	800022b4 <scheduler+0x12>

00000000800022ba <sched>:
{
    800022ba:	7179                	addi	sp,sp,-48
    800022bc:	f406                	sd	ra,40(sp)
    800022be:	f022                	sd	s0,32(sp)
    800022c0:	ec26                	sd	s1,24(sp)
    800022c2:	e84a                	sd	s2,16(sp)
    800022c4:	e44e                	sd	s3,8(sp)
    800022c6:	1800                	addi	s0,sp,48
    for (p = proc; p < &proc[NPROC]; p++)
    800022c8:	0000f797          	auipc	a5,0xf
    800022cc:	da878793          	addi	a5,a5,-600 # 80011070 <proc>
    800022d0:	00015697          	auipc	a3,0x15
    800022d4:	9a068693          	addi	a3,a3,-1632 # 80016c70 <tickslock>
    800022d8:	a029                	j	800022e2 <sched+0x28>
    800022da:	17078793          	addi	a5,a5,368
    800022de:	00d78d63          	beq	a5,a3,800022f8 <sched+0x3e>
        if (p->priority > 0 && --p->promotion_timer == 0) // using short-ciruit evaluation
    800022e2:	5bd8                	lw	a4,52(a5)
    800022e4:	db7d                	beqz	a4,800022da <sched+0x20>
    800022e6:	5f98                	lw	a4,56(a5)
    800022e8:	377d                	addiw	a4,a4,-1
    800022ea:	0007061b          	sext.w	a2,a4
    800022ee:	df98                	sw	a4,56(a5)
    800022f0:	f66d                	bnez	a2,800022da <sched+0x20>
            p->priority = 0; // we only have two priorities in our scheduler
    800022f2:	0207aa23          	sw	zero,52(a5)
    800022f6:	b7d5                	j	800022da <sched+0x20>
    p = myproc();
    800022f8:	00000097          	auipc	ra,0x0
    800022fc:	95c080e7          	jalr	-1700(ra) # 80001c54 <myproc>
    80002300:	892a                	mv	s2,a0
    if (!holding(&p->lock))
    80002302:	fffff097          	auipc	ra,0xfffff
    80002306:	89c080e7          	jalr	-1892(ra) # 80000b9e <holding>
    8000230a:	c925                	beqz	a0,8000237a <sched+0xc0>
    8000230c:	8792                	mv	a5,tp
    if (mycpu()->noff != 1)
    8000230e:	2781                	sext.w	a5,a5
    80002310:	079e                	slli	a5,a5,0x7
    80002312:	0000f717          	auipc	a4,0xf
    80002316:	92e70713          	addi	a4,a4,-1746 # 80010c40 <cpus>
    8000231a:	97ba                	add	a5,a5,a4
    8000231c:	5fb8                	lw	a4,120(a5)
    8000231e:	4785                	li	a5,1
    80002320:	06f71563          	bne	a4,a5,8000238a <sched+0xd0>
    if (p->state == RUNNING)
    80002324:	01892703          	lw	a4,24(s2)
    80002328:	4791                	li	a5,4
    8000232a:	06f70863          	beq	a4,a5,8000239a <sched+0xe0>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000232e:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80002332:	8b89                	andi	a5,a5,2
    if (intr_get())
    80002334:	ebbd                	bnez	a5,800023aa <sched+0xf0>
  asm volatile("mv %0, tp" : "=r" (x) );
    80002336:	8792                	mv	a5,tp
    intena = mycpu()->intena;
    80002338:	0000f497          	auipc	s1,0xf
    8000233c:	90848493          	addi	s1,s1,-1784 # 80010c40 <cpus>
    80002340:	2781                	sext.w	a5,a5
    80002342:	079e                	slli	a5,a5,0x7
    80002344:	97a6                	add	a5,a5,s1
    80002346:	07c7a983          	lw	s3,124(a5)
    8000234a:	8592                	mv	a1,tp
    swtch(&p->context, &mycpu()->context);
    8000234c:	2581                	sext.w	a1,a1
    8000234e:	059e                	slli	a1,a1,0x7
    80002350:	05a1                	addi	a1,a1,8
    80002352:	95a6                	add	a1,a1,s1
    80002354:	06890513          	addi	a0,s2,104
    80002358:	00000097          	auipc	ra,0x0
    8000235c:	752080e7          	jalr	1874(ra) # 80002aaa <swtch>
    80002360:	8792                	mv	a5,tp
    mycpu()->intena = intena;
    80002362:	2781                	sext.w	a5,a5
    80002364:	079e                	slli	a5,a5,0x7
    80002366:	94be                	add	s1,s1,a5
    80002368:	0734ae23          	sw	s3,124(s1)
}
    8000236c:	70a2                	ld	ra,40(sp)
    8000236e:	7402                	ld	s0,32(sp)
    80002370:	64e2                	ld	s1,24(sp)
    80002372:	6942                	ld	s2,16(sp)
    80002374:	69a2                	ld	s3,8(sp)
    80002376:	6145                	addi	sp,sp,48
    80002378:	8082                	ret
        panic("sched p->lock");
    8000237a:	00006517          	auipc	a0,0x6
    8000237e:	e9e50513          	addi	a0,a0,-354 # 80008218 <digits+0x1d8>
    80002382:	ffffe097          	auipc	ra,0xffffe
    80002386:	200080e7          	jalr	512(ra) # 80000582 <panic>
        panic("sched locks");
    8000238a:	00006517          	auipc	a0,0x6
    8000238e:	e9e50513          	addi	a0,a0,-354 # 80008228 <digits+0x1e8>
    80002392:	ffffe097          	auipc	ra,0xffffe
    80002396:	1f0080e7          	jalr	496(ra) # 80000582 <panic>
        panic("sched running");
    8000239a:	00006517          	auipc	a0,0x6
    8000239e:	e9e50513          	addi	a0,a0,-354 # 80008238 <digits+0x1f8>
    800023a2:	ffffe097          	auipc	ra,0xffffe
    800023a6:	1e0080e7          	jalr	480(ra) # 80000582 <panic>
        panic("sched interruptible");
    800023aa:	00006517          	auipc	a0,0x6
    800023ae:	e9e50513          	addi	a0,a0,-354 # 80008248 <digits+0x208>
    800023b2:	ffffe097          	auipc	ra,0xffffe
    800023b6:	1d0080e7          	jalr	464(ra) # 80000582 <panic>

00000000800023ba <yield>:
{
    800023ba:	1101                	addi	sp,sp,-32
    800023bc:	ec06                	sd	ra,24(sp)
    800023be:	e822                	sd	s0,16(sp)
    800023c0:	e426                	sd	s1,8(sp)
    800023c2:	e04a                	sd	s2,0(sp)
    800023c4:	1000                	addi	s0,sp,32
    800023c6:	892a                	mv	s2,a0
    struct proc *p = myproc();
    800023c8:	00000097          	auipc	ra,0x0
    800023cc:	88c080e7          	jalr	-1908(ra) # 80001c54 <myproc>
    800023d0:	84aa                	mv	s1,a0
    acquire(&p->lock);
    800023d2:	fffff097          	auipc	ra,0xfffff
    800023d6:	846080e7          	jalr	-1978(ra) # 80000c18 <acquire>
    p->state = RUNNABLE;
    800023da:	478d                	li	a5,3
    800023dc:	cc9c                	sw	a5,24(s1)
    if (reason == YIELD_TIMER)
    800023de:	4785                	li	a5,1
    800023e0:	02f90163          	beq	s2,a5,80002402 <yield+0x48>
    sched();
    800023e4:	00000097          	auipc	ra,0x0
    800023e8:	ed6080e7          	jalr	-298(ra) # 800022ba <sched>
    release(&p->lock);
    800023ec:	8526                	mv	a0,s1
    800023ee:	fffff097          	auipc	ra,0xfffff
    800023f2:	8de080e7          	jalr	-1826(ra) # 80000ccc <release>
}
    800023f6:	60e2                	ld	ra,24(sp)
    800023f8:	6442                	ld	s0,16(sp)
    800023fa:	64a2                	ld	s1,8(sp)
    800023fc:	6902                	ld	s2,0(sp)
    800023fe:	6105                	addi	sp,sp,32
    80002400:	8082                	ret
        p->priority = (p->priority + 1 > MAX_PRIO ? p->priority : (p->priority + 1));
    80002402:	58d8                	lw	a4,52(s1)
    80002404:	0017079b          	addiw	a5,a4,1
    80002408:	4685                	li	a3,1
    8000240a:	00f6f363          	bgeu	a3,a5,80002410 <yield+0x56>
    8000240e:	87ba                	mv	a5,a4
    80002410:	d8dc                	sw	a5,52(s1)
        p->promotion_timer = PROM_TIME;
    80002412:	4795                	li	a5,5
    80002414:	dc9c                	sw	a5,56(s1)
    80002416:	b7f9                	j	800023e4 <yield+0x2a>

0000000080002418 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void sleep(void *chan, struct spinlock *lk)
{
    80002418:	7179                	addi	sp,sp,-48
    8000241a:	f406                	sd	ra,40(sp)
    8000241c:	f022                	sd	s0,32(sp)
    8000241e:	ec26                	sd	s1,24(sp)
    80002420:	e84a                	sd	s2,16(sp)
    80002422:	e44e                	sd	s3,8(sp)
    80002424:	1800                	addi	s0,sp,48
    80002426:	89aa                	mv	s3,a0
    80002428:	892e                	mv	s2,a1
    struct proc *p = myproc();
    8000242a:	00000097          	auipc	ra,0x0
    8000242e:	82a080e7          	jalr	-2006(ra) # 80001c54 <myproc>
    80002432:	84aa                	mv	s1,a0
    // Once we hold p->lock, we can be
    // guaranteed that we won't miss any wakeup
    // (wakeup locks p->lock),
    // so it's okay to release lk.

    acquire(&p->lock); // DOC: sleeplock1
    80002434:	ffffe097          	auipc	ra,0xffffe
    80002438:	7e4080e7          	jalr	2020(ra) # 80000c18 <acquire>
    release(lk);
    8000243c:	854a                	mv	a0,s2
    8000243e:	fffff097          	auipc	ra,0xfffff
    80002442:	88e080e7          	jalr	-1906(ra) # 80000ccc <release>

    // Go to sleep.
    p->chan = chan;
    80002446:	0334b023          	sd	s3,32(s1)
    p->state = SLEEPING;
    8000244a:	4789                	li	a5,2
    8000244c:	cc9c                	sw	a5,24(s1)

    sched();
    8000244e:	00000097          	auipc	ra,0x0
    80002452:	e6c080e7          	jalr	-404(ra) # 800022ba <sched>

    // Tidy up.
    p->chan = 0;
    80002456:	0204b023          	sd	zero,32(s1)

    // Reacquire original lock.
    release(&p->lock);
    8000245a:	8526                	mv	a0,s1
    8000245c:	fffff097          	auipc	ra,0xfffff
    80002460:	870080e7          	jalr	-1936(ra) # 80000ccc <release>
    acquire(lk);
    80002464:	854a                	mv	a0,s2
    80002466:	ffffe097          	auipc	ra,0xffffe
    8000246a:	7b2080e7          	jalr	1970(ra) # 80000c18 <acquire>
}
    8000246e:	70a2                	ld	ra,40(sp)
    80002470:	7402                	ld	s0,32(sp)
    80002472:	64e2                	ld	s1,24(sp)
    80002474:	6942                	ld	s2,16(sp)
    80002476:	69a2                	ld	s3,8(sp)
    80002478:	6145                	addi	sp,sp,48
    8000247a:	8082                	ret

000000008000247c <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void wakeup(void *chan)
{
    8000247c:	7139                	addi	sp,sp,-64
    8000247e:	fc06                	sd	ra,56(sp)
    80002480:	f822                	sd	s0,48(sp)
    80002482:	f426                	sd	s1,40(sp)
    80002484:	f04a                	sd	s2,32(sp)
    80002486:	ec4e                	sd	s3,24(sp)
    80002488:	e852                	sd	s4,16(sp)
    8000248a:	e456                	sd	s5,8(sp)
    8000248c:	0080                	addi	s0,sp,64
    8000248e:	8a2a                	mv	s4,a0
    struct proc *p;

    for (p = proc; p < &proc[NPROC]; p++)
    80002490:	0000f497          	auipc	s1,0xf
    80002494:	be048493          	addi	s1,s1,-1056 # 80011070 <proc>
    {
        if (p != myproc())
        {
            acquire(&p->lock);
            if (p->state == SLEEPING && p->chan == chan)
    80002498:	4989                	li	s3,2
            {
                p->state = RUNNABLE;
    8000249a:	4a8d                	li	s5,3
    for (p = proc; p < &proc[NPROC]; p++)
    8000249c:	00014917          	auipc	s2,0x14
    800024a0:	7d490913          	addi	s2,s2,2004 # 80016c70 <tickslock>
    800024a4:	a811                	j	800024b8 <wakeup+0x3c>
            }
            release(&p->lock);
    800024a6:	8526                	mv	a0,s1
    800024a8:	fffff097          	auipc	ra,0xfffff
    800024ac:	824080e7          	jalr	-2012(ra) # 80000ccc <release>
    for (p = proc; p < &proc[NPROC]; p++)
    800024b0:	17048493          	addi	s1,s1,368
    800024b4:	03248663          	beq	s1,s2,800024e0 <wakeup+0x64>
        if (p != myproc())
    800024b8:	fffff097          	auipc	ra,0xfffff
    800024bc:	79c080e7          	jalr	1948(ra) # 80001c54 <myproc>
    800024c0:	fea488e3          	beq	s1,a0,800024b0 <wakeup+0x34>
            acquire(&p->lock);
    800024c4:	8526                	mv	a0,s1
    800024c6:	ffffe097          	auipc	ra,0xffffe
    800024ca:	752080e7          	jalr	1874(ra) # 80000c18 <acquire>
            if (p->state == SLEEPING && p->chan == chan)
    800024ce:	4c9c                	lw	a5,24(s1)
    800024d0:	fd379be3          	bne	a5,s3,800024a6 <wakeup+0x2a>
    800024d4:	709c                	ld	a5,32(s1)
    800024d6:	fd4798e3          	bne	a5,s4,800024a6 <wakeup+0x2a>
                p->state = RUNNABLE;
    800024da:	0154ac23          	sw	s5,24(s1)
    800024de:	b7e1                	j	800024a6 <wakeup+0x2a>
        }
    }
}
    800024e0:	70e2                	ld	ra,56(sp)
    800024e2:	7442                	ld	s0,48(sp)
    800024e4:	74a2                	ld	s1,40(sp)
    800024e6:	7902                	ld	s2,32(sp)
    800024e8:	69e2                	ld	s3,24(sp)
    800024ea:	6a42                	ld	s4,16(sp)
    800024ec:	6aa2                	ld	s5,8(sp)
    800024ee:	6121                	addi	sp,sp,64
    800024f0:	8082                	ret

00000000800024f2 <reparent>:
{
    800024f2:	7179                	addi	sp,sp,-48
    800024f4:	f406                	sd	ra,40(sp)
    800024f6:	f022                	sd	s0,32(sp)
    800024f8:	ec26                	sd	s1,24(sp)
    800024fa:	e84a                	sd	s2,16(sp)
    800024fc:	e44e                	sd	s3,8(sp)
    800024fe:	e052                	sd	s4,0(sp)
    80002500:	1800                	addi	s0,sp,48
    80002502:	892a                	mv	s2,a0
    for (pp = proc; pp < &proc[NPROC]; pp++)
    80002504:	0000f497          	auipc	s1,0xf
    80002508:	b6c48493          	addi	s1,s1,-1172 # 80011070 <proc>
            pp->parent = initproc;
    8000250c:	00006a17          	auipc	s4,0x6
    80002510:	4bca0a13          	addi	s4,s4,1212 # 800089c8 <initproc>
    for (pp = proc; pp < &proc[NPROC]; pp++)
    80002514:	00014997          	auipc	s3,0x14
    80002518:	75c98993          	addi	s3,s3,1884 # 80016c70 <tickslock>
    8000251c:	a029                	j	80002526 <reparent+0x34>
    8000251e:	17048493          	addi	s1,s1,368
    80002522:	01348d63          	beq	s1,s3,8000253c <reparent+0x4a>
        if (pp->parent == p)
    80002526:	60bc                	ld	a5,64(s1)
    80002528:	ff279be3          	bne	a5,s2,8000251e <reparent+0x2c>
            pp->parent = initproc;
    8000252c:	000a3503          	ld	a0,0(s4)
    80002530:	e0a8                	sd	a0,64(s1)
            wakeup(initproc);
    80002532:	00000097          	auipc	ra,0x0
    80002536:	f4a080e7          	jalr	-182(ra) # 8000247c <wakeup>
    8000253a:	b7d5                	j	8000251e <reparent+0x2c>
}
    8000253c:	70a2                	ld	ra,40(sp)
    8000253e:	7402                	ld	s0,32(sp)
    80002540:	64e2                	ld	s1,24(sp)
    80002542:	6942                	ld	s2,16(sp)
    80002544:	69a2                	ld	s3,8(sp)
    80002546:	6a02                	ld	s4,0(sp)
    80002548:	6145                	addi	sp,sp,48
    8000254a:	8082                	ret

000000008000254c <exit>:
{
    8000254c:	7179                	addi	sp,sp,-48
    8000254e:	f406                	sd	ra,40(sp)
    80002550:	f022                	sd	s0,32(sp)
    80002552:	ec26                	sd	s1,24(sp)
    80002554:	e84a                	sd	s2,16(sp)
    80002556:	e44e                	sd	s3,8(sp)
    80002558:	e052                	sd	s4,0(sp)
    8000255a:	1800                	addi	s0,sp,48
    8000255c:	8a2a                	mv	s4,a0
    struct proc *p = myproc();
    8000255e:	fffff097          	auipc	ra,0xfffff
    80002562:	6f6080e7          	jalr	1782(ra) # 80001c54 <myproc>
    80002566:	89aa                	mv	s3,a0
    if (p == initproc)
    80002568:	00006797          	auipc	a5,0x6
    8000256c:	4607b783          	ld	a5,1120(a5) # 800089c8 <initproc>
    80002570:	0d850493          	addi	s1,a0,216
    80002574:	15850913          	addi	s2,a0,344
    80002578:	02a79363          	bne	a5,a0,8000259e <exit+0x52>
        panic("init exiting");
    8000257c:	00006517          	auipc	a0,0x6
    80002580:	ce450513          	addi	a0,a0,-796 # 80008260 <digits+0x220>
    80002584:	ffffe097          	auipc	ra,0xffffe
    80002588:	ffe080e7          	jalr	-2(ra) # 80000582 <panic>
            fileclose(f);
    8000258c:	00002097          	auipc	ra,0x2
    80002590:	48a080e7          	jalr	1162(ra) # 80004a16 <fileclose>
            p->ofile[fd] = 0;
    80002594:	0004b023          	sd	zero,0(s1)
    for (int fd = 0; fd < NOFILE; fd++)
    80002598:	04a1                	addi	s1,s1,8
    8000259a:	01248563          	beq	s1,s2,800025a4 <exit+0x58>
        if (p->ofile[fd])
    8000259e:	6088                	ld	a0,0(s1)
    800025a0:	f575                	bnez	a0,8000258c <exit+0x40>
    800025a2:	bfdd                	j	80002598 <exit+0x4c>
    begin_op();
    800025a4:	00002097          	auipc	ra,0x2
    800025a8:	fae080e7          	jalr	-82(ra) # 80004552 <begin_op>
    iput(p->cwd);
    800025ac:	1589b503          	ld	a0,344(s3)
    800025b0:	00001097          	auipc	ra,0x1
    800025b4:	7b6080e7          	jalr	1974(ra) # 80003d66 <iput>
    end_op();
    800025b8:	00002097          	auipc	ra,0x2
    800025bc:	014080e7          	jalr	20(ra) # 800045cc <end_op>
    p->cwd = 0;
    800025c0:	1409bc23          	sd	zero,344(s3)
    acquire(&wait_lock);
    800025c4:	0000f497          	auipc	s1,0xf
    800025c8:	a9448493          	addi	s1,s1,-1388 # 80011058 <wait_lock>
    800025cc:	8526                	mv	a0,s1
    800025ce:	ffffe097          	auipc	ra,0xffffe
    800025d2:	64a080e7          	jalr	1610(ra) # 80000c18 <acquire>
    reparent(p);
    800025d6:	854e                	mv	a0,s3
    800025d8:	00000097          	auipc	ra,0x0
    800025dc:	f1a080e7          	jalr	-230(ra) # 800024f2 <reparent>
    wakeup(p->parent);
    800025e0:	0409b503          	ld	a0,64(s3)
    800025e4:	00000097          	auipc	ra,0x0
    800025e8:	e98080e7          	jalr	-360(ra) # 8000247c <wakeup>
    acquire(&p->lock);
    800025ec:	854e                	mv	a0,s3
    800025ee:	ffffe097          	auipc	ra,0xffffe
    800025f2:	62a080e7          	jalr	1578(ra) # 80000c18 <acquire>
    p->xstate = status;
    800025f6:	0349a623          	sw	s4,44(s3)
    p->state = ZOMBIE;
    800025fa:	4795                	li	a5,5
    800025fc:	00f9ac23          	sw	a5,24(s3)
    release(&wait_lock);
    80002600:	8526                	mv	a0,s1
    80002602:	ffffe097          	auipc	ra,0xffffe
    80002606:	6ca080e7          	jalr	1738(ra) # 80000ccc <release>
    sched();
    8000260a:	00000097          	auipc	ra,0x0
    8000260e:	cb0080e7          	jalr	-848(ra) # 800022ba <sched>
    panic("zombie exit");
    80002612:	00006517          	auipc	a0,0x6
    80002616:	c5e50513          	addi	a0,a0,-930 # 80008270 <digits+0x230>
    8000261a:	ffffe097          	auipc	ra,0xffffe
    8000261e:	f68080e7          	jalr	-152(ra) # 80000582 <panic>

0000000080002622 <kill>:

// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int kill(int pid)
{
    80002622:	7179                	addi	sp,sp,-48
    80002624:	f406                	sd	ra,40(sp)
    80002626:	f022                	sd	s0,32(sp)
    80002628:	ec26                	sd	s1,24(sp)
    8000262a:	e84a                	sd	s2,16(sp)
    8000262c:	e44e                	sd	s3,8(sp)
    8000262e:	1800                	addi	s0,sp,48
    80002630:	892a                	mv	s2,a0
    struct proc *p;

    for (p = proc; p < &proc[NPROC]; p++)
    80002632:	0000f497          	auipc	s1,0xf
    80002636:	a3e48493          	addi	s1,s1,-1474 # 80011070 <proc>
    8000263a:	00014997          	auipc	s3,0x14
    8000263e:	63698993          	addi	s3,s3,1590 # 80016c70 <tickslock>
    {
        acquire(&p->lock);
    80002642:	8526                	mv	a0,s1
    80002644:	ffffe097          	auipc	ra,0xffffe
    80002648:	5d4080e7          	jalr	1492(ra) # 80000c18 <acquire>
        if (p->pid == pid)
    8000264c:	589c                	lw	a5,48(s1)
    8000264e:	01278d63          	beq	a5,s2,80002668 <kill+0x46>
                p->state = RUNNABLE;
            }
            release(&p->lock);
            return 0;
        }
        release(&p->lock);
    80002652:	8526                	mv	a0,s1
    80002654:	ffffe097          	auipc	ra,0xffffe
    80002658:	678080e7          	jalr	1656(ra) # 80000ccc <release>
    for (p = proc; p < &proc[NPROC]; p++)
    8000265c:	17048493          	addi	s1,s1,368
    80002660:	ff3491e3          	bne	s1,s3,80002642 <kill+0x20>
    }
    return -1;
    80002664:	557d                	li	a0,-1
    80002666:	a829                	j	80002680 <kill+0x5e>
            p->killed = 1;
    80002668:	4785                	li	a5,1
    8000266a:	d49c                	sw	a5,40(s1)
            if (p->state == SLEEPING)
    8000266c:	4c98                	lw	a4,24(s1)
    8000266e:	4789                	li	a5,2
    80002670:	00f70f63          	beq	a4,a5,8000268e <kill+0x6c>
            release(&p->lock);
    80002674:	8526                	mv	a0,s1
    80002676:	ffffe097          	auipc	ra,0xffffe
    8000267a:	656080e7          	jalr	1622(ra) # 80000ccc <release>
            return 0;
    8000267e:	4501                	li	a0,0
}
    80002680:	70a2                	ld	ra,40(sp)
    80002682:	7402                	ld	s0,32(sp)
    80002684:	64e2                	ld	s1,24(sp)
    80002686:	6942                	ld	s2,16(sp)
    80002688:	69a2                	ld	s3,8(sp)
    8000268a:	6145                	addi	sp,sp,48
    8000268c:	8082                	ret
                p->state = RUNNABLE;
    8000268e:	478d                	li	a5,3
    80002690:	cc9c                	sw	a5,24(s1)
    80002692:	b7cd                	j	80002674 <kill+0x52>

0000000080002694 <setkilled>:

void setkilled(struct proc *p)
{
    80002694:	1101                	addi	sp,sp,-32
    80002696:	ec06                	sd	ra,24(sp)
    80002698:	e822                	sd	s0,16(sp)
    8000269a:	e426                	sd	s1,8(sp)
    8000269c:	1000                	addi	s0,sp,32
    8000269e:	84aa                	mv	s1,a0
    acquire(&p->lock);
    800026a0:	ffffe097          	auipc	ra,0xffffe
    800026a4:	578080e7          	jalr	1400(ra) # 80000c18 <acquire>
    p->killed = 1;
    800026a8:	4785                	li	a5,1
    800026aa:	d49c                	sw	a5,40(s1)
    release(&p->lock);
    800026ac:	8526                	mv	a0,s1
    800026ae:	ffffe097          	auipc	ra,0xffffe
    800026b2:	61e080e7          	jalr	1566(ra) # 80000ccc <release>
}
    800026b6:	60e2                	ld	ra,24(sp)
    800026b8:	6442                	ld	s0,16(sp)
    800026ba:	64a2                	ld	s1,8(sp)
    800026bc:	6105                	addi	sp,sp,32
    800026be:	8082                	ret

00000000800026c0 <killed>:

int killed(struct proc *p)
{
    800026c0:	1101                	addi	sp,sp,-32
    800026c2:	ec06                	sd	ra,24(sp)
    800026c4:	e822                	sd	s0,16(sp)
    800026c6:	e426                	sd	s1,8(sp)
    800026c8:	e04a                	sd	s2,0(sp)
    800026ca:	1000                	addi	s0,sp,32
    800026cc:	84aa                	mv	s1,a0
    int k;

    acquire(&p->lock);
    800026ce:	ffffe097          	auipc	ra,0xffffe
    800026d2:	54a080e7          	jalr	1354(ra) # 80000c18 <acquire>
    k = p->killed;
    800026d6:	0284a903          	lw	s2,40(s1)
    release(&p->lock);
    800026da:	8526                	mv	a0,s1
    800026dc:	ffffe097          	auipc	ra,0xffffe
    800026e0:	5f0080e7          	jalr	1520(ra) # 80000ccc <release>
    return k;
}
    800026e4:	854a                	mv	a0,s2
    800026e6:	60e2                	ld	ra,24(sp)
    800026e8:	6442                	ld	s0,16(sp)
    800026ea:	64a2                	ld	s1,8(sp)
    800026ec:	6902                	ld	s2,0(sp)
    800026ee:	6105                	addi	sp,sp,32
    800026f0:	8082                	ret

00000000800026f2 <wait>:
{
    800026f2:	715d                	addi	sp,sp,-80
    800026f4:	e486                	sd	ra,72(sp)
    800026f6:	e0a2                	sd	s0,64(sp)
    800026f8:	fc26                	sd	s1,56(sp)
    800026fa:	f84a                	sd	s2,48(sp)
    800026fc:	f44e                	sd	s3,40(sp)
    800026fe:	f052                	sd	s4,32(sp)
    80002700:	ec56                	sd	s5,24(sp)
    80002702:	e85a                	sd	s6,16(sp)
    80002704:	e45e                	sd	s7,8(sp)
    80002706:	e062                	sd	s8,0(sp)
    80002708:	0880                	addi	s0,sp,80
    8000270a:	8b2a                	mv	s6,a0
    struct proc *p = myproc();
    8000270c:	fffff097          	auipc	ra,0xfffff
    80002710:	548080e7          	jalr	1352(ra) # 80001c54 <myproc>
    80002714:	892a                	mv	s2,a0
    acquire(&wait_lock);
    80002716:	0000f517          	auipc	a0,0xf
    8000271a:	94250513          	addi	a0,a0,-1726 # 80011058 <wait_lock>
    8000271e:	ffffe097          	auipc	ra,0xffffe
    80002722:	4fa080e7          	jalr	1274(ra) # 80000c18 <acquire>
        havekids = 0;
    80002726:	4b81                	li	s7,0
                if (pp->state == ZOMBIE)
    80002728:	4a15                	li	s4,5
                havekids = 1;
    8000272a:	4a85                	li	s5,1
        for (pp = proc; pp < &proc[NPROC]; pp++)
    8000272c:	00014997          	auipc	s3,0x14
    80002730:	54498993          	addi	s3,s3,1348 # 80016c70 <tickslock>
        sleep(p, &wait_lock); // DOC: wait-sleep
    80002734:	0000fc17          	auipc	s8,0xf
    80002738:	924c0c13          	addi	s8,s8,-1756 # 80011058 <wait_lock>
    8000273c:	a0d1                	j	80002800 <wait+0x10e>
                    pid = pp->pid;
    8000273e:	0304a983          	lw	s3,48(s1)
                    if (addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    80002742:	000b0e63          	beqz	s6,8000275e <wait+0x6c>
    80002746:	4691                	li	a3,4
    80002748:	02c48613          	addi	a2,s1,44
    8000274c:	85da                	mv	a1,s6
    8000274e:	05893503          	ld	a0,88(s2)
    80002752:	fffff097          	auipc	ra,0xfffff
    80002756:	f5a080e7          	jalr	-166(ra) # 800016ac <copyout>
    8000275a:	04054163          	bltz	a0,8000279c <wait+0xaa>
                    freeproc(pp);
    8000275e:	8526                	mv	a0,s1
    80002760:	fffff097          	auipc	ra,0xfffff
    80002764:	6a6080e7          	jalr	1702(ra) # 80001e06 <freeproc>
                    release(&pp->lock);
    80002768:	8526                	mv	a0,s1
    8000276a:	ffffe097          	auipc	ra,0xffffe
    8000276e:	562080e7          	jalr	1378(ra) # 80000ccc <release>
                    release(&wait_lock);
    80002772:	0000f517          	auipc	a0,0xf
    80002776:	8e650513          	addi	a0,a0,-1818 # 80011058 <wait_lock>
    8000277a:	ffffe097          	auipc	ra,0xffffe
    8000277e:	552080e7          	jalr	1362(ra) # 80000ccc <release>
}
    80002782:	854e                	mv	a0,s3
    80002784:	60a6                	ld	ra,72(sp)
    80002786:	6406                	ld	s0,64(sp)
    80002788:	74e2                	ld	s1,56(sp)
    8000278a:	7942                	ld	s2,48(sp)
    8000278c:	79a2                	ld	s3,40(sp)
    8000278e:	7a02                	ld	s4,32(sp)
    80002790:	6ae2                	ld	s5,24(sp)
    80002792:	6b42                	ld	s6,16(sp)
    80002794:	6ba2                	ld	s7,8(sp)
    80002796:	6c02                	ld	s8,0(sp)
    80002798:	6161                	addi	sp,sp,80
    8000279a:	8082                	ret
                        release(&pp->lock);
    8000279c:	8526                	mv	a0,s1
    8000279e:	ffffe097          	auipc	ra,0xffffe
    800027a2:	52e080e7          	jalr	1326(ra) # 80000ccc <release>
                        release(&wait_lock);
    800027a6:	0000f517          	auipc	a0,0xf
    800027aa:	8b250513          	addi	a0,a0,-1870 # 80011058 <wait_lock>
    800027ae:	ffffe097          	auipc	ra,0xffffe
    800027b2:	51e080e7          	jalr	1310(ra) # 80000ccc <release>
                        return -1;
    800027b6:	59fd                	li	s3,-1
    800027b8:	b7e9                	j	80002782 <wait+0x90>
        for (pp = proc; pp < &proc[NPROC]; pp++)
    800027ba:	17048493          	addi	s1,s1,368
    800027be:	03348463          	beq	s1,s3,800027e6 <wait+0xf4>
            if (pp->parent == p)
    800027c2:	60bc                	ld	a5,64(s1)
    800027c4:	ff279be3          	bne	a5,s2,800027ba <wait+0xc8>
                acquire(&pp->lock);
    800027c8:	8526                	mv	a0,s1
    800027ca:	ffffe097          	auipc	ra,0xffffe
    800027ce:	44e080e7          	jalr	1102(ra) # 80000c18 <acquire>
                if (pp->state == ZOMBIE)
    800027d2:	4c9c                	lw	a5,24(s1)
    800027d4:	f74785e3          	beq	a5,s4,8000273e <wait+0x4c>
                release(&pp->lock);
    800027d8:	8526                	mv	a0,s1
    800027da:	ffffe097          	auipc	ra,0xffffe
    800027de:	4f2080e7          	jalr	1266(ra) # 80000ccc <release>
                havekids = 1;
    800027e2:	8756                	mv	a4,s5
    800027e4:	bfd9                	j	800027ba <wait+0xc8>
        if (!havekids || killed(p))
    800027e6:	c31d                	beqz	a4,8000280c <wait+0x11a>
    800027e8:	854a                	mv	a0,s2
    800027ea:	00000097          	auipc	ra,0x0
    800027ee:	ed6080e7          	jalr	-298(ra) # 800026c0 <killed>
    800027f2:	ed09                	bnez	a0,8000280c <wait+0x11a>
        sleep(p, &wait_lock); // DOC: wait-sleep
    800027f4:	85e2                	mv	a1,s8
    800027f6:	854a                	mv	a0,s2
    800027f8:	00000097          	auipc	ra,0x0
    800027fc:	c20080e7          	jalr	-992(ra) # 80002418 <sleep>
        havekids = 0;
    80002800:	875e                	mv	a4,s7
        for (pp = proc; pp < &proc[NPROC]; pp++)
    80002802:	0000f497          	auipc	s1,0xf
    80002806:	86e48493          	addi	s1,s1,-1938 # 80011070 <proc>
    8000280a:	bf65                	j	800027c2 <wait+0xd0>
            release(&wait_lock);
    8000280c:	0000f517          	auipc	a0,0xf
    80002810:	84c50513          	addi	a0,a0,-1972 # 80011058 <wait_lock>
    80002814:	ffffe097          	auipc	ra,0xffffe
    80002818:	4b8080e7          	jalr	1208(ra) # 80000ccc <release>
            return -1;
    8000281c:	59fd                	li	s3,-1
    8000281e:	b795                	j	80002782 <wait+0x90>

0000000080002820 <either_copyout>:

// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80002820:	7179                	addi	sp,sp,-48
    80002822:	f406                	sd	ra,40(sp)
    80002824:	f022                	sd	s0,32(sp)
    80002826:	ec26                	sd	s1,24(sp)
    80002828:	e84a                	sd	s2,16(sp)
    8000282a:	e44e                	sd	s3,8(sp)
    8000282c:	e052                	sd	s4,0(sp)
    8000282e:	1800                	addi	s0,sp,48
    80002830:	84aa                	mv	s1,a0
    80002832:	892e                	mv	s2,a1
    80002834:	89b2                	mv	s3,a2
    80002836:	8a36                	mv	s4,a3
    struct proc *p = myproc();
    80002838:	fffff097          	auipc	ra,0xfffff
    8000283c:	41c080e7          	jalr	1052(ra) # 80001c54 <myproc>
    if (user_dst)
    80002840:	c08d                	beqz	s1,80002862 <either_copyout+0x42>
    {
        return copyout(p->pagetable, dst, src, len);
    80002842:	86d2                	mv	a3,s4
    80002844:	864e                	mv	a2,s3
    80002846:	85ca                	mv	a1,s2
    80002848:	6d28                	ld	a0,88(a0)
    8000284a:	fffff097          	auipc	ra,0xfffff
    8000284e:	e62080e7          	jalr	-414(ra) # 800016ac <copyout>
    else
    {
        memmove((char *)dst, src, len);
        return 0;
    }
}
    80002852:	70a2                	ld	ra,40(sp)
    80002854:	7402                	ld	s0,32(sp)
    80002856:	64e2                	ld	s1,24(sp)
    80002858:	6942                	ld	s2,16(sp)
    8000285a:	69a2                	ld	s3,8(sp)
    8000285c:	6a02                	ld	s4,0(sp)
    8000285e:	6145                	addi	sp,sp,48
    80002860:	8082                	ret
        memmove((char *)dst, src, len);
    80002862:	000a061b          	sext.w	a2,s4
    80002866:	85ce                	mv	a1,s3
    80002868:	854a                	mv	a0,s2
    8000286a:	ffffe097          	auipc	ra,0xffffe
    8000286e:	506080e7          	jalr	1286(ra) # 80000d70 <memmove>
        return 0;
    80002872:	8526                	mv	a0,s1
    80002874:	bff9                	j	80002852 <either_copyout+0x32>

0000000080002876 <either_copyin>:

// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80002876:	7179                	addi	sp,sp,-48
    80002878:	f406                	sd	ra,40(sp)
    8000287a:	f022                	sd	s0,32(sp)
    8000287c:	ec26                	sd	s1,24(sp)
    8000287e:	e84a                	sd	s2,16(sp)
    80002880:	e44e                	sd	s3,8(sp)
    80002882:	e052                	sd	s4,0(sp)
    80002884:	1800                	addi	s0,sp,48
    80002886:	892a                	mv	s2,a0
    80002888:	84ae                	mv	s1,a1
    8000288a:	89b2                	mv	s3,a2
    8000288c:	8a36                	mv	s4,a3
    struct proc *p = myproc();
    8000288e:	fffff097          	auipc	ra,0xfffff
    80002892:	3c6080e7          	jalr	966(ra) # 80001c54 <myproc>
    if (user_src)
    80002896:	c08d                	beqz	s1,800028b8 <either_copyin+0x42>
    {
        return copyin(p->pagetable, dst, src, len);
    80002898:	86d2                	mv	a3,s4
    8000289a:	864e                	mv	a2,s3
    8000289c:	85ca                	mv	a1,s2
    8000289e:	6d28                	ld	a0,88(a0)
    800028a0:	fffff097          	auipc	ra,0xfffff
    800028a4:	e98080e7          	jalr	-360(ra) # 80001738 <copyin>
    else
    {
        memmove(dst, (char *)src, len);
        return 0;
    }
}
    800028a8:	70a2                	ld	ra,40(sp)
    800028aa:	7402                	ld	s0,32(sp)
    800028ac:	64e2                	ld	s1,24(sp)
    800028ae:	6942                	ld	s2,16(sp)
    800028b0:	69a2                	ld	s3,8(sp)
    800028b2:	6a02                	ld	s4,0(sp)
    800028b4:	6145                	addi	sp,sp,48
    800028b6:	8082                	ret
        memmove(dst, (char *)src, len);
    800028b8:	000a061b          	sext.w	a2,s4
    800028bc:	85ce                	mv	a1,s3
    800028be:	854a                	mv	a0,s2
    800028c0:	ffffe097          	auipc	ra,0xffffe
    800028c4:	4b0080e7          	jalr	1200(ra) # 80000d70 <memmove>
        return 0;
    800028c8:	8526                	mv	a0,s1
    800028ca:	bff9                	j	800028a8 <either_copyin+0x32>

00000000800028cc <procdump>:

// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void procdump(void)
{
    800028cc:	715d                	addi	sp,sp,-80
    800028ce:	e486                	sd	ra,72(sp)
    800028d0:	e0a2                	sd	s0,64(sp)
    800028d2:	fc26                	sd	s1,56(sp)
    800028d4:	f84a                	sd	s2,48(sp)
    800028d6:	f44e                	sd	s3,40(sp)
    800028d8:	f052                	sd	s4,32(sp)
    800028da:	ec56                	sd	s5,24(sp)
    800028dc:	e85a                	sd	s6,16(sp)
    800028de:	e45e                	sd	s7,8(sp)
    800028e0:	0880                	addi	s0,sp,80
        [RUNNING] "run   ",
        [ZOMBIE] "zombie"};
    struct proc *p;
    char *state;

    printf("\n");
    800028e2:	00005517          	auipc	a0,0x5
    800028e6:	7e650513          	addi	a0,a0,2022 # 800080c8 <digits+0x88>
    800028ea:	ffffe097          	auipc	ra,0xffffe
    800028ee:	ce2080e7          	jalr	-798(ra) # 800005cc <printf>
    for (p = proc; p < &proc[NPROC]; p++)
    800028f2:	0000f497          	auipc	s1,0xf
    800028f6:	8de48493          	addi	s1,s1,-1826 # 800111d0 <proc+0x160>
    800028fa:	00014917          	auipc	s2,0x14
    800028fe:	4d690913          	addi	s2,s2,1238 # 80016dd0 <bcache+0x148>
    {
        if (p->state == UNUSED)
            continue;
        if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002902:	4b15                	li	s6,5
            state = states[p->state];
        else
            state = "???";
    80002904:	00006997          	auipc	s3,0x6
    80002908:	97c98993          	addi	s3,s3,-1668 # 80008280 <digits+0x240>
        printf("%d <%s %s", p->pid, state, p->name);
    8000290c:	00006a97          	auipc	s5,0x6
    80002910:	97ca8a93          	addi	s5,s5,-1668 # 80008288 <digits+0x248>
        printf("\n");
    80002914:	00005a17          	auipc	s4,0x5
    80002918:	7b4a0a13          	addi	s4,s4,1972 # 800080c8 <digits+0x88>
        if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000291c:	00006b97          	auipc	s7,0x6
    80002920:	a54b8b93          	addi	s7,s7,-1452 # 80008370 <states.0>
    80002924:	a00d                	j	80002946 <procdump+0x7a>
        printf("%d <%s %s", p->pid, state, p->name);
    80002926:	ed06a583          	lw	a1,-304(a3)
    8000292a:	8556                	mv	a0,s5
    8000292c:	ffffe097          	auipc	ra,0xffffe
    80002930:	ca0080e7          	jalr	-864(ra) # 800005cc <printf>
        printf("\n");
    80002934:	8552                	mv	a0,s4
    80002936:	ffffe097          	auipc	ra,0xffffe
    8000293a:	c96080e7          	jalr	-874(ra) # 800005cc <printf>
    for (p = proc; p < &proc[NPROC]; p++)
    8000293e:	17048493          	addi	s1,s1,368
    80002942:	03248263          	beq	s1,s2,80002966 <procdump+0x9a>
        if (p->state == UNUSED)
    80002946:	86a6                	mv	a3,s1
    80002948:	eb84a783          	lw	a5,-328(s1)
    8000294c:	dbed                	beqz	a5,8000293e <procdump+0x72>
            state = "???";
    8000294e:	864e                	mv	a2,s3
        if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002950:	fcfb6be3          	bltu	s6,a5,80002926 <procdump+0x5a>
    80002954:	02079713          	slli	a4,a5,0x20
    80002958:	01d75793          	srli	a5,a4,0x1d
    8000295c:	97de                	add	a5,a5,s7
    8000295e:	6390                	ld	a2,0(a5)
    80002960:	f279                	bnez	a2,80002926 <procdump+0x5a>
            state = "???";
    80002962:	864e                	mv	a2,s3
    80002964:	b7c9                	j	80002926 <procdump+0x5a>
    }
}
    80002966:	60a6                	ld	ra,72(sp)
    80002968:	6406                	ld	s0,64(sp)
    8000296a:	74e2                	ld	s1,56(sp)
    8000296c:	7942                	ld	s2,48(sp)
    8000296e:	79a2                	ld	s3,40(sp)
    80002970:	7a02                	ld	s4,32(sp)
    80002972:	6ae2                	ld	s5,24(sp)
    80002974:	6b42                	ld	s6,16(sp)
    80002976:	6ba2                	ld	s7,8(sp)
    80002978:	6161                	addi	sp,sp,80
    8000297a:	8082                	ret

000000008000297c <schedls>:

void schedls()
{
    8000297c:	1101                	addi	sp,sp,-32
    8000297e:	ec06                	sd	ra,24(sp)
    80002980:	e822                	sd	s0,16(sp)
    80002982:	e426                	sd	s1,8(sp)
    80002984:	1000                	addi	s0,sp,32
    printf("[ ]\tScheduler Name\tScheduler ID\n");
    80002986:	00006517          	auipc	a0,0x6
    8000298a:	91250513          	addi	a0,a0,-1774 # 80008298 <digits+0x258>
    8000298e:	ffffe097          	auipc	ra,0xffffe
    80002992:	c3e080e7          	jalr	-962(ra) # 800005cc <printf>
    printf("====================================\n");
    80002996:	00006517          	auipc	a0,0x6
    8000299a:	92a50513          	addi	a0,a0,-1750 # 800082c0 <digits+0x280>
    8000299e:	ffffe097          	auipc	ra,0xffffe
    800029a2:	c2e080e7          	jalr	-978(ra) # 800005cc <printf>
    for (int i = 0; i < SCHEDC; i++)
    {
        if (available_schedulers[i].impl == sched_pointer)
    800029a6:	00006717          	auipc	a4,0x6
    800029aa:	fc273703          	ld	a4,-62(a4) # 80008968 <available_schedulers+0x10>
    800029ae:	00006797          	auipc	a5,0x6
    800029b2:	f5a7b783          	ld	a5,-166(a5) # 80008908 <sched_pointer>
    800029b6:	08f70763          	beq	a4,a5,80002a44 <schedls+0xc8>
        {
            printf("[*]\t");
        }
        else
        {
            printf("   \t");
    800029ba:	00006517          	auipc	a0,0x6
    800029be:	92e50513          	addi	a0,a0,-1746 # 800082e8 <digits+0x2a8>
    800029c2:	ffffe097          	auipc	ra,0xffffe
    800029c6:	c0a080e7          	jalr	-1014(ra) # 800005cc <printf>
        }
        printf("%s\t%d\n", available_schedulers[i].name, available_schedulers[i].id);
    800029ca:	00006497          	auipc	s1,0x6
    800029ce:	f5648493          	addi	s1,s1,-170 # 80008920 <initcode>
    800029d2:	48b0                	lw	a2,80(s1)
    800029d4:	00006597          	auipc	a1,0x6
    800029d8:	f8458593          	addi	a1,a1,-124 # 80008958 <available_schedulers>
    800029dc:	00006517          	auipc	a0,0x6
    800029e0:	91c50513          	addi	a0,a0,-1764 # 800082f8 <digits+0x2b8>
    800029e4:	ffffe097          	auipc	ra,0xffffe
    800029e8:	be8080e7          	jalr	-1048(ra) # 800005cc <printf>
        if (available_schedulers[i].impl == sched_pointer)
    800029ec:	74b8                	ld	a4,104(s1)
    800029ee:	00006797          	auipc	a5,0x6
    800029f2:	f1a7b783          	ld	a5,-230(a5) # 80008908 <sched_pointer>
    800029f6:	06f70063          	beq	a4,a5,80002a56 <schedls+0xda>
            printf("   \t");
    800029fa:	00006517          	auipc	a0,0x6
    800029fe:	8ee50513          	addi	a0,a0,-1810 # 800082e8 <digits+0x2a8>
    80002a02:	ffffe097          	auipc	ra,0xffffe
    80002a06:	bca080e7          	jalr	-1078(ra) # 800005cc <printf>
        printf("%s\t%d\n", available_schedulers[i].name, available_schedulers[i].id);
    80002a0a:	00006617          	auipc	a2,0x6
    80002a0e:	f8662603          	lw	a2,-122(a2) # 80008990 <available_schedulers+0x38>
    80002a12:	00006597          	auipc	a1,0x6
    80002a16:	f6658593          	addi	a1,a1,-154 # 80008978 <available_schedulers+0x20>
    80002a1a:	00006517          	auipc	a0,0x6
    80002a1e:	8de50513          	addi	a0,a0,-1826 # 800082f8 <digits+0x2b8>
    80002a22:	ffffe097          	auipc	ra,0xffffe
    80002a26:	baa080e7          	jalr	-1110(ra) # 800005cc <printf>
    }
    printf("\n*: current scheduler\n\n");
    80002a2a:	00006517          	auipc	a0,0x6
    80002a2e:	8d650513          	addi	a0,a0,-1834 # 80008300 <digits+0x2c0>
    80002a32:	ffffe097          	auipc	ra,0xffffe
    80002a36:	b9a080e7          	jalr	-1126(ra) # 800005cc <printf>
}
    80002a3a:	60e2                	ld	ra,24(sp)
    80002a3c:	6442                	ld	s0,16(sp)
    80002a3e:	64a2                	ld	s1,8(sp)
    80002a40:	6105                	addi	sp,sp,32
    80002a42:	8082                	ret
            printf("[*]\t");
    80002a44:	00006517          	auipc	a0,0x6
    80002a48:	8ac50513          	addi	a0,a0,-1876 # 800082f0 <digits+0x2b0>
    80002a4c:	ffffe097          	auipc	ra,0xffffe
    80002a50:	b80080e7          	jalr	-1152(ra) # 800005cc <printf>
    80002a54:	bf9d                	j	800029ca <schedls+0x4e>
    80002a56:	00006517          	auipc	a0,0x6
    80002a5a:	89a50513          	addi	a0,a0,-1894 # 800082f0 <digits+0x2b0>
    80002a5e:	ffffe097          	auipc	ra,0xffffe
    80002a62:	b6e080e7          	jalr	-1170(ra) # 800005cc <printf>
    80002a66:	b755                	j	80002a0a <schedls+0x8e>

0000000080002a68 <schedset>:

void schedset(int id)
{
    80002a68:	1141                	addi	sp,sp,-16
    80002a6a:	e406                	sd	ra,8(sp)
    80002a6c:	e022                	sd	s0,0(sp)
    80002a6e:	0800                	addi	s0,sp,16
    sched_pointer = available_schedulers[id - 1].impl;
    80002a70:	357d                	addiw	a0,a0,-1
    80002a72:	0516                	slli	a0,a0,0x5
    80002a74:	00006797          	auipc	a5,0x6
    80002a78:	eac78793          	addi	a5,a5,-340 # 80008920 <initcode>
    80002a7c:	97aa                	add	a5,a5,a0
    80002a7e:	67bc                	ld	a5,72(a5)
    80002a80:	00006717          	auipc	a4,0x6
    80002a84:	e8f73423          	sd	a5,-376(a4) # 80008908 <sched_pointer>
    printf("Scheduler successfully changed to %s\n", available_schedulers[id - 1].name);
    80002a88:	00006597          	auipc	a1,0x6
    80002a8c:	ed058593          	addi	a1,a1,-304 # 80008958 <available_schedulers>
    80002a90:	95aa                	add	a1,a1,a0
    80002a92:	00006517          	auipc	a0,0x6
    80002a96:	88650513          	addi	a0,a0,-1914 # 80008318 <digits+0x2d8>
    80002a9a:	ffffe097          	auipc	ra,0xffffe
    80002a9e:	b32080e7          	jalr	-1230(ra) # 800005cc <printf>
    80002aa2:	60a2                	ld	ra,8(sp)
    80002aa4:	6402                	ld	s0,0(sp)
    80002aa6:	0141                	addi	sp,sp,16
    80002aa8:	8082                	ret

0000000080002aaa <swtch>:
    80002aaa:	00153023          	sd	ra,0(a0)
    80002aae:	00253423          	sd	sp,8(a0)
    80002ab2:	e900                	sd	s0,16(a0)
    80002ab4:	ed04                	sd	s1,24(a0)
    80002ab6:	03253023          	sd	s2,32(a0)
    80002aba:	03353423          	sd	s3,40(a0)
    80002abe:	03453823          	sd	s4,48(a0)
    80002ac2:	03553c23          	sd	s5,56(a0)
    80002ac6:	05653023          	sd	s6,64(a0)
    80002aca:	05753423          	sd	s7,72(a0)
    80002ace:	05853823          	sd	s8,80(a0)
    80002ad2:	05953c23          	sd	s9,88(a0)
    80002ad6:	07a53023          	sd	s10,96(a0)
    80002ada:	07b53423          	sd	s11,104(a0)
    80002ade:	0005b083          	ld	ra,0(a1)
    80002ae2:	0085b103          	ld	sp,8(a1)
    80002ae6:	6980                	ld	s0,16(a1)
    80002ae8:	6d84                	ld	s1,24(a1)
    80002aea:	0205b903          	ld	s2,32(a1)
    80002aee:	0285b983          	ld	s3,40(a1)
    80002af2:	0305ba03          	ld	s4,48(a1)
    80002af6:	0385ba83          	ld	s5,56(a1)
    80002afa:	0405bb03          	ld	s6,64(a1)
    80002afe:	0485bb83          	ld	s7,72(a1)
    80002b02:	0505bc03          	ld	s8,80(a1)
    80002b06:	0585bc83          	ld	s9,88(a1)
    80002b0a:	0605bd03          	ld	s10,96(a1)
    80002b0e:	0685bd83          	ld	s11,104(a1)
    80002b12:	8082                	ret

0000000080002b14 <trapinit>:
void kernelvec();

extern int devintr();

void trapinit(void)
{
    80002b14:	1141                	addi	sp,sp,-16
    80002b16:	e406                	sd	ra,8(sp)
    80002b18:	e022                	sd	s0,0(sp)
    80002b1a:	0800                	addi	s0,sp,16
    initlock(&tickslock, "time");
    80002b1c:	00006597          	auipc	a1,0x6
    80002b20:	88458593          	addi	a1,a1,-1916 # 800083a0 <states.0+0x30>
    80002b24:	00014517          	auipc	a0,0x14
    80002b28:	14c50513          	addi	a0,a0,332 # 80016c70 <tickslock>
    80002b2c:	ffffe097          	auipc	ra,0xffffe
    80002b30:	05c080e7          	jalr	92(ra) # 80000b88 <initlock>
}
    80002b34:	60a2                	ld	ra,8(sp)
    80002b36:	6402                	ld	s0,0(sp)
    80002b38:	0141                	addi	sp,sp,16
    80002b3a:	8082                	ret

0000000080002b3c <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void trapinithart(void)
{
    80002b3c:	1141                	addi	sp,sp,-16
    80002b3e:	e422                	sd	s0,8(sp)
    80002b40:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002b42:	00003797          	auipc	a5,0x3
    80002b46:	4fe78793          	addi	a5,a5,1278 # 80006040 <kernelvec>
    80002b4a:	10579073          	csrw	stvec,a5
    w_stvec((uint64)kernelvec);
}
    80002b4e:	6422                	ld	s0,8(sp)
    80002b50:	0141                	addi	sp,sp,16
    80002b52:	8082                	ret

0000000080002b54 <usertrapret>:

//
// return to user space
//
void usertrapret(void)
{
    80002b54:	1141                	addi	sp,sp,-16
    80002b56:	e406                	sd	ra,8(sp)
    80002b58:	e022                	sd	s0,0(sp)
    80002b5a:	0800                	addi	s0,sp,16
    struct proc *p = myproc();
    80002b5c:	fffff097          	auipc	ra,0xfffff
    80002b60:	0f8080e7          	jalr	248(ra) # 80001c54 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002b64:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80002b68:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002b6a:	10079073          	csrw	sstatus,a5
    // kerneltrap() to usertrap(), so turn off interrupts until
    // we're back in user space, where usertrap() is correct.
    intr_off();

    // send syscalls, interrupts, and exceptions to uservec in trampoline.S
    uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80002b6e:	00004697          	auipc	a3,0x4
    80002b72:	49268693          	addi	a3,a3,1170 # 80007000 <_trampoline>
    80002b76:	00004717          	auipc	a4,0x4
    80002b7a:	48a70713          	addi	a4,a4,1162 # 80007000 <_trampoline>
    80002b7e:	8f15                	sub	a4,a4,a3
    80002b80:	040007b7          	lui	a5,0x4000
    80002b84:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80002b86:	07b2                	slli	a5,a5,0xc
    80002b88:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002b8a:	10571073          	csrw	stvec,a4
    w_stvec(trampoline_uservec);

    // set up trapframe values that uservec will need when
    // the process next traps into the kernel.
    p->trapframe->kernel_satp = r_satp();         // kernel page table
    80002b8e:	7138                	ld	a4,96(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80002b90:	18002673          	csrr	a2,satp
    80002b94:	e310                	sd	a2,0(a4)
    p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80002b96:	7130                	ld	a2,96(a0)
    80002b98:	6538                	ld	a4,72(a0)
    80002b9a:	6585                	lui	a1,0x1
    80002b9c:	972e                	add	a4,a4,a1
    80002b9e:	e618                	sd	a4,8(a2)
    p->trapframe->kernel_trap = (uint64)usertrap;
    80002ba0:	7138                	ld	a4,96(a0)
    80002ba2:	00000617          	auipc	a2,0x0
    80002ba6:	13460613          	addi	a2,a2,308 # 80002cd6 <usertrap>
    80002baa:	eb10                	sd	a2,16(a4)
    p->trapframe->kernel_hartid = r_tp(); // hartid for cpuid()
    80002bac:	7138                	ld	a4,96(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80002bae:	8612                	mv	a2,tp
    80002bb0:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002bb2:	10002773          	csrr	a4,sstatus
    // set up the registers that trampoline.S's sret will use
    // to get to user space.

    // set S Previous Privilege mode to User.
    unsigned long x = r_sstatus();
    x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80002bb6:	eff77713          	andi	a4,a4,-257
    x |= SSTATUS_SPIE; // enable interrupts in user mode
    80002bba:	02076713          	ori	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002bbe:	10071073          	csrw	sstatus,a4
    w_sstatus(x);

    // set S Exception Program Counter to the saved user pc.
    w_sepc(p->trapframe->epc);
    80002bc2:	7138                	ld	a4,96(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002bc4:	6f18                	ld	a4,24(a4)
    80002bc6:	14171073          	csrw	sepc,a4

    // tell trampoline.S the user page table to switch to.
    uint64 satp = MAKE_SATP(p->pagetable);
    80002bca:	6d28                	ld	a0,88(a0)
    80002bcc:	8131                	srli	a0,a0,0xc

    // jump to userret in trampoline.S at the top of memory, which
    // switches to the user page table, restores user registers,
    // and switches to user mode with sret.
    uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80002bce:	00004717          	auipc	a4,0x4
    80002bd2:	4ce70713          	addi	a4,a4,1230 # 8000709c <userret>
    80002bd6:	8f15                	sub	a4,a4,a3
    80002bd8:	97ba                	add	a5,a5,a4
    ((void (*)(uint64))trampoline_userret)(satp);
    80002bda:	577d                	li	a4,-1
    80002bdc:	177e                	slli	a4,a4,0x3f
    80002bde:	8d59                	or	a0,a0,a4
    80002be0:	9782                	jalr	a5
}
    80002be2:	60a2                	ld	ra,8(sp)
    80002be4:	6402                	ld	s0,0(sp)
    80002be6:	0141                	addi	sp,sp,16
    80002be8:	8082                	ret

0000000080002bea <clockintr>:
    w_sepc(sepc);
    w_sstatus(sstatus);
}

void clockintr()
{
    80002bea:	1101                	addi	sp,sp,-32
    80002bec:	ec06                	sd	ra,24(sp)
    80002bee:	e822                	sd	s0,16(sp)
    80002bf0:	e426                	sd	s1,8(sp)
    80002bf2:	1000                	addi	s0,sp,32
    acquire(&tickslock);
    80002bf4:	00014497          	auipc	s1,0x14
    80002bf8:	07c48493          	addi	s1,s1,124 # 80016c70 <tickslock>
    80002bfc:	8526                	mv	a0,s1
    80002bfe:	ffffe097          	auipc	ra,0xffffe
    80002c02:	01a080e7          	jalr	26(ra) # 80000c18 <acquire>
    ticks++;
    80002c06:	00006517          	auipc	a0,0x6
    80002c0a:	dca50513          	addi	a0,a0,-566 # 800089d0 <ticks>
    80002c0e:	411c                	lw	a5,0(a0)
    80002c10:	2785                	addiw	a5,a5,1
    80002c12:	c11c                	sw	a5,0(a0)
    wakeup(&ticks);
    80002c14:	00000097          	auipc	ra,0x0
    80002c18:	868080e7          	jalr	-1944(ra) # 8000247c <wakeup>
    release(&tickslock);
    80002c1c:	8526                	mv	a0,s1
    80002c1e:	ffffe097          	auipc	ra,0xffffe
    80002c22:	0ae080e7          	jalr	174(ra) # 80000ccc <release>
}
    80002c26:	60e2                	ld	ra,24(sp)
    80002c28:	6442                	ld	s0,16(sp)
    80002c2a:	64a2                	ld	s1,8(sp)
    80002c2c:	6105                	addi	sp,sp,32
    80002c2e:	8082                	ret

0000000080002c30 <devintr>:
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002c30:	142027f3          	csrr	a5,scause

        return 2;
    }
    else
    {
        return 0;
    80002c34:	4501                	li	a0,0
    if ((scause & 0x8000000000000000L) &&
    80002c36:	0807df63          	bgez	a5,80002cd4 <devintr+0xa4>
{
    80002c3a:	1101                	addi	sp,sp,-32
    80002c3c:	ec06                	sd	ra,24(sp)
    80002c3e:	e822                	sd	s0,16(sp)
    80002c40:	e426                	sd	s1,8(sp)
    80002c42:	1000                	addi	s0,sp,32
        (scause & 0xff) == 9)
    80002c44:	0ff7f713          	zext.b	a4,a5
    if ((scause & 0x8000000000000000L) &&
    80002c48:	46a5                	li	a3,9
    80002c4a:	00d70d63          	beq	a4,a3,80002c64 <devintr+0x34>
    else if (scause == 0x8000000000000001L)
    80002c4e:	577d                	li	a4,-1
    80002c50:	177e                	slli	a4,a4,0x3f
    80002c52:	0705                	addi	a4,a4,1
        return 0;
    80002c54:	4501                	li	a0,0
    else if (scause == 0x8000000000000001L)
    80002c56:	04e78e63          	beq	a5,a4,80002cb2 <devintr+0x82>
    }
}
    80002c5a:	60e2                	ld	ra,24(sp)
    80002c5c:	6442                	ld	s0,16(sp)
    80002c5e:	64a2                	ld	s1,8(sp)
    80002c60:	6105                	addi	sp,sp,32
    80002c62:	8082                	ret
        int irq = plic_claim();
    80002c64:	00003097          	auipc	ra,0x3
    80002c68:	4e4080e7          	jalr	1252(ra) # 80006148 <plic_claim>
    80002c6c:	84aa                	mv	s1,a0
        if (irq == UART0_IRQ)
    80002c6e:	47a9                	li	a5,10
    80002c70:	02f50763          	beq	a0,a5,80002c9e <devintr+0x6e>
        else if (irq == VIRTIO0_IRQ)
    80002c74:	4785                	li	a5,1
    80002c76:	02f50963          	beq	a0,a5,80002ca8 <devintr+0x78>
        return 1;
    80002c7a:	4505                	li	a0,1
        else if (irq)
    80002c7c:	dcf9                	beqz	s1,80002c5a <devintr+0x2a>
            printf("unexpected interrupt irq=%d\n", irq);
    80002c7e:	85a6                	mv	a1,s1
    80002c80:	00005517          	auipc	a0,0x5
    80002c84:	72850513          	addi	a0,a0,1832 # 800083a8 <states.0+0x38>
    80002c88:	ffffe097          	auipc	ra,0xffffe
    80002c8c:	944080e7          	jalr	-1724(ra) # 800005cc <printf>
            plic_complete(irq);
    80002c90:	8526                	mv	a0,s1
    80002c92:	00003097          	auipc	ra,0x3
    80002c96:	4da080e7          	jalr	1242(ra) # 8000616c <plic_complete>
        return 1;
    80002c9a:	4505                	li	a0,1
    80002c9c:	bf7d                	j	80002c5a <devintr+0x2a>
            uartintr();
    80002c9e:	ffffe097          	auipc	ra,0xffffe
    80002ca2:	d3c080e7          	jalr	-708(ra) # 800009da <uartintr>
        if (irq)
    80002ca6:	b7ed                	j	80002c90 <devintr+0x60>
            virtio_disk_intr();
    80002ca8:	00004097          	auipc	ra,0x4
    80002cac:	98a080e7          	jalr	-1654(ra) # 80006632 <virtio_disk_intr>
        if (irq)
    80002cb0:	b7c5                	j	80002c90 <devintr+0x60>
        if (cpuid() == 0)
    80002cb2:	fffff097          	auipc	ra,0xfffff
    80002cb6:	f76080e7          	jalr	-138(ra) # 80001c28 <cpuid>
    80002cba:	c901                	beqz	a0,80002cca <devintr+0x9a>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80002cbc:	144027f3          	csrr	a5,sip
        w_sip(r_sip() & ~2);
    80002cc0:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80002cc2:	14479073          	csrw	sip,a5
        return 2;
    80002cc6:	4509                	li	a0,2
    80002cc8:	bf49                	j	80002c5a <devintr+0x2a>
            clockintr();
    80002cca:	00000097          	auipc	ra,0x0
    80002cce:	f20080e7          	jalr	-224(ra) # 80002bea <clockintr>
    80002cd2:	b7ed                	j	80002cbc <devintr+0x8c>
}
    80002cd4:	8082                	ret

0000000080002cd6 <usertrap>:
{
    80002cd6:	1101                	addi	sp,sp,-32
    80002cd8:	ec06                	sd	ra,24(sp)
    80002cda:	e822                	sd	s0,16(sp)
    80002cdc:	e426                	sd	s1,8(sp)
    80002cde:	e04a                	sd	s2,0(sp)
    80002ce0:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002ce2:	100027f3          	csrr	a5,sstatus
    if ((r_sstatus() & SSTATUS_SPP) != 0)
    80002ce6:	1007f793          	andi	a5,a5,256
    80002cea:	e3b1                	bnez	a5,80002d2e <usertrap+0x58>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002cec:	00003797          	auipc	a5,0x3
    80002cf0:	35478793          	addi	a5,a5,852 # 80006040 <kernelvec>
    80002cf4:	10579073          	csrw	stvec,a5
    struct proc *p = myproc();
    80002cf8:	fffff097          	auipc	ra,0xfffff
    80002cfc:	f5c080e7          	jalr	-164(ra) # 80001c54 <myproc>
    80002d00:	84aa                	mv	s1,a0
    p->trapframe->epc = r_sepc();
    80002d02:	713c                	ld	a5,96(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002d04:	14102773          	csrr	a4,sepc
    80002d08:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002d0a:	14202773          	csrr	a4,scause
    if (r_scause() == 8)
    80002d0e:	47a1                	li	a5,8
    80002d10:	02f70763          	beq	a4,a5,80002d3e <usertrap+0x68>
    else if ((which_dev = devintr()) != 0)
    80002d14:	00000097          	auipc	ra,0x0
    80002d18:	f1c080e7          	jalr	-228(ra) # 80002c30 <devintr>
    80002d1c:	892a                	mv	s2,a0
    80002d1e:	c151                	beqz	a0,80002da2 <usertrap+0xcc>
    if (killed(p))
    80002d20:	8526                	mv	a0,s1
    80002d22:	00000097          	auipc	ra,0x0
    80002d26:	99e080e7          	jalr	-1634(ra) # 800026c0 <killed>
    80002d2a:	c929                	beqz	a0,80002d7c <usertrap+0xa6>
    80002d2c:	a099                	j	80002d72 <usertrap+0x9c>
        panic("usertrap: not from user mode");
    80002d2e:	00005517          	auipc	a0,0x5
    80002d32:	69a50513          	addi	a0,a0,1690 # 800083c8 <states.0+0x58>
    80002d36:	ffffe097          	auipc	ra,0xffffe
    80002d3a:	84c080e7          	jalr	-1972(ra) # 80000582 <panic>
        if (killed(p))
    80002d3e:	00000097          	auipc	ra,0x0
    80002d42:	982080e7          	jalr	-1662(ra) # 800026c0 <killed>
    80002d46:	e921                	bnez	a0,80002d96 <usertrap+0xc0>
        p->trapframe->epc += 4;
    80002d48:	70b8                	ld	a4,96(s1)
    80002d4a:	6f1c                	ld	a5,24(a4)
    80002d4c:	0791                	addi	a5,a5,4
    80002d4e:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002d50:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80002d54:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002d58:	10079073          	csrw	sstatus,a5
        syscall();
    80002d5c:	00000097          	auipc	ra,0x0
    80002d60:	2d8080e7          	jalr	728(ra) # 80003034 <syscall>
    if (killed(p))
    80002d64:	8526                	mv	a0,s1
    80002d66:	00000097          	auipc	ra,0x0
    80002d6a:	95a080e7          	jalr	-1702(ra) # 800026c0 <killed>
    80002d6e:	c911                	beqz	a0,80002d82 <usertrap+0xac>
    80002d70:	4901                	li	s2,0
        exit(-1);
    80002d72:	557d                	li	a0,-1
    80002d74:	fffff097          	auipc	ra,0xfffff
    80002d78:	7d8080e7          	jalr	2008(ra) # 8000254c <exit>
    if (which_dev == 2)
    80002d7c:	4789                	li	a5,2
    80002d7e:	04f90f63          	beq	s2,a5,80002ddc <usertrap+0x106>
    usertrapret();
    80002d82:	00000097          	auipc	ra,0x0
    80002d86:	dd2080e7          	jalr	-558(ra) # 80002b54 <usertrapret>
}
    80002d8a:	60e2                	ld	ra,24(sp)
    80002d8c:	6442                	ld	s0,16(sp)
    80002d8e:	64a2                	ld	s1,8(sp)
    80002d90:	6902                	ld	s2,0(sp)
    80002d92:	6105                	addi	sp,sp,32
    80002d94:	8082                	ret
            exit(-1);
    80002d96:	557d                	li	a0,-1
    80002d98:	fffff097          	auipc	ra,0xfffff
    80002d9c:	7b4080e7          	jalr	1972(ra) # 8000254c <exit>
    80002da0:	b765                	j	80002d48 <usertrap+0x72>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002da2:	142025f3          	csrr	a1,scause
        printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80002da6:	5890                	lw	a2,48(s1)
    80002da8:	00005517          	auipc	a0,0x5
    80002dac:	64050513          	addi	a0,a0,1600 # 800083e8 <states.0+0x78>
    80002db0:	ffffe097          	auipc	ra,0xffffe
    80002db4:	81c080e7          	jalr	-2020(ra) # 800005cc <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002db8:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002dbc:	14302673          	csrr	a2,stval
        printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002dc0:	00005517          	auipc	a0,0x5
    80002dc4:	65850513          	addi	a0,a0,1624 # 80008418 <states.0+0xa8>
    80002dc8:	ffffe097          	auipc	ra,0xffffe
    80002dcc:	804080e7          	jalr	-2044(ra) # 800005cc <printf>
        setkilled(p);
    80002dd0:	8526                	mv	a0,s1
    80002dd2:	00000097          	auipc	ra,0x0
    80002dd6:	8c2080e7          	jalr	-1854(ra) # 80002694 <setkilled>
    80002dda:	b769                	j	80002d64 <usertrap+0x8e>
        yield(YIELD_TIMER);
    80002ddc:	4505                	li	a0,1
    80002dde:	fffff097          	auipc	ra,0xfffff
    80002de2:	5dc080e7          	jalr	1500(ra) # 800023ba <yield>
    80002de6:	bf71                	j	80002d82 <usertrap+0xac>

0000000080002de8 <kerneltrap>:
{
    80002de8:	7179                	addi	sp,sp,-48
    80002dea:	f406                	sd	ra,40(sp)
    80002dec:	f022                	sd	s0,32(sp)
    80002dee:	ec26                	sd	s1,24(sp)
    80002df0:	e84a                	sd	s2,16(sp)
    80002df2:	e44e                	sd	s3,8(sp)
    80002df4:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002df6:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002dfa:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002dfe:	142029f3          	csrr	s3,scause
    if ((sstatus & SSTATUS_SPP) == 0)
    80002e02:	1004f793          	andi	a5,s1,256
    80002e06:	cb85                	beqz	a5,80002e36 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002e08:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80002e0c:	8b89                	andi	a5,a5,2
    if (intr_get() != 0)
    80002e0e:	ef85                	bnez	a5,80002e46 <kerneltrap+0x5e>
    if ((which_dev = devintr()) == 0)
    80002e10:	00000097          	auipc	ra,0x0
    80002e14:	e20080e7          	jalr	-480(ra) # 80002c30 <devintr>
    80002e18:	cd1d                	beqz	a0,80002e56 <kerneltrap+0x6e>
    if (which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002e1a:	4789                	li	a5,2
    80002e1c:	06f50a63          	beq	a0,a5,80002e90 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002e20:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002e24:	10049073          	csrw	sstatus,s1
}
    80002e28:	70a2                	ld	ra,40(sp)
    80002e2a:	7402                	ld	s0,32(sp)
    80002e2c:	64e2                	ld	s1,24(sp)
    80002e2e:	6942                	ld	s2,16(sp)
    80002e30:	69a2                	ld	s3,8(sp)
    80002e32:	6145                	addi	sp,sp,48
    80002e34:	8082                	ret
        panic("kerneltrap: not from supervisor mode");
    80002e36:	00005517          	auipc	a0,0x5
    80002e3a:	60250513          	addi	a0,a0,1538 # 80008438 <states.0+0xc8>
    80002e3e:	ffffd097          	auipc	ra,0xffffd
    80002e42:	744080e7          	jalr	1860(ra) # 80000582 <panic>
        panic("kerneltrap: interrupts enabled");
    80002e46:	00005517          	auipc	a0,0x5
    80002e4a:	61a50513          	addi	a0,a0,1562 # 80008460 <states.0+0xf0>
    80002e4e:	ffffd097          	auipc	ra,0xffffd
    80002e52:	734080e7          	jalr	1844(ra) # 80000582 <panic>
        printf("scause %p\n", scause);
    80002e56:	85ce                	mv	a1,s3
    80002e58:	00005517          	auipc	a0,0x5
    80002e5c:	62850513          	addi	a0,a0,1576 # 80008480 <states.0+0x110>
    80002e60:	ffffd097          	auipc	ra,0xffffd
    80002e64:	76c080e7          	jalr	1900(ra) # 800005cc <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002e68:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002e6c:	14302673          	csrr	a2,stval
        printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002e70:	00005517          	auipc	a0,0x5
    80002e74:	62050513          	addi	a0,a0,1568 # 80008490 <states.0+0x120>
    80002e78:	ffffd097          	auipc	ra,0xffffd
    80002e7c:	754080e7          	jalr	1876(ra) # 800005cc <printf>
        panic("kerneltrap");
    80002e80:	00005517          	auipc	a0,0x5
    80002e84:	62850513          	addi	a0,a0,1576 # 800084a8 <states.0+0x138>
    80002e88:	ffffd097          	auipc	ra,0xffffd
    80002e8c:	6fa080e7          	jalr	1786(ra) # 80000582 <panic>
    if (which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80002e90:	fffff097          	auipc	ra,0xfffff
    80002e94:	dc4080e7          	jalr	-572(ra) # 80001c54 <myproc>
    80002e98:	d541                	beqz	a0,80002e20 <kerneltrap+0x38>
    80002e9a:	fffff097          	auipc	ra,0xfffff
    80002e9e:	dba080e7          	jalr	-582(ra) # 80001c54 <myproc>
    80002ea2:	4d18                	lw	a4,24(a0)
    80002ea4:	4791                	li	a5,4
    80002ea6:	f6f71de3          	bne	a4,a5,80002e20 <kerneltrap+0x38>
        yield(YIELD_OTHER); // we are in the kernel already - not the user proc to blame for
    80002eaa:	4509                	li	a0,2
    80002eac:	fffff097          	auipc	ra,0xfffff
    80002eb0:	50e080e7          	jalr	1294(ra) # 800023ba <yield>
    80002eb4:	b7b5                	j	80002e20 <kerneltrap+0x38>

0000000080002eb6 <argraw>:
    return strlen(buf);
}

static uint64
argraw(int n)
{
    80002eb6:	1101                	addi	sp,sp,-32
    80002eb8:	ec06                	sd	ra,24(sp)
    80002eba:	e822                	sd	s0,16(sp)
    80002ebc:	e426                	sd	s1,8(sp)
    80002ebe:	1000                	addi	s0,sp,32
    80002ec0:	84aa                	mv	s1,a0
    struct proc *p = myproc();
    80002ec2:	fffff097          	auipc	ra,0xfffff
    80002ec6:	d92080e7          	jalr	-622(ra) # 80001c54 <myproc>
    switch (n)
    80002eca:	4795                	li	a5,5
    80002ecc:	0497e163          	bltu	a5,s1,80002f0e <argraw+0x58>
    80002ed0:	048a                	slli	s1,s1,0x2
    80002ed2:	00005717          	auipc	a4,0x5
    80002ed6:	60e70713          	addi	a4,a4,1550 # 800084e0 <states.0+0x170>
    80002eda:	94ba                	add	s1,s1,a4
    80002edc:	409c                	lw	a5,0(s1)
    80002ede:	97ba                	add	a5,a5,a4
    80002ee0:	8782                	jr	a5
    {
    case 0:
        return p->trapframe->a0;
    80002ee2:	713c                	ld	a5,96(a0)
    80002ee4:	7ba8                	ld	a0,112(a5)
    case 5:
        return p->trapframe->a5;
    }
    panic("argraw");
    return -1;
}
    80002ee6:	60e2                	ld	ra,24(sp)
    80002ee8:	6442                	ld	s0,16(sp)
    80002eea:	64a2                	ld	s1,8(sp)
    80002eec:	6105                	addi	sp,sp,32
    80002eee:	8082                	ret
        return p->trapframe->a1;
    80002ef0:	713c                	ld	a5,96(a0)
    80002ef2:	7fa8                	ld	a0,120(a5)
    80002ef4:	bfcd                	j	80002ee6 <argraw+0x30>
        return p->trapframe->a2;
    80002ef6:	713c                	ld	a5,96(a0)
    80002ef8:	63c8                	ld	a0,128(a5)
    80002efa:	b7f5                	j	80002ee6 <argraw+0x30>
        return p->trapframe->a3;
    80002efc:	713c                	ld	a5,96(a0)
    80002efe:	67c8                	ld	a0,136(a5)
    80002f00:	b7dd                	j	80002ee6 <argraw+0x30>
        return p->trapframe->a4;
    80002f02:	713c                	ld	a5,96(a0)
    80002f04:	6bc8                	ld	a0,144(a5)
    80002f06:	b7c5                	j	80002ee6 <argraw+0x30>
        return p->trapframe->a5;
    80002f08:	713c                	ld	a5,96(a0)
    80002f0a:	6fc8                	ld	a0,152(a5)
    80002f0c:	bfe9                	j	80002ee6 <argraw+0x30>
    panic("argraw");
    80002f0e:	00005517          	auipc	a0,0x5
    80002f12:	5aa50513          	addi	a0,a0,1450 # 800084b8 <states.0+0x148>
    80002f16:	ffffd097          	auipc	ra,0xffffd
    80002f1a:	66c080e7          	jalr	1644(ra) # 80000582 <panic>

0000000080002f1e <fetchaddr>:
{
    80002f1e:	1101                	addi	sp,sp,-32
    80002f20:	ec06                	sd	ra,24(sp)
    80002f22:	e822                	sd	s0,16(sp)
    80002f24:	e426                	sd	s1,8(sp)
    80002f26:	e04a                	sd	s2,0(sp)
    80002f28:	1000                	addi	s0,sp,32
    80002f2a:	84aa                	mv	s1,a0
    80002f2c:	892e                	mv	s2,a1
    struct proc *p = myproc();
    80002f2e:	fffff097          	auipc	ra,0xfffff
    80002f32:	d26080e7          	jalr	-730(ra) # 80001c54 <myproc>
    if (addr >= p->sz || addr + sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80002f36:	693c                	ld	a5,80(a0)
    80002f38:	02f4f863          	bgeu	s1,a5,80002f68 <fetchaddr+0x4a>
    80002f3c:	00848713          	addi	a4,s1,8
    80002f40:	02e7e663          	bltu	a5,a4,80002f6c <fetchaddr+0x4e>
    if (copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80002f44:	46a1                	li	a3,8
    80002f46:	8626                	mv	a2,s1
    80002f48:	85ca                	mv	a1,s2
    80002f4a:	6d28                	ld	a0,88(a0)
    80002f4c:	ffffe097          	auipc	ra,0xffffe
    80002f50:	7ec080e7          	jalr	2028(ra) # 80001738 <copyin>
    80002f54:	00a03533          	snez	a0,a0
    80002f58:	40a00533          	neg	a0,a0
}
    80002f5c:	60e2                	ld	ra,24(sp)
    80002f5e:	6442                	ld	s0,16(sp)
    80002f60:	64a2                	ld	s1,8(sp)
    80002f62:	6902                	ld	s2,0(sp)
    80002f64:	6105                	addi	sp,sp,32
    80002f66:	8082                	ret
        return -1;
    80002f68:	557d                	li	a0,-1
    80002f6a:	bfcd                	j	80002f5c <fetchaddr+0x3e>
    80002f6c:	557d                	li	a0,-1
    80002f6e:	b7fd                	j	80002f5c <fetchaddr+0x3e>

0000000080002f70 <fetchstr>:
{
    80002f70:	7179                	addi	sp,sp,-48
    80002f72:	f406                	sd	ra,40(sp)
    80002f74:	f022                	sd	s0,32(sp)
    80002f76:	ec26                	sd	s1,24(sp)
    80002f78:	e84a                	sd	s2,16(sp)
    80002f7a:	e44e                	sd	s3,8(sp)
    80002f7c:	1800                	addi	s0,sp,48
    80002f7e:	892a                	mv	s2,a0
    80002f80:	84ae                	mv	s1,a1
    80002f82:	89b2                	mv	s3,a2
    struct proc *p = myproc();
    80002f84:	fffff097          	auipc	ra,0xfffff
    80002f88:	cd0080e7          	jalr	-816(ra) # 80001c54 <myproc>
    if (copyinstr(p->pagetable, buf, addr, max) < 0)
    80002f8c:	86ce                	mv	a3,s3
    80002f8e:	864a                	mv	a2,s2
    80002f90:	85a6                	mv	a1,s1
    80002f92:	6d28                	ld	a0,88(a0)
    80002f94:	fffff097          	auipc	ra,0xfffff
    80002f98:	832080e7          	jalr	-1998(ra) # 800017c6 <copyinstr>
    80002f9c:	00054e63          	bltz	a0,80002fb8 <fetchstr+0x48>
    return strlen(buf);
    80002fa0:	8526                	mv	a0,s1
    80002fa2:	ffffe097          	auipc	ra,0xffffe
    80002fa6:	eec080e7          	jalr	-276(ra) # 80000e8e <strlen>
}
    80002faa:	70a2                	ld	ra,40(sp)
    80002fac:	7402                	ld	s0,32(sp)
    80002fae:	64e2                	ld	s1,24(sp)
    80002fb0:	6942                	ld	s2,16(sp)
    80002fb2:	69a2                	ld	s3,8(sp)
    80002fb4:	6145                	addi	sp,sp,48
    80002fb6:	8082                	ret
        return -1;
    80002fb8:	557d                	li	a0,-1
    80002fba:	bfc5                	j	80002faa <fetchstr+0x3a>

0000000080002fbc <argint>:

// Fetch the nth 32-bit system call argument.
void argint(int n, int *ip)
{
    80002fbc:	1101                	addi	sp,sp,-32
    80002fbe:	ec06                	sd	ra,24(sp)
    80002fc0:	e822                	sd	s0,16(sp)
    80002fc2:	e426                	sd	s1,8(sp)
    80002fc4:	1000                	addi	s0,sp,32
    80002fc6:	84ae                	mv	s1,a1
    *ip = argraw(n);
    80002fc8:	00000097          	auipc	ra,0x0
    80002fcc:	eee080e7          	jalr	-274(ra) # 80002eb6 <argraw>
    80002fd0:	c088                	sw	a0,0(s1)
}
    80002fd2:	60e2                	ld	ra,24(sp)
    80002fd4:	6442                	ld	s0,16(sp)
    80002fd6:	64a2                	ld	s1,8(sp)
    80002fd8:	6105                	addi	sp,sp,32
    80002fda:	8082                	ret

0000000080002fdc <argaddr>:

// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void argaddr(int n, uint64 *ip)
{
    80002fdc:	1101                	addi	sp,sp,-32
    80002fde:	ec06                	sd	ra,24(sp)
    80002fe0:	e822                	sd	s0,16(sp)
    80002fe2:	e426                	sd	s1,8(sp)
    80002fe4:	1000                	addi	s0,sp,32
    80002fe6:	84ae                	mv	s1,a1
    *ip = argraw(n);
    80002fe8:	00000097          	auipc	ra,0x0
    80002fec:	ece080e7          	jalr	-306(ra) # 80002eb6 <argraw>
    80002ff0:	e088                	sd	a0,0(s1)
}
    80002ff2:	60e2                	ld	ra,24(sp)
    80002ff4:	6442                	ld	s0,16(sp)
    80002ff6:	64a2                	ld	s1,8(sp)
    80002ff8:	6105                	addi	sp,sp,32
    80002ffa:	8082                	ret

0000000080002ffc <argstr>:

// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int argstr(int n, char *buf, int max)
{
    80002ffc:	7179                	addi	sp,sp,-48
    80002ffe:	f406                	sd	ra,40(sp)
    80003000:	f022                	sd	s0,32(sp)
    80003002:	ec26                	sd	s1,24(sp)
    80003004:	e84a                	sd	s2,16(sp)
    80003006:	1800                	addi	s0,sp,48
    80003008:	84ae                	mv	s1,a1
    8000300a:	8932                	mv	s2,a2
    uint64 addr;
    argaddr(n, &addr);
    8000300c:	fd840593          	addi	a1,s0,-40
    80003010:	00000097          	auipc	ra,0x0
    80003014:	fcc080e7          	jalr	-52(ra) # 80002fdc <argaddr>
    return fetchstr(addr, buf, max);
    80003018:	864a                	mv	a2,s2
    8000301a:	85a6                	mv	a1,s1
    8000301c:	fd843503          	ld	a0,-40(s0)
    80003020:	00000097          	auipc	ra,0x0
    80003024:	f50080e7          	jalr	-176(ra) # 80002f70 <fetchstr>
}
    80003028:	70a2                	ld	ra,40(sp)
    8000302a:	7402                	ld	s0,32(sp)
    8000302c:	64e2                	ld	s1,24(sp)
    8000302e:	6942                	ld	s2,16(sp)
    80003030:	6145                	addi	sp,sp,48
    80003032:	8082                	ret

0000000080003034 <syscall>:
    [SYS_schedls] sys_schedls,
    [SYS_schedset] sys_schedset,
};

void syscall(void)
{
    80003034:	1101                	addi	sp,sp,-32
    80003036:	ec06                	sd	ra,24(sp)
    80003038:	e822                	sd	s0,16(sp)
    8000303a:	e426                	sd	s1,8(sp)
    8000303c:	e04a                	sd	s2,0(sp)
    8000303e:	1000                	addi	s0,sp,32
    int num;
    struct proc *p = myproc();
    80003040:	fffff097          	auipc	ra,0xfffff
    80003044:	c14080e7          	jalr	-1004(ra) # 80001c54 <myproc>
    80003048:	84aa                	mv	s1,a0

    num = p->trapframe->a7;
    8000304a:	06053903          	ld	s2,96(a0)
    8000304e:	0a893783          	ld	a5,168(s2)
    80003052:	0007869b          	sext.w	a3,a5
    if (num > 0 && num < NELEM(syscalls) && syscalls[num])
    80003056:	37fd                	addiw	a5,a5,-1
    80003058:	475d                	li	a4,23
    8000305a:	00f76f63          	bltu	a4,a5,80003078 <syscall+0x44>
    8000305e:	00369713          	slli	a4,a3,0x3
    80003062:	00005797          	auipc	a5,0x5
    80003066:	49678793          	addi	a5,a5,1174 # 800084f8 <syscalls>
    8000306a:	97ba                	add	a5,a5,a4
    8000306c:	639c                	ld	a5,0(a5)
    8000306e:	c789                	beqz	a5,80003078 <syscall+0x44>
    {
        // Use num to lookup the system call function for num, call it,
        // and store its return value in p->trapframe->a0
        p->trapframe->a0 = syscalls[num]();
    80003070:	9782                	jalr	a5
    80003072:	06a93823          	sd	a0,112(s2)
    80003076:	a839                	j	80003094 <syscall+0x60>
    }
    else
    {
        printf("%d %s: unknown sys call %d\n",
    80003078:	16048613          	addi	a2,s1,352
    8000307c:	588c                	lw	a1,48(s1)
    8000307e:	00005517          	auipc	a0,0x5
    80003082:	44250513          	addi	a0,a0,1090 # 800084c0 <states.0+0x150>
    80003086:	ffffd097          	auipc	ra,0xffffd
    8000308a:	546080e7          	jalr	1350(ra) # 800005cc <printf>
               p->pid, p->name, num);
        p->trapframe->a0 = -1;
    8000308e:	70bc                	ld	a5,96(s1)
    80003090:	577d                	li	a4,-1
    80003092:	fbb8                	sd	a4,112(a5)
    }
}
    80003094:	60e2                	ld	ra,24(sp)
    80003096:	6442                	ld	s0,16(sp)
    80003098:	64a2                	ld	s1,8(sp)
    8000309a:	6902                	ld	s2,0(sp)
    8000309c:	6105                	addi	sp,sp,32
    8000309e:	8082                	ret

00000000800030a0 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    800030a0:	1101                	addi	sp,sp,-32
    800030a2:	ec06                	sd	ra,24(sp)
    800030a4:	e822                	sd	s0,16(sp)
    800030a6:	1000                	addi	s0,sp,32
    int n;
    argint(0, &n);
    800030a8:	fec40593          	addi	a1,s0,-20
    800030ac:	4501                	li	a0,0
    800030ae:	00000097          	auipc	ra,0x0
    800030b2:	f0e080e7          	jalr	-242(ra) # 80002fbc <argint>
    exit(n);
    800030b6:	fec42503          	lw	a0,-20(s0)
    800030ba:	fffff097          	auipc	ra,0xfffff
    800030be:	492080e7          	jalr	1170(ra) # 8000254c <exit>
    return 0; // not reached
}
    800030c2:	4501                	li	a0,0
    800030c4:	60e2                	ld	ra,24(sp)
    800030c6:	6442                	ld	s0,16(sp)
    800030c8:	6105                	addi	sp,sp,32
    800030ca:	8082                	ret

00000000800030cc <sys_getpid>:

uint64
sys_getpid(void)
{
    800030cc:	1141                	addi	sp,sp,-16
    800030ce:	e406                	sd	ra,8(sp)
    800030d0:	e022                	sd	s0,0(sp)
    800030d2:	0800                	addi	s0,sp,16
    return myproc()->pid;
    800030d4:	fffff097          	auipc	ra,0xfffff
    800030d8:	b80080e7          	jalr	-1152(ra) # 80001c54 <myproc>
}
    800030dc:	5908                	lw	a0,48(a0)
    800030de:	60a2                	ld	ra,8(sp)
    800030e0:	6402                	ld	s0,0(sp)
    800030e2:	0141                	addi	sp,sp,16
    800030e4:	8082                	ret

00000000800030e6 <sys_fork>:

uint64
sys_fork(void)
{
    800030e6:	1141                	addi	sp,sp,-16
    800030e8:	e406                	sd	ra,8(sp)
    800030ea:	e022                	sd	s0,0(sp)
    800030ec:	0800                	addi	s0,sp,16
    return fork();
    800030ee:	fffff097          	auipc	ra,0xfffff
    800030f2:	074080e7          	jalr	116(ra) # 80002162 <fork>
}
    800030f6:	60a2                	ld	ra,8(sp)
    800030f8:	6402                	ld	s0,0(sp)
    800030fa:	0141                	addi	sp,sp,16
    800030fc:	8082                	ret

00000000800030fe <sys_wait>:

uint64
sys_wait(void)
{
    800030fe:	1101                	addi	sp,sp,-32
    80003100:	ec06                	sd	ra,24(sp)
    80003102:	e822                	sd	s0,16(sp)
    80003104:	1000                	addi	s0,sp,32
    uint64 p;
    argaddr(0, &p);
    80003106:	fe840593          	addi	a1,s0,-24
    8000310a:	4501                	li	a0,0
    8000310c:	00000097          	auipc	ra,0x0
    80003110:	ed0080e7          	jalr	-304(ra) # 80002fdc <argaddr>
    return wait(p);
    80003114:	fe843503          	ld	a0,-24(s0)
    80003118:	fffff097          	auipc	ra,0xfffff
    8000311c:	5da080e7          	jalr	1498(ra) # 800026f2 <wait>
}
    80003120:	60e2                	ld	ra,24(sp)
    80003122:	6442                	ld	s0,16(sp)
    80003124:	6105                	addi	sp,sp,32
    80003126:	8082                	ret

0000000080003128 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80003128:	7179                	addi	sp,sp,-48
    8000312a:	f406                	sd	ra,40(sp)
    8000312c:	f022                	sd	s0,32(sp)
    8000312e:	ec26                	sd	s1,24(sp)
    80003130:	1800                	addi	s0,sp,48
    uint64 addr;
    int n;

    argint(0, &n);
    80003132:	fdc40593          	addi	a1,s0,-36
    80003136:	4501                	li	a0,0
    80003138:	00000097          	auipc	ra,0x0
    8000313c:	e84080e7          	jalr	-380(ra) # 80002fbc <argint>
    addr = myproc()->sz;
    80003140:	fffff097          	auipc	ra,0xfffff
    80003144:	b14080e7          	jalr	-1260(ra) # 80001c54 <myproc>
    80003148:	6924                	ld	s1,80(a0)
    if (growproc(n) < 0)
    8000314a:	fdc42503          	lw	a0,-36(s0)
    8000314e:	fffff097          	auipc	ra,0xfffff
    80003152:	e68080e7          	jalr	-408(ra) # 80001fb6 <growproc>
    80003156:	00054863          	bltz	a0,80003166 <sys_sbrk+0x3e>
        return -1;
    return addr;
}
    8000315a:	8526                	mv	a0,s1
    8000315c:	70a2                	ld	ra,40(sp)
    8000315e:	7402                	ld	s0,32(sp)
    80003160:	64e2                	ld	s1,24(sp)
    80003162:	6145                	addi	sp,sp,48
    80003164:	8082                	ret
        return -1;
    80003166:	54fd                	li	s1,-1
    80003168:	bfcd                	j	8000315a <sys_sbrk+0x32>

000000008000316a <sys_sleep>:

uint64
sys_sleep(void)
{
    8000316a:	7139                	addi	sp,sp,-64
    8000316c:	fc06                	sd	ra,56(sp)
    8000316e:	f822                	sd	s0,48(sp)
    80003170:	f426                	sd	s1,40(sp)
    80003172:	f04a                	sd	s2,32(sp)
    80003174:	ec4e                	sd	s3,24(sp)
    80003176:	0080                	addi	s0,sp,64
    int n;
    uint ticks0;

    argint(0, &n);
    80003178:	fcc40593          	addi	a1,s0,-52
    8000317c:	4501                	li	a0,0
    8000317e:	00000097          	auipc	ra,0x0
    80003182:	e3e080e7          	jalr	-450(ra) # 80002fbc <argint>
    acquire(&tickslock);
    80003186:	00014517          	auipc	a0,0x14
    8000318a:	aea50513          	addi	a0,a0,-1302 # 80016c70 <tickslock>
    8000318e:	ffffe097          	auipc	ra,0xffffe
    80003192:	a8a080e7          	jalr	-1398(ra) # 80000c18 <acquire>
    ticks0 = ticks;
    80003196:	00006917          	auipc	s2,0x6
    8000319a:	83a92903          	lw	s2,-1990(s2) # 800089d0 <ticks>
    while (ticks - ticks0 < n)
    8000319e:	fcc42783          	lw	a5,-52(s0)
    800031a2:	cf9d                	beqz	a5,800031e0 <sys_sleep+0x76>
        if (killed(myproc()))
        {
            release(&tickslock);
            return -1;
        }
        sleep(&ticks, &tickslock);
    800031a4:	00014997          	auipc	s3,0x14
    800031a8:	acc98993          	addi	s3,s3,-1332 # 80016c70 <tickslock>
    800031ac:	00006497          	auipc	s1,0x6
    800031b0:	82448493          	addi	s1,s1,-2012 # 800089d0 <ticks>
        if (killed(myproc()))
    800031b4:	fffff097          	auipc	ra,0xfffff
    800031b8:	aa0080e7          	jalr	-1376(ra) # 80001c54 <myproc>
    800031bc:	fffff097          	auipc	ra,0xfffff
    800031c0:	504080e7          	jalr	1284(ra) # 800026c0 <killed>
    800031c4:	ed15                	bnez	a0,80003200 <sys_sleep+0x96>
        sleep(&ticks, &tickslock);
    800031c6:	85ce                	mv	a1,s3
    800031c8:	8526                	mv	a0,s1
    800031ca:	fffff097          	auipc	ra,0xfffff
    800031ce:	24e080e7          	jalr	590(ra) # 80002418 <sleep>
    while (ticks - ticks0 < n)
    800031d2:	409c                	lw	a5,0(s1)
    800031d4:	412787bb          	subw	a5,a5,s2
    800031d8:	fcc42703          	lw	a4,-52(s0)
    800031dc:	fce7ece3          	bltu	a5,a4,800031b4 <sys_sleep+0x4a>
    }
    release(&tickslock);
    800031e0:	00014517          	auipc	a0,0x14
    800031e4:	a9050513          	addi	a0,a0,-1392 # 80016c70 <tickslock>
    800031e8:	ffffe097          	auipc	ra,0xffffe
    800031ec:	ae4080e7          	jalr	-1308(ra) # 80000ccc <release>
    return 0;
    800031f0:	4501                	li	a0,0
}
    800031f2:	70e2                	ld	ra,56(sp)
    800031f4:	7442                	ld	s0,48(sp)
    800031f6:	74a2                	ld	s1,40(sp)
    800031f8:	7902                	ld	s2,32(sp)
    800031fa:	69e2                	ld	s3,24(sp)
    800031fc:	6121                	addi	sp,sp,64
    800031fe:	8082                	ret
            release(&tickslock);
    80003200:	00014517          	auipc	a0,0x14
    80003204:	a7050513          	addi	a0,a0,-1424 # 80016c70 <tickslock>
    80003208:	ffffe097          	auipc	ra,0xffffe
    8000320c:	ac4080e7          	jalr	-1340(ra) # 80000ccc <release>
            return -1;
    80003210:	557d                	li	a0,-1
    80003212:	b7c5                	j	800031f2 <sys_sleep+0x88>

0000000080003214 <sys_kill>:

uint64
sys_kill(void)
{
    80003214:	1101                	addi	sp,sp,-32
    80003216:	ec06                	sd	ra,24(sp)
    80003218:	e822                	sd	s0,16(sp)
    8000321a:	1000                	addi	s0,sp,32
    int pid;

    argint(0, &pid);
    8000321c:	fec40593          	addi	a1,s0,-20
    80003220:	4501                	li	a0,0
    80003222:	00000097          	auipc	ra,0x0
    80003226:	d9a080e7          	jalr	-614(ra) # 80002fbc <argint>
    return kill(pid);
    8000322a:	fec42503          	lw	a0,-20(s0)
    8000322e:	fffff097          	auipc	ra,0xfffff
    80003232:	3f4080e7          	jalr	1012(ra) # 80002622 <kill>
}
    80003236:	60e2                	ld	ra,24(sp)
    80003238:	6442                	ld	s0,16(sp)
    8000323a:	6105                	addi	sp,sp,32
    8000323c:	8082                	ret

000000008000323e <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    8000323e:	1101                	addi	sp,sp,-32
    80003240:	ec06                	sd	ra,24(sp)
    80003242:	e822                	sd	s0,16(sp)
    80003244:	e426                	sd	s1,8(sp)
    80003246:	1000                	addi	s0,sp,32
    uint xticks;

    acquire(&tickslock);
    80003248:	00014517          	auipc	a0,0x14
    8000324c:	a2850513          	addi	a0,a0,-1496 # 80016c70 <tickslock>
    80003250:	ffffe097          	auipc	ra,0xffffe
    80003254:	9c8080e7          	jalr	-1592(ra) # 80000c18 <acquire>
    xticks = ticks;
    80003258:	00005497          	auipc	s1,0x5
    8000325c:	7784a483          	lw	s1,1912(s1) # 800089d0 <ticks>
    release(&tickslock);
    80003260:	00014517          	auipc	a0,0x14
    80003264:	a1050513          	addi	a0,a0,-1520 # 80016c70 <tickslock>
    80003268:	ffffe097          	auipc	ra,0xffffe
    8000326c:	a64080e7          	jalr	-1436(ra) # 80000ccc <release>
    return xticks;
}
    80003270:	02049513          	slli	a0,s1,0x20
    80003274:	9101                	srli	a0,a0,0x20
    80003276:	60e2                	ld	ra,24(sp)
    80003278:	6442                	ld	s0,16(sp)
    8000327a:	64a2                	ld	s1,8(sp)
    8000327c:	6105                	addi	sp,sp,32
    8000327e:	8082                	ret

0000000080003280 <sys_ps>:

void *
sys_ps(void)
{
    80003280:	1101                	addi	sp,sp,-32
    80003282:	ec06                	sd	ra,24(sp)
    80003284:	e822                	sd	s0,16(sp)
    80003286:	1000                	addi	s0,sp,32
    int start = 0, count = 0;
    80003288:	fe042623          	sw	zero,-20(s0)
    8000328c:	fe042423          	sw	zero,-24(s0)
    argint(0, &start);
    80003290:	fec40593          	addi	a1,s0,-20
    80003294:	4501                	li	a0,0
    80003296:	00000097          	auipc	ra,0x0
    8000329a:	d26080e7          	jalr	-730(ra) # 80002fbc <argint>
    argint(1, &count);
    8000329e:	fe840593          	addi	a1,s0,-24
    800032a2:	4505                	li	a0,1
    800032a4:	00000097          	auipc	ra,0x0
    800032a8:	d18080e7          	jalr	-744(ra) # 80002fbc <argint>
    return ps((uint8)start, (uint8)count);
    800032ac:	fe844583          	lbu	a1,-24(s0)
    800032b0:	fec44503          	lbu	a0,-20(s0)
    800032b4:	fffff097          	auipc	ra,0xfffff
    800032b8:	d5e080e7          	jalr	-674(ra) # 80002012 <ps>
}
    800032bc:	60e2                	ld	ra,24(sp)
    800032be:	6442                	ld	s0,16(sp)
    800032c0:	6105                	addi	sp,sp,32
    800032c2:	8082                	ret

00000000800032c4 <sys_schedls>:

uint64 sys_schedls(void)
{
    800032c4:	1141                	addi	sp,sp,-16
    800032c6:	e406                	sd	ra,8(sp)
    800032c8:	e022                	sd	s0,0(sp)
    800032ca:	0800                	addi	s0,sp,16
    schedls();
    800032cc:	fffff097          	auipc	ra,0xfffff
    800032d0:	6b0080e7          	jalr	1712(ra) # 8000297c <schedls>
    return 0;
}
    800032d4:	4501                	li	a0,0
    800032d6:	60a2                	ld	ra,8(sp)
    800032d8:	6402                	ld	s0,0(sp)
    800032da:	0141                	addi	sp,sp,16
    800032dc:	8082                	ret

00000000800032de <sys_schedset>:

uint64 sys_schedset(void)
{
    800032de:	1101                	addi	sp,sp,-32
    800032e0:	ec06                	sd	ra,24(sp)
    800032e2:	e822                	sd	s0,16(sp)
    800032e4:	1000                	addi	s0,sp,32
    int id = 0;
    800032e6:	fe042623          	sw	zero,-20(s0)
    argint(0, &id);
    800032ea:	fec40593          	addi	a1,s0,-20
    800032ee:	4501                	li	a0,0
    800032f0:	00000097          	auipc	ra,0x0
    800032f4:	ccc080e7          	jalr	-820(ra) # 80002fbc <argint>
    schedset(id);
    800032f8:	fec42503          	lw	a0,-20(s0)
    800032fc:	fffff097          	auipc	ra,0xfffff
    80003300:	76c080e7          	jalr	1900(ra) # 80002a68 <schedset>
    return 0;
    80003304:	4501                	li	a0,0
    80003306:	60e2                	ld	ra,24(sp)
    80003308:	6442                	ld	s0,16(sp)
    8000330a:	6105                	addi	sp,sp,32
    8000330c:	8082                	ret

000000008000330e <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    8000330e:	7179                	addi	sp,sp,-48
    80003310:	f406                	sd	ra,40(sp)
    80003312:	f022                	sd	s0,32(sp)
    80003314:	ec26                	sd	s1,24(sp)
    80003316:	e84a                	sd	s2,16(sp)
    80003318:	e44e                	sd	s3,8(sp)
    8000331a:	e052                	sd	s4,0(sp)
    8000331c:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    8000331e:	00005597          	auipc	a1,0x5
    80003322:	2a258593          	addi	a1,a1,674 # 800085c0 <syscalls+0xc8>
    80003326:	00014517          	auipc	a0,0x14
    8000332a:	96250513          	addi	a0,a0,-1694 # 80016c88 <bcache>
    8000332e:	ffffe097          	auipc	ra,0xffffe
    80003332:	85a080e7          	jalr	-1958(ra) # 80000b88 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80003336:	0001c797          	auipc	a5,0x1c
    8000333a:	95278793          	addi	a5,a5,-1710 # 8001ec88 <bcache+0x8000>
    8000333e:	0001c717          	auipc	a4,0x1c
    80003342:	bb270713          	addi	a4,a4,-1102 # 8001eef0 <bcache+0x8268>
    80003346:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    8000334a:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000334e:	00014497          	auipc	s1,0x14
    80003352:	95248493          	addi	s1,s1,-1710 # 80016ca0 <bcache+0x18>
    b->next = bcache.head.next;
    80003356:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80003358:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    8000335a:	00005a17          	auipc	s4,0x5
    8000335e:	26ea0a13          	addi	s4,s4,622 # 800085c8 <syscalls+0xd0>
    b->next = bcache.head.next;
    80003362:	2b893783          	ld	a5,696(s2)
    80003366:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80003368:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    8000336c:	85d2                	mv	a1,s4
    8000336e:	01048513          	addi	a0,s1,16
    80003372:	00001097          	auipc	ra,0x1
    80003376:	496080e7          	jalr	1174(ra) # 80004808 <initsleeplock>
    bcache.head.next->prev = b;
    8000337a:	2b893783          	ld	a5,696(s2)
    8000337e:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80003380:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80003384:	45848493          	addi	s1,s1,1112
    80003388:	fd349de3          	bne	s1,s3,80003362 <binit+0x54>
  }
}
    8000338c:	70a2                	ld	ra,40(sp)
    8000338e:	7402                	ld	s0,32(sp)
    80003390:	64e2                	ld	s1,24(sp)
    80003392:	6942                	ld	s2,16(sp)
    80003394:	69a2                	ld	s3,8(sp)
    80003396:	6a02                	ld	s4,0(sp)
    80003398:	6145                	addi	sp,sp,48
    8000339a:	8082                	ret

000000008000339c <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    8000339c:	7179                	addi	sp,sp,-48
    8000339e:	f406                	sd	ra,40(sp)
    800033a0:	f022                	sd	s0,32(sp)
    800033a2:	ec26                	sd	s1,24(sp)
    800033a4:	e84a                	sd	s2,16(sp)
    800033a6:	e44e                	sd	s3,8(sp)
    800033a8:	1800                	addi	s0,sp,48
    800033aa:	892a                	mv	s2,a0
    800033ac:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    800033ae:	00014517          	auipc	a0,0x14
    800033b2:	8da50513          	addi	a0,a0,-1830 # 80016c88 <bcache>
    800033b6:	ffffe097          	auipc	ra,0xffffe
    800033ba:	862080e7          	jalr	-1950(ra) # 80000c18 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800033be:	0001c497          	auipc	s1,0x1c
    800033c2:	b824b483          	ld	s1,-1150(s1) # 8001ef40 <bcache+0x82b8>
    800033c6:	0001c797          	auipc	a5,0x1c
    800033ca:	b2a78793          	addi	a5,a5,-1238 # 8001eef0 <bcache+0x8268>
    800033ce:	02f48f63          	beq	s1,a5,8000340c <bread+0x70>
    800033d2:	873e                	mv	a4,a5
    800033d4:	a021                	j	800033dc <bread+0x40>
    800033d6:	68a4                	ld	s1,80(s1)
    800033d8:	02e48a63          	beq	s1,a4,8000340c <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    800033dc:	449c                	lw	a5,8(s1)
    800033de:	ff279ce3          	bne	a5,s2,800033d6 <bread+0x3a>
    800033e2:	44dc                	lw	a5,12(s1)
    800033e4:	ff3799e3          	bne	a5,s3,800033d6 <bread+0x3a>
      b->refcnt++;
    800033e8:	40bc                	lw	a5,64(s1)
    800033ea:	2785                	addiw	a5,a5,1
    800033ec:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800033ee:	00014517          	auipc	a0,0x14
    800033f2:	89a50513          	addi	a0,a0,-1894 # 80016c88 <bcache>
    800033f6:	ffffe097          	auipc	ra,0xffffe
    800033fa:	8d6080e7          	jalr	-1834(ra) # 80000ccc <release>
      acquiresleep(&b->lock);
    800033fe:	01048513          	addi	a0,s1,16
    80003402:	00001097          	auipc	ra,0x1
    80003406:	440080e7          	jalr	1088(ra) # 80004842 <acquiresleep>
      return b;
    8000340a:	a8b9                	j	80003468 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    8000340c:	0001c497          	auipc	s1,0x1c
    80003410:	b2c4b483          	ld	s1,-1236(s1) # 8001ef38 <bcache+0x82b0>
    80003414:	0001c797          	auipc	a5,0x1c
    80003418:	adc78793          	addi	a5,a5,-1316 # 8001eef0 <bcache+0x8268>
    8000341c:	00f48863          	beq	s1,a5,8000342c <bread+0x90>
    80003420:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    80003422:	40bc                	lw	a5,64(s1)
    80003424:	cf81                	beqz	a5,8000343c <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80003426:	64a4                	ld	s1,72(s1)
    80003428:	fee49de3          	bne	s1,a4,80003422 <bread+0x86>
  panic("bget: no buffers");
    8000342c:	00005517          	auipc	a0,0x5
    80003430:	1a450513          	addi	a0,a0,420 # 800085d0 <syscalls+0xd8>
    80003434:	ffffd097          	auipc	ra,0xffffd
    80003438:	14e080e7          	jalr	334(ra) # 80000582 <panic>
      b->dev = dev;
    8000343c:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80003440:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80003444:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80003448:	4785                	li	a5,1
    8000344a:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000344c:	00014517          	auipc	a0,0x14
    80003450:	83c50513          	addi	a0,a0,-1988 # 80016c88 <bcache>
    80003454:	ffffe097          	auipc	ra,0xffffe
    80003458:	878080e7          	jalr	-1928(ra) # 80000ccc <release>
      acquiresleep(&b->lock);
    8000345c:	01048513          	addi	a0,s1,16
    80003460:	00001097          	auipc	ra,0x1
    80003464:	3e2080e7          	jalr	994(ra) # 80004842 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80003468:	409c                	lw	a5,0(s1)
    8000346a:	cb89                	beqz	a5,8000347c <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    8000346c:	8526                	mv	a0,s1
    8000346e:	70a2                	ld	ra,40(sp)
    80003470:	7402                	ld	s0,32(sp)
    80003472:	64e2                	ld	s1,24(sp)
    80003474:	6942                	ld	s2,16(sp)
    80003476:	69a2                	ld	s3,8(sp)
    80003478:	6145                	addi	sp,sp,48
    8000347a:	8082                	ret
    virtio_disk_rw(b, 0);
    8000347c:	4581                	li	a1,0
    8000347e:	8526                	mv	a0,s1
    80003480:	00003097          	auipc	ra,0x3
    80003484:	f82080e7          	jalr	-126(ra) # 80006402 <virtio_disk_rw>
    b->valid = 1;
    80003488:	4785                	li	a5,1
    8000348a:	c09c                	sw	a5,0(s1)
  return b;
    8000348c:	b7c5                	j	8000346c <bread+0xd0>

000000008000348e <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    8000348e:	1101                	addi	sp,sp,-32
    80003490:	ec06                	sd	ra,24(sp)
    80003492:	e822                	sd	s0,16(sp)
    80003494:	e426                	sd	s1,8(sp)
    80003496:	1000                	addi	s0,sp,32
    80003498:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000349a:	0541                	addi	a0,a0,16
    8000349c:	00001097          	auipc	ra,0x1
    800034a0:	440080e7          	jalr	1088(ra) # 800048dc <holdingsleep>
    800034a4:	cd01                	beqz	a0,800034bc <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    800034a6:	4585                	li	a1,1
    800034a8:	8526                	mv	a0,s1
    800034aa:	00003097          	auipc	ra,0x3
    800034ae:	f58080e7          	jalr	-168(ra) # 80006402 <virtio_disk_rw>
}
    800034b2:	60e2                	ld	ra,24(sp)
    800034b4:	6442                	ld	s0,16(sp)
    800034b6:	64a2                	ld	s1,8(sp)
    800034b8:	6105                	addi	sp,sp,32
    800034ba:	8082                	ret
    panic("bwrite");
    800034bc:	00005517          	auipc	a0,0x5
    800034c0:	12c50513          	addi	a0,a0,300 # 800085e8 <syscalls+0xf0>
    800034c4:	ffffd097          	auipc	ra,0xffffd
    800034c8:	0be080e7          	jalr	190(ra) # 80000582 <panic>

00000000800034cc <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800034cc:	1101                	addi	sp,sp,-32
    800034ce:	ec06                	sd	ra,24(sp)
    800034d0:	e822                	sd	s0,16(sp)
    800034d2:	e426                	sd	s1,8(sp)
    800034d4:	e04a                	sd	s2,0(sp)
    800034d6:	1000                	addi	s0,sp,32
    800034d8:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800034da:	01050913          	addi	s2,a0,16
    800034de:	854a                	mv	a0,s2
    800034e0:	00001097          	auipc	ra,0x1
    800034e4:	3fc080e7          	jalr	1020(ra) # 800048dc <holdingsleep>
    800034e8:	c925                	beqz	a0,80003558 <brelse+0x8c>
    panic("brelse");

  releasesleep(&b->lock);
    800034ea:	854a                	mv	a0,s2
    800034ec:	00001097          	auipc	ra,0x1
    800034f0:	3ac080e7          	jalr	940(ra) # 80004898 <releasesleep>

  acquire(&bcache.lock);
    800034f4:	00013517          	auipc	a0,0x13
    800034f8:	79450513          	addi	a0,a0,1940 # 80016c88 <bcache>
    800034fc:	ffffd097          	auipc	ra,0xffffd
    80003500:	71c080e7          	jalr	1820(ra) # 80000c18 <acquire>
  b->refcnt--;
    80003504:	40bc                	lw	a5,64(s1)
    80003506:	37fd                	addiw	a5,a5,-1
    80003508:	0007871b          	sext.w	a4,a5
    8000350c:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    8000350e:	e71d                	bnez	a4,8000353c <brelse+0x70>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80003510:	68b8                	ld	a4,80(s1)
    80003512:	64bc                	ld	a5,72(s1)
    80003514:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    80003516:	68b8                	ld	a4,80(s1)
    80003518:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    8000351a:	0001b797          	auipc	a5,0x1b
    8000351e:	76e78793          	addi	a5,a5,1902 # 8001ec88 <bcache+0x8000>
    80003522:	2b87b703          	ld	a4,696(a5)
    80003526:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80003528:	0001c717          	auipc	a4,0x1c
    8000352c:	9c870713          	addi	a4,a4,-1592 # 8001eef0 <bcache+0x8268>
    80003530:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80003532:	2b87b703          	ld	a4,696(a5)
    80003536:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80003538:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    8000353c:	00013517          	auipc	a0,0x13
    80003540:	74c50513          	addi	a0,a0,1868 # 80016c88 <bcache>
    80003544:	ffffd097          	auipc	ra,0xffffd
    80003548:	788080e7          	jalr	1928(ra) # 80000ccc <release>
}
    8000354c:	60e2                	ld	ra,24(sp)
    8000354e:	6442                	ld	s0,16(sp)
    80003550:	64a2                	ld	s1,8(sp)
    80003552:	6902                	ld	s2,0(sp)
    80003554:	6105                	addi	sp,sp,32
    80003556:	8082                	ret
    panic("brelse");
    80003558:	00005517          	auipc	a0,0x5
    8000355c:	09850513          	addi	a0,a0,152 # 800085f0 <syscalls+0xf8>
    80003560:	ffffd097          	auipc	ra,0xffffd
    80003564:	022080e7          	jalr	34(ra) # 80000582 <panic>

0000000080003568 <bpin>:

void
bpin(struct buf *b) {
    80003568:	1101                	addi	sp,sp,-32
    8000356a:	ec06                	sd	ra,24(sp)
    8000356c:	e822                	sd	s0,16(sp)
    8000356e:	e426                	sd	s1,8(sp)
    80003570:	1000                	addi	s0,sp,32
    80003572:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80003574:	00013517          	auipc	a0,0x13
    80003578:	71450513          	addi	a0,a0,1812 # 80016c88 <bcache>
    8000357c:	ffffd097          	auipc	ra,0xffffd
    80003580:	69c080e7          	jalr	1692(ra) # 80000c18 <acquire>
  b->refcnt++;
    80003584:	40bc                	lw	a5,64(s1)
    80003586:	2785                	addiw	a5,a5,1
    80003588:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000358a:	00013517          	auipc	a0,0x13
    8000358e:	6fe50513          	addi	a0,a0,1790 # 80016c88 <bcache>
    80003592:	ffffd097          	auipc	ra,0xffffd
    80003596:	73a080e7          	jalr	1850(ra) # 80000ccc <release>
}
    8000359a:	60e2                	ld	ra,24(sp)
    8000359c:	6442                	ld	s0,16(sp)
    8000359e:	64a2                	ld	s1,8(sp)
    800035a0:	6105                	addi	sp,sp,32
    800035a2:	8082                	ret

00000000800035a4 <bunpin>:

void
bunpin(struct buf *b) {
    800035a4:	1101                	addi	sp,sp,-32
    800035a6:	ec06                	sd	ra,24(sp)
    800035a8:	e822                	sd	s0,16(sp)
    800035aa:	e426                	sd	s1,8(sp)
    800035ac:	1000                	addi	s0,sp,32
    800035ae:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800035b0:	00013517          	auipc	a0,0x13
    800035b4:	6d850513          	addi	a0,a0,1752 # 80016c88 <bcache>
    800035b8:	ffffd097          	auipc	ra,0xffffd
    800035bc:	660080e7          	jalr	1632(ra) # 80000c18 <acquire>
  b->refcnt--;
    800035c0:	40bc                	lw	a5,64(s1)
    800035c2:	37fd                	addiw	a5,a5,-1
    800035c4:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800035c6:	00013517          	auipc	a0,0x13
    800035ca:	6c250513          	addi	a0,a0,1730 # 80016c88 <bcache>
    800035ce:	ffffd097          	auipc	ra,0xffffd
    800035d2:	6fe080e7          	jalr	1790(ra) # 80000ccc <release>
}
    800035d6:	60e2                	ld	ra,24(sp)
    800035d8:	6442                	ld	s0,16(sp)
    800035da:	64a2                	ld	s1,8(sp)
    800035dc:	6105                	addi	sp,sp,32
    800035de:	8082                	ret

00000000800035e0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800035e0:	1101                	addi	sp,sp,-32
    800035e2:	ec06                	sd	ra,24(sp)
    800035e4:	e822                	sd	s0,16(sp)
    800035e6:	e426                	sd	s1,8(sp)
    800035e8:	e04a                	sd	s2,0(sp)
    800035ea:	1000                	addi	s0,sp,32
    800035ec:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    800035ee:	00d5d59b          	srliw	a1,a1,0xd
    800035f2:	0001c797          	auipc	a5,0x1c
    800035f6:	d727a783          	lw	a5,-654(a5) # 8001f364 <sb+0x1c>
    800035fa:	9dbd                	addw	a1,a1,a5
    800035fc:	00000097          	auipc	ra,0x0
    80003600:	da0080e7          	jalr	-608(ra) # 8000339c <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80003604:	0074f713          	andi	a4,s1,7
    80003608:	4785                	li	a5,1
    8000360a:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    8000360e:	14ce                	slli	s1,s1,0x33
    80003610:	90d9                	srli	s1,s1,0x36
    80003612:	00950733          	add	a4,a0,s1
    80003616:	05874703          	lbu	a4,88(a4)
    8000361a:	00e7f6b3          	and	a3,a5,a4
    8000361e:	c69d                	beqz	a3,8000364c <bfree+0x6c>
    80003620:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80003622:	94aa                	add	s1,s1,a0
    80003624:	fff7c793          	not	a5,a5
    80003628:	8f7d                	and	a4,a4,a5
    8000362a:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    8000362e:	00001097          	auipc	ra,0x1
    80003632:	0f6080e7          	jalr	246(ra) # 80004724 <log_write>
  brelse(bp);
    80003636:	854a                	mv	a0,s2
    80003638:	00000097          	auipc	ra,0x0
    8000363c:	e94080e7          	jalr	-364(ra) # 800034cc <brelse>
}
    80003640:	60e2                	ld	ra,24(sp)
    80003642:	6442                	ld	s0,16(sp)
    80003644:	64a2                	ld	s1,8(sp)
    80003646:	6902                	ld	s2,0(sp)
    80003648:	6105                	addi	sp,sp,32
    8000364a:	8082                	ret
    panic("freeing free block");
    8000364c:	00005517          	auipc	a0,0x5
    80003650:	fac50513          	addi	a0,a0,-84 # 800085f8 <syscalls+0x100>
    80003654:	ffffd097          	auipc	ra,0xffffd
    80003658:	f2e080e7          	jalr	-210(ra) # 80000582 <panic>

000000008000365c <balloc>:
{
    8000365c:	711d                	addi	sp,sp,-96
    8000365e:	ec86                	sd	ra,88(sp)
    80003660:	e8a2                	sd	s0,80(sp)
    80003662:	e4a6                	sd	s1,72(sp)
    80003664:	e0ca                	sd	s2,64(sp)
    80003666:	fc4e                	sd	s3,56(sp)
    80003668:	f852                	sd	s4,48(sp)
    8000366a:	f456                	sd	s5,40(sp)
    8000366c:	f05a                	sd	s6,32(sp)
    8000366e:	ec5e                	sd	s7,24(sp)
    80003670:	e862                	sd	s8,16(sp)
    80003672:	e466                	sd	s9,8(sp)
    80003674:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80003676:	0001c797          	auipc	a5,0x1c
    8000367a:	cd67a783          	lw	a5,-810(a5) # 8001f34c <sb+0x4>
    8000367e:	cff5                	beqz	a5,8000377a <balloc+0x11e>
    80003680:	8baa                	mv	s7,a0
    80003682:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80003684:	0001cb17          	auipc	s6,0x1c
    80003688:	cc4b0b13          	addi	s6,s6,-828 # 8001f348 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000368c:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    8000368e:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003690:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80003692:	6c89                	lui	s9,0x2
    80003694:	a061                	j	8000371c <balloc+0xc0>
        bp->data[bi/8] |= m;  // Mark block in use.
    80003696:	97ca                	add	a5,a5,s2
    80003698:	8e55                	or	a2,a2,a3
    8000369a:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    8000369e:	854a                	mv	a0,s2
    800036a0:	00001097          	auipc	ra,0x1
    800036a4:	084080e7          	jalr	132(ra) # 80004724 <log_write>
        brelse(bp);
    800036a8:	854a                	mv	a0,s2
    800036aa:	00000097          	auipc	ra,0x0
    800036ae:	e22080e7          	jalr	-478(ra) # 800034cc <brelse>
  bp = bread(dev, bno);
    800036b2:	85a6                	mv	a1,s1
    800036b4:	855e                	mv	a0,s7
    800036b6:	00000097          	auipc	ra,0x0
    800036ba:	ce6080e7          	jalr	-794(ra) # 8000339c <bread>
    800036be:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    800036c0:	40000613          	li	a2,1024
    800036c4:	4581                	li	a1,0
    800036c6:	05850513          	addi	a0,a0,88
    800036ca:	ffffd097          	auipc	ra,0xffffd
    800036ce:	64a080e7          	jalr	1610(ra) # 80000d14 <memset>
  log_write(bp);
    800036d2:	854a                	mv	a0,s2
    800036d4:	00001097          	auipc	ra,0x1
    800036d8:	050080e7          	jalr	80(ra) # 80004724 <log_write>
  brelse(bp);
    800036dc:	854a                	mv	a0,s2
    800036de:	00000097          	auipc	ra,0x0
    800036e2:	dee080e7          	jalr	-530(ra) # 800034cc <brelse>
}
    800036e6:	8526                	mv	a0,s1
    800036e8:	60e6                	ld	ra,88(sp)
    800036ea:	6446                	ld	s0,80(sp)
    800036ec:	64a6                	ld	s1,72(sp)
    800036ee:	6906                	ld	s2,64(sp)
    800036f0:	79e2                	ld	s3,56(sp)
    800036f2:	7a42                	ld	s4,48(sp)
    800036f4:	7aa2                	ld	s5,40(sp)
    800036f6:	7b02                	ld	s6,32(sp)
    800036f8:	6be2                	ld	s7,24(sp)
    800036fa:	6c42                	ld	s8,16(sp)
    800036fc:	6ca2                	ld	s9,8(sp)
    800036fe:	6125                	addi	sp,sp,96
    80003700:	8082                	ret
    brelse(bp);
    80003702:	854a                	mv	a0,s2
    80003704:	00000097          	auipc	ra,0x0
    80003708:	dc8080e7          	jalr	-568(ra) # 800034cc <brelse>
  for(b = 0; b < sb.size; b += BPB){
    8000370c:	015c87bb          	addw	a5,s9,s5
    80003710:	00078a9b          	sext.w	s5,a5
    80003714:	004b2703          	lw	a4,4(s6)
    80003718:	06eaf163          	bgeu	s5,a4,8000377a <balloc+0x11e>
    bp = bread(dev, BBLOCK(b, sb));
    8000371c:	41fad79b          	sraiw	a5,s5,0x1f
    80003720:	0137d79b          	srliw	a5,a5,0x13
    80003724:	015787bb          	addw	a5,a5,s5
    80003728:	40d7d79b          	sraiw	a5,a5,0xd
    8000372c:	01cb2583          	lw	a1,28(s6)
    80003730:	9dbd                	addw	a1,a1,a5
    80003732:	855e                	mv	a0,s7
    80003734:	00000097          	auipc	ra,0x0
    80003738:	c68080e7          	jalr	-920(ra) # 8000339c <bread>
    8000373c:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000373e:	004b2503          	lw	a0,4(s6)
    80003742:	000a849b          	sext.w	s1,s5
    80003746:	8762                	mv	a4,s8
    80003748:	faa4fde3          	bgeu	s1,a0,80003702 <balloc+0xa6>
      m = 1 << (bi % 8);
    8000374c:	00777693          	andi	a3,a4,7
    80003750:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80003754:	41f7579b          	sraiw	a5,a4,0x1f
    80003758:	01d7d79b          	srliw	a5,a5,0x1d
    8000375c:	9fb9                	addw	a5,a5,a4
    8000375e:	4037d79b          	sraiw	a5,a5,0x3
    80003762:	00f90633          	add	a2,s2,a5
    80003766:	05864603          	lbu	a2,88(a2)
    8000376a:	00c6f5b3          	and	a1,a3,a2
    8000376e:	d585                	beqz	a1,80003696 <balloc+0x3a>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003770:	2705                	addiw	a4,a4,1
    80003772:	2485                	addiw	s1,s1,1
    80003774:	fd471ae3          	bne	a4,s4,80003748 <balloc+0xec>
    80003778:	b769                	j	80003702 <balloc+0xa6>
  printf("balloc: out of blocks\n");
    8000377a:	00005517          	auipc	a0,0x5
    8000377e:	e9650513          	addi	a0,a0,-362 # 80008610 <syscalls+0x118>
    80003782:	ffffd097          	auipc	ra,0xffffd
    80003786:	e4a080e7          	jalr	-438(ra) # 800005cc <printf>
  return 0;
    8000378a:	4481                	li	s1,0
    8000378c:	bfa9                	j	800036e6 <balloc+0x8a>

000000008000378e <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    8000378e:	7179                	addi	sp,sp,-48
    80003790:	f406                	sd	ra,40(sp)
    80003792:	f022                	sd	s0,32(sp)
    80003794:	ec26                	sd	s1,24(sp)
    80003796:	e84a                	sd	s2,16(sp)
    80003798:	e44e                	sd	s3,8(sp)
    8000379a:	e052                	sd	s4,0(sp)
    8000379c:	1800                	addi	s0,sp,48
    8000379e:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800037a0:	47ad                	li	a5,11
    800037a2:	02b7e863          	bltu	a5,a1,800037d2 <bmap+0x44>
    if((addr = ip->addrs[bn]) == 0){
    800037a6:	02059793          	slli	a5,a1,0x20
    800037aa:	01e7d593          	srli	a1,a5,0x1e
    800037ae:	00b504b3          	add	s1,a0,a1
    800037b2:	0504a903          	lw	s2,80(s1)
    800037b6:	06091e63          	bnez	s2,80003832 <bmap+0xa4>
      addr = balloc(ip->dev);
    800037ba:	4108                	lw	a0,0(a0)
    800037bc:	00000097          	auipc	ra,0x0
    800037c0:	ea0080e7          	jalr	-352(ra) # 8000365c <balloc>
    800037c4:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    800037c8:	06090563          	beqz	s2,80003832 <bmap+0xa4>
        return 0;
      ip->addrs[bn] = addr;
    800037cc:	0524a823          	sw	s2,80(s1)
    800037d0:	a08d                	j	80003832 <bmap+0xa4>
    }
    return addr;
  }
  bn -= NDIRECT;
    800037d2:	ff45849b          	addiw	s1,a1,-12
    800037d6:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    800037da:	0ff00793          	li	a5,255
    800037de:	08e7e563          	bltu	a5,a4,80003868 <bmap+0xda>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    800037e2:	08052903          	lw	s2,128(a0)
    800037e6:	00091d63          	bnez	s2,80003800 <bmap+0x72>
      addr = balloc(ip->dev);
    800037ea:	4108                	lw	a0,0(a0)
    800037ec:	00000097          	auipc	ra,0x0
    800037f0:	e70080e7          	jalr	-400(ra) # 8000365c <balloc>
    800037f4:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    800037f8:	02090d63          	beqz	s2,80003832 <bmap+0xa4>
        return 0;
      ip->addrs[NDIRECT] = addr;
    800037fc:	0929a023          	sw	s2,128(s3)
    }
    bp = bread(ip->dev, addr);
    80003800:	85ca                	mv	a1,s2
    80003802:	0009a503          	lw	a0,0(s3)
    80003806:	00000097          	auipc	ra,0x0
    8000380a:	b96080e7          	jalr	-1130(ra) # 8000339c <bread>
    8000380e:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80003810:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    80003814:	02049713          	slli	a4,s1,0x20
    80003818:	01e75593          	srli	a1,a4,0x1e
    8000381c:	00b784b3          	add	s1,a5,a1
    80003820:	0004a903          	lw	s2,0(s1)
    80003824:	02090063          	beqz	s2,80003844 <bmap+0xb6>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    80003828:	8552                	mv	a0,s4
    8000382a:	00000097          	auipc	ra,0x0
    8000382e:	ca2080e7          	jalr	-862(ra) # 800034cc <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    80003832:	854a                	mv	a0,s2
    80003834:	70a2                	ld	ra,40(sp)
    80003836:	7402                	ld	s0,32(sp)
    80003838:	64e2                	ld	s1,24(sp)
    8000383a:	6942                	ld	s2,16(sp)
    8000383c:	69a2                	ld	s3,8(sp)
    8000383e:	6a02                	ld	s4,0(sp)
    80003840:	6145                	addi	sp,sp,48
    80003842:	8082                	ret
      addr = balloc(ip->dev);
    80003844:	0009a503          	lw	a0,0(s3)
    80003848:	00000097          	auipc	ra,0x0
    8000384c:	e14080e7          	jalr	-492(ra) # 8000365c <balloc>
    80003850:	0005091b          	sext.w	s2,a0
      if(addr){
    80003854:	fc090ae3          	beqz	s2,80003828 <bmap+0x9a>
        a[bn] = addr;
    80003858:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    8000385c:	8552                	mv	a0,s4
    8000385e:	00001097          	auipc	ra,0x1
    80003862:	ec6080e7          	jalr	-314(ra) # 80004724 <log_write>
    80003866:	b7c9                	j	80003828 <bmap+0x9a>
  panic("bmap: out of range");
    80003868:	00005517          	auipc	a0,0x5
    8000386c:	dc050513          	addi	a0,a0,-576 # 80008628 <syscalls+0x130>
    80003870:	ffffd097          	auipc	ra,0xffffd
    80003874:	d12080e7          	jalr	-750(ra) # 80000582 <panic>

0000000080003878 <iget>:
{
    80003878:	7179                	addi	sp,sp,-48
    8000387a:	f406                	sd	ra,40(sp)
    8000387c:	f022                	sd	s0,32(sp)
    8000387e:	ec26                	sd	s1,24(sp)
    80003880:	e84a                	sd	s2,16(sp)
    80003882:	e44e                	sd	s3,8(sp)
    80003884:	e052                	sd	s4,0(sp)
    80003886:	1800                	addi	s0,sp,48
    80003888:	89aa                	mv	s3,a0
    8000388a:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    8000388c:	0001c517          	auipc	a0,0x1c
    80003890:	adc50513          	addi	a0,a0,-1316 # 8001f368 <itable>
    80003894:	ffffd097          	auipc	ra,0xffffd
    80003898:	384080e7          	jalr	900(ra) # 80000c18 <acquire>
  empty = 0;
    8000389c:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    8000389e:	0001c497          	auipc	s1,0x1c
    800038a2:	ae248493          	addi	s1,s1,-1310 # 8001f380 <itable+0x18>
    800038a6:	0001d697          	auipc	a3,0x1d
    800038aa:	56a68693          	addi	a3,a3,1386 # 80020e10 <log>
    800038ae:	a039                	j	800038bc <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800038b0:	02090b63          	beqz	s2,800038e6 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800038b4:	08848493          	addi	s1,s1,136
    800038b8:	02d48a63          	beq	s1,a3,800038ec <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    800038bc:	449c                	lw	a5,8(s1)
    800038be:	fef059e3          	blez	a5,800038b0 <iget+0x38>
    800038c2:	4098                	lw	a4,0(s1)
    800038c4:	ff3716e3          	bne	a4,s3,800038b0 <iget+0x38>
    800038c8:	40d8                	lw	a4,4(s1)
    800038ca:	ff4713e3          	bne	a4,s4,800038b0 <iget+0x38>
      ip->ref++;
    800038ce:	2785                	addiw	a5,a5,1
    800038d0:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    800038d2:	0001c517          	auipc	a0,0x1c
    800038d6:	a9650513          	addi	a0,a0,-1386 # 8001f368 <itable>
    800038da:	ffffd097          	auipc	ra,0xffffd
    800038de:	3f2080e7          	jalr	1010(ra) # 80000ccc <release>
      return ip;
    800038e2:	8926                	mv	s2,s1
    800038e4:	a03d                	j	80003912 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800038e6:	f7f9                	bnez	a5,800038b4 <iget+0x3c>
    800038e8:	8926                	mv	s2,s1
    800038ea:	b7e9                	j	800038b4 <iget+0x3c>
  if(empty == 0)
    800038ec:	02090c63          	beqz	s2,80003924 <iget+0xac>
  ip->dev = dev;
    800038f0:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    800038f4:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    800038f8:	4785                	li	a5,1
    800038fa:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    800038fe:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80003902:	0001c517          	auipc	a0,0x1c
    80003906:	a6650513          	addi	a0,a0,-1434 # 8001f368 <itable>
    8000390a:	ffffd097          	auipc	ra,0xffffd
    8000390e:	3c2080e7          	jalr	962(ra) # 80000ccc <release>
}
    80003912:	854a                	mv	a0,s2
    80003914:	70a2                	ld	ra,40(sp)
    80003916:	7402                	ld	s0,32(sp)
    80003918:	64e2                	ld	s1,24(sp)
    8000391a:	6942                	ld	s2,16(sp)
    8000391c:	69a2                	ld	s3,8(sp)
    8000391e:	6a02                	ld	s4,0(sp)
    80003920:	6145                	addi	sp,sp,48
    80003922:	8082                	ret
    panic("iget: no inodes");
    80003924:	00005517          	auipc	a0,0x5
    80003928:	d1c50513          	addi	a0,a0,-740 # 80008640 <syscalls+0x148>
    8000392c:	ffffd097          	auipc	ra,0xffffd
    80003930:	c56080e7          	jalr	-938(ra) # 80000582 <panic>

0000000080003934 <fsinit>:
fsinit(int dev) {
    80003934:	7179                	addi	sp,sp,-48
    80003936:	f406                	sd	ra,40(sp)
    80003938:	f022                	sd	s0,32(sp)
    8000393a:	ec26                	sd	s1,24(sp)
    8000393c:	e84a                	sd	s2,16(sp)
    8000393e:	e44e                	sd	s3,8(sp)
    80003940:	1800                	addi	s0,sp,48
    80003942:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80003944:	4585                	li	a1,1
    80003946:	00000097          	auipc	ra,0x0
    8000394a:	a56080e7          	jalr	-1450(ra) # 8000339c <bread>
    8000394e:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80003950:	0001c997          	auipc	s3,0x1c
    80003954:	9f898993          	addi	s3,s3,-1544 # 8001f348 <sb>
    80003958:	02000613          	li	a2,32
    8000395c:	05850593          	addi	a1,a0,88
    80003960:	854e                	mv	a0,s3
    80003962:	ffffd097          	auipc	ra,0xffffd
    80003966:	40e080e7          	jalr	1038(ra) # 80000d70 <memmove>
  brelse(bp);
    8000396a:	8526                	mv	a0,s1
    8000396c:	00000097          	auipc	ra,0x0
    80003970:	b60080e7          	jalr	-1184(ra) # 800034cc <brelse>
  if(sb.magic != FSMAGIC)
    80003974:	0009a703          	lw	a4,0(s3)
    80003978:	102037b7          	lui	a5,0x10203
    8000397c:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80003980:	02f71263          	bne	a4,a5,800039a4 <fsinit+0x70>
  initlog(dev, &sb);
    80003984:	0001c597          	auipc	a1,0x1c
    80003988:	9c458593          	addi	a1,a1,-1596 # 8001f348 <sb>
    8000398c:	854a                	mv	a0,s2
    8000398e:	00001097          	auipc	ra,0x1
    80003992:	b2c080e7          	jalr	-1236(ra) # 800044ba <initlog>
}
    80003996:	70a2                	ld	ra,40(sp)
    80003998:	7402                	ld	s0,32(sp)
    8000399a:	64e2                	ld	s1,24(sp)
    8000399c:	6942                	ld	s2,16(sp)
    8000399e:	69a2                	ld	s3,8(sp)
    800039a0:	6145                	addi	sp,sp,48
    800039a2:	8082                	ret
    panic("invalid file system");
    800039a4:	00005517          	auipc	a0,0x5
    800039a8:	cac50513          	addi	a0,a0,-852 # 80008650 <syscalls+0x158>
    800039ac:	ffffd097          	auipc	ra,0xffffd
    800039b0:	bd6080e7          	jalr	-1066(ra) # 80000582 <panic>

00000000800039b4 <iinit>:
{
    800039b4:	7179                	addi	sp,sp,-48
    800039b6:	f406                	sd	ra,40(sp)
    800039b8:	f022                	sd	s0,32(sp)
    800039ba:	ec26                	sd	s1,24(sp)
    800039bc:	e84a                	sd	s2,16(sp)
    800039be:	e44e                	sd	s3,8(sp)
    800039c0:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    800039c2:	00005597          	auipc	a1,0x5
    800039c6:	ca658593          	addi	a1,a1,-858 # 80008668 <syscalls+0x170>
    800039ca:	0001c517          	auipc	a0,0x1c
    800039ce:	99e50513          	addi	a0,a0,-1634 # 8001f368 <itable>
    800039d2:	ffffd097          	auipc	ra,0xffffd
    800039d6:	1b6080e7          	jalr	438(ra) # 80000b88 <initlock>
  for(i = 0; i < NINODE; i++) {
    800039da:	0001c497          	auipc	s1,0x1c
    800039de:	9b648493          	addi	s1,s1,-1610 # 8001f390 <itable+0x28>
    800039e2:	0001d997          	auipc	s3,0x1d
    800039e6:	43e98993          	addi	s3,s3,1086 # 80020e20 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    800039ea:	00005917          	auipc	s2,0x5
    800039ee:	c8690913          	addi	s2,s2,-890 # 80008670 <syscalls+0x178>
    800039f2:	85ca                	mv	a1,s2
    800039f4:	8526                	mv	a0,s1
    800039f6:	00001097          	auipc	ra,0x1
    800039fa:	e12080e7          	jalr	-494(ra) # 80004808 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    800039fe:	08848493          	addi	s1,s1,136
    80003a02:	ff3498e3          	bne	s1,s3,800039f2 <iinit+0x3e>
}
    80003a06:	70a2                	ld	ra,40(sp)
    80003a08:	7402                	ld	s0,32(sp)
    80003a0a:	64e2                	ld	s1,24(sp)
    80003a0c:	6942                	ld	s2,16(sp)
    80003a0e:	69a2                	ld	s3,8(sp)
    80003a10:	6145                	addi	sp,sp,48
    80003a12:	8082                	ret

0000000080003a14 <ialloc>:
{
    80003a14:	7139                	addi	sp,sp,-64
    80003a16:	fc06                	sd	ra,56(sp)
    80003a18:	f822                	sd	s0,48(sp)
    80003a1a:	f426                	sd	s1,40(sp)
    80003a1c:	f04a                	sd	s2,32(sp)
    80003a1e:	ec4e                	sd	s3,24(sp)
    80003a20:	e852                	sd	s4,16(sp)
    80003a22:	e456                	sd	s5,8(sp)
    80003a24:	e05a                	sd	s6,0(sp)
    80003a26:	0080                	addi	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    80003a28:	0001c717          	auipc	a4,0x1c
    80003a2c:	92c72703          	lw	a4,-1748(a4) # 8001f354 <sb+0xc>
    80003a30:	4785                	li	a5,1
    80003a32:	04e7f863          	bgeu	a5,a4,80003a82 <ialloc+0x6e>
    80003a36:	8aaa                	mv	s5,a0
    80003a38:	8b2e                	mv	s6,a1
    80003a3a:	4905                	li	s2,1
    bp = bread(dev, IBLOCK(inum, sb));
    80003a3c:	0001ca17          	auipc	s4,0x1c
    80003a40:	90ca0a13          	addi	s4,s4,-1780 # 8001f348 <sb>
    80003a44:	00495593          	srli	a1,s2,0x4
    80003a48:	018a2783          	lw	a5,24(s4)
    80003a4c:	9dbd                	addw	a1,a1,a5
    80003a4e:	8556                	mv	a0,s5
    80003a50:	00000097          	auipc	ra,0x0
    80003a54:	94c080e7          	jalr	-1716(ra) # 8000339c <bread>
    80003a58:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80003a5a:	05850993          	addi	s3,a0,88
    80003a5e:	00f97793          	andi	a5,s2,15
    80003a62:	079a                	slli	a5,a5,0x6
    80003a64:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80003a66:	00099783          	lh	a5,0(s3)
    80003a6a:	cf9d                	beqz	a5,80003aa8 <ialloc+0x94>
    brelse(bp);
    80003a6c:	00000097          	auipc	ra,0x0
    80003a70:	a60080e7          	jalr	-1440(ra) # 800034cc <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80003a74:	0905                	addi	s2,s2,1
    80003a76:	00ca2703          	lw	a4,12(s4)
    80003a7a:	0009079b          	sext.w	a5,s2
    80003a7e:	fce7e3e3          	bltu	a5,a4,80003a44 <ialloc+0x30>
  printf("ialloc: no inodes\n");
    80003a82:	00005517          	auipc	a0,0x5
    80003a86:	bf650513          	addi	a0,a0,-1034 # 80008678 <syscalls+0x180>
    80003a8a:	ffffd097          	auipc	ra,0xffffd
    80003a8e:	b42080e7          	jalr	-1214(ra) # 800005cc <printf>
  return 0;
    80003a92:	4501                	li	a0,0
}
    80003a94:	70e2                	ld	ra,56(sp)
    80003a96:	7442                	ld	s0,48(sp)
    80003a98:	74a2                	ld	s1,40(sp)
    80003a9a:	7902                	ld	s2,32(sp)
    80003a9c:	69e2                	ld	s3,24(sp)
    80003a9e:	6a42                	ld	s4,16(sp)
    80003aa0:	6aa2                	ld	s5,8(sp)
    80003aa2:	6b02                	ld	s6,0(sp)
    80003aa4:	6121                	addi	sp,sp,64
    80003aa6:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    80003aa8:	04000613          	li	a2,64
    80003aac:	4581                	li	a1,0
    80003aae:	854e                	mv	a0,s3
    80003ab0:	ffffd097          	auipc	ra,0xffffd
    80003ab4:	264080e7          	jalr	612(ra) # 80000d14 <memset>
      dip->type = type;
    80003ab8:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80003abc:	8526                	mv	a0,s1
    80003abe:	00001097          	auipc	ra,0x1
    80003ac2:	c66080e7          	jalr	-922(ra) # 80004724 <log_write>
      brelse(bp);
    80003ac6:	8526                	mv	a0,s1
    80003ac8:	00000097          	auipc	ra,0x0
    80003acc:	a04080e7          	jalr	-1532(ra) # 800034cc <brelse>
      return iget(dev, inum);
    80003ad0:	0009059b          	sext.w	a1,s2
    80003ad4:	8556                	mv	a0,s5
    80003ad6:	00000097          	auipc	ra,0x0
    80003ada:	da2080e7          	jalr	-606(ra) # 80003878 <iget>
    80003ade:	bf5d                	j	80003a94 <ialloc+0x80>

0000000080003ae0 <iupdate>:
{
    80003ae0:	1101                	addi	sp,sp,-32
    80003ae2:	ec06                	sd	ra,24(sp)
    80003ae4:	e822                	sd	s0,16(sp)
    80003ae6:	e426                	sd	s1,8(sp)
    80003ae8:	e04a                	sd	s2,0(sp)
    80003aea:	1000                	addi	s0,sp,32
    80003aec:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003aee:	415c                	lw	a5,4(a0)
    80003af0:	0047d79b          	srliw	a5,a5,0x4
    80003af4:	0001c597          	auipc	a1,0x1c
    80003af8:	86c5a583          	lw	a1,-1940(a1) # 8001f360 <sb+0x18>
    80003afc:	9dbd                	addw	a1,a1,a5
    80003afe:	4108                	lw	a0,0(a0)
    80003b00:	00000097          	auipc	ra,0x0
    80003b04:	89c080e7          	jalr	-1892(ra) # 8000339c <bread>
    80003b08:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80003b0a:	05850793          	addi	a5,a0,88
    80003b0e:	40d8                	lw	a4,4(s1)
    80003b10:	8b3d                	andi	a4,a4,15
    80003b12:	071a                	slli	a4,a4,0x6
    80003b14:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80003b16:	04449703          	lh	a4,68(s1)
    80003b1a:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80003b1e:	04649703          	lh	a4,70(s1)
    80003b22:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80003b26:	04849703          	lh	a4,72(s1)
    80003b2a:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80003b2e:	04a49703          	lh	a4,74(s1)
    80003b32:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80003b36:	44f8                	lw	a4,76(s1)
    80003b38:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80003b3a:	03400613          	li	a2,52
    80003b3e:	05048593          	addi	a1,s1,80
    80003b42:	00c78513          	addi	a0,a5,12
    80003b46:	ffffd097          	auipc	ra,0xffffd
    80003b4a:	22a080e7          	jalr	554(ra) # 80000d70 <memmove>
  log_write(bp);
    80003b4e:	854a                	mv	a0,s2
    80003b50:	00001097          	auipc	ra,0x1
    80003b54:	bd4080e7          	jalr	-1068(ra) # 80004724 <log_write>
  brelse(bp);
    80003b58:	854a                	mv	a0,s2
    80003b5a:	00000097          	auipc	ra,0x0
    80003b5e:	972080e7          	jalr	-1678(ra) # 800034cc <brelse>
}
    80003b62:	60e2                	ld	ra,24(sp)
    80003b64:	6442                	ld	s0,16(sp)
    80003b66:	64a2                	ld	s1,8(sp)
    80003b68:	6902                	ld	s2,0(sp)
    80003b6a:	6105                	addi	sp,sp,32
    80003b6c:	8082                	ret

0000000080003b6e <idup>:
{
    80003b6e:	1101                	addi	sp,sp,-32
    80003b70:	ec06                	sd	ra,24(sp)
    80003b72:	e822                	sd	s0,16(sp)
    80003b74:	e426                	sd	s1,8(sp)
    80003b76:	1000                	addi	s0,sp,32
    80003b78:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80003b7a:	0001b517          	auipc	a0,0x1b
    80003b7e:	7ee50513          	addi	a0,a0,2030 # 8001f368 <itable>
    80003b82:	ffffd097          	auipc	ra,0xffffd
    80003b86:	096080e7          	jalr	150(ra) # 80000c18 <acquire>
  ip->ref++;
    80003b8a:	449c                	lw	a5,8(s1)
    80003b8c:	2785                	addiw	a5,a5,1
    80003b8e:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003b90:	0001b517          	auipc	a0,0x1b
    80003b94:	7d850513          	addi	a0,a0,2008 # 8001f368 <itable>
    80003b98:	ffffd097          	auipc	ra,0xffffd
    80003b9c:	134080e7          	jalr	308(ra) # 80000ccc <release>
}
    80003ba0:	8526                	mv	a0,s1
    80003ba2:	60e2                	ld	ra,24(sp)
    80003ba4:	6442                	ld	s0,16(sp)
    80003ba6:	64a2                	ld	s1,8(sp)
    80003ba8:	6105                	addi	sp,sp,32
    80003baa:	8082                	ret

0000000080003bac <ilock>:
{
    80003bac:	1101                	addi	sp,sp,-32
    80003bae:	ec06                	sd	ra,24(sp)
    80003bb0:	e822                	sd	s0,16(sp)
    80003bb2:	e426                	sd	s1,8(sp)
    80003bb4:	e04a                	sd	s2,0(sp)
    80003bb6:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80003bb8:	c115                	beqz	a0,80003bdc <ilock+0x30>
    80003bba:	84aa                	mv	s1,a0
    80003bbc:	451c                	lw	a5,8(a0)
    80003bbe:	00f05f63          	blez	a5,80003bdc <ilock+0x30>
  acquiresleep(&ip->lock);
    80003bc2:	0541                	addi	a0,a0,16
    80003bc4:	00001097          	auipc	ra,0x1
    80003bc8:	c7e080e7          	jalr	-898(ra) # 80004842 <acquiresleep>
  if(ip->valid == 0){
    80003bcc:	40bc                	lw	a5,64(s1)
    80003bce:	cf99                	beqz	a5,80003bec <ilock+0x40>
}
    80003bd0:	60e2                	ld	ra,24(sp)
    80003bd2:	6442                	ld	s0,16(sp)
    80003bd4:	64a2                	ld	s1,8(sp)
    80003bd6:	6902                	ld	s2,0(sp)
    80003bd8:	6105                	addi	sp,sp,32
    80003bda:	8082                	ret
    panic("ilock");
    80003bdc:	00005517          	auipc	a0,0x5
    80003be0:	ab450513          	addi	a0,a0,-1356 # 80008690 <syscalls+0x198>
    80003be4:	ffffd097          	auipc	ra,0xffffd
    80003be8:	99e080e7          	jalr	-1634(ra) # 80000582 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003bec:	40dc                	lw	a5,4(s1)
    80003bee:	0047d79b          	srliw	a5,a5,0x4
    80003bf2:	0001b597          	auipc	a1,0x1b
    80003bf6:	76e5a583          	lw	a1,1902(a1) # 8001f360 <sb+0x18>
    80003bfa:	9dbd                	addw	a1,a1,a5
    80003bfc:	4088                	lw	a0,0(s1)
    80003bfe:	fffff097          	auipc	ra,0xfffff
    80003c02:	79e080e7          	jalr	1950(ra) # 8000339c <bread>
    80003c06:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80003c08:	05850593          	addi	a1,a0,88
    80003c0c:	40dc                	lw	a5,4(s1)
    80003c0e:	8bbd                	andi	a5,a5,15
    80003c10:	079a                	slli	a5,a5,0x6
    80003c12:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80003c14:	00059783          	lh	a5,0(a1)
    80003c18:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80003c1c:	00259783          	lh	a5,2(a1)
    80003c20:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80003c24:	00459783          	lh	a5,4(a1)
    80003c28:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80003c2c:	00659783          	lh	a5,6(a1)
    80003c30:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80003c34:	459c                	lw	a5,8(a1)
    80003c36:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80003c38:	03400613          	li	a2,52
    80003c3c:	05b1                	addi	a1,a1,12
    80003c3e:	05048513          	addi	a0,s1,80
    80003c42:	ffffd097          	auipc	ra,0xffffd
    80003c46:	12e080e7          	jalr	302(ra) # 80000d70 <memmove>
    brelse(bp);
    80003c4a:	854a                	mv	a0,s2
    80003c4c:	00000097          	auipc	ra,0x0
    80003c50:	880080e7          	jalr	-1920(ra) # 800034cc <brelse>
    ip->valid = 1;
    80003c54:	4785                	li	a5,1
    80003c56:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80003c58:	04449783          	lh	a5,68(s1)
    80003c5c:	fbb5                	bnez	a5,80003bd0 <ilock+0x24>
      panic("ilock: no type");
    80003c5e:	00005517          	auipc	a0,0x5
    80003c62:	a3a50513          	addi	a0,a0,-1478 # 80008698 <syscalls+0x1a0>
    80003c66:	ffffd097          	auipc	ra,0xffffd
    80003c6a:	91c080e7          	jalr	-1764(ra) # 80000582 <panic>

0000000080003c6e <iunlock>:
{
    80003c6e:	1101                	addi	sp,sp,-32
    80003c70:	ec06                	sd	ra,24(sp)
    80003c72:	e822                	sd	s0,16(sp)
    80003c74:	e426                	sd	s1,8(sp)
    80003c76:	e04a                	sd	s2,0(sp)
    80003c78:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80003c7a:	c905                	beqz	a0,80003caa <iunlock+0x3c>
    80003c7c:	84aa                	mv	s1,a0
    80003c7e:	01050913          	addi	s2,a0,16
    80003c82:	854a                	mv	a0,s2
    80003c84:	00001097          	auipc	ra,0x1
    80003c88:	c58080e7          	jalr	-936(ra) # 800048dc <holdingsleep>
    80003c8c:	cd19                	beqz	a0,80003caa <iunlock+0x3c>
    80003c8e:	449c                	lw	a5,8(s1)
    80003c90:	00f05d63          	blez	a5,80003caa <iunlock+0x3c>
  releasesleep(&ip->lock);
    80003c94:	854a                	mv	a0,s2
    80003c96:	00001097          	auipc	ra,0x1
    80003c9a:	c02080e7          	jalr	-1022(ra) # 80004898 <releasesleep>
}
    80003c9e:	60e2                	ld	ra,24(sp)
    80003ca0:	6442                	ld	s0,16(sp)
    80003ca2:	64a2                	ld	s1,8(sp)
    80003ca4:	6902                	ld	s2,0(sp)
    80003ca6:	6105                	addi	sp,sp,32
    80003ca8:	8082                	ret
    panic("iunlock");
    80003caa:	00005517          	auipc	a0,0x5
    80003cae:	9fe50513          	addi	a0,a0,-1538 # 800086a8 <syscalls+0x1b0>
    80003cb2:	ffffd097          	auipc	ra,0xffffd
    80003cb6:	8d0080e7          	jalr	-1840(ra) # 80000582 <panic>

0000000080003cba <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80003cba:	7179                	addi	sp,sp,-48
    80003cbc:	f406                	sd	ra,40(sp)
    80003cbe:	f022                	sd	s0,32(sp)
    80003cc0:	ec26                	sd	s1,24(sp)
    80003cc2:	e84a                	sd	s2,16(sp)
    80003cc4:	e44e                	sd	s3,8(sp)
    80003cc6:	e052                	sd	s4,0(sp)
    80003cc8:	1800                	addi	s0,sp,48
    80003cca:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80003ccc:	05050493          	addi	s1,a0,80
    80003cd0:	08050913          	addi	s2,a0,128
    80003cd4:	a021                	j	80003cdc <itrunc+0x22>
    80003cd6:	0491                	addi	s1,s1,4
    80003cd8:	01248d63          	beq	s1,s2,80003cf2 <itrunc+0x38>
    if(ip->addrs[i]){
    80003cdc:	408c                	lw	a1,0(s1)
    80003cde:	dde5                	beqz	a1,80003cd6 <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80003ce0:	0009a503          	lw	a0,0(s3)
    80003ce4:	00000097          	auipc	ra,0x0
    80003ce8:	8fc080e7          	jalr	-1796(ra) # 800035e0 <bfree>
      ip->addrs[i] = 0;
    80003cec:	0004a023          	sw	zero,0(s1)
    80003cf0:	b7dd                	j	80003cd6 <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80003cf2:	0809a583          	lw	a1,128(s3)
    80003cf6:	e185                	bnez	a1,80003d16 <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80003cf8:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80003cfc:	854e                	mv	a0,s3
    80003cfe:	00000097          	auipc	ra,0x0
    80003d02:	de2080e7          	jalr	-542(ra) # 80003ae0 <iupdate>
}
    80003d06:	70a2                	ld	ra,40(sp)
    80003d08:	7402                	ld	s0,32(sp)
    80003d0a:	64e2                	ld	s1,24(sp)
    80003d0c:	6942                	ld	s2,16(sp)
    80003d0e:	69a2                	ld	s3,8(sp)
    80003d10:	6a02                	ld	s4,0(sp)
    80003d12:	6145                	addi	sp,sp,48
    80003d14:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80003d16:	0009a503          	lw	a0,0(s3)
    80003d1a:	fffff097          	auipc	ra,0xfffff
    80003d1e:	682080e7          	jalr	1666(ra) # 8000339c <bread>
    80003d22:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80003d24:	05850493          	addi	s1,a0,88
    80003d28:	45850913          	addi	s2,a0,1112
    80003d2c:	a021                	j	80003d34 <itrunc+0x7a>
    80003d2e:	0491                	addi	s1,s1,4
    80003d30:	01248b63          	beq	s1,s2,80003d46 <itrunc+0x8c>
      if(a[j])
    80003d34:	408c                	lw	a1,0(s1)
    80003d36:	dde5                	beqz	a1,80003d2e <itrunc+0x74>
        bfree(ip->dev, a[j]);
    80003d38:	0009a503          	lw	a0,0(s3)
    80003d3c:	00000097          	auipc	ra,0x0
    80003d40:	8a4080e7          	jalr	-1884(ra) # 800035e0 <bfree>
    80003d44:	b7ed                	j	80003d2e <itrunc+0x74>
    brelse(bp);
    80003d46:	8552                	mv	a0,s4
    80003d48:	fffff097          	auipc	ra,0xfffff
    80003d4c:	784080e7          	jalr	1924(ra) # 800034cc <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80003d50:	0809a583          	lw	a1,128(s3)
    80003d54:	0009a503          	lw	a0,0(s3)
    80003d58:	00000097          	auipc	ra,0x0
    80003d5c:	888080e7          	jalr	-1912(ra) # 800035e0 <bfree>
    ip->addrs[NDIRECT] = 0;
    80003d60:	0809a023          	sw	zero,128(s3)
    80003d64:	bf51                	j	80003cf8 <itrunc+0x3e>

0000000080003d66 <iput>:
{
    80003d66:	1101                	addi	sp,sp,-32
    80003d68:	ec06                	sd	ra,24(sp)
    80003d6a:	e822                	sd	s0,16(sp)
    80003d6c:	e426                	sd	s1,8(sp)
    80003d6e:	e04a                	sd	s2,0(sp)
    80003d70:	1000                	addi	s0,sp,32
    80003d72:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80003d74:	0001b517          	auipc	a0,0x1b
    80003d78:	5f450513          	addi	a0,a0,1524 # 8001f368 <itable>
    80003d7c:	ffffd097          	auipc	ra,0xffffd
    80003d80:	e9c080e7          	jalr	-356(ra) # 80000c18 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003d84:	4498                	lw	a4,8(s1)
    80003d86:	4785                	li	a5,1
    80003d88:	02f70363          	beq	a4,a5,80003dae <iput+0x48>
  ip->ref--;
    80003d8c:	449c                	lw	a5,8(s1)
    80003d8e:	37fd                	addiw	a5,a5,-1
    80003d90:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003d92:	0001b517          	auipc	a0,0x1b
    80003d96:	5d650513          	addi	a0,a0,1494 # 8001f368 <itable>
    80003d9a:	ffffd097          	auipc	ra,0xffffd
    80003d9e:	f32080e7          	jalr	-206(ra) # 80000ccc <release>
}
    80003da2:	60e2                	ld	ra,24(sp)
    80003da4:	6442                	ld	s0,16(sp)
    80003da6:	64a2                	ld	s1,8(sp)
    80003da8:	6902                	ld	s2,0(sp)
    80003daa:	6105                	addi	sp,sp,32
    80003dac:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003dae:	40bc                	lw	a5,64(s1)
    80003db0:	dff1                	beqz	a5,80003d8c <iput+0x26>
    80003db2:	04a49783          	lh	a5,74(s1)
    80003db6:	fbf9                	bnez	a5,80003d8c <iput+0x26>
    acquiresleep(&ip->lock);
    80003db8:	01048913          	addi	s2,s1,16
    80003dbc:	854a                	mv	a0,s2
    80003dbe:	00001097          	auipc	ra,0x1
    80003dc2:	a84080e7          	jalr	-1404(ra) # 80004842 <acquiresleep>
    release(&itable.lock);
    80003dc6:	0001b517          	auipc	a0,0x1b
    80003dca:	5a250513          	addi	a0,a0,1442 # 8001f368 <itable>
    80003dce:	ffffd097          	auipc	ra,0xffffd
    80003dd2:	efe080e7          	jalr	-258(ra) # 80000ccc <release>
    itrunc(ip);
    80003dd6:	8526                	mv	a0,s1
    80003dd8:	00000097          	auipc	ra,0x0
    80003ddc:	ee2080e7          	jalr	-286(ra) # 80003cba <itrunc>
    ip->type = 0;
    80003de0:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80003de4:	8526                	mv	a0,s1
    80003de6:	00000097          	auipc	ra,0x0
    80003dea:	cfa080e7          	jalr	-774(ra) # 80003ae0 <iupdate>
    ip->valid = 0;
    80003dee:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80003df2:	854a                	mv	a0,s2
    80003df4:	00001097          	auipc	ra,0x1
    80003df8:	aa4080e7          	jalr	-1372(ra) # 80004898 <releasesleep>
    acquire(&itable.lock);
    80003dfc:	0001b517          	auipc	a0,0x1b
    80003e00:	56c50513          	addi	a0,a0,1388 # 8001f368 <itable>
    80003e04:	ffffd097          	auipc	ra,0xffffd
    80003e08:	e14080e7          	jalr	-492(ra) # 80000c18 <acquire>
    80003e0c:	b741                	j	80003d8c <iput+0x26>

0000000080003e0e <iunlockput>:
{
    80003e0e:	1101                	addi	sp,sp,-32
    80003e10:	ec06                	sd	ra,24(sp)
    80003e12:	e822                	sd	s0,16(sp)
    80003e14:	e426                	sd	s1,8(sp)
    80003e16:	1000                	addi	s0,sp,32
    80003e18:	84aa                	mv	s1,a0
  iunlock(ip);
    80003e1a:	00000097          	auipc	ra,0x0
    80003e1e:	e54080e7          	jalr	-428(ra) # 80003c6e <iunlock>
  iput(ip);
    80003e22:	8526                	mv	a0,s1
    80003e24:	00000097          	auipc	ra,0x0
    80003e28:	f42080e7          	jalr	-190(ra) # 80003d66 <iput>
}
    80003e2c:	60e2                	ld	ra,24(sp)
    80003e2e:	6442                	ld	s0,16(sp)
    80003e30:	64a2                	ld	s1,8(sp)
    80003e32:	6105                	addi	sp,sp,32
    80003e34:	8082                	ret

0000000080003e36 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80003e36:	1141                	addi	sp,sp,-16
    80003e38:	e422                	sd	s0,8(sp)
    80003e3a:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80003e3c:	411c                	lw	a5,0(a0)
    80003e3e:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80003e40:	415c                	lw	a5,4(a0)
    80003e42:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80003e44:	04451783          	lh	a5,68(a0)
    80003e48:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80003e4c:	04a51783          	lh	a5,74(a0)
    80003e50:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80003e54:	04c56783          	lwu	a5,76(a0)
    80003e58:	e99c                	sd	a5,16(a1)
}
    80003e5a:	6422                	ld	s0,8(sp)
    80003e5c:	0141                	addi	sp,sp,16
    80003e5e:	8082                	ret

0000000080003e60 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003e60:	457c                	lw	a5,76(a0)
    80003e62:	0ed7e963          	bltu	a5,a3,80003f54 <readi+0xf4>
{
    80003e66:	7159                	addi	sp,sp,-112
    80003e68:	f486                	sd	ra,104(sp)
    80003e6a:	f0a2                	sd	s0,96(sp)
    80003e6c:	eca6                	sd	s1,88(sp)
    80003e6e:	e8ca                	sd	s2,80(sp)
    80003e70:	e4ce                	sd	s3,72(sp)
    80003e72:	e0d2                	sd	s4,64(sp)
    80003e74:	fc56                	sd	s5,56(sp)
    80003e76:	f85a                	sd	s6,48(sp)
    80003e78:	f45e                	sd	s7,40(sp)
    80003e7a:	f062                	sd	s8,32(sp)
    80003e7c:	ec66                	sd	s9,24(sp)
    80003e7e:	e86a                	sd	s10,16(sp)
    80003e80:	e46e                	sd	s11,8(sp)
    80003e82:	1880                	addi	s0,sp,112
    80003e84:	8b2a                	mv	s6,a0
    80003e86:	8bae                	mv	s7,a1
    80003e88:	8a32                	mv	s4,a2
    80003e8a:	84b6                	mv	s1,a3
    80003e8c:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    80003e8e:	9f35                	addw	a4,a4,a3
    return 0;
    80003e90:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80003e92:	0ad76063          	bltu	a4,a3,80003f32 <readi+0xd2>
  if(off + n > ip->size)
    80003e96:	00e7f463          	bgeu	a5,a4,80003e9e <readi+0x3e>
    n = ip->size - off;
    80003e9a:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003e9e:	0a0a8963          	beqz	s5,80003f50 <readi+0xf0>
    80003ea2:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80003ea4:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80003ea8:	5c7d                	li	s8,-1
    80003eaa:	a82d                	j	80003ee4 <readi+0x84>
    80003eac:	020d1d93          	slli	s11,s10,0x20
    80003eb0:	020ddd93          	srli	s11,s11,0x20
    80003eb4:	05890613          	addi	a2,s2,88
    80003eb8:	86ee                	mv	a3,s11
    80003eba:	963a                	add	a2,a2,a4
    80003ebc:	85d2                	mv	a1,s4
    80003ebe:	855e                	mv	a0,s7
    80003ec0:	fffff097          	auipc	ra,0xfffff
    80003ec4:	960080e7          	jalr	-1696(ra) # 80002820 <either_copyout>
    80003ec8:	05850d63          	beq	a0,s8,80003f22 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80003ecc:	854a                	mv	a0,s2
    80003ece:	fffff097          	auipc	ra,0xfffff
    80003ed2:	5fe080e7          	jalr	1534(ra) # 800034cc <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003ed6:	013d09bb          	addw	s3,s10,s3
    80003eda:	009d04bb          	addw	s1,s10,s1
    80003ede:	9a6e                	add	s4,s4,s11
    80003ee0:	0559f763          	bgeu	s3,s5,80003f2e <readi+0xce>
    uint addr = bmap(ip, off/BSIZE);
    80003ee4:	00a4d59b          	srliw	a1,s1,0xa
    80003ee8:	855a                	mv	a0,s6
    80003eea:	00000097          	auipc	ra,0x0
    80003eee:	8a4080e7          	jalr	-1884(ra) # 8000378e <bmap>
    80003ef2:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80003ef6:	cd85                	beqz	a1,80003f2e <readi+0xce>
    bp = bread(ip->dev, addr);
    80003ef8:	000b2503          	lw	a0,0(s6)
    80003efc:	fffff097          	auipc	ra,0xfffff
    80003f00:	4a0080e7          	jalr	1184(ra) # 8000339c <bread>
    80003f04:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003f06:	3ff4f713          	andi	a4,s1,1023
    80003f0a:	40ec87bb          	subw	a5,s9,a4
    80003f0e:	413a86bb          	subw	a3,s5,s3
    80003f12:	8d3e                	mv	s10,a5
    80003f14:	2781                	sext.w	a5,a5
    80003f16:	0006861b          	sext.w	a2,a3
    80003f1a:	f8f679e3          	bgeu	a2,a5,80003eac <readi+0x4c>
    80003f1e:	8d36                	mv	s10,a3
    80003f20:	b771                	j	80003eac <readi+0x4c>
      brelse(bp);
    80003f22:	854a                	mv	a0,s2
    80003f24:	fffff097          	auipc	ra,0xfffff
    80003f28:	5a8080e7          	jalr	1448(ra) # 800034cc <brelse>
      tot = -1;
    80003f2c:	59fd                	li	s3,-1
  }
  return tot;
    80003f2e:	0009851b          	sext.w	a0,s3
}
    80003f32:	70a6                	ld	ra,104(sp)
    80003f34:	7406                	ld	s0,96(sp)
    80003f36:	64e6                	ld	s1,88(sp)
    80003f38:	6946                	ld	s2,80(sp)
    80003f3a:	69a6                	ld	s3,72(sp)
    80003f3c:	6a06                	ld	s4,64(sp)
    80003f3e:	7ae2                	ld	s5,56(sp)
    80003f40:	7b42                	ld	s6,48(sp)
    80003f42:	7ba2                	ld	s7,40(sp)
    80003f44:	7c02                	ld	s8,32(sp)
    80003f46:	6ce2                	ld	s9,24(sp)
    80003f48:	6d42                	ld	s10,16(sp)
    80003f4a:	6da2                	ld	s11,8(sp)
    80003f4c:	6165                	addi	sp,sp,112
    80003f4e:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003f50:	89d6                	mv	s3,s5
    80003f52:	bff1                	j	80003f2e <readi+0xce>
    return 0;
    80003f54:	4501                	li	a0,0
}
    80003f56:	8082                	ret

0000000080003f58 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003f58:	457c                	lw	a5,76(a0)
    80003f5a:	10d7e863          	bltu	a5,a3,8000406a <writei+0x112>
{
    80003f5e:	7159                	addi	sp,sp,-112
    80003f60:	f486                	sd	ra,104(sp)
    80003f62:	f0a2                	sd	s0,96(sp)
    80003f64:	eca6                	sd	s1,88(sp)
    80003f66:	e8ca                	sd	s2,80(sp)
    80003f68:	e4ce                	sd	s3,72(sp)
    80003f6a:	e0d2                	sd	s4,64(sp)
    80003f6c:	fc56                	sd	s5,56(sp)
    80003f6e:	f85a                	sd	s6,48(sp)
    80003f70:	f45e                	sd	s7,40(sp)
    80003f72:	f062                	sd	s8,32(sp)
    80003f74:	ec66                	sd	s9,24(sp)
    80003f76:	e86a                	sd	s10,16(sp)
    80003f78:	e46e                	sd	s11,8(sp)
    80003f7a:	1880                	addi	s0,sp,112
    80003f7c:	8aaa                	mv	s5,a0
    80003f7e:	8bae                	mv	s7,a1
    80003f80:	8a32                	mv	s4,a2
    80003f82:	8936                	mv	s2,a3
    80003f84:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80003f86:	00e687bb          	addw	a5,a3,a4
    80003f8a:	0ed7e263          	bltu	a5,a3,8000406e <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80003f8e:	00043737          	lui	a4,0x43
    80003f92:	0ef76063          	bltu	a4,a5,80004072 <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003f96:	0c0b0863          	beqz	s6,80004066 <writei+0x10e>
    80003f9a:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80003f9c:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003fa0:	5c7d                	li	s8,-1
    80003fa2:	a091                	j	80003fe6 <writei+0x8e>
    80003fa4:	020d1d93          	slli	s11,s10,0x20
    80003fa8:	020ddd93          	srli	s11,s11,0x20
    80003fac:	05848513          	addi	a0,s1,88
    80003fb0:	86ee                	mv	a3,s11
    80003fb2:	8652                	mv	a2,s4
    80003fb4:	85de                	mv	a1,s7
    80003fb6:	953a                	add	a0,a0,a4
    80003fb8:	fffff097          	auipc	ra,0xfffff
    80003fbc:	8be080e7          	jalr	-1858(ra) # 80002876 <either_copyin>
    80003fc0:	07850263          	beq	a0,s8,80004024 <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    80003fc4:	8526                	mv	a0,s1
    80003fc6:	00000097          	auipc	ra,0x0
    80003fca:	75e080e7          	jalr	1886(ra) # 80004724 <log_write>
    brelse(bp);
    80003fce:	8526                	mv	a0,s1
    80003fd0:	fffff097          	auipc	ra,0xfffff
    80003fd4:	4fc080e7          	jalr	1276(ra) # 800034cc <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003fd8:	013d09bb          	addw	s3,s10,s3
    80003fdc:	012d093b          	addw	s2,s10,s2
    80003fe0:	9a6e                	add	s4,s4,s11
    80003fe2:	0569f663          	bgeu	s3,s6,8000402e <writei+0xd6>
    uint addr = bmap(ip, off/BSIZE);
    80003fe6:	00a9559b          	srliw	a1,s2,0xa
    80003fea:	8556                	mv	a0,s5
    80003fec:	fffff097          	auipc	ra,0xfffff
    80003ff0:	7a2080e7          	jalr	1954(ra) # 8000378e <bmap>
    80003ff4:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80003ff8:	c99d                	beqz	a1,8000402e <writei+0xd6>
    bp = bread(ip->dev, addr);
    80003ffa:	000aa503          	lw	a0,0(s5)
    80003ffe:	fffff097          	auipc	ra,0xfffff
    80004002:	39e080e7          	jalr	926(ra) # 8000339c <bread>
    80004006:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80004008:	3ff97713          	andi	a4,s2,1023
    8000400c:	40ec87bb          	subw	a5,s9,a4
    80004010:	413b06bb          	subw	a3,s6,s3
    80004014:	8d3e                	mv	s10,a5
    80004016:	2781                	sext.w	a5,a5
    80004018:	0006861b          	sext.w	a2,a3
    8000401c:	f8f674e3          	bgeu	a2,a5,80003fa4 <writei+0x4c>
    80004020:	8d36                	mv	s10,a3
    80004022:	b749                	j	80003fa4 <writei+0x4c>
      brelse(bp);
    80004024:	8526                	mv	a0,s1
    80004026:	fffff097          	auipc	ra,0xfffff
    8000402a:	4a6080e7          	jalr	1190(ra) # 800034cc <brelse>
  }

  if(off > ip->size)
    8000402e:	04caa783          	lw	a5,76(s5)
    80004032:	0127f463          	bgeu	a5,s2,8000403a <writei+0xe2>
    ip->size = off;
    80004036:	052aa623          	sw	s2,76(s5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    8000403a:	8556                	mv	a0,s5
    8000403c:	00000097          	auipc	ra,0x0
    80004040:	aa4080e7          	jalr	-1372(ra) # 80003ae0 <iupdate>

  return tot;
    80004044:	0009851b          	sext.w	a0,s3
}
    80004048:	70a6                	ld	ra,104(sp)
    8000404a:	7406                	ld	s0,96(sp)
    8000404c:	64e6                	ld	s1,88(sp)
    8000404e:	6946                	ld	s2,80(sp)
    80004050:	69a6                	ld	s3,72(sp)
    80004052:	6a06                	ld	s4,64(sp)
    80004054:	7ae2                	ld	s5,56(sp)
    80004056:	7b42                	ld	s6,48(sp)
    80004058:	7ba2                	ld	s7,40(sp)
    8000405a:	7c02                	ld	s8,32(sp)
    8000405c:	6ce2                	ld	s9,24(sp)
    8000405e:	6d42                	ld	s10,16(sp)
    80004060:	6da2                	ld	s11,8(sp)
    80004062:	6165                	addi	sp,sp,112
    80004064:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80004066:	89da                	mv	s3,s6
    80004068:	bfc9                	j	8000403a <writei+0xe2>
    return -1;
    8000406a:	557d                	li	a0,-1
}
    8000406c:	8082                	ret
    return -1;
    8000406e:	557d                	li	a0,-1
    80004070:	bfe1                	j	80004048 <writei+0xf0>
    return -1;
    80004072:	557d                	li	a0,-1
    80004074:	bfd1                	j	80004048 <writei+0xf0>

0000000080004076 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80004076:	1141                	addi	sp,sp,-16
    80004078:	e406                	sd	ra,8(sp)
    8000407a:	e022                	sd	s0,0(sp)
    8000407c:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    8000407e:	4639                	li	a2,14
    80004080:	ffffd097          	auipc	ra,0xffffd
    80004084:	d64080e7          	jalr	-668(ra) # 80000de4 <strncmp>
}
    80004088:	60a2                	ld	ra,8(sp)
    8000408a:	6402                	ld	s0,0(sp)
    8000408c:	0141                	addi	sp,sp,16
    8000408e:	8082                	ret

0000000080004090 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80004090:	7139                	addi	sp,sp,-64
    80004092:	fc06                	sd	ra,56(sp)
    80004094:	f822                	sd	s0,48(sp)
    80004096:	f426                	sd	s1,40(sp)
    80004098:	f04a                	sd	s2,32(sp)
    8000409a:	ec4e                	sd	s3,24(sp)
    8000409c:	e852                	sd	s4,16(sp)
    8000409e:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    800040a0:	04451703          	lh	a4,68(a0)
    800040a4:	4785                	li	a5,1
    800040a6:	00f71a63          	bne	a4,a5,800040ba <dirlookup+0x2a>
    800040aa:	892a                	mv	s2,a0
    800040ac:	89ae                	mv	s3,a1
    800040ae:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    800040b0:	457c                	lw	a5,76(a0)
    800040b2:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    800040b4:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    800040b6:	e79d                	bnez	a5,800040e4 <dirlookup+0x54>
    800040b8:	a8a5                	j	80004130 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    800040ba:	00004517          	auipc	a0,0x4
    800040be:	5f650513          	addi	a0,a0,1526 # 800086b0 <syscalls+0x1b8>
    800040c2:	ffffc097          	auipc	ra,0xffffc
    800040c6:	4c0080e7          	jalr	1216(ra) # 80000582 <panic>
      panic("dirlookup read");
    800040ca:	00004517          	auipc	a0,0x4
    800040ce:	5fe50513          	addi	a0,a0,1534 # 800086c8 <syscalls+0x1d0>
    800040d2:	ffffc097          	auipc	ra,0xffffc
    800040d6:	4b0080e7          	jalr	1200(ra) # 80000582 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800040da:	24c1                	addiw	s1,s1,16
    800040dc:	04c92783          	lw	a5,76(s2)
    800040e0:	04f4f763          	bgeu	s1,a5,8000412e <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800040e4:	4741                	li	a4,16
    800040e6:	86a6                	mv	a3,s1
    800040e8:	fc040613          	addi	a2,s0,-64
    800040ec:	4581                	li	a1,0
    800040ee:	854a                	mv	a0,s2
    800040f0:	00000097          	auipc	ra,0x0
    800040f4:	d70080e7          	jalr	-656(ra) # 80003e60 <readi>
    800040f8:	47c1                	li	a5,16
    800040fa:	fcf518e3          	bne	a0,a5,800040ca <dirlookup+0x3a>
    if(de.inum == 0)
    800040fe:	fc045783          	lhu	a5,-64(s0)
    80004102:	dfe1                	beqz	a5,800040da <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    80004104:	fc240593          	addi	a1,s0,-62
    80004108:	854e                	mv	a0,s3
    8000410a:	00000097          	auipc	ra,0x0
    8000410e:	f6c080e7          	jalr	-148(ra) # 80004076 <namecmp>
    80004112:	f561                	bnez	a0,800040da <dirlookup+0x4a>
      if(poff)
    80004114:	000a0463          	beqz	s4,8000411c <dirlookup+0x8c>
        *poff = off;
    80004118:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    8000411c:	fc045583          	lhu	a1,-64(s0)
    80004120:	00092503          	lw	a0,0(s2)
    80004124:	fffff097          	auipc	ra,0xfffff
    80004128:	754080e7          	jalr	1876(ra) # 80003878 <iget>
    8000412c:	a011                	j	80004130 <dirlookup+0xa0>
  return 0;
    8000412e:	4501                	li	a0,0
}
    80004130:	70e2                	ld	ra,56(sp)
    80004132:	7442                	ld	s0,48(sp)
    80004134:	74a2                	ld	s1,40(sp)
    80004136:	7902                	ld	s2,32(sp)
    80004138:	69e2                	ld	s3,24(sp)
    8000413a:	6a42                	ld	s4,16(sp)
    8000413c:	6121                	addi	sp,sp,64
    8000413e:	8082                	ret

0000000080004140 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80004140:	711d                	addi	sp,sp,-96
    80004142:	ec86                	sd	ra,88(sp)
    80004144:	e8a2                	sd	s0,80(sp)
    80004146:	e4a6                	sd	s1,72(sp)
    80004148:	e0ca                	sd	s2,64(sp)
    8000414a:	fc4e                	sd	s3,56(sp)
    8000414c:	f852                	sd	s4,48(sp)
    8000414e:	f456                	sd	s5,40(sp)
    80004150:	f05a                	sd	s6,32(sp)
    80004152:	ec5e                	sd	s7,24(sp)
    80004154:	e862                	sd	s8,16(sp)
    80004156:	e466                	sd	s9,8(sp)
    80004158:	1080                	addi	s0,sp,96
    8000415a:	84aa                	mv	s1,a0
    8000415c:	8b2e                	mv	s6,a1
    8000415e:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80004160:	00054703          	lbu	a4,0(a0)
    80004164:	02f00793          	li	a5,47
    80004168:	02f70263          	beq	a4,a5,8000418c <namex+0x4c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    8000416c:	ffffe097          	auipc	ra,0xffffe
    80004170:	ae8080e7          	jalr	-1304(ra) # 80001c54 <myproc>
    80004174:	15853503          	ld	a0,344(a0)
    80004178:	00000097          	auipc	ra,0x0
    8000417c:	9f6080e7          	jalr	-1546(ra) # 80003b6e <idup>
    80004180:	8a2a                	mv	s4,a0
  while(*path == '/')
    80004182:	02f00913          	li	s2,47
  if(len >= DIRSIZ)
    80004186:	4c35                	li	s8,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80004188:	4b85                	li	s7,1
    8000418a:	a875                	j	80004246 <namex+0x106>
    ip = iget(ROOTDEV, ROOTINO);
    8000418c:	4585                	li	a1,1
    8000418e:	4505                	li	a0,1
    80004190:	fffff097          	auipc	ra,0xfffff
    80004194:	6e8080e7          	jalr	1768(ra) # 80003878 <iget>
    80004198:	8a2a                	mv	s4,a0
    8000419a:	b7e5                	j	80004182 <namex+0x42>
      iunlockput(ip);
    8000419c:	8552                	mv	a0,s4
    8000419e:	00000097          	auipc	ra,0x0
    800041a2:	c70080e7          	jalr	-912(ra) # 80003e0e <iunlockput>
      return 0;
    800041a6:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    800041a8:	8552                	mv	a0,s4
    800041aa:	60e6                	ld	ra,88(sp)
    800041ac:	6446                	ld	s0,80(sp)
    800041ae:	64a6                	ld	s1,72(sp)
    800041b0:	6906                	ld	s2,64(sp)
    800041b2:	79e2                	ld	s3,56(sp)
    800041b4:	7a42                	ld	s4,48(sp)
    800041b6:	7aa2                	ld	s5,40(sp)
    800041b8:	7b02                	ld	s6,32(sp)
    800041ba:	6be2                	ld	s7,24(sp)
    800041bc:	6c42                	ld	s8,16(sp)
    800041be:	6ca2                	ld	s9,8(sp)
    800041c0:	6125                	addi	sp,sp,96
    800041c2:	8082                	ret
      iunlock(ip);
    800041c4:	8552                	mv	a0,s4
    800041c6:	00000097          	auipc	ra,0x0
    800041ca:	aa8080e7          	jalr	-1368(ra) # 80003c6e <iunlock>
      return ip;
    800041ce:	bfe9                	j	800041a8 <namex+0x68>
      iunlockput(ip);
    800041d0:	8552                	mv	a0,s4
    800041d2:	00000097          	auipc	ra,0x0
    800041d6:	c3c080e7          	jalr	-964(ra) # 80003e0e <iunlockput>
      return 0;
    800041da:	8a4e                	mv	s4,s3
    800041dc:	b7f1                	j	800041a8 <namex+0x68>
  len = path - s;
    800041de:	40998633          	sub	a2,s3,s1
    800041e2:	00060c9b          	sext.w	s9,a2
  if(len >= DIRSIZ)
    800041e6:	099c5863          	bge	s8,s9,80004276 <namex+0x136>
    memmove(name, s, DIRSIZ);
    800041ea:	4639                	li	a2,14
    800041ec:	85a6                	mv	a1,s1
    800041ee:	8556                	mv	a0,s5
    800041f0:	ffffd097          	auipc	ra,0xffffd
    800041f4:	b80080e7          	jalr	-1152(ra) # 80000d70 <memmove>
    800041f8:	84ce                	mv	s1,s3
  while(*path == '/')
    800041fa:	0004c783          	lbu	a5,0(s1)
    800041fe:	01279763          	bne	a5,s2,8000420c <namex+0xcc>
    path++;
    80004202:	0485                	addi	s1,s1,1
  while(*path == '/')
    80004204:	0004c783          	lbu	a5,0(s1)
    80004208:	ff278de3          	beq	a5,s2,80004202 <namex+0xc2>
    ilock(ip);
    8000420c:	8552                	mv	a0,s4
    8000420e:	00000097          	auipc	ra,0x0
    80004212:	99e080e7          	jalr	-1634(ra) # 80003bac <ilock>
    if(ip->type != T_DIR){
    80004216:	044a1783          	lh	a5,68(s4)
    8000421a:	f97791e3          	bne	a5,s7,8000419c <namex+0x5c>
    if(nameiparent && *path == '\0'){
    8000421e:	000b0563          	beqz	s6,80004228 <namex+0xe8>
    80004222:	0004c783          	lbu	a5,0(s1)
    80004226:	dfd9                	beqz	a5,800041c4 <namex+0x84>
    if((next = dirlookup(ip, name, 0)) == 0){
    80004228:	4601                	li	a2,0
    8000422a:	85d6                	mv	a1,s5
    8000422c:	8552                	mv	a0,s4
    8000422e:	00000097          	auipc	ra,0x0
    80004232:	e62080e7          	jalr	-414(ra) # 80004090 <dirlookup>
    80004236:	89aa                	mv	s3,a0
    80004238:	dd41                	beqz	a0,800041d0 <namex+0x90>
    iunlockput(ip);
    8000423a:	8552                	mv	a0,s4
    8000423c:	00000097          	auipc	ra,0x0
    80004240:	bd2080e7          	jalr	-1070(ra) # 80003e0e <iunlockput>
    ip = next;
    80004244:	8a4e                	mv	s4,s3
  while(*path == '/')
    80004246:	0004c783          	lbu	a5,0(s1)
    8000424a:	01279763          	bne	a5,s2,80004258 <namex+0x118>
    path++;
    8000424e:	0485                	addi	s1,s1,1
  while(*path == '/')
    80004250:	0004c783          	lbu	a5,0(s1)
    80004254:	ff278de3          	beq	a5,s2,8000424e <namex+0x10e>
  if(*path == 0)
    80004258:	cb9d                	beqz	a5,8000428e <namex+0x14e>
  while(*path != '/' && *path != 0)
    8000425a:	0004c783          	lbu	a5,0(s1)
    8000425e:	89a6                	mv	s3,s1
  len = path - s;
    80004260:	4c81                	li	s9,0
    80004262:	4601                	li	a2,0
  while(*path != '/' && *path != 0)
    80004264:	01278963          	beq	a5,s2,80004276 <namex+0x136>
    80004268:	dbbd                	beqz	a5,800041de <namex+0x9e>
    path++;
    8000426a:	0985                	addi	s3,s3,1
  while(*path != '/' && *path != 0)
    8000426c:	0009c783          	lbu	a5,0(s3)
    80004270:	ff279ce3          	bne	a5,s2,80004268 <namex+0x128>
    80004274:	b7ad                	j	800041de <namex+0x9e>
    memmove(name, s, len);
    80004276:	2601                	sext.w	a2,a2
    80004278:	85a6                	mv	a1,s1
    8000427a:	8556                	mv	a0,s5
    8000427c:	ffffd097          	auipc	ra,0xffffd
    80004280:	af4080e7          	jalr	-1292(ra) # 80000d70 <memmove>
    name[len] = 0;
    80004284:	9cd6                	add	s9,s9,s5
    80004286:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    8000428a:	84ce                	mv	s1,s3
    8000428c:	b7bd                	j	800041fa <namex+0xba>
  if(nameiparent){
    8000428e:	f00b0de3          	beqz	s6,800041a8 <namex+0x68>
    iput(ip);
    80004292:	8552                	mv	a0,s4
    80004294:	00000097          	auipc	ra,0x0
    80004298:	ad2080e7          	jalr	-1326(ra) # 80003d66 <iput>
    return 0;
    8000429c:	4a01                	li	s4,0
    8000429e:	b729                	j	800041a8 <namex+0x68>

00000000800042a0 <dirlink>:
{
    800042a0:	7139                	addi	sp,sp,-64
    800042a2:	fc06                	sd	ra,56(sp)
    800042a4:	f822                	sd	s0,48(sp)
    800042a6:	f426                	sd	s1,40(sp)
    800042a8:	f04a                	sd	s2,32(sp)
    800042aa:	ec4e                	sd	s3,24(sp)
    800042ac:	e852                	sd	s4,16(sp)
    800042ae:	0080                	addi	s0,sp,64
    800042b0:	892a                	mv	s2,a0
    800042b2:	8a2e                	mv	s4,a1
    800042b4:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    800042b6:	4601                	li	a2,0
    800042b8:	00000097          	auipc	ra,0x0
    800042bc:	dd8080e7          	jalr	-552(ra) # 80004090 <dirlookup>
    800042c0:	e93d                	bnez	a0,80004336 <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800042c2:	04c92483          	lw	s1,76(s2)
    800042c6:	c49d                	beqz	s1,800042f4 <dirlink+0x54>
    800042c8:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800042ca:	4741                	li	a4,16
    800042cc:	86a6                	mv	a3,s1
    800042ce:	fc040613          	addi	a2,s0,-64
    800042d2:	4581                	li	a1,0
    800042d4:	854a                	mv	a0,s2
    800042d6:	00000097          	auipc	ra,0x0
    800042da:	b8a080e7          	jalr	-1142(ra) # 80003e60 <readi>
    800042de:	47c1                	li	a5,16
    800042e0:	06f51163          	bne	a0,a5,80004342 <dirlink+0xa2>
    if(de.inum == 0)
    800042e4:	fc045783          	lhu	a5,-64(s0)
    800042e8:	c791                	beqz	a5,800042f4 <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800042ea:	24c1                	addiw	s1,s1,16
    800042ec:	04c92783          	lw	a5,76(s2)
    800042f0:	fcf4ede3          	bltu	s1,a5,800042ca <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    800042f4:	4639                	li	a2,14
    800042f6:	85d2                	mv	a1,s4
    800042f8:	fc240513          	addi	a0,s0,-62
    800042fc:	ffffd097          	auipc	ra,0xffffd
    80004300:	b24080e7          	jalr	-1244(ra) # 80000e20 <strncpy>
  de.inum = inum;
    80004304:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004308:	4741                	li	a4,16
    8000430a:	86a6                	mv	a3,s1
    8000430c:	fc040613          	addi	a2,s0,-64
    80004310:	4581                	li	a1,0
    80004312:	854a                	mv	a0,s2
    80004314:	00000097          	auipc	ra,0x0
    80004318:	c44080e7          	jalr	-956(ra) # 80003f58 <writei>
    8000431c:	1541                	addi	a0,a0,-16
    8000431e:	00a03533          	snez	a0,a0
    80004322:	40a00533          	neg	a0,a0
}
    80004326:	70e2                	ld	ra,56(sp)
    80004328:	7442                	ld	s0,48(sp)
    8000432a:	74a2                	ld	s1,40(sp)
    8000432c:	7902                	ld	s2,32(sp)
    8000432e:	69e2                	ld	s3,24(sp)
    80004330:	6a42                	ld	s4,16(sp)
    80004332:	6121                	addi	sp,sp,64
    80004334:	8082                	ret
    iput(ip);
    80004336:	00000097          	auipc	ra,0x0
    8000433a:	a30080e7          	jalr	-1488(ra) # 80003d66 <iput>
    return -1;
    8000433e:	557d                	li	a0,-1
    80004340:	b7dd                	j	80004326 <dirlink+0x86>
      panic("dirlink read");
    80004342:	00004517          	auipc	a0,0x4
    80004346:	39650513          	addi	a0,a0,918 # 800086d8 <syscalls+0x1e0>
    8000434a:	ffffc097          	auipc	ra,0xffffc
    8000434e:	238080e7          	jalr	568(ra) # 80000582 <panic>

0000000080004352 <namei>:

struct inode*
namei(char *path)
{
    80004352:	1101                	addi	sp,sp,-32
    80004354:	ec06                	sd	ra,24(sp)
    80004356:	e822                	sd	s0,16(sp)
    80004358:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    8000435a:	fe040613          	addi	a2,s0,-32
    8000435e:	4581                	li	a1,0
    80004360:	00000097          	auipc	ra,0x0
    80004364:	de0080e7          	jalr	-544(ra) # 80004140 <namex>
}
    80004368:	60e2                	ld	ra,24(sp)
    8000436a:	6442                	ld	s0,16(sp)
    8000436c:	6105                	addi	sp,sp,32
    8000436e:	8082                	ret

0000000080004370 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80004370:	1141                	addi	sp,sp,-16
    80004372:	e406                	sd	ra,8(sp)
    80004374:	e022                	sd	s0,0(sp)
    80004376:	0800                	addi	s0,sp,16
    80004378:	862e                	mv	a2,a1
  return namex(path, 1, name);
    8000437a:	4585                	li	a1,1
    8000437c:	00000097          	auipc	ra,0x0
    80004380:	dc4080e7          	jalr	-572(ra) # 80004140 <namex>
}
    80004384:	60a2                	ld	ra,8(sp)
    80004386:	6402                	ld	s0,0(sp)
    80004388:	0141                	addi	sp,sp,16
    8000438a:	8082                	ret

000000008000438c <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    8000438c:	1101                	addi	sp,sp,-32
    8000438e:	ec06                	sd	ra,24(sp)
    80004390:	e822                	sd	s0,16(sp)
    80004392:	e426                	sd	s1,8(sp)
    80004394:	e04a                	sd	s2,0(sp)
    80004396:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80004398:	0001d917          	auipc	s2,0x1d
    8000439c:	a7890913          	addi	s2,s2,-1416 # 80020e10 <log>
    800043a0:	01892583          	lw	a1,24(s2)
    800043a4:	02892503          	lw	a0,40(s2)
    800043a8:	fffff097          	auipc	ra,0xfffff
    800043ac:	ff4080e7          	jalr	-12(ra) # 8000339c <bread>
    800043b0:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    800043b2:	02c92603          	lw	a2,44(s2)
    800043b6:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    800043b8:	00c05f63          	blez	a2,800043d6 <write_head+0x4a>
    800043bc:	0001d717          	auipc	a4,0x1d
    800043c0:	a8470713          	addi	a4,a4,-1404 # 80020e40 <log+0x30>
    800043c4:	87aa                	mv	a5,a0
    800043c6:	060a                	slli	a2,a2,0x2
    800043c8:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    800043ca:	4314                	lw	a3,0(a4)
    800043cc:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    800043ce:	0711                	addi	a4,a4,4
    800043d0:	0791                	addi	a5,a5,4
    800043d2:	fec79ce3          	bne	a5,a2,800043ca <write_head+0x3e>
  }
  bwrite(buf);
    800043d6:	8526                	mv	a0,s1
    800043d8:	fffff097          	auipc	ra,0xfffff
    800043dc:	0b6080e7          	jalr	182(ra) # 8000348e <bwrite>
  brelse(buf);
    800043e0:	8526                	mv	a0,s1
    800043e2:	fffff097          	auipc	ra,0xfffff
    800043e6:	0ea080e7          	jalr	234(ra) # 800034cc <brelse>
}
    800043ea:	60e2                	ld	ra,24(sp)
    800043ec:	6442                	ld	s0,16(sp)
    800043ee:	64a2                	ld	s1,8(sp)
    800043f0:	6902                	ld	s2,0(sp)
    800043f2:	6105                	addi	sp,sp,32
    800043f4:	8082                	ret

00000000800043f6 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    800043f6:	0001d797          	auipc	a5,0x1d
    800043fa:	a467a783          	lw	a5,-1466(a5) # 80020e3c <log+0x2c>
    800043fe:	0af05d63          	blez	a5,800044b8 <install_trans+0xc2>
{
    80004402:	7139                	addi	sp,sp,-64
    80004404:	fc06                	sd	ra,56(sp)
    80004406:	f822                	sd	s0,48(sp)
    80004408:	f426                	sd	s1,40(sp)
    8000440a:	f04a                	sd	s2,32(sp)
    8000440c:	ec4e                	sd	s3,24(sp)
    8000440e:	e852                	sd	s4,16(sp)
    80004410:	e456                	sd	s5,8(sp)
    80004412:	e05a                	sd	s6,0(sp)
    80004414:	0080                	addi	s0,sp,64
    80004416:	8b2a                	mv	s6,a0
    80004418:	0001da97          	auipc	s5,0x1d
    8000441c:	a28a8a93          	addi	s5,s5,-1496 # 80020e40 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80004420:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80004422:	0001d997          	auipc	s3,0x1d
    80004426:	9ee98993          	addi	s3,s3,-1554 # 80020e10 <log>
    8000442a:	a00d                	j	8000444c <install_trans+0x56>
    brelse(lbuf);
    8000442c:	854a                	mv	a0,s2
    8000442e:	fffff097          	auipc	ra,0xfffff
    80004432:	09e080e7          	jalr	158(ra) # 800034cc <brelse>
    brelse(dbuf);
    80004436:	8526                	mv	a0,s1
    80004438:	fffff097          	auipc	ra,0xfffff
    8000443c:	094080e7          	jalr	148(ra) # 800034cc <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80004440:	2a05                	addiw	s4,s4,1
    80004442:	0a91                	addi	s5,s5,4
    80004444:	02c9a783          	lw	a5,44(s3)
    80004448:	04fa5e63          	bge	s4,a5,800044a4 <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    8000444c:	0189a583          	lw	a1,24(s3)
    80004450:	014585bb          	addw	a1,a1,s4
    80004454:	2585                	addiw	a1,a1,1
    80004456:	0289a503          	lw	a0,40(s3)
    8000445a:	fffff097          	auipc	ra,0xfffff
    8000445e:	f42080e7          	jalr	-190(ra) # 8000339c <bread>
    80004462:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80004464:	000aa583          	lw	a1,0(s5)
    80004468:	0289a503          	lw	a0,40(s3)
    8000446c:	fffff097          	auipc	ra,0xfffff
    80004470:	f30080e7          	jalr	-208(ra) # 8000339c <bread>
    80004474:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80004476:	40000613          	li	a2,1024
    8000447a:	05890593          	addi	a1,s2,88
    8000447e:	05850513          	addi	a0,a0,88
    80004482:	ffffd097          	auipc	ra,0xffffd
    80004486:	8ee080e7          	jalr	-1810(ra) # 80000d70 <memmove>
    bwrite(dbuf);  // write dst to disk
    8000448a:	8526                	mv	a0,s1
    8000448c:	fffff097          	auipc	ra,0xfffff
    80004490:	002080e7          	jalr	2(ra) # 8000348e <bwrite>
    if(recovering == 0)
    80004494:	f80b1ce3          	bnez	s6,8000442c <install_trans+0x36>
      bunpin(dbuf);
    80004498:	8526                	mv	a0,s1
    8000449a:	fffff097          	auipc	ra,0xfffff
    8000449e:	10a080e7          	jalr	266(ra) # 800035a4 <bunpin>
    800044a2:	b769                	j	8000442c <install_trans+0x36>
}
    800044a4:	70e2                	ld	ra,56(sp)
    800044a6:	7442                	ld	s0,48(sp)
    800044a8:	74a2                	ld	s1,40(sp)
    800044aa:	7902                	ld	s2,32(sp)
    800044ac:	69e2                	ld	s3,24(sp)
    800044ae:	6a42                	ld	s4,16(sp)
    800044b0:	6aa2                	ld	s5,8(sp)
    800044b2:	6b02                	ld	s6,0(sp)
    800044b4:	6121                	addi	sp,sp,64
    800044b6:	8082                	ret
    800044b8:	8082                	ret

00000000800044ba <initlog>:
{
    800044ba:	7179                	addi	sp,sp,-48
    800044bc:	f406                	sd	ra,40(sp)
    800044be:	f022                	sd	s0,32(sp)
    800044c0:	ec26                	sd	s1,24(sp)
    800044c2:	e84a                	sd	s2,16(sp)
    800044c4:	e44e                	sd	s3,8(sp)
    800044c6:	1800                	addi	s0,sp,48
    800044c8:	892a                	mv	s2,a0
    800044ca:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    800044cc:	0001d497          	auipc	s1,0x1d
    800044d0:	94448493          	addi	s1,s1,-1724 # 80020e10 <log>
    800044d4:	00004597          	auipc	a1,0x4
    800044d8:	21458593          	addi	a1,a1,532 # 800086e8 <syscalls+0x1f0>
    800044dc:	8526                	mv	a0,s1
    800044de:	ffffc097          	auipc	ra,0xffffc
    800044e2:	6aa080e7          	jalr	1706(ra) # 80000b88 <initlock>
  log.start = sb->logstart;
    800044e6:	0149a583          	lw	a1,20(s3)
    800044ea:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    800044ec:	0109a783          	lw	a5,16(s3)
    800044f0:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    800044f2:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    800044f6:	854a                	mv	a0,s2
    800044f8:	fffff097          	auipc	ra,0xfffff
    800044fc:	ea4080e7          	jalr	-348(ra) # 8000339c <bread>
  log.lh.n = lh->n;
    80004500:	4d30                	lw	a2,88(a0)
    80004502:	d4d0                	sw	a2,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    80004504:	00c05f63          	blez	a2,80004522 <initlog+0x68>
    80004508:	87aa                	mv	a5,a0
    8000450a:	0001d717          	auipc	a4,0x1d
    8000450e:	93670713          	addi	a4,a4,-1738 # 80020e40 <log+0x30>
    80004512:	060a                	slli	a2,a2,0x2
    80004514:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    80004516:	4ff4                	lw	a3,92(a5)
    80004518:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    8000451a:	0791                	addi	a5,a5,4
    8000451c:	0711                	addi	a4,a4,4
    8000451e:	fec79ce3          	bne	a5,a2,80004516 <initlog+0x5c>
  brelse(buf);
    80004522:	fffff097          	auipc	ra,0xfffff
    80004526:	faa080e7          	jalr	-86(ra) # 800034cc <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    8000452a:	4505                	li	a0,1
    8000452c:	00000097          	auipc	ra,0x0
    80004530:	eca080e7          	jalr	-310(ra) # 800043f6 <install_trans>
  log.lh.n = 0;
    80004534:	0001d797          	auipc	a5,0x1d
    80004538:	9007a423          	sw	zero,-1784(a5) # 80020e3c <log+0x2c>
  write_head(); // clear the log
    8000453c:	00000097          	auipc	ra,0x0
    80004540:	e50080e7          	jalr	-432(ra) # 8000438c <write_head>
}
    80004544:	70a2                	ld	ra,40(sp)
    80004546:	7402                	ld	s0,32(sp)
    80004548:	64e2                	ld	s1,24(sp)
    8000454a:	6942                	ld	s2,16(sp)
    8000454c:	69a2                	ld	s3,8(sp)
    8000454e:	6145                	addi	sp,sp,48
    80004550:	8082                	ret

0000000080004552 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80004552:	1101                	addi	sp,sp,-32
    80004554:	ec06                	sd	ra,24(sp)
    80004556:	e822                	sd	s0,16(sp)
    80004558:	e426                	sd	s1,8(sp)
    8000455a:	e04a                	sd	s2,0(sp)
    8000455c:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    8000455e:	0001d517          	auipc	a0,0x1d
    80004562:	8b250513          	addi	a0,a0,-1870 # 80020e10 <log>
    80004566:	ffffc097          	auipc	ra,0xffffc
    8000456a:	6b2080e7          	jalr	1714(ra) # 80000c18 <acquire>
  while(1){
    if(log.committing){
    8000456e:	0001d497          	auipc	s1,0x1d
    80004572:	8a248493          	addi	s1,s1,-1886 # 80020e10 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80004576:	4979                	li	s2,30
    80004578:	a039                	j	80004586 <begin_op+0x34>
      sleep(&log, &log.lock);
    8000457a:	85a6                	mv	a1,s1
    8000457c:	8526                	mv	a0,s1
    8000457e:	ffffe097          	auipc	ra,0xffffe
    80004582:	e9a080e7          	jalr	-358(ra) # 80002418 <sleep>
    if(log.committing){
    80004586:	50dc                	lw	a5,36(s1)
    80004588:	fbed                	bnez	a5,8000457a <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000458a:	5098                	lw	a4,32(s1)
    8000458c:	2705                	addiw	a4,a4,1
    8000458e:	0027179b          	slliw	a5,a4,0x2
    80004592:	9fb9                	addw	a5,a5,a4
    80004594:	0017979b          	slliw	a5,a5,0x1
    80004598:	54d4                	lw	a3,44(s1)
    8000459a:	9fb5                	addw	a5,a5,a3
    8000459c:	00f95963          	bge	s2,a5,800045ae <begin_op+0x5c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    800045a0:	85a6                	mv	a1,s1
    800045a2:	8526                	mv	a0,s1
    800045a4:	ffffe097          	auipc	ra,0xffffe
    800045a8:	e74080e7          	jalr	-396(ra) # 80002418 <sleep>
    800045ac:	bfe9                	j	80004586 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    800045ae:	0001d517          	auipc	a0,0x1d
    800045b2:	86250513          	addi	a0,a0,-1950 # 80020e10 <log>
    800045b6:	d118                	sw	a4,32(a0)
      release(&log.lock);
    800045b8:	ffffc097          	auipc	ra,0xffffc
    800045bc:	714080e7          	jalr	1812(ra) # 80000ccc <release>
      break;
    }
  }
}
    800045c0:	60e2                	ld	ra,24(sp)
    800045c2:	6442                	ld	s0,16(sp)
    800045c4:	64a2                	ld	s1,8(sp)
    800045c6:	6902                	ld	s2,0(sp)
    800045c8:	6105                	addi	sp,sp,32
    800045ca:	8082                	ret

00000000800045cc <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    800045cc:	7139                	addi	sp,sp,-64
    800045ce:	fc06                	sd	ra,56(sp)
    800045d0:	f822                	sd	s0,48(sp)
    800045d2:	f426                	sd	s1,40(sp)
    800045d4:	f04a                	sd	s2,32(sp)
    800045d6:	ec4e                	sd	s3,24(sp)
    800045d8:	e852                	sd	s4,16(sp)
    800045da:	e456                	sd	s5,8(sp)
    800045dc:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    800045de:	0001d497          	auipc	s1,0x1d
    800045e2:	83248493          	addi	s1,s1,-1998 # 80020e10 <log>
    800045e6:	8526                	mv	a0,s1
    800045e8:	ffffc097          	auipc	ra,0xffffc
    800045ec:	630080e7          	jalr	1584(ra) # 80000c18 <acquire>
  log.outstanding -= 1;
    800045f0:	509c                	lw	a5,32(s1)
    800045f2:	37fd                	addiw	a5,a5,-1
    800045f4:	0007891b          	sext.w	s2,a5
    800045f8:	d09c                	sw	a5,32(s1)
  if(log.committing)
    800045fa:	50dc                	lw	a5,36(s1)
    800045fc:	e7b9                	bnez	a5,8000464a <end_op+0x7e>
    panic("log.committing");
  if(log.outstanding == 0){
    800045fe:	04091e63          	bnez	s2,8000465a <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    80004602:	0001d497          	auipc	s1,0x1d
    80004606:	80e48493          	addi	s1,s1,-2034 # 80020e10 <log>
    8000460a:	4785                	li	a5,1
    8000460c:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    8000460e:	8526                	mv	a0,s1
    80004610:	ffffc097          	auipc	ra,0xffffc
    80004614:	6bc080e7          	jalr	1724(ra) # 80000ccc <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80004618:	54dc                	lw	a5,44(s1)
    8000461a:	06f04763          	bgtz	a5,80004688 <end_op+0xbc>
    acquire(&log.lock);
    8000461e:	0001c497          	auipc	s1,0x1c
    80004622:	7f248493          	addi	s1,s1,2034 # 80020e10 <log>
    80004626:	8526                	mv	a0,s1
    80004628:	ffffc097          	auipc	ra,0xffffc
    8000462c:	5f0080e7          	jalr	1520(ra) # 80000c18 <acquire>
    log.committing = 0;
    80004630:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    80004634:	8526                	mv	a0,s1
    80004636:	ffffe097          	auipc	ra,0xffffe
    8000463a:	e46080e7          	jalr	-442(ra) # 8000247c <wakeup>
    release(&log.lock);
    8000463e:	8526                	mv	a0,s1
    80004640:	ffffc097          	auipc	ra,0xffffc
    80004644:	68c080e7          	jalr	1676(ra) # 80000ccc <release>
}
    80004648:	a03d                	j	80004676 <end_op+0xaa>
    panic("log.committing");
    8000464a:	00004517          	auipc	a0,0x4
    8000464e:	0a650513          	addi	a0,a0,166 # 800086f0 <syscalls+0x1f8>
    80004652:	ffffc097          	auipc	ra,0xffffc
    80004656:	f30080e7          	jalr	-208(ra) # 80000582 <panic>
    wakeup(&log);
    8000465a:	0001c497          	auipc	s1,0x1c
    8000465e:	7b648493          	addi	s1,s1,1974 # 80020e10 <log>
    80004662:	8526                	mv	a0,s1
    80004664:	ffffe097          	auipc	ra,0xffffe
    80004668:	e18080e7          	jalr	-488(ra) # 8000247c <wakeup>
  release(&log.lock);
    8000466c:	8526                	mv	a0,s1
    8000466e:	ffffc097          	auipc	ra,0xffffc
    80004672:	65e080e7          	jalr	1630(ra) # 80000ccc <release>
}
    80004676:	70e2                	ld	ra,56(sp)
    80004678:	7442                	ld	s0,48(sp)
    8000467a:	74a2                	ld	s1,40(sp)
    8000467c:	7902                	ld	s2,32(sp)
    8000467e:	69e2                	ld	s3,24(sp)
    80004680:	6a42                	ld	s4,16(sp)
    80004682:	6aa2                	ld	s5,8(sp)
    80004684:	6121                	addi	sp,sp,64
    80004686:	8082                	ret
  for (tail = 0; tail < log.lh.n; tail++) {
    80004688:	0001ca97          	auipc	s5,0x1c
    8000468c:	7b8a8a93          	addi	s5,s5,1976 # 80020e40 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80004690:	0001ca17          	auipc	s4,0x1c
    80004694:	780a0a13          	addi	s4,s4,1920 # 80020e10 <log>
    80004698:	018a2583          	lw	a1,24(s4)
    8000469c:	012585bb          	addw	a1,a1,s2
    800046a0:	2585                	addiw	a1,a1,1
    800046a2:	028a2503          	lw	a0,40(s4)
    800046a6:	fffff097          	auipc	ra,0xfffff
    800046aa:	cf6080e7          	jalr	-778(ra) # 8000339c <bread>
    800046ae:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800046b0:	000aa583          	lw	a1,0(s5)
    800046b4:	028a2503          	lw	a0,40(s4)
    800046b8:	fffff097          	auipc	ra,0xfffff
    800046bc:	ce4080e7          	jalr	-796(ra) # 8000339c <bread>
    800046c0:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    800046c2:	40000613          	li	a2,1024
    800046c6:	05850593          	addi	a1,a0,88
    800046ca:	05848513          	addi	a0,s1,88
    800046ce:	ffffc097          	auipc	ra,0xffffc
    800046d2:	6a2080e7          	jalr	1698(ra) # 80000d70 <memmove>
    bwrite(to);  // write the log
    800046d6:	8526                	mv	a0,s1
    800046d8:	fffff097          	auipc	ra,0xfffff
    800046dc:	db6080e7          	jalr	-586(ra) # 8000348e <bwrite>
    brelse(from);
    800046e0:	854e                	mv	a0,s3
    800046e2:	fffff097          	auipc	ra,0xfffff
    800046e6:	dea080e7          	jalr	-534(ra) # 800034cc <brelse>
    brelse(to);
    800046ea:	8526                	mv	a0,s1
    800046ec:	fffff097          	auipc	ra,0xfffff
    800046f0:	de0080e7          	jalr	-544(ra) # 800034cc <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800046f4:	2905                	addiw	s2,s2,1
    800046f6:	0a91                	addi	s5,s5,4
    800046f8:	02ca2783          	lw	a5,44(s4)
    800046fc:	f8f94ee3          	blt	s2,a5,80004698 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80004700:	00000097          	auipc	ra,0x0
    80004704:	c8c080e7          	jalr	-884(ra) # 8000438c <write_head>
    install_trans(0); // Now install writes to home locations
    80004708:	4501                	li	a0,0
    8000470a:	00000097          	auipc	ra,0x0
    8000470e:	cec080e7          	jalr	-788(ra) # 800043f6 <install_trans>
    log.lh.n = 0;
    80004712:	0001c797          	auipc	a5,0x1c
    80004716:	7207a523          	sw	zero,1834(a5) # 80020e3c <log+0x2c>
    write_head();    // Erase the transaction from the log
    8000471a:	00000097          	auipc	ra,0x0
    8000471e:	c72080e7          	jalr	-910(ra) # 8000438c <write_head>
    80004722:	bdf5                	j	8000461e <end_op+0x52>

0000000080004724 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80004724:	1101                	addi	sp,sp,-32
    80004726:	ec06                	sd	ra,24(sp)
    80004728:	e822                	sd	s0,16(sp)
    8000472a:	e426                	sd	s1,8(sp)
    8000472c:	e04a                	sd	s2,0(sp)
    8000472e:	1000                	addi	s0,sp,32
    80004730:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    80004732:	0001c917          	auipc	s2,0x1c
    80004736:	6de90913          	addi	s2,s2,1758 # 80020e10 <log>
    8000473a:	854a                	mv	a0,s2
    8000473c:	ffffc097          	auipc	ra,0xffffc
    80004740:	4dc080e7          	jalr	1244(ra) # 80000c18 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80004744:	02c92603          	lw	a2,44(s2)
    80004748:	47f5                	li	a5,29
    8000474a:	06c7c563          	blt	a5,a2,800047b4 <log_write+0x90>
    8000474e:	0001c797          	auipc	a5,0x1c
    80004752:	6de7a783          	lw	a5,1758(a5) # 80020e2c <log+0x1c>
    80004756:	37fd                	addiw	a5,a5,-1
    80004758:	04f65e63          	bge	a2,a5,800047b4 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    8000475c:	0001c797          	auipc	a5,0x1c
    80004760:	6d47a783          	lw	a5,1748(a5) # 80020e30 <log+0x20>
    80004764:	06f05063          	blez	a5,800047c4 <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80004768:	4781                	li	a5,0
    8000476a:	06c05563          	blez	a2,800047d4 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000476e:	44cc                	lw	a1,12(s1)
    80004770:	0001c717          	auipc	a4,0x1c
    80004774:	6d070713          	addi	a4,a4,1744 # 80020e40 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    80004778:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000477a:	4314                	lw	a3,0(a4)
    8000477c:	04b68c63          	beq	a3,a1,800047d4 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    80004780:	2785                	addiw	a5,a5,1
    80004782:	0711                	addi	a4,a4,4
    80004784:	fef61be3          	bne	a2,a5,8000477a <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    80004788:	0621                	addi	a2,a2,8
    8000478a:	060a                	slli	a2,a2,0x2
    8000478c:	0001c797          	auipc	a5,0x1c
    80004790:	68478793          	addi	a5,a5,1668 # 80020e10 <log>
    80004794:	97b2                	add	a5,a5,a2
    80004796:	44d8                	lw	a4,12(s1)
    80004798:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    8000479a:	8526                	mv	a0,s1
    8000479c:	fffff097          	auipc	ra,0xfffff
    800047a0:	dcc080e7          	jalr	-564(ra) # 80003568 <bpin>
    log.lh.n++;
    800047a4:	0001c717          	auipc	a4,0x1c
    800047a8:	66c70713          	addi	a4,a4,1644 # 80020e10 <log>
    800047ac:	575c                	lw	a5,44(a4)
    800047ae:	2785                	addiw	a5,a5,1
    800047b0:	d75c                	sw	a5,44(a4)
    800047b2:	a82d                	j	800047ec <log_write+0xc8>
    panic("too big a transaction");
    800047b4:	00004517          	auipc	a0,0x4
    800047b8:	f4c50513          	addi	a0,a0,-180 # 80008700 <syscalls+0x208>
    800047bc:	ffffc097          	auipc	ra,0xffffc
    800047c0:	dc6080e7          	jalr	-570(ra) # 80000582 <panic>
    panic("log_write outside of trans");
    800047c4:	00004517          	auipc	a0,0x4
    800047c8:	f5450513          	addi	a0,a0,-172 # 80008718 <syscalls+0x220>
    800047cc:	ffffc097          	auipc	ra,0xffffc
    800047d0:	db6080e7          	jalr	-586(ra) # 80000582 <panic>
  log.lh.block[i] = b->blockno;
    800047d4:	00878693          	addi	a3,a5,8
    800047d8:	068a                	slli	a3,a3,0x2
    800047da:	0001c717          	auipc	a4,0x1c
    800047de:	63670713          	addi	a4,a4,1590 # 80020e10 <log>
    800047e2:	9736                	add	a4,a4,a3
    800047e4:	44d4                	lw	a3,12(s1)
    800047e6:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    800047e8:	faf609e3          	beq	a2,a5,8000479a <log_write+0x76>
  }
  release(&log.lock);
    800047ec:	0001c517          	auipc	a0,0x1c
    800047f0:	62450513          	addi	a0,a0,1572 # 80020e10 <log>
    800047f4:	ffffc097          	auipc	ra,0xffffc
    800047f8:	4d8080e7          	jalr	1240(ra) # 80000ccc <release>
}
    800047fc:	60e2                	ld	ra,24(sp)
    800047fe:	6442                	ld	s0,16(sp)
    80004800:	64a2                	ld	s1,8(sp)
    80004802:	6902                	ld	s2,0(sp)
    80004804:	6105                	addi	sp,sp,32
    80004806:	8082                	ret

0000000080004808 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80004808:	1101                	addi	sp,sp,-32
    8000480a:	ec06                	sd	ra,24(sp)
    8000480c:	e822                	sd	s0,16(sp)
    8000480e:	e426                	sd	s1,8(sp)
    80004810:	e04a                	sd	s2,0(sp)
    80004812:	1000                	addi	s0,sp,32
    80004814:	84aa                	mv	s1,a0
    80004816:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80004818:	00004597          	auipc	a1,0x4
    8000481c:	f2058593          	addi	a1,a1,-224 # 80008738 <syscalls+0x240>
    80004820:	0521                	addi	a0,a0,8
    80004822:	ffffc097          	auipc	ra,0xffffc
    80004826:	366080e7          	jalr	870(ra) # 80000b88 <initlock>
  lk->name = name;
    8000482a:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    8000482e:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80004832:	0204a423          	sw	zero,40(s1)
}
    80004836:	60e2                	ld	ra,24(sp)
    80004838:	6442                	ld	s0,16(sp)
    8000483a:	64a2                	ld	s1,8(sp)
    8000483c:	6902                	ld	s2,0(sp)
    8000483e:	6105                	addi	sp,sp,32
    80004840:	8082                	ret

0000000080004842 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80004842:	1101                	addi	sp,sp,-32
    80004844:	ec06                	sd	ra,24(sp)
    80004846:	e822                	sd	s0,16(sp)
    80004848:	e426                	sd	s1,8(sp)
    8000484a:	e04a                	sd	s2,0(sp)
    8000484c:	1000                	addi	s0,sp,32
    8000484e:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80004850:	00850913          	addi	s2,a0,8
    80004854:	854a                	mv	a0,s2
    80004856:	ffffc097          	auipc	ra,0xffffc
    8000485a:	3c2080e7          	jalr	962(ra) # 80000c18 <acquire>
  while (lk->locked) {
    8000485e:	409c                	lw	a5,0(s1)
    80004860:	cb89                	beqz	a5,80004872 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80004862:	85ca                	mv	a1,s2
    80004864:	8526                	mv	a0,s1
    80004866:	ffffe097          	auipc	ra,0xffffe
    8000486a:	bb2080e7          	jalr	-1102(ra) # 80002418 <sleep>
  while (lk->locked) {
    8000486e:	409c                	lw	a5,0(s1)
    80004870:	fbed                	bnez	a5,80004862 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80004872:	4785                	li	a5,1
    80004874:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80004876:	ffffd097          	auipc	ra,0xffffd
    8000487a:	3de080e7          	jalr	990(ra) # 80001c54 <myproc>
    8000487e:	591c                	lw	a5,48(a0)
    80004880:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80004882:	854a                	mv	a0,s2
    80004884:	ffffc097          	auipc	ra,0xffffc
    80004888:	448080e7          	jalr	1096(ra) # 80000ccc <release>
}
    8000488c:	60e2                	ld	ra,24(sp)
    8000488e:	6442                	ld	s0,16(sp)
    80004890:	64a2                	ld	s1,8(sp)
    80004892:	6902                	ld	s2,0(sp)
    80004894:	6105                	addi	sp,sp,32
    80004896:	8082                	ret

0000000080004898 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80004898:	1101                	addi	sp,sp,-32
    8000489a:	ec06                	sd	ra,24(sp)
    8000489c:	e822                	sd	s0,16(sp)
    8000489e:	e426                	sd	s1,8(sp)
    800048a0:	e04a                	sd	s2,0(sp)
    800048a2:	1000                	addi	s0,sp,32
    800048a4:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800048a6:	00850913          	addi	s2,a0,8
    800048aa:	854a                	mv	a0,s2
    800048ac:	ffffc097          	auipc	ra,0xffffc
    800048b0:	36c080e7          	jalr	876(ra) # 80000c18 <acquire>
  lk->locked = 0;
    800048b4:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800048b8:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    800048bc:	8526                	mv	a0,s1
    800048be:	ffffe097          	auipc	ra,0xffffe
    800048c2:	bbe080e7          	jalr	-1090(ra) # 8000247c <wakeup>
  release(&lk->lk);
    800048c6:	854a                	mv	a0,s2
    800048c8:	ffffc097          	auipc	ra,0xffffc
    800048cc:	404080e7          	jalr	1028(ra) # 80000ccc <release>
}
    800048d0:	60e2                	ld	ra,24(sp)
    800048d2:	6442                	ld	s0,16(sp)
    800048d4:	64a2                	ld	s1,8(sp)
    800048d6:	6902                	ld	s2,0(sp)
    800048d8:	6105                	addi	sp,sp,32
    800048da:	8082                	ret

00000000800048dc <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800048dc:	7179                	addi	sp,sp,-48
    800048de:	f406                	sd	ra,40(sp)
    800048e0:	f022                	sd	s0,32(sp)
    800048e2:	ec26                	sd	s1,24(sp)
    800048e4:	e84a                	sd	s2,16(sp)
    800048e6:	e44e                	sd	s3,8(sp)
    800048e8:	1800                	addi	s0,sp,48
    800048ea:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    800048ec:	00850913          	addi	s2,a0,8
    800048f0:	854a                	mv	a0,s2
    800048f2:	ffffc097          	auipc	ra,0xffffc
    800048f6:	326080e7          	jalr	806(ra) # 80000c18 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800048fa:	409c                	lw	a5,0(s1)
    800048fc:	ef99                	bnez	a5,8000491a <holdingsleep+0x3e>
    800048fe:	4481                	li	s1,0
  release(&lk->lk);
    80004900:	854a                	mv	a0,s2
    80004902:	ffffc097          	auipc	ra,0xffffc
    80004906:	3ca080e7          	jalr	970(ra) # 80000ccc <release>
  return r;
}
    8000490a:	8526                	mv	a0,s1
    8000490c:	70a2                	ld	ra,40(sp)
    8000490e:	7402                	ld	s0,32(sp)
    80004910:	64e2                	ld	s1,24(sp)
    80004912:	6942                	ld	s2,16(sp)
    80004914:	69a2                	ld	s3,8(sp)
    80004916:	6145                	addi	sp,sp,48
    80004918:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    8000491a:	0284a983          	lw	s3,40(s1)
    8000491e:	ffffd097          	auipc	ra,0xffffd
    80004922:	336080e7          	jalr	822(ra) # 80001c54 <myproc>
    80004926:	5904                	lw	s1,48(a0)
    80004928:	413484b3          	sub	s1,s1,s3
    8000492c:	0014b493          	seqz	s1,s1
    80004930:	bfc1                	j	80004900 <holdingsleep+0x24>

0000000080004932 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80004932:	1141                	addi	sp,sp,-16
    80004934:	e406                	sd	ra,8(sp)
    80004936:	e022                	sd	s0,0(sp)
    80004938:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    8000493a:	00004597          	auipc	a1,0x4
    8000493e:	e0e58593          	addi	a1,a1,-498 # 80008748 <syscalls+0x250>
    80004942:	0001c517          	auipc	a0,0x1c
    80004946:	61650513          	addi	a0,a0,1558 # 80020f58 <ftable>
    8000494a:	ffffc097          	auipc	ra,0xffffc
    8000494e:	23e080e7          	jalr	574(ra) # 80000b88 <initlock>
}
    80004952:	60a2                	ld	ra,8(sp)
    80004954:	6402                	ld	s0,0(sp)
    80004956:	0141                	addi	sp,sp,16
    80004958:	8082                	ret

000000008000495a <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    8000495a:	1101                	addi	sp,sp,-32
    8000495c:	ec06                	sd	ra,24(sp)
    8000495e:	e822                	sd	s0,16(sp)
    80004960:	e426                	sd	s1,8(sp)
    80004962:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80004964:	0001c517          	auipc	a0,0x1c
    80004968:	5f450513          	addi	a0,a0,1524 # 80020f58 <ftable>
    8000496c:	ffffc097          	auipc	ra,0xffffc
    80004970:	2ac080e7          	jalr	684(ra) # 80000c18 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80004974:	0001c497          	auipc	s1,0x1c
    80004978:	5fc48493          	addi	s1,s1,1532 # 80020f70 <ftable+0x18>
    8000497c:	0001d717          	auipc	a4,0x1d
    80004980:	59470713          	addi	a4,a4,1428 # 80021f10 <disk>
    if(f->ref == 0){
    80004984:	40dc                	lw	a5,4(s1)
    80004986:	cf99                	beqz	a5,800049a4 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80004988:	02848493          	addi	s1,s1,40
    8000498c:	fee49ce3          	bne	s1,a4,80004984 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80004990:	0001c517          	auipc	a0,0x1c
    80004994:	5c850513          	addi	a0,a0,1480 # 80020f58 <ftable>
    80004998:	ffffc097          	auipc	ra,0xffffc
    8000499c:	334080e7          	jalr	820(ra) # 80000ccc <release>
  return 0;
    800049a0:	4481                	li	s1,0
    800049a2:	a819                	j	800049b8 <filealloc+0x5e>
      f->ref = 1;
    800049a4:	4785                	li	a5,1
    800049a6:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    800049a8:	0001c517          	auipc	a0,0x1c
    800049ac:	5b050513          	addi	a0,a0,1456 # 80020f58 <ftable>
    800049b0:	ffffc097          	auipc	ra,0xffffc
    800049b4:	31c080e7          	jalr	796(ra) # 80000ccc <release>
}
    800049b8:	8526                	mv	a0,s1
    800049ba:	60e2                	ld	ra,24(sp)
    800049bc:	6442                	ld	s0,16(sp)
    800049be:	64a2                	ld	s1,8(sp)
    800049c0:	6105                	addi	sp,sp,32
    800049c2:	8082                	ret

00000000800049c4 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    800049c4:	1101                	addi	sp,sp,-32
    800049c6:	ec06                	sd	ra,24(sp)
    800049c8:	e822                	sd	s0,16(sp)
    800049ca:	e426                	sd	s1,8(sp)
    800049cc:	1000                	addi	s0,sp,32
    800049ce:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    800049d0:	0001c517          	auipc	a0,0x1c
    800049d4:	58850513          	addi	a0,a0,1416 # 80020f58 <ftable>
    800049d8:	ffffc097          	auipc	ra,0xffffc
    800049dc:	240080e7          	jalr	576(ra) # 80000c18 <acquire>
  if(f->ref < 1)
    800049e0:	40dc                	lw	a5,4(s1)
    800049e2:	02f05263          	blez	a5,80004a06 <filedup+0x42>
    panic("filedup");
  f->ref++;
    800049e6:	2785                	addiw	a5,a5,1
    800049e8:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    800049ea:	0001c517          	auipc	a0,0x1c
    800049ee:	56e50513          	addi	a0,a0,1390 # 80020f58 <ftable>
    800049f2:	ffffc097          	auipc	ra,0xffffc
    800049f6:	2da080e7          	jalr	730(ra) # 80000ccc <release>
  return f;
}
    800049fa:	8526                	mv	a0,s1
    800049fc:	60e2                	ld	ra,24(sp)
    800049fe:	6442                	ld	s0,16(sp)
    80004a00:	64a2                	ld	s1,8(sp)
    80004a02:	6105                	addi	sp,sp,32
    80004a04:	8082                	ret
    panic("filedup");
    80004a06:	00004517          	auipc	a0,0x4
    80004a0a:	d4a50513          	addi	a0,a0,-694 # 80008750 <syscalls+0x258>
    80004a0e:	ffffc097          	auipc	ra,0xffffc
    80004a12:	b74080e7          	jalr	-1164(ra) # 80000582 <panic>

0000000080004a16 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80004a16:	7139                	addi	sp,sp,-64
    80004a18:	fc06                	sd	ra,56(sp)
    80004a1a:	f822                	sd	s0,48(sp)
    80004a1c:	f426                	sd	s1,40(sp)
    80004a1e:	f04a                	sd	s2,32(sp)
    80004a20:	ec4e                	sd	s3,24(sp)
    80004a22:	e852                	sd	s4,16(sp)
    80004a24:	e456                	sd	s5,8(sp)
    80004a26:	0080                	addi	s0,sp,64
    80004a28:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80004a2a:	0001c517          	auipc	a0,0x1c
    80004a2e:	52e50513          	addi	a0,a0,1326 # 80020f58 <ftable>
    80004a32:	ffffc097          	auipc	ra,0xffffc
    80004a36:	1e6080e7          	jalr	486(ra) # 80000c18 <acquire>
  if(f->ref < 1)
    80004a3a:	40dc                	lw	a5,4(s1)
    80004a3c:	06f05163          	blez	a5,80004a9e <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    80004a40:	37fd                	addiw	a5,a5,-1
    80004a42:	0007871b          	sext.w	a4,a5
    80004a46:	c0dc                	sw	a5,4(s1)
    80004a48:	06e04363          	bgtz	a4,80004aae <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80004a4c:	0004a903          	lw	s2,0(s1)
    80004a50:	0094ca83          	lbu	s5,9(s1)
    80004a54:	0104ba03          	ld	s4,16(s1)
    80004a58:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80004a5c:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80004a60:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80004a64:	0001c517          	auipc	a0,0x1c
    80004a68:	4f450513          	addi	a0,a0,1268 # 80020f58 <ftable>
    80004a6c:	ffffc097          	auipc	ra,0xffffc
    80004a70:	260080e7          	jalr	608(ra) # 80000ccc <release>

  if(ff.type == FD_PIPE){
    80004a74:	4785                	li	a5,1
    80004a76:	04f90d63          	beq	s2,a5,80004ad0 <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80004a7a:	3979                	addiw	s2,s2,-2
    80004a7c:	4785                	li	a5,1
    80004a7e:	0527e063          	bltu	a5,s2,80004abe <fileclose+0xa8>
    begin_op();
    80004a82:	00000097          	auipc	ra,0x0
    80004a86:	ad0080e7          	jalr	-1328(ra) # 80004552 <begin_op>
    iput(ff.ip);
    80004a8a:	854e                	mv	a0,s3
    80004a8c:	fffff097          	auipc	ra,0xfffff
    80004a90:	2da080e7          	jalr	730(ra) # 80003d66 <iput>
    end_op();
    80004a94:	00000097          	auipc	ra,0x0
    80004a98:	b38080e7          	jalr	-1224(ra) # 800045cc <end_op>
    80004a9c:	a00d                	j	80004abe <fileclose+0xa8>
    panic("fileclose");
    80004a9e:	00004517          	auipc	a0,0x4
    80004aa2:	cba50513          	addi	a0,a0,-838 # 80008758 <syscalls+0x260>
    80004aa6:	ffffc097          	auipc	ra,0xffffc
    80004aaa:	adc080e7          	jalr	-1316(ra) # 80000582 <panic>
    release(&ftable.lock);
    80004aae:	0001c517          	auipc	a0,0x1c
    80004ab2:	4aa50513          	addi	a0,a0,1194 # 80020f58 <ftable>
    80004ab6:	ffffc097          	auipc	ra,0xffffc
    80004aba:	216080e7          	jalr	534(ra) # 80000ccc <release>
  }
}
    80004abe:	70e2                	ld	ra,56(sp)
    80004ac0:	7442                	ld	s0,48(sp)
    80004ac2:	74a2                	ld	s1,40(sp)
    80004ac4:	7902                	ld	s2,32(sp)
    80004ac6:	69e2                	ld	s3,24(sp)
    80004ac8:	6a42                	ld	s4,16(sp)
    80004aca:	6aa2                	ld	s5,8(sp)
    80004acc:	6121                	addi	sp,sp,64
    80004ace:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80004ad0:	85d6                	mv	a1,s5
    80004ad2:	8552                	mv	a0,s4
    80004ad4:	00000097          	auipc	ra,0x0
    80004ad8:	348080e7          	jalr	840(ra) # 80004e1c <pipeclose>
    80004adc:	b7cd                	j	80004abe <fileclose+0xa8>

0000000080004ade <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80004ade:	715d                	addi	sp,sp,-80
    80004ae0:	e486                	sd	ra,72(sp)
    80004ae2:	e0a2                	sd	s0,64(sp)
    80004ae4:	fc26                	sd	s1,56(sp)
    80004ae6:	f84a                	sd	s2,48(sp)
    80004ae8:	f44e                	sd	s3,40(sp)
    80004aea:	0880                	addi	s0,sp,80
    80004aec:	84aa                	mv	s1,a0
    80004aee:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80004af0:	ffffd097          	auipc	ra,0xffffd
    80004af4:	164080e7          	jalr	356(ra) # 80001c54 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80004af8:	409c                	lw	a5,0(s1)
    80004afa:	37f9                	addiw	a5,a5,-2
    80004afc:	4705                	li	a4,1
    80004afe:	04f76763          	bltu	a4,a5,80004b4c <filestat+0x6e>
    80004b02:	892a                	mv	s2,a0
    ilock(f->ip);
    80004b04:	6c88                	ld	a0,24(s1)
    80004b06:	fffff097          	auipc	ra,0xfffff
    80004b0a:	0a6080e7          	jalr	166(ra) # 80003bac <ilock>
    stati(f->ip, &st);
    80004b0e:	fb840593          	addi	a1,s0,-72
    80004b12:	6c88                	ld	a0,24(s1)
    80004b14:	fffff097          	auipc	ra,0xfffff
    80004b18:	322080e7          	jalr	802(ra) # 80003e36 <stati>
    iunlock(f->ip);
    80004b1c:	6c88                	ld	a0,24(s1)
    80004b1e:	fffff097          	auipc	ra,0xfffff
    80004b22:	150080e7          	jalr	336(ra) # 80003c6e <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80004b26:	46e1                	li	a3,24
    80004b28:	fb840613          	addi	a2,s0,-72
    80004b2c:	85ce                	mv	a1,s3
    80004b2e:	05893503          	ld	a0,88(s2)
    80004b32:	ffffd097          	auipc	ra,0xffffd
    80004b36:	b7a080e7          	jalr	-1158(ra) # 800016ac <copyout>
    80004b3a:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80004b3e:	60a6                	ld	ra,72(sp)
    80004b40:	6406                	ld	s0,64(sp)
    80004b42:	74e2                	ld	s1,56(sp)
    80004b44:	7942                	ld	s2,48(sp)
    80004b46:	79a2                	ld	s3,40(sp)
    80004b48:	6161                	addi	sp,sp,80
    80004b4a:	8082                	ret
  return -1;
    80004b4c:	557d                	li	a0,-1
    80004b4e:	bfc5                	j	80004b3e <filestat+0x60>

0000000080004b50 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80004b50:	7179                	addi	sp,sp,-48
    80004b52:	f406                	sd	ra,40(sp)
    80004b54:	f022                	sd	s0,32(sp)
    80004b56:	ec26                	sd	s1,24(sp)
    80004b58:	e84a                	sd	s2,16(sp)
    80004b5a:	e44e                	sd	s3,8(sp)
    80004b5c:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80004b5e:	00854783          	lbu	a5,8(a0)
    80004b62:	c3d5                	beqz	a5,80004c06 <fileread+0xb6>
    80004b64:	84aa                	mv	s1,a0
    80004b66:	89ae                	mv	s3,a1
    80004b68:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80004b6a:	411c                	lw	a5,0(a0)
    80004b6c:	4705                	li	a4,1
    80004b6e:	04e78963          	beq	a5,a4,80004bc0 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80004b72:	470d                	li	a4,3
    80004b74:	04e78d63          	beq	a5,a4,80004bce <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80004b78:	4709                	li	a4,2
    80004b7a:	06e79e63          	bne	a5,a4,80004bf6 <fileread+0xa6>
    ilock(f->ip);
    80004b7e:	6d08                	ld	a0,24(a0)
    80004b80:	fffff097          	auipc	ra,0xfffff
    80004b84:	02c080e7          	jalr	44(ra) # 80003bac <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80004b88:	874a                	mv	a4,s2
    80004b8a:	5094                	lw	a3,32(s1)
    80004b8c:	864e                	mv	a2,s3
    80004b8e:	4585                	li	a1,1
    80004b90:	6c88                	ld	a0,24(s1)
    80004b92:	fffff097          	auipc	ra,0xfffff
    80004b96:	2ce080e7          	jalr	718(ra) # 80003e60 <readi>
    80004b9a:	892a                	mv	s2,a0
    80004b9c:	00a05563          	blez	a0,80004ba6 <fileread+0x56>
      f->off += r;
    80004ba0:	509c                	lw	a5,32(s1)
    80004ba2:	9fa9                	addw	a5,a5,a0
    80004ba4:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80004ba6:	6c88                	ld	a0,24(s1)
    80004ba8:	fffff097          	auipc	ra,0xfffff
    80004bac:	0c6080e7          	jalr	198(ra) # 80003c6e <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80004bb0:	854a                	mv	a0,s2
    80004bb2:	70a2                	ld	ra,40(sp)
    80004bb4:	7402                	ld	s0,32(sp)
    80004bb6:	64e2                	ld	s1,24(sp)
    80004bb8:	6942                	ld	s2,16(sp)
    80004bba:	69a2                	ld	s3,8(sp)
    80004bbc:	6145                	addi	sp,sp,48
    80004bbe:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80004bc0:	6908                	ld	a0,16(a0)
    80004bc2:	00000097          	auipc	ra,0x0
    80004bc6:	3c2080e7          	jalr	962(ra) # 80004f84 <piperead>
    80004bca:	892a                	mv	s2,a0
    80004bcc:	b7d5                	j	80004bb0 <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80004bce:	02451783          	lh	a5,36(a0)
    80004bd2:	03079693          	slli	a3,a5,0x30
    80004bd6:	92c1                	srli	a3,a3,0x30
    80004bd8:	4725                	li	a4,9
    80004bda:	02d76863          	bltu	a4,a3,80004c0a <fileread+0xba>
    80004bde:	0792                	slli	a5,a5,0x4
    80004be0:	0001c717          	auipc	a4,0x1c
    80004be4:	2d870713          	addi	a4,a4,728 # 80020eb8 <devsw>
    80004be8:	97ba                	add	a5,a5,a4
    80004bea:	639c                	ld	a5,0(a5)
    80004bec:	c38d                	beqz	a5,80004c0e <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80004bee:	4505                	li	a0,1
    80004bf0:	9782                	jalr	a5
    80004bf2:	892a                	mv	s2,a0
    80004bf4:	bf75                	j	80004bb0 <fileread+0x60>
    panic("fileread");
    80004bf6:	00004517          	auipc	a0,0x4
    80004bfa:	b7250513          	addi	a0,a0,-1166 # 80008768 <syscalls+0x270>
    80004bfe:	ffffc097          	auipc	ra,0xffffc
    80004c02:	984080e7          	jalr	-1660(ra) # 80000582 <panic>
    return -1;
    80004c06:	597d                	li	s2,-1
    80004c08:	b765                	j	80004bb0 <fileread+0x60>
      return -1;
    80004c0a:	597d                	li	s2,-1
    80004c0c:	b755                	j	80004bb0 <fileread+0x60>
    80004c0e:	597d                	li	s2,-1
    80004c10:	b745                	j	80004bb0 <fileread+0x60>

0000000080004c12 <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    80004c12:	00954783          	lbu	a5,9(a0)
    80004c16:	10078e63          	beqz	a5,80004d32 <filewrite+0x120>
{
    80004c1a:	715d                	addi	sp,sp,-80
    80004c1c:	e486                	sd	ra,72(sp)
    80004c1e:	e0a2                	sd	s0,64(sp)
    80004c20:	fc26                	sd	s1,56(sp)
    80004c22:	f84a                	sd	s2,48(sp)
    80004c24:	f44e                	sd	s3,40(sp)
    80004c26:	f052                	sd	s4,32(sp)
    80004c28:	ec56                	sd	s5,24(sp)
    80004c2a:	e85a                	sd	s6,16(sp)
    80004c2c:	e45e                	sd	s7,8(sp)
    80004c2e:	e062                	sd	s8,0(sp)
    80004c30:	0880                	addi	s0,sp,80
    80004c32:	892a                	mv	s2,a0
    80004c34:	8b2e                	mv	s6,a1
    80004c36:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    80004c38:	411c                	lw	a5,0(a0)
    80004c3a:	4705                	li	a4,1
    80004c3c:	02e78263          	beq	a5,a4,80004c60 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80004c40:	470d                	li	a4,3
    80004c42:	02e78563          	beq	a5,a4,80004c6c <filewrite+0x5a>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80004c46:	4709                	li	a4,2
    80004c48:	0ce79d63          	bne	a5,a4,80004d22 <filewrite+0x110>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80004c4c:	0ac05b63          	blez	a2,80004d02 <filewrite+0xf0>
    int i = 0;
    80004c50:	4981                	li	s3,0
      int n1 = n - i;
      if(n1 > max)
    80004c52:	6b85                	lui	s7,0x1
    80004c54:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80004c58:	6c05                	lui	s8,0x1
    80004c5a:	c00c0c1b          	addiw	s8,s8,-1024 # c00 <_entry-0x7ffff400>
    80004c5e:	a851                	j	80004cf2 <filewrite+0xe0>
    ret = pipewrite(f->pipe, addr, n);
    80004c60:	6908                	ld	a0,16(a0)
    80004c62:	00000097          	auipc	ra,0x0
    80004c66:	22a080e7          	jalr	554(ra) # 80004e8c <pipewrite>
    80004c6a:	a045                	j	80004d0a <filewrite+0xf8>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80004c6c:	02451783          	lh	a5,36(a0)
    80004c70:	03079693          	slli	a3,a5,0x30
    80004c74:	92c1                	srli	a3,a3,0x30
    80004c76:	4725                	li	a4,9
    80004c78:	0ad76f63          	bltu	a4,a3,80004d36 <filewrite+0x124>
    80004c7c:	0792                	slli	a5,a5,0x4
    80004c7e:	0001c717          	auipc	a4,0x1c
    80004c82:	23a70713          	addi	a4,a4,570 # 80020eb8 <devsw>
    80004c86:	97ba                	add	a5,a5,a4
    80004c88:	679c                	ld	a5,8(a5)
    80004c8a:	cbc5                	beqz	a5,80004d3a <filewrite+0x128>
    ret = devsw[f->major].write(1, addr, n);
    80004c8c:	4505                	li	a0,1
    80004c8e:	9782                	jalr	a5
    80004c90:	a8ad                	j	80004d0a <filewrite+0xf8>
      if(n1 > max)
    80004c92:	00048a9b          	sext.w	s5,s1
        n1 = max;

      begin_op();
    80004c96:	00000097          	auipc	ra,0x0
    80004c9a:	8bc080e7          	jalr	-1860(ra) # 80004552 <begin_op>
      ilock(f->ip);
    80004c9e:	01893503          	ld	a0,24(s2)
    80004ca2:	fffff097          	auipc	ra,0xfffff
    80004ca6:	f0a080e7          	jalr	-246(ra) # 80003bac <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80004caa:	8756                	mv	a4,s5
    80004cac:	02092683          	lw	a3,32(s2)
    80004cb0:	01698633          	add	a2,s3,s6
    80004cb4:	4585                	li	a1,1
    80004cb6:	01893503          	ld	a0,24(s2)
    80004cba:	fffff097          	auipc	ra,0xfffff
    80004cbe:	29e080e7          	jalr	670(ra) # 80003f58 <writei>
    80004cc2:	84aa                	mv	s1,a0
    80004cc4:	00a05763          	blez	a0,80004cd2 <filewrite+0xc0>
        f->off += r;
    80004cc8:	02092783          	lw	a5,32(s2)
    80004ccc:	9fa9                	addw	a5,a5,a0
    80004cce:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80004cd2:	01893503          	ld	a0,24(s2)
    80004cd6:	fffff097          	auipc	ra,0xfffff
    80004cda:	f98080e7          	jalr	-104(ra) # 80003c6e <iunlock>
      end_op();
    80004cde:	00000097          	auipc	ra,0x0
    80004ce2:	8ee080e7          	jalr	-1810(ra) # 800045cc <end_op>

      if(r != n1){
    80004ce6:	009a9f63          	bne	s5,s1,80004d04 <filewrite+0xf2>
        // error from writei
        break;
      }
      i += r;
    80004cea:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80004cee:	0149db63          	bge	s3,s4,80004d04 <filewrite+0xf2>
      int n1 = n - i;
    80004cf2:	413a04bb          	subw	s1,s4,s3
      if(n1 > max)
    80004cf6:	0004879b          	sext.w	a5,s1
    80004cfa:	f8fbdce3          	bge	s7,a5,80004c92 <filewrite+0x80>
    80004cfe:	84e2                	mv	s1,s8
    80004d00:	bf49                	j	80004c92 <filewrite+0x80>
    int i = 0;
    80004d02:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80004d04:	033a1d63          	bne	s4,s3,80004d3e <filewrite+0x12c>
    80004d08:	8552                	mv	a0,s4
  } else {
    panic("filewrite");
  }

  return ret;
}
    80004d0a:	60a6                	ld	ra,72(sp)
    80004d0c:	6406                	ld	s0,64(sp)
    80004d0e:	74e2                	ld	s1,56(sp)
    80004d10:	7942                	ld	s2,48(sp)
    80004d12:	79a2                	ld	s3,40(sp)
    80004d14:	7a02                	ld	s4,32(sp)
    80004d16:	6ae2                	ld	s5,24(sp)
    80004d18:	6b42                	ld	s6,16(sp)
    80004d1a:	6ba2                	ld	s7,8(sp)
    80004d1c:	6c02                	ld	s8,0(sp)
    80004d1e:	6161                	addi	sp,sp,80
    80004d20:	8082                	ret
    panic("filewrite");
    80004d22:	00004517          	auipc	a0,0x4
    80004d26:	a5650513          	addi	a0,a0,-1450 # 80008778 <syscalls+0x280>
    80004d2a:	ffffc097          	auipc	ra,0xffffc
    80004d2e:	858080e7          	jalr	-1960(ra) # 80000582 <panic>
    return -1;
    80004d32:	557d                	li	a0,-1
}
    80004d34:	8082                	ret
      return -1;
    80004d36:	557d                	li	a0,-1
    80004d38:	bfc9                	j	80004d0a <filewrite+0xf8>
    80004d3a:	557d                	li	a0,-1
    80004d3c:	b7f9                	j	80004d0a <filewrite+0xf8>
    ret = (i == n ? n : -1);
    80004d3e:	557d                	li	a0,-1
    80004d40:	b7e9                	j	80004d0a <filewrite+0xf8>

0000000080004d42 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80004d42:	7179                	addi	sp,sp,-48
    80004d44:	f406                	sd	ra,40(sp)
    80004d46:	f022                	sd	s0,32(sp)
    80004d48:	ec26                	sd	s1,24(sp)
    80004d4a:	e84a                	sd	s2,16(sp)
    80004d4c:	e44e                	sd	s3,8(sp)
    80004d4e:	e052                	sd	s4,0(sp)
    80004d50:	1800                	addi	s0,sp,48
    80004d52:	84aa                	mv	s1,a0
    80004d54:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80004d56:	0005b023          	sd	zero,0(a1)
    80004d5a:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80004d5e:	00000097          	auipc	ra,0x0
    80004d62:	bfc080e7          	jalr	-1028(ra) # 8000495a <filealloc>
    80004d66:	e088                	sd	a0,0(s1)
    80004d68:	c551                	beqz	a0,80004df4 <pipealloc+0xb2>
    80004d6a:	00000097          	auipc	ra,0x0
    80004d6e:	bf0080e7          	jalr	-1040(ra) # 8000495a <filealloc>
    80004d72:	00aa3023          	sd	a0,0(s4)
    80004d76:	c92d                	beqz	a0,80004de8 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80004d78:	ffffc097          	auipc	ra,0xffffc
    80004d7c:	db0080e7          	jalr	-592(ra) # 80000b28 <kalloc>
    80004d80:	892a                	mv	s2,a0
    80004d82:	c125                	beqz	a0,80004de2 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80004d84:	4985                	li	s3,1
    80004d86:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80004d8a:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80004d8e:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80004d92:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80004d96:	00004597          	auipc	a1,0x4
    80004d9a:	9f258593          	addi	a1,a1,-1550 # 80008788 <syscalls+0x290>
    80004d9e:	ffffc097          	auipc	ra,0xffffc
    80004da2:	dea080e7          	jalr	-534(ra) # 80000b88 <initlock>
  (*f0)->type = FD_PIPE;
    80004da6:	609c                	ld	a5,0(s1)
    80004da8:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80004dac:	609c                	ld	a5,0(s1)
    80004dae:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80004db2:	609c                	ld	a5,0(s1)
    80004db4:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80004db8:	609c                	ld	a5,0(s1)
    80004dba:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80004dbe:	000a3783          	ld	a5,0(s4)
    80004dc2:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80004dc6:	000a3783          	ld	a5,0(s4)
    80004dca:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80004dce:	000a3783          	ld	a5,0(s4)
    80004dd2:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80004dd6:	000a3783          	ld	a5,0(s4)
    80004dda:	0127b823          	sd	s2,16(a5)
  return 0;
    80004dde:	4501                	li	a0,0
    80004de0:	a025                	j	80004e08 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80004de2:	6088                	ld	a0,0(s1)
    80004de4:	e501                	bnez	a0,80004dec <pipealloc+0xaa>
    80004de6:	a039                	j	80004df4 <pipealloc+0xb2>
    80004de8:	6088                	ld	a0,0(s1)
    80004dea:	c51d                	beqz	a0,80004e18 <pipealloc+0xd6>
    fileclose(*f0);
    80004dec:	00000097          	auipc	ra,0x0
    80004df0:	c2a080e7          	jalr	-982(ra) # 80004a16 <fileclose>
  if(*f1)
    80004df4:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80004df8:	557d                	li	a0,-1
  if(*f1)
    80004dfa:	c799                	beqz	a5,80004e08 <pipealloc+0xc6>
    fileclose(*f1);
    80004dfc:	853e                	mv	a0,a5
    80004dfe:	00000097          	auipc	ra,0x0
    80004e02:	c18080e7          	jalr	-1000(ra) # 80004a16 <fileclose>
  return -1;
    80004e06:	557d                	li	a0,-1
}
    80004e08:	70a2                	ld	ra,40(sp)
    80004e0a:	7402                	ld	s0,32(sp)
    80004e0c:	64e2                	ld	s1,24(sp)
    80004e0e:	6942                	ld	s2,16(sp)
    80004e10:	69a2                	ld	s3,8(sp)
    80004e12:	6a02                	ld	s4,0(sp)
    80004e14:	6145                	addi	sp,sp,48
    80004e16:	8082                	ret
  return -1;
    80004e18:	557d                	li	a0,-1
    80004e1a:	b7fd                	j	80004e08 <pipealloc+0xc6>

0000000080004e1c <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80004e1c:	1101                	addi	sp,sp,-32
    80004e1e:	ec06                	sd	ra,24(sp)
    80004e20:	e822                	sd	s0,16(sp)
    80004e22:	e426                	sd	s1,8(sp)
    80004e24:	e04a                	sd	s2,0(sp)
    80004e26:	1000                	addi	s0,sp,32
    80004e28:	84aa                	mv	s1,a0
    80004e2a:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80004e2c:	ffffc097          	auipc	ra,0xffffc
    80004e30:	dec080e7          	jalr	-532(ra) # 80000c18 <acquire>
  if(writable){
    80004e34:	02090d63          	beqz	s2,80004e6e <pipeclose+0x52>
    pi->writeopen = 0;
    80004e38:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80004e3c:	21848513          	addi	a0,s1,536
    80004e40:	ffffd097          	auipc	ra,0xffffd
    80004e44:	63c080e7          	jalr	1596(ra) # 8000247c <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80004e48:	2204b783          	ld	a5,544(s1)
    80004e4c:	eb95                	bnez	a5,80004e80 <pipeclose+0x64>
    release(&pi->lock);
    80004e4e:	8526                	mv	a0,s1
    80004e50:	ffffc097          	auipc	ra,0xffffc
    80004e54:	e7c080e7          	jalr	-388(ra) # 80000ccc <release>
    kfree((char*)pi);
    80004e58:	8526                	mv	a0,s1
    80004e5a:	ffffc097          	auipc	ra,0xffffc
    80004e5e:	bd0080e7          	jalr	-1072(ra) # 80000a2a <kfree>
  } else
    release(&pi->lock);
}
    80004e62:	60e2                	ld	ra,24(sp)
    80004e64:	6442                	ld	s0,16(sp)
    80004e66:	64a2                	ld	s1,8(sp)
    80004e68:	6902                	ld	s2,0(sp)
    80004e6a:	6105                	addi	sp,sp,32
    80004e6c:	8082                	ret
    pi->readopen = 0;
    80004e6e:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80004e72:	21c48513          	addi	a0,s1,540
    80004e76:	ffffd097          	auipc	ra,0xffffd
    80004e7a:	606080e7          	jalr	1542(ra) # 8000247c <wakeup>
    80004e7e:	b7e9                	j	80004e48 <pipeclose+0x2c>
    release(&pi->lock);
    80004e80:	8526                	mv	a0,s1
    80004e82:	ffffc097          	auipc	ra,0xffffc
    80004e86:	e4a080e7          	jalr	-438(ra) # 80000ccc <release>
}
    80004e8a:	bfe1                	j	80004e62 <pipeclose+0x46>

0000000080004e8c <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80004e8c:	711d                	addi	sp,sp,-96
    80004e8e:	ec86                	sd	ra,88(sp)
    80004e90:	e8a2                	sd	s0,80(sp)
    80004e92:	e4a6                	sd	s1,72(sp)
    80004e94:	e0ca                	sd	s2,64(sp)
    80004e96:	fc4e                	sd	s3,56(sp)
    80004e98:	f852                	sd	s4,48(sp)
    80004e9a:	f456                	sd	s5,40(sp)
    80004e9c:	f05a                	sd	s6,32(sp)
    80004e9e:	ec5e                	sd	s7,24(sp)
    80004ea0:	e862                	sd	s8,16(sp)
    80004ea2:	1080                	addi	s0,sp,96
    80004ea4:	84aa                	mv	s1,a0
    80004ea6:	8aae                	mv	s5,a1
    80004ea8:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80004eaa:	ffffd097          	auipc	ra,0xffffd
    80004eae:	daa080e7          	jalr	-598(ra) # 80001c54 <myproc>
    80004eb2:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80004eb4:	8526                	mv	a0,s1
    80004eb6:	ffffc097          	auipc	ra,0xffffc
    80004eba:	d62080e7          	jalr	-670(ra) # 80000c18 <acquire>
  while(i < n){
    80004ebe:	0b405663          	blez	s4,80004f6a <pipewrite+0xde>
  int i = 0;
    80004ec2:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004ec4:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80004ec6:	21848c13          	addi	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80004eca:	21c48b93          	addi	s7,s1,540
    80004ece:	a089                	j	80004f10 <pipewrite+0x84>
      release(&pi->lock);
    80004ed0:	8526                	mv	a0,s1
    80004ed2:	ffffc097          	auipc	ra,0xffffc
    80004ed6:	dfa080e7          	jalr	-518(ra) # 80000ccc <release>
      return -1;
    80004eda:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80004edc:	854a                	mv	a0,s2
    80004ede:	60e6                	ld	ra,88(sp)
    80004ee0:	6446                	ld	s0,80(sp)
    80004ee2:	64a6                	ld	s1,72(sp)
    80004ee4:	6906                	ld	s2,64(sp)
    80004ee6:	79e2                	ld	s3,56(sp)
    80004ee8:	7a42                	ld	s4,48(sp)
    80004eea:	7aa2                	ld	s5,40(sp)
    80004eec:	7b02                	ld	s6,32(sp)
    80004eee:	6be2                	ld	s7,24(sp)
    80004ef0:	6c42                	ld	s8,16(sp)
    80004ef2:	6125                	addi	sp,sp,96
    80004ef4:	8082                	ret
      wakeup(&pi->nread);
    80004ef6:	8562                	mv	a0,s8
    80004ef8:	ffffd097          	auipc	ra,0xffffd
    80004efc:	584080e7          	jalr	1412(ra) # 8000247c <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80004f00:	85a6                	mv	a1,s1
    80004f02:	855e                	mv	a0,s7
    80004f04:	ffffd097          	auipc	ra,0xffffd
    80004f08:	514080e7          	jalr	1300(ra) # 80002418 <sleep>
  while(i < n){
    80004f0c:	07495063          	bge	s2,s4,80004f6c <pipewrite+0xe0>
    if(pi->readopen == 0 || killed(pr)){
    80004f10:	2204a783          	lw	a5,544(s1)
    80004f14:	dfd5                	beqz	a5,80004ed0 <pipewrite+0x44>
    80004f16:	854e                	mv	a0,s3
    80004f18:	ffffd097          	auipc	ra,0xffffd
    80004f1c:	7a8080e7          	jalr	1960(ra) # 800026c0 <killed>
    80004f20:	f945                	bnez	a0,80004ed0 <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80004f22:	2184a783          	lw	a5,536(s1)
    80004f26:	21c4a703          	lw	a4,540(s1)
    80004f2a:	2007879b          	addiw	a5,a5,512
    80004f2e:	fcf704e3          	beq	a4,a5,80004ef6 <pipewrite+0x6a>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004f32:	4685                	li	a3,1
    80004f34:	01590633          	add	a2,s2,s5
    80004f38:	faf40593          	addi	a1,s0,-81
    80004f3c:	0589b503          	ld	a0,88(s3)
    80004f40:	ffffc097          	auipc	ra,0xffffc
    80004f44:	7f8080e7          	jalr	2040(ra) # 80001738 <copyin>
    80004f48:	03650263          	beq	a0,s6,80004f6c <pipewrite+0xe0>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004f4c:	21c4a783          	lw	a5,540(s1)
    80004f50:	0017871b          	addiw	a4,a5,1
    80004f54:	20e4ae23          	sw	a4,540(s1)
    80004f58:	1ff7f793          	andi	a5,a5,511
    80004f5c:	97a6                	add	a5,a5,s1
    80004f5e:	faf44703          	lbu	a4,-81(s0)
    80004f62:	00e78c23          	sb	a4,24(a5)
      i++;
    80004f66:	2905                	addiw	s2,s2,1
    80004f68:	b755                	j	80004f0c <pipewrite+0x80>
  int i = 0;
    80004f6a:	4901                	li	s2,0
  wakeup(&pi->nread);
    80004f6c:	21848513          	addi	a0,s1,536
    80004f70:	ffffd097          	auipc	ra,0xffffd
    80004f74:	50c080e7          	jalr	1292(ra) # 8000247c <wakeup>
  release(&pi->lock);
    80004f78:	8526                	mv	a0,s1
    80004f7a:	ffffc097          	auipc	ra,0xffffc
    80004f7e:	d52080e7          	jalr	-686(ra) # 80000ccc <release>
  return i;
    80004f82:	bfa9                	j	80004edc <pipewrite+0x50>

0000000080004f84 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80004f84:	715d                	addi	sp,sp,-80
    80004f86:	e486                	sd	ra,72(sp)
    80004f88:	e0a2                	sd	s0,64(sp)
    80004f8a:	fc26                	sd	s1,56(sp)
    80004f8c:	f84a                	sd	s2,48(sp)
    80004f8e:	f44e                	sd	s3,40(sp)
    80004f90:	f052                	sd	s4,32(sp)
    80004f92:	ec56                	sd	s5,24(sp)
    80004f94:	e85a                	sd	s6,16(sp)
    80004f96:	0880                	addi	s0,sp,80
    80004f98:	84aa                	mv	s1,a0
    80004f9a:	892e                	mv	s2,a1
    80004f9c:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80004f9e:	ffffd097          	auipc	ra,0xffffd
    80004fa2:	cb6080e7          	jalr	-842(ra) # 80001c54 <myproc>
    80004fa6:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80004fa8:	8526                	mv	a0,s1
    80004faa:	ffffc097          	auipc	ra,0xffffc
    80004fae:	c6e080e7          	jalr	-914(ra) # 80000c18 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004fb2:	2184a703          	lw	a4,536(s1)
    80004fb6:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004fba:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004fbe:	02f71763          	bne	a4,a5,80004fec <piperead+0x68>
    80004fc2:	2244a783          	lw	a5,548(s1)
    80004fc6:	c39d                	beqz	a5,80004fec <piperead+0x68>
    if(killed(pr)){
    80004fc8:	8552                	mv	a0,s4
    80004fca:	ffffd097          	auipc	ra,0xffffd
    80004fce:	6f6080e7          	jalr	1782(ra) # 800026c0 <killed>
    80004fd2:	e949                	bnez	a0,80005064 <piperead+0xe0>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004fd4:	85a6                	mv	a1,s1
    80004fd6:	854e                	mv	a0,s3
    80004fd8:	ffffd097          	auipc	ra,0xffffd
    80004fdc:	440080e7          	jalr	1088(ra) # 80002418 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004fe0:	2184a703          	lw	a4,536(s1)
    80004fe4:	21c4a783          	lw	a5,540(s1)
    80004fe8:	fcf70de3          	beq	a4,a5,80004fc2 <piperead+0x3e>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004fec:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004fee:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004ff0:	05505463          	blez	s5,80005038 <piperead+0xb4>
    if(pi->nread == pi->nwrite)
    80004ff4:	2184a783          	lw	a5,536(s1)
    80004ff8:	21c4a703          	lw	a4,540(s1)
    80004ffc:	02f70e63          	beq	a4,a5,80005038 <piperead+0xb4>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80005000:	0017871b          	addiw	a4,a5,1
    80005004:	20e4ac23          	sw	a4,536(s1)
    80005008:	1ff7f793          	andi	a5,a5,511
    8000500c:	97a6                	add	a5,a5,s1
    8000500e:	0187c783          	lbu	a5,24(a5)
    80005012:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80005016:	4685                	li	a3,1
    80005018:	fbf40613          	addi	a2,s0,-65
    8000501c:	85ca                	mv	a1,s2
    8000501e:	058a3503          	ld	a0,88(s4)
    80005022:	ffffc097          	auipc	ra,0xffffc
    80005026:	68a080e7          	jalr	1674(ra) # 800016ac <copyout>
    8000502a:	01650763          	beq	a0,s6,80005038 <piperead+0xb4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000502e:	2985                	addiw	s3,s3,1
    80005030:	0905                	addi	s2,s2,1
    80005032:	fd3a91e3          	bne	s5,s3,80004ff4 <piperead+0x70>
    80005036:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80005038:	21c48513          	addi	a0,s1,540
    8000503c:	ffffd097          	auipc	ra,0xffffd
    80005040:	440080e7          	jalr	1088(ra) # 8000247c <wakeup>
  release(&pi->lock);
    80005044:	8526                	mv	a0,s1
    80005046:	ffffc097          	auipc	ra,0xffffc
    8000504a:	c86080e7          	jalr	-890(ra) # 80000ccc <release>
  return i;
}
    8000504e:	854e                	mv	a0,s3
    80005050:	60a6                	ld	ra,72(sp)
    80005052:	6406                	ld	s0,64(sp)
    80005054:	74e2                	ld	s1,56(sp)
    80005056:	7942                	ld	s2,48(sp)
    80005058:	79a2                	ld	s3,40(sp)
    8000505a:	7a02                	ld	s4,32(sp)
    8000505c:	6ae2                	ld	s5,24(sp)
    8000505e:	6b42                	ld	s6,16(sp)
    80005060:	6161                	addi	sp,sp,80
    80005062:	8082                	ret
      release(&pi->lock);
    80005064:	8526                	mv	a0,s1
    80005066:	ffffc097          	auipc	ra,0xffffc
    8000506a:	c66080e7          	jalr	-922(ra) # 80000ccc <release>
      return -1;
    8000506e:	59fd                	li	s3,-1
    80005070:	bff9                	j	8000504e <piperead+0xca>

0000000080005072 <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    80005072:	1141                	addi	sp,sp,-16
    80005074:	e422                	sd	s0,8(sp)
    80005076:	0800                	addi	s0,sp,16
    80005078:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    8000507a:	8905                	andi	a0,a0,1
    8000507c:	050e                	slli	a0,a0,0x3
      perm = PTE_X;
    if(flags & 0x2)
    8000507e:	8b89                	andi	a5,a5,2
    80005080:	c399                	beqz	a5,80005086 <flags2perm+0x14>
      perm |= PTE_W;
    80005082:	00456513          	ori	a0,a0,4
    return perm;
}
    80005086:	6422                	ld	s0,8(sp)
    80005088:	0141                	addi	sp,sp,16
    8000508a:	8082                	ret

000000008000508c <exec>:

int
exec(char *path, char **argv)
{
    8000508c:	df010113          	addi	sp,sp,-528
    80005090:	20113423          	sd	ra,520(sp)
    80005094:	20813023          	sd	s0,512(sp)
    80005098:	ffa6                	sd	s1,504(sp)
    8000509a:	fbca                	sd	s2,496(sp)
    8000509c:	f7ce                	sd	s3,488(sp)
    8000509e:	f3d2                	sd	s4,480(sp)
    800050a0:	efd6                	sd	s5,472(sp)
    800050a2:	ebda                	sd	s6,464(sp)
    800050a4:	e7de                	sd	s7,456(sp)
    800050a6:	e3e2                	sd	s8,448(sp)
    800050a8:	ff66                	sd	s9,440(sp)
    800050aa:	fb6a                	sd	s10,432(sp)
    800050ac:	f76e                	sd	s11,424(sp)
    800050ae:	0c00                	addi	s0,sp,528
    800050b0:	892a                	mv	s2,a0
    800050b2:	dea43c23          	sd	a0,-520(s0)
    800050b6:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    800050ba:	ffffd097          	auipc	ra,0xffffd
    800050be:	b9a080e7          	jalr	-1126(ra) # 80001c54 <myproc>
    800050c2:	84aa                	mv	s1,a0

  begin_op();
    800050c4:	fffff097          	auipc	ra,0xfffff
    800050c8:	48e080e7          	jalr	1166(ra) # 80004552 <begin_op>

  if((ip = namei(path)) == 0){
    800050cc:	854a                	mv	a0,s2
    800050ce:	fffff097          	auipc	ra,0xfffff
    800050d2:	284080e7          	jalr	644(ra) # 80004352 <namei>
    800050d6:	c92d                	beqz	a0,80005148 <exec+0xbc>
    800050d8:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    800050da:	fffff097          	auipc	ra,0xfffff
    800050de:	ad2080e7          	jalr	-1326(ra) # 80003bac <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    800050e2:	04000713          	li	a4,64
    800050e6:	4681                	li	a3,0
    800050e8:	e5040613          	addi	a2,s0,-432
    800050ec:	4581                	li	a1,0
    800050ee:	8552                	mv	a0,s4
    800050f0:	fffff097          	auipc	ra,0xfffff
    800050f4:	d70080e7          	jalr	-656(ra) # 80003e60 <readi>
    800050f8:	04000793          	li	a5,64
    800050fc:	00f51a63          	bne	a0,a5,80005110 <exec+0x84>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    80005100:	e5042703          	lw	a4,-432(s0)
    80005104:	464c47b7          	lui	a5,0x464c4
    80005108:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    8000510c:	04f70463          	beq	a4,a5,80005154 <exec+0xc8>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80005110:	8552                	mv	a0,s4
    80005112:	fffff097          	auipc	ra,0xfffff
    80005116:	cfc080e7          	jalr	-772(ra) # 80003e0e <iunlockput>
    end_op();
    8000511a:	fffff097          	auipc	ra,0xfffff
    8000511e:	4b2080e7          	jalr	1202(ra) # 800045cc <end_op>
  }
  return -1;
    80005122:	557d                	li	a0,-1
}
    80005124:	20813083          	ld	ra,520(sp)
    80005128:	20013403          	ld	s0,512(sp)
    8000512c:	74fe                	ld	s1,504(sp)
    8000512e:	795e                	ld	s2,496(sp)
    80005130:	79be                	ld	s3,488(sp)
    80005132:	7a1e                	ld	s4,480(sp)
    80005134:	6afe                	ld	s5,472(sp)
    80005136:	6b5e                	ld	s6,464(sp)
    80005138:	6bbe                	ld	s7,456(sp)
    8000513a:	6c1e                	ld	s8,448(sp)
    8000513c:	7cfa                	ld	s9,440(sp)
    8000513e:	7d5a                	ld	s10,432(sp)
    80005140:	7dba                	ld	s11,424(sp)
    80005142:	21010113          	addi	sp,sp,528
    80005146:	8082                	ret
    end_op();
    80005148:	fffff097          	auipc	ra,0xfffff
    8000514c:	484080e7          	jalr	1156(ra) # 800045cc <end_op>
    return -1;
    80005150:	557d                	li	a0,-1
    80005152:	bfc9                	j	80005124 <exec+0x98>
  if((pagetable = proc_pagetable(p)) == 0)
    80005154:	8526                	mv	a0,s1
    80005156:	ffffd097          	auipc	ra,0xffffd
    8000515a:	bc2080e7          	jalr	-1086(ra) # 80001d18 <proc_pagetable>
    8000515e:	8b2a                	mv	s6,a0
    80005160:	d945                	beqz	a0,80005110 <exec+0x84>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80005162:	e7042d03          	lw	s10,-400(s0)
    80005166:	e8845783          	lhu	a5,-376(s0)
    8000516a:	10078463          	beqz	a5,80005272 <exec+0x1e6>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    8000516e:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80005170:	4d81                	li	s11,0
    if(ph.vaddr % PGSIZE != 0)
    80005172:	6c85                	lui	s9,0x1
    80005174:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    80005178:	def43823          	sd	a5,-528(s0)

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    8000517c:	6a85                	lui	s5,0x1
    8000517e:	a0b5                	j	800051ea <exec+0x15e>
      panic("loadseg: address should exist");
    80005180:	00003517          	auipc	a0,0x3
    80005184:	61050513          	addi	a0,a0,1552 # 80008790 <syscalls+0x298>
    80005188:	ffffb097          	auipc	ra,0xffffb
    8000518c:	3fa080e7          	jalr	1018(ra) # 80000582 <panic>
    if(sz - i < PGSIZE)
    80005190:	2481                	sext.w	s1,s1
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80005192:	8726                	mv	a4,s1
    80005194:	012c06bb          	addw	a3,s8,s2
    80005198:	4581                	li	a1,0
    8000519a:	8552                	mv	a0,s4
    8000519c:	fffff097          	auipc	ra,0xfffff
    800051a0:	cc4080e7          	jalr	-828(ra) # 80003e60 <readi>
    800051a4:	2501                	sext.w	a0,a0
    800051a6:	24a49863          	bne	s1,a0,800053f6 <exec+0x36a>
  for(i = 0; i < sz; i += PGSIZE){
    800051aa:	012a893b          	addw	s2,s5,s2
    800051ae:	03397563          	bgeu	s2,s3,800051d8 <exec+0x14c>
    pa = walkaddr(pagetable, va + i);
    800051b2:	02091593          	slli	a1,s2,0x20
    800051b6:	9181                	srli	a1,a1,0x20
    800051b8:	95de                	add	a1,a1,s7
    800051ba:	855a                	mv	a0,s6
    800051bc:	ffffc097          	auipc	ra,0xffffc
    800051c0:	ee0080e7          	jalr	-288(ra) # 8000109c <walkaddr>
    800051c4:	862a                	mv	a2,a0
    if(pa == 0)
    800051c6:	dd4d                	beqz	a0,80005180 <exec+0xf4>
    if(sz - i < PGSIZE)
    800051c8:	412984bb          	subw	s1,s3,s2
    800051cc:	0004879b          	sext.w	a5,s1
    800051d0:	fcfcf0e3          	bgeu	s9,a5,80005190 <exec+0x104>
    800051d4:	84d6                	mv	s1,s5
    800051d6:	bf6d                	j	80005190 <exec+0x104>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    800051d8:	e0843903          	ld	s2,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800051dc:	2d85                	addiw	s11,s11,1
    800051de:	038d0d1b          	addiw	s10,s10,56
    800051e2:	e8845783          	lhu	a5,-376(s0)
    800051e6:	08fdd763          	bge	s11,a5,80005274 <exec+0x1e8>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    800051ea:	2d01                	sext.w	s10,s10
    800051ec:	03800713          	li	a4,56
    800051f0:	86ea                	mv	a3,s10
    800051f2:	e1840613          	addi	a2,s0,-488
    800051f6:	4581                	li	a1,0
    800051f8:	8552                	mv	a0,s4
    800051fa:	fffff097          	auipc	ra,0xfffff
    800051fe:	c66080e7          	jalr	-922(ra) # 80003e60 <readi>
    80005202:	03800793          	li	a5,56
    80005206:	1ef51663          	bne	a0,a5,800053f2 <exec+0x366>
    if(ph.type != ELF_PROG_LOAD)
    8000520a:	e1842783          	lw	a5,-488(s0)
    8000520e:	4705                	li	a4,1
    80005210:	fce796e3          	bne	a5,a4,800051dc <exec+0x150>
    if(ph.memsz < ph.filesz)
    80005214:	e4043483          	ld	s1,-448(s0)
    80005218:	e3843783          	ld	a5,-456(s0)
    8000521c:	1ef4e863          	bltu	s1,a5,8000540c <exec+0x380>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80005220:	e2843783          	ld	a5,-472(s0)
    80005224:	94be                	add	s1,s1,a5
    80005226:	1ef4e663          	bltu	s1,a5,80005412 <exec+0x386>
    if(ph.vaddr % PGSIZE != 0)
    8000522a:	df043703          	ld	a4,-528(s0)
    8000522e:	8ff9                	and	a5,a5,a4
    80005230:	1e079463          	bnez	a5,80005418 <exec+0x38c>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80005234:	e1c42503          	lw	a0,-484(s0)
    80005238:	00000097          	auipc	ra,0x0
    8000523c:	e3a080e7          	jalr	-454(ra) # 80005072 <flags2perm>
    80005240:	86aa                	mv	a3,a0
    80005242:	8626                	mv	a2,s1
    80005244:	85ca                	mv	a1,s2
    80005246:	855a                	mv	a0,s6
    80005248:	ffffc097          	auipc	ra,0xffffc
    8000524c:	208080e7          	jalr	520(ra) # 80001450 <uvmalloc>
    80005250:	e0a43423          	sd	a0,-504(s0)
    80005254:	1c050563          	beqz	a0,8000541e <exec+0x392>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80005258:	e2843b83          	ld	s7,-472(s0)
    8000525c:	e2042c03          	lw	s8,-480(s0)
    80005260:	e3842983          	lw	s3,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80005264:	00098463          	beqz	s3,8000526c <exec+0x1e0>
    80005268:	4901                	li	s2,0
    8000526a:	b7a1                	j	800051b2 <exec+0x126>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    8000526c:	e0843903          	ld	s2,-504(s0)
    80005270:	b7b5                	j	800051dc <exec+0x150>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80005272:	4901                	li	s2,0
  iunlockput(ip);
    80005274:	8552                	mv	a0,s4
    80005276:	fffff097          	auipc	ra,0xfffff
    8000527a:	b98080e7          	jalr	-1128(ra) # 80003e0e <iunlockput>
  end_op();
    8000527e:	fffff097          	auipc	ra,0xfffff
    80005282:	34e080e7          	jalr	846(ra) # 800045cc <end_op>
  p = myproc();
    80005286:	ffffd097          	auipc	ra,0xffffd
    8000528a:	9ce080e7          	jalr	-1586(ra) # 80001c54 <myproc>
    8000528e:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    80005290:	05053c83          	ld	s9,80(a0)
  sz = PGROUNDUP(sz);
    80005294:	6985                	lui	s3,0x1
    80005296:	19fd                	addi	s3,s3,-1 # fff <_entry-0x7ffff001>
    80005298:	99ca                	add	s3,s3,s2
    8000529a:	77fd                	lui	a5,0xfffff
    8000529c:	00f9f9b3          	and	s3,s3,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    800052a0:	4691                	li	a3,4
    800052a2:	6609                	lui	a2,0x2
    800052a4:	964e                	add	a2,a2,s3
    800052a6:	85ce                	mv	a1,s3
    800052a8:	855a                	mv	a0,s6
    800052aa:	ffffc097          	auipc	ra,0xffffc
    800052ae:	1a6080e7          	jalr	422(ra) # 80001450 <uvmalloc>
    800052b2:	892a                	mv	s2,a0
    800052b4:	e0a43423          	sd	a0,-504(s0)
    800052b8:	e509                	bnez	a0,800052c2 <exec+0x236>
  if(pagetable)
    800052ba:	e1343423          	sd	s3,-504(s0)
    800052be:	4a01                	li	s4,0
    800052c0:	aa1d                	j	800053f6 <exec+0x36a>
  uvmclear(pagetable, sz-2*PGSIZE);
    800052c2:	75f9                	lui	a1,0xffffe
    800052c4:	95aa                	add	a1,a1,a0
    800052c6:	855a                	mv	a0,s6
    800052c8:	ffffc097          	auipc	ra,0xffffc
    800052cc:	3b2080e7          	jalr	946(ra) # 8000167a <uvmclear>
  stackbase = sp - PGSIZE;
    800052d0:	7bfd                	lui	s7,0xfffff
    800052d2:	9bca                	add	s7,s7,s2
  for(argc = 0; argv[argc]; argc++) {
    800052d4:	e0043783          	ld	a5,-512(s0)
    800052d8:	6388                	ld	a0,0(a5)
    800052da:	c52d                	beqz	a0,80005344 <exec+0x2b8>
    800052dc:	e9040993          	addi	s3,s0,-368
    800052e0:	f9040c13          	addi	s8,s0,-112
    800052e4:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    800052e6:	ffffc097          	auipc	ra,0xffffc
    800052ea:	ba8080e7          	jalr	-1112(ra) # 80000e8e <strlen>
    800052ee:	0015079b          	addiw	a5,a0,1
    800052f2:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    800052f6:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    800052fa:	13796563          	bltu	s2,s7,80005424 <exec+0x398>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    800052fe:	e0043d03          	ld	s10,-512(s0)
    80005302:	000d3a03          	ld	s4,0(s10)
    80005306:	8552                	mv	a0,s4
    80005308:	ffffc097          	auipc	ra,0xffffc
    8000530c:	b86080e7          	jalr	-1146(ra) # 80000e8e <strlen>
    80005310:	0015069b          	addiw	a3,a0,1
    80005314:	8652                	mv	a2,s4
    80005316:	85ca                	mv	a1,s2
    80005318:	855a                	mv	a0,s6
    8000531a:	ffffc097          	auipc	ra,0xffffc
    8000531e:	392080e7          	jalr	914(ra) # 800016ac <copyout>
    80005322:	10054363          	bltz	a0,80005428 <exec+0x39c>
    ustack[argc] = sp;
    80005326:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    8000532a:	0485                	addi	s1,s1,1
    8000532c:	008d0793          	addi	a5,s10,8
    80005330:	e0f43023          	sd	a5,-512(s0)
    80005334:	008d3503          	ld	a0,8(s10)
    80005338:	c909                	beqz	a0,8000534a <exec+0x2be>
    if(argc >= MAXARG)
    8000533a:	09a1                	addi	s3,s3,8
    8000533c:	fb8995e3          	bne	s3,s8,800052e6 <exec+0x25a>
  ip = 0;
    80005340:	4a01                	li	s4,0
    80005342:	a855                	j	800053f6 <exec+0x36a>
  sp = sz;
    80005344:	e0843903          	ld	s2,-504(s0)
  for(argc = 0; argv[argc]; argc++) {
    80005348:	4481                	li	s1,0
  ustack[argc] = 0;
    8000534a:	00349793          	slli	a5,s1,0x3
    8000534e:	f9078793          	addi	a5,a5,-112 # ffffffffffffef90 <end+0xffffffff7ffdcf40>
    80005352:	97a2                	add	a5,a5,s0
    80005354:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    80005358:	00148693          	addi	a3,s1,1
    8000535c:	068e                	slli	a3,a3,0x3
    8000535e:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80005362:	ff097913          	andi	s2,s2,-16
  sz = sz1;
    80005366:	e0843983          	ld	s3,-504(s0)
  if(sp < stackbase)
    8000536a:	f57968e3          	bltu	s2,s7,800052ba <exec+0x22e>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    8000536e:	e9040613          	addi	a2,s0,-368
    80005372:	85ca                	mv	a1,s2
    80005374:	855a                	mv	a0,s6
    80005376:	ffffc097          	auipc	ra,0xffffc
    8000537a:	336080e7          	jalr	822(ra) # 800016ac <copyout>
    8000537e:	0a054763          	bltz	a0,8000542c <exec+0x3a0>
  p->trapframe->a1 = sp;
    80005382:	060ab783          	ld	a5,96(s5) # 1060 <_entry-0x7fffefa0>
    80005386:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    8000538a:	df843783          	ld	a5,-520(s0)
    8000538e:	0007c703          	lbu	a4,0(a5)
    80005392:	cf11                	beqz	a4,800053ae <exec+0x322>
    80005394:	0785                	addi	a5,a5,1
    if(*s == '/')
    80005396:	02f00693          	li	a3,47
    8000539a:	a039                	j	800053a8 <exec+0x31c>
      last = s+1;
    8000539c:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    800053a0:	0785                	addi	a5,a5,1
    800053a2:	fff7c703          	lbu	a4,-1(a5)
    800053a6:	c701                	beqz	a4,800053ae <exec+0x322>
    if(*s == '/')
    800053a8:	fed71ce3          	bne	a4,a3,800053a0 <exec+0x314>
    800053ac:	bfc5                	j	8000539c <exec+0x310>
  safestrcpy(p->name, last, sizeof(p->name));
    800053ae:	4641                	li	a2,16
    800053b0:	df843583          	ld	a1,-520(s0)
    800053b4:	160a8513          	addi	a0,s5,352
    800053b8:	ffffc097          	auipc	ra,0xffffc
    800053bc:	aa4080e7          	jalr	-1372(ra) # 80000e5c <safestrcpy>
  oldpagetable = p->pagetable;
    800053c0:	058ab503          	ld	a0,88(s5)
  p->pagetable = pagetable;
    800053c4:	056abc23          	sd	s6,88(s5)
  p->sz = sz;
    800053c8:	e0843783          	ld	a5,-504(s0)
    800053cc:	04fab823          	sd	a5,80(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800053d0:	060ab783          	ld	a5,96(s5)
    800053d4:	e6843703          	ld	a4,-408(s0)
    800053d8:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800053da:	060ab783          	ld	a5,96(s5)
    800053de:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    800053e2:	85e6                	mv	a1,s9
    800053e4:	ffffd097          	auipc	ra,0xffffd
    800053e8:	9d0080e7          	jalr	-1584(ra) # 80001db4 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800053ec:	0004851b          	sext.w	a0,s1
    800053f0:	bb15                	j	80005124 <exec+0x98>
    800053f2:	e1243423          	sd	s2,-504(s0)
    proc_freepagetable(pagetable, sz);
    800053f6:	e0843583          	ld	a1,-504(s0)
    800053fa:	855a                	mv	a0,s6
    800053fc:	ffffd097          	auipc	ra,0xffffd
    80005400:	9b8080e7          	jalr	-1608(ra) # 80001db4 <proc_freepagetable>
  return -1;
    80005404:	557d                	li	a0,-1
  if(ip){
    80005406:	d00a0fe3          	beqz	s4,80005124 <exec+0x98>
    8000540a:	b319                	j	80005110 <exec+0x84>
    8000540c:	e1243423          	sd	s2,-504(s0)
    80005410:	b7dd                	j	800053f6 <exec+0x36a>
    80005412:	e1243423          	sd	s2,-504(s0)
    80005416:	b7c5                	j	800053f6 <exec+0x36a>
    80005418:	e1243423          	sd	s2,-504(s0)
    8000541c:	bfe9                	j	800053f6 <exec+0x36a>
    8000541e:	e1243423          	sd	s2,-504(s0)
    80005422:	bfd1                	j	800053f6 <exec+0x36a>
  ip = 0;
    80005424:	4a01                	li	s4,0
    80005426:	bfc1                	j	800053f6 <exec+0x36a>
    80005428:	4a01                	li	s4,0
  if(pagetable)
    8000542a:	b7f1                	j	800053f6 <exec+0x36a>
  sz = sz1;
    8000542c:	e0843983          	ld	s3,-504(s0)
    80005430:	b569                	j	800052ba <exec+0x22e>

0000000080005432 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80005432:	7179                	addi	sp,sp,-48
    80005434:	f406                	sd	ra,40(sp)
    80005436:	f022                	sd	s0,32(sp)
    80005438:	ec26                	sd	s1,24(sp)
    8000543a:	e84a                	sd	s2,16(sp)
    8000543c:	1800                	addi	s0,sp,48
    8000543e:	892e                	mv	s2,a1
    80005440:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    80005442:	fdc40593          	addi	a1,s0,-36
    80005446:	ffffe097          	auipc	ra,0xffffe
    8000544a:	b76080e7          	jalr	-1162(ra) # 80002fbc <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    8000544e:	fdc42703          	lw	a4,-36(s0)
    80005452:	47bd                	li	a5,15
    80005454:	02e7eb63          	bltu	a5,a4,8000548a <argfd+0x58>
    80005458:	ffffc097          	auipc	ra,0xffffc
    8000545c:	7fc080e7          	jalr	2044(ra) # 80001c54 <myproc>
    80005460:	fdc42703          	lw	a4,-36(s0)
    80005464:	01a70793          	addi	a5,a4,26
    80005468:	078e                	slli	a5,a5,0x3
    8000546a:	953e                	add	a0,a0,a5
    8000546c:	651c                	ld	a5,8(a0)
    8000546e:	c385                	beqz	a5,8000548e <argfd+0x5c>
    return -1;
  if(pfd)
    80005470:	00090463          	beqz	s2,80005478 <argfd+0x46>
    *pfd = fd;
    80005474:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80005478:	4501                	li	a0,0
  if(pf)
    8000547a:	c091                	beqz	s1,8000547e <argfd+0x4c>
    *pf = f;
    8000547c:	e09c                	sd	a5,0(s1)
}
    8000547e:	70a2                	ld	ra,40(sp)
    80005480:	7402                	ld	s0,32(sp)
    80005482:	64e2                	ld	s1,24(sp)
    80005484:	6942                	ld	s2,16(sp)
    80005486:	6145                	addi	sp,sp,48
    80005488:	8082                	ret
    return -1;
    8000548a:	557d                	li	a0,-1
    8000548c:	bfcd                	j	8000547e <argfd+0x4c>
    8000548e:	557d                	li	a0,-1
    80005490:	b7fd                	j	8000547e <argfd+0x4c>

0000000080005492 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80005492:	1101                	addi	sp,sp,-32
    80005494:	ec06                	sd	ra,24(sp)
    80005496:	e822                	sd	s0,16(sp)
    80005498:	e426                	sd	s1,8(sp)
    8000549a:	1000                	addi	s0,sp,32
    8000549c:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    8000549e:	ffffc097          	auipc	ra,0xffffc
    800054a2:	7b6080e7          	jalr	1974(ra) # 80001c54 <myproc>
    800054a6:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    800054a8:	0d850793          	addi	a5,a0,216
    800054ac:	4501                	li	a0,0
    800054ae:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    800054b0:	6398                	ld	a4,0(a5)
    800054b2:	cb19                	beqz	a4,800054c8 <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    800054b4:	2505                	addiw	a0,a0,1
    800054b6:	07a1                	addi	a5,a5,8
    800054b8:	fed51ce3          	bne	a0,a3,800054b0 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    800054bc:	557d                	li	a0,-1
}
    800054be:	60e2                	ld	ra,24(sp)
    800054c0:	6442                	ld	s0,16(sp)
    800054c2:	64a2                	ld	s1,8(sp)
    800054c4:	6105                	addi	sp,sp,32
    800054c6:	8082                	ret
      p->ofile[fd] = f;
    800054c8:	01a50793          	addi	a5,a0,26
    800054cc:	078e                	slli	a5,a5,0x3
    800054ce:	963e                	add	a2,a2,a5
    800054d0:	e604                	sd	s1,8(a2)
      return fd;
    800054d2:	b7f5                	j	800054be <fdalloc+0x2c>

00000000800054d4 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    800054d4:	715d                	addi	sp,sp,-80
    800054d6:	e486                	sd	ra,72(sp)
    800054d8:	e0a2                	sd	s0,64(sp)
    800054da:	fc26                	sd	s1,56(sp)
    800054dc:	f84a                	sd	s2,48(sp)
    800054de:	f44e                	sd	s3,40(sp)
    800054e0:	f052                	sd	s4,32(sp)
    800054e2:	ec56                	sd	s5,24(sp)
    800054e4:	e85a                	sd	s6,16(sp)
    800054e6:	0880                	addi	s0,sp,80
    800054e8:	8b2e                	mv	s6,a1
    800054ea:	89b2                	mv	s3,a2
    800054ec:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    800054ee:	fb040593          	addi	a1,s0,-80
    800054f2:	fffff097          	auipc	ra,0xfffff
    800054f6:	e7e080e7          	jalr	-386(ra) # 80004370 <nameiparent>
    800054fa:	84aa                	mv	s1,a0
    800054fc:	14050b63          	beqz	a0,80005652 <create+0x17e>
    return 0;

  ilock(dp);
    80005500:	ffffe097          	auipc	ra,0xffffe
    80005504:	6ac080e7          	jalr	1708(ra) # 80003bac <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80005508:	4601                	li	a2,0
    8000550a:	fb040593          	addi	a1,s0,-80
    8000550e:	8526                	mv	a0,s1
    80005510:	fffff097          	auipc	ra,0xfffff
    80005514:	b80080e7          	jalr	-1152(ra) # 80004090 <dirlookup>
    80005518:	8aaa                	mv	s5,a0
    8000551a:	c921                	beqz	a0,8000556a <create+0x96>
    iunlockput(dp);
    8000551c:	8526                	mv	a0,s1
    8000551e:	fffff097          	auipc	ra,0xfffff
    80005522:	8f0080e7          	jalr	-1808(ra) # 80003e0e <iunlockput>
    ilock(ip);
    80005526:	8556                	mv	a0,s5
    80005528:	ffffe097          	auipc	ra,0xffffe
    8000552c:	684080e7          	jalr	1668(ra) # 80003bac <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80005530:	4789                	li	a5,2
    80005532:	02fb1563          	bne	s6,a5,8000555c <create+0x88>
    80005536:	044ad783          	lhu	a5,68(s5)
    8000553a:	37f9                	addiw	a5,a5,-2
    8000553c:	17c2                	slli	a5,a5,0x30
    8000553e:	93c1                	srli	a5,a5,0x30
    80005540:	4705                	li	a4,1
    80005542:	00f76d63          	bltu	a4,a5,8000555c <create+0x88>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80005546:	8556                	mv	a0,s5
    80005548:	60a6                	ld	ra,72(sp)
    8000554a:	6406                	ld	s0,64(sp)
    8000554c:	74e2                	ld	s1,56(sp)
    8000554e:	7942                	ld	s2,48(sp)
    80005550:	79a2                	ld	s3,40(sp)
    80005552:	7a02                	ld	s4,32(sp)
    80005554:	6ae2                	ld	s5,24(sp)
    80005556:	6b42                	ld	s6,16(sp)
    80005558:	6161                	addi	sp,sp,80
    8000555a:	8082                	ret
    iunlockput(ip);
    8000555c:	8556                	mv	a0,s5
    8000555e:	fffff097          	auipc	ra,0xfffff
    80005562:	8b0080e7          	jalr	-1872(ra) # 80003e0e <iunlockput>
    return 0;
    80005566:	4a81                	li	s5,0
    80005568:	bff9                	j	80005546 <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0){
    8000556a:	85da                	mv	a1,s6
    8000556c:	4088                	lw	a0,0(s1)
    8000556e:	ffffe097          	auipc	ra,0xffffe
    80005572:	4a6080e7          	jalr	1190(ra) # 80003a14 <ialloc>
    80005576:	8a2a                	mv	s4,a0
    80005578:	c529                	beqz	a0,800055c2 <create+0xee>
  ilock(ip);
    8000557a:	ffffe097          	auipc	ra,0xffffe
    8000557e:	632080e7          	jalr	1586(ra) # 80003bac <ilock>
  ip->major = major;
    80005582:	053a1323          	sh	s3,70(s4)
  ip->minor = minor;
    80005586:	052a1423          	sh	s2,72(s4)
  ip->nlink = 1;
    8000558a:	4905                	li	s2,1
    8000558c:	052a1523          	sh	s2,74(s4)
  iupdate(ip);
    80005590:	8552                	mv	a0,s4
    80005592:	ffffe097          	auipc	ra,0xffffe
    80005596:	54e080e7          	jalr	1358(ra) # 80003ae0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    8000559a:	032b0b63          	beq	s6,s2,800055d0 <create+0xfc>
  if(dirlink(dp, name, ip->inum) < 0)
    8000559e:	004a2603          	lw	a2,4(s4)
    800055a2:	fb040593          	addi	a1,s0,-80
    800055a6:	8526                	mv	a0,s1
    800055a8:	fffff097          	auipc	ra,0xfffff
    800055ac:	cf8080e7          	jalr	-776(ra) # 800042a0 <dirlink>
    800055b0:	06054f63          	bltz	a0,8000562e <create+0x15a>
  iunlockput(dp);
    800055b4:	8526                	mv	a0,s1
    800055b6:	fffff097          	auipc	ra,0xfffff
    800055ba:	858080e7          	jalr	-1960(ra) # 80003e0e <iunlockput>
  return ip;
    800055be:	8ad2                	mv	s5,s4
    800055c0:	b759                	j	80005546 <create+0x72>
    iunlockput(dp);
    800055c2:	8526                	mv	a0,s1
    800055c4:	fffff097          	auipc	ra,0xfffff
    800055c8:	84a080e7          	jalr	-1974(ra) # 80003e0e <iunlockput>
    return 0;
    800055cc:	8ad2                	mv	s5,s4
    800055ce:	bfa5                	j	80005546 <create+0x72>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    800055d0:	004a2603          	lw	a2,4(s4)
    800055d4:	00003597          	auipc	a1,0x3
    800055d8:	1dc58593          	addi	a1,a1,476 # 800087b0 <syscalls+0x2b8>
    800055dc:	8552                	mv	a0,s4
    800055de:	fffff097          	auipc	ra,0xfffff
    800055e2:	cc2080e7          	jalr	-830(ra) # 800042a0 <dirlink>
    800055e6:	04054463          	bltz	a0,8000562e <create+0x15a>
    800055ea:	40d0                	lw	a2,4(s1)
    800055ec:	00003597          	auipc	a1,0x3
    800055f0:	1cc58593          	addi	a1,a1,460 # 800087b8 <syscalls+0x2c0>
    800055f4:	8552                	mv	a0,s4
    800055f6:	fffff097          	auipc	ra,0xfffff
    800055fa:	caa080e7          	jalr	-854(ra) # 800042a0 <dirlink>
    800055fe:	02054863          	bltz	a0,8000562e <create+0x15a>
  if(dirlink(dp, name, ip->inum) < 0)
    80005602:	004a2603          	lw	a2,4(s4)
    80005606:	fb040593          	addi	a1,s0,-80
    8000560a:	8526                	mv	a0,s1
    8000560c:	fffff097          	auipc	ra,0xfffff
    80005610:	c94080e7          	jalr	-876(ra) # 800042a0 <dirlink>
    80005614:	00054d63          	bltz	a0,8000562e <create+0x15a>
    dp->nlink++;  // for ".."
    80005618:	04a4d783          	lhu	a5,74(s1)
    8000561c:	2785                	addiw	a5,a5,1
    8000561e:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80005622:	8526                	mv	a0,s1
    80005624:	ffffe097          	auipc	ra,0xffffe
    80005628:	4bc080e7          	jalr	1212(ra) # 80003ae0 <iupdate>
    8000562c:	b761                	j	800055b4 <create+0xe0>
  ip->nlink = 0;
    8000562e:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    80005632:	8552                	mv	a0,s4
    80005634:	ffffe097          	auipc	ra,0xffffe
    80005638:	4ac080e7          	jalr	1196(ra) # 80003ae0 <iupdate>
  iunlockput(ip);
    8000563c:	8552                	mv	a0,s4
    8000563e:	ffffe097          	auipc	ra,0xffffe
    80005642:	7d0080e7          	jalr	2000(ra) # 80003e0e <iunlockput>
  iunlockput(dp);
    80005646:	8526                	mv	a0,s1
    80005648:	ffffe097          	auipc	ra,0xffffe
    8000564c:	7c6080e7          	jalr	1990(ra) # 80003e0e <iunlockput>
  return 0;
    80005650:	bddd                	j	80005546 <create+0x72>
    return 0;
    80005652:	8aaa                	mv	s5,a0
    80005654:	bdcd                	j	80005546 <create+0x72>

0000000080005656 <sys_dup>:
{
    80005656:	7179                	addi	sp,sp,-48
    80005658:	f406                	sd	ra,40(sp)
    8000565a:	f022                	sd	s0,32(sp)
    8000565c:	ec26                	sd	s1,24(sp)
    8000565e:	e84a                	sd	s2,16(sp)
    80005660:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80005662:	fd840613          	addi	a2,s0,-40
    80005666:	4581                	li	a1,0
    80005668:	4501                	li	a0,0
    8000566a:	00000097          	auipc	ra,0x0
    8000566e:	dc8080e7          	jalr	-568(ra) # 80005432 <argfd>
    return -1;
    80005672:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80005674:	02054363          	bltz	a0,8000569a <sys_dup+0x44>
  if((fd=fdalloc(f)) < 0)
    80005678:	fd843903          	ld	s2,-40(s0)
    8000567c:	854a                	mv	a0,s2
    8000567e:	00000097          	auipc	ra,0x0
    80005682:	e14080e7          	jalr	-492(ra) # 80005492 <fdalloc>
    80005686:	84aa                	mv	s1,a0
    return -1;
    80005688:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    8000568a:	00054863          	bltz	a0,8000569a <sys_dup+0x44>
  filedup(f);
    8000568e:	854a                	mv	a0,s2
    80005690:	fffff097          	auipc	ra,0xfffff
    80005694:	334080e7          	jalr	820(ra) # 800049c4 <filedup>
  return fd;
    80005698:	87a6                	mv	a5,s1
}
    8000569a:	853e                	mv	a0,a5
    8000569c:	70a2                	ld	ra,40(sp)
    8000569e:	7402                	ld	s0,32(sp)
    800056a0:	64e2                	ld	s1,24(sp)
    800056a2:	6942                	ld	s2,16(sp)
    800056a4:	6145                	addi	sp,sp,48
    800056a6:	8082                	ret

00000000800056a8 <sys_read>:
{
    800056a8:	7179                	addi	sp,sp,-48
    800056aa:	f406                	sd	ra,40(sp)
    800056ac:	f022                	sd	s0,32(sp)
    800056ae:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    800056b0:	fd840593          	addi	a1,s0,-40
    800056b4:	4505                	li	a0,1
    800056b6:	ffffe097          	auipc	ra,0xffffe
    800056ba:	926080e7          	jalr	-1754(ra) # 80002fdc <argaddr>
  argint(2, &n);
    800056be:	fe440593          	addi	a1,s0,-28
    800056c2:	4509                	li	a0,2
    800056c4:	ffffe097          	auipc	ra,0xffffe
    800056c8:	8f8080e7          	jalr	-1800(ra) # 80002fbc <argint>
  if(argfd(0, 0, &f) < 0)
    800056cc:	fe840613          	addi	a2,s0,-24
    800056d0:	4581                	li	a1,0
    800056d2:	4501                	li	a0,0
    800056d4:	00000097          	auipc	ra,0x0
    800056d8:	d5e080e7          	jalr	-674(ra) # 80005432 <argfd>
    800056dc:	87aa                	mv	a5,a0
    return -1;
    800056de:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800056e0:	0007cc63          	bltz	a5,800056f8 <sys_read+0x50>
  return fileread(f, p, n);
    800056e4:	fe442603          	lw	a2,-28(s0)
    800056e8:	fd843583          	ld	a1,-40(s0)
    800056ec:	fe843503          	ld	a0,-24(s0)
    800056f0:	fffff097          	auipc	ra,0xfffff
    800056f4:	460080e7          	jalr	1120(ra) # 80004b50 <fileread>
}
    800056f8:	70a2                	ld	ra,40(sp)
    800056fa:	7402                	ld	s0,32(sp)
    800056fc:	6145                	addi	sp,sp,48
    800056fe:	8082                	ret

0000000080005700 <sys_write>:
{
    80005700:	7179                	addi	sp,sp,-48
    80005702:	f406                	sd	ra,40(sp)
    80005704:	f022                	sd	s0,32(sp)
    80005706:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80005708:	fd840593          	addi	a1,s0,-40
    8000570c:	4505                	li	a0,1
    8000570e:	ffffe097          	auipc	ra,0xffffe
    80005712:	8ce080e7          	jalr	-1842(ra) # 80002fdc <argaddr>
  argint(2, &n);
    80005716:	fe440593          	addi	a1,s0,-28
    8000571a:	4509                	li	a0,2
    8000571c:	ffffe097          	auipc	ra,0xffffe
    80005720:	8a0080e7          	jalr	-1888(ra) # 80002fbc <argint>
  if(argfd(0, 0, &f) < 0)
    80005724:	fe840613          	addi	a2,s0,-24
    80005728:	4581                	li	a1,0
    8000572a:	4501                	li	a0,0
    8000572c:	00000097          	auipc	ra,0x0
    80005730:	d06080e7          	jalr	-762(ra) # 80005432 <argfd>
    80005734:	87aa                	mv	a5,a0
    return -1;
    80005736:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80005738:	0007cc63          	bltz	a5,80005750 <sys_write+0x50>
  return filewrite(f, p, n);
    8000573c:	fe442603          	lw	a2,-28(s0)
    80005740:	fd843583          	ld	a1,-40(s0)
    80005744:	fe843503          	ld	a0,-24(s0)
    80005748:	fffff097          	auipc	ra,0xfffff
    8000574c:	4ca080e7          	jalr	1226(ra) # 80004c12 <filewrite>
}
    80005750:	70a2                	ld	ra,40(sp)
    80005752:	7402                	ld	s0,32(sp)
    80005754:	6145                	addi	sp,sp,48
    80005756:	8082                	ret

0000000080005758 <sys_close>:
{
    80005758:	1101                	addi	sp,sp,-32
    8000575a:	ec06                	sd	ra,24(sp)
    8000575c:	e822                	sd	s0,16(sp)
    8000575e:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80005760:	fe040613          	addi	a2,s0,-32
    80005764:	fec40593          	addi	a1,s0,-20
    80005768:	4501                	li	a0,0
    8000576a:	00000097          	auipc	ra,0x0
    8000576e:	cc8080e7          	jalr	-824(ra) # 80005432 <argfd>
    return -1;
    80005772:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80005774:	02054463          	bltz	a0,8000579c <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80005778:	ffffc097          	auipc	ra,0xffffc
    8000577c:	4dc080e7          	jalr	1244(ra) # 80001c54 <myproc>
    80005780:	fec42783          	lw	a5,-20(s0)
    80005784:	07e9                	addi	a5,a5,26
    80005786:	078e                	slli	a5,a5,0x3
    80005788:	953e                	add	a0,a0,a5
    8000578a:	00053423          	sd	zero,8(a0)
  fileclose(f);
    8000578e:	fe043503          	ld	a0,-32(s0)
    80005792:	fffff097          	auipc	ra,0xfffff
    80005796:	284080e7          	jalr	644(ra) # 80004a16 <fileclose>
  return 0;
    8000579a:	4781                	li	a5,0
}
    8000579c:	853e                	mv	a0,a5
    8000579e:	60e2                	ld	ra,24(sp)
    800057a0:	6442                	ld	s0,16(sp)
    800057a2:	6105                	addi	sp,sp,32
    800057a4:	8082                	ret

00000000800057a6 <sys_fstat>:
{
    800057a6:	1101                	addi	sp,sp,-32
    800057a8:	ec06                	sd	ra,24(sp)
    800057aa:	e822                	sd	s0,16(sp)
    800057ac:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    800057ae:	fe040593          	addi	a1,s0,-32
    800057b2:	4505                	li	a0,1
    800057b4:	ffffe097          	auipc	ra,0xffffe
    800057b8:	828080e7          	jalr	-2008(ra) # 80002fdc <argaddr>
  if(argfd(0, 0, &f) < 0)
    800057bc:	fe840613          	addi	a2,s0,-24
    800057c0:	4581                	li	a1,0
    800057c2:	4501                	li	a0,0
    800057c4:	00000097          	auipc	ra,0x0
    800057c8:	c6e080e7          	jalr	-914(ra) # 80005432 <argfd>
    800057cc:	87aa                	mv	a5,a0
    return -1;
    800057ce:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800057d0:	0007ca63          	bltz	a5,800057e4 <sys_fstat+0x3e>
  return filestat(f, st);
    800057d4:	fe043583          	ld	a1,-32(s0)
    800057d8:	fe843503          	ld	a0,-24(s0)
    800057dc:	fffff097          	auipc	ra,0xfffff
    800057e0:	302080e7          	jalr	770(ra) # 80004ade <filestat>
}
    800057e4:	60e2                	ld	ra,24(sp)
    800057e6:	6442                	ld	s0,16(sp)
    800057e8:	6105                	addi	sp,sp,32
    800057ea:	8082                	ret

00000000800057ec <sys_link>:
{
    800057ec:	7169                	addi	sp,sp,-304
    800057ee:	f606                	sd	ra,296(sp)
    800057f0:	f222                	sd	s0,288(sp)
    800057f2:	ee26                	sd	s1,280(sp)
    800057f4:	ea4a                	sd	s2,272(sp)
    800057f6:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800057f8:	08000613          	li	a2,128
    800057fc:	ed040593          	addi	a1,s0,-304
    80005800:	4501                	li	a0,0
    80005802:	ffffd097          	auipc	ra,0xffffd
    80005806:	7fa080e7          	jalr	2042(ra) # 80002ffc <argstr>
    return -1;
    8000580a:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000580c:	10054e63          	bltz	a0,80005928 <sys_link+0x13c>
    80005810:	08000613          	li	a2,128
    80005814:	f5040593          	addi	a1,s0,-176
    80005818:	4505                	li	a0,1
    8000581a:	ffffd097          	auipc	ra,0xffffd
    8000581e:	7e2080e7          	jalr	2018(ra) # 80002ffc <argstr>
    return -1;
    80005822:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80005824:	10054263          	bltz	a0,80005928 <sys_link+0x13c>
  begin_op();
    80005828:	fffff097          	auipc	ra,0xfffff
    8000582c:	d2a080e7          	jalr	-726(ra) # 80004552 <begin_op>
  if((ip = namei(old)) == 0){
    80005830:	ed040513          	addi	a0,s0,-304
    80005834:	fffff097          	auipc	ra,0xfffff
    80005838:	b1e080e7          	jalr	-1250(ra) # 80004352 <namei>
    8000583c:	84aa                	mv	s1,a0
    8000583e:	c551                	beqz	a0,800058ca <sys_link+0xde>
  ilock(ip);
    80005840:	ffffe097          	auipc	ra,0xffffe
    80005844:	36c080e7          	jalr	876(ra) # 80003bac <ilock>
  if(ip->type == T_DIR){
    80005848:	04449703          	lh	a4,68(s1)
    8000584c:	4785                	li	a5,1
    8000584e:	08f70463          	beq	a4,a5,800058d6 <sys_link+0xea>
  ip->nlink++;
    80005852:	04a4d783          	lhu	a5,74(s1)
    80005856:	2785                	addiw	a5,a5,1
    80005858:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    8000585c:	8526                	mv	a0,s1
    8000585e:	ffffe097          	auipc	ra,0xffffe
    80005862:	282080e7          	jalr	642(ra) # 80003ae0 <iupdate>
  iunlock(ip);
    80005866:	8526                	mv	a0,s1
    80005868:	ffffe097          	auipc	ra,0xffffe
    8000586c:	406080e7          	jalr	1030(ra) # 80003c6e <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80005870:	fd040593          	addi	a1,s0,-48
    80005874:	f5040513          	addi	a0,s0,-176
    80005878:	fffff097          	auipc	ra,0xfffff
    8000587c:	af8080e7          	jalr	-1288(ra) # 80004370 <nameiparent>
    80005880:	892a                	mv	s2,a0
    80005882:	c935                	beqz	a0,800058f6 <sys_link+0x10a>
  ilock(dp);
    80005884:	ffffe097          	auipc	ra,0xffffe
    80005888:	328080e7          	jalr	808(ra) # 80003bac <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    8000588c:	00092703          	lw	a4,0(s2)
    80005890:	409c                	lw	a5,0(s1)
    80005892:	04f71d63          	bne	a4,a5,800058ec <sys_link+0x100>
    80005896:	40d0                	lw	a2,4(s1)
    80005898:	fd040593          	addi	a1,s0,-48
    8000589c:	854a                	mv	a0,s2
    8000589e:	fffff097          	auipc	ra,0xfffff
    800058a2:	a02080e7          	jalr	-1534(ra) # 800042a0 <dirlink>
    800058a6:	04054363          	bltz	a0,800058ec <sys_link+0x100>
  iunlockput(dp);
    800058aa:	854a                	mv	a0,s2
    800058ac:	ffffe097          	auipc	ra,0xffffe
    800058b0:	562080e7          	jalr	1378(ra) # 80003e0e <iunlockput>
  iput(ip);
    800058b4:	8526                	mv	a0,s1
    800058b6:	ffffe097          	auipc	ra,0xffffe
    800058ba:	4b0080e7          	jalr	1200(ra) # 80003d66 <iput>
  end_op();
    800058be:	fffff097          	auipc	ra,0xfffff
    800058c2:	d0e080e7          	jalr	-754(ra) # 800045cc <end_op>
  return 0;
    800058c6:	4781                	li	a5,0
    800058c8:	a085                	j	80005928 <sys_link+0x13c>
    end_op();
    800058ca:	fffff097          	auipc	ra,0xfffff
    800058ce:	d02080e7          	jalr	-766(ra) # 800045cc <end_op>
    return -1;
    800058d2:	57fd                	li	a5,-1
    800058d4:	a891                	j	80005928 <sys_link+0x13c>
    iunlockput(ip);
    800058d6:	8526                	mv	a0,s1
    800058d8:	ffffe097          	auipc	ra,0xffffe
    800058dc:	536080e7          	jalr	1334(ra) # 80003e0e <iunlockput>
    end_op();
    800058e0:	fffff097          	auipc	ra,0xfffff
    800058e4:	cec080e7          	jalr	-788(ra) # 800045cc <end_op>
    return -1;
    800058e8:	57fd                	li	a5,-1
    800058ea:	a83d                	j	80005928 <sys_link+0x13c>
    iunlockput(dp);
    800058ec:	854a                	mv	a0,s2
    800058ee:	ffffe097          	auipc	ra,0xffffe
    800058f2:	520080e7          	jalr	1312(ra) # 80003e0e <iunlockput>
  ilock(ip);
    800058f6:	8526                	mv	a0,s1
    800058f8:	ffffe097          	auipc	ra,0xffffe
    800058fc:	2b4080e7          	jalr	692(ra) # 80003bac <ilock>
  ip->nlink--;
    80005900:	04a4d783          	lhu	a5,74(s1)
    80005904:	37fd                	addiw	a5,a5,-1
    80005906:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    8000590a:	8526                	mv	a0,s1
    8000590c:	ffffe097          	auipc	ra,0xffffe
    80005910:	1d4080e7          	jalr	468(ra) # 80003ae0 <iupdate>
  iunlockput(ip);
    80005914:	8526                	mv	a0,s1
    80005916:	ffffe097          	auipc	ra,0xffffe
    8000591a:	4f8080e7          	jalr	1272(ra) # 80003e0e <iunlockput>
  end_op();
    8000591e:	fffff097          	auipc	ra,0xfffff
    80005922:	cae080e7          	jalr	-850(ra) # 800045cc <end_op>
  return -1;
    80005926:	57fd                	li	a5,-1
}
    80005928:	853e                	mv	a0,a5
    8000592a:	70b2                	ld	ra,296(sp)
    8000592c:	7412                	ld	s0,288(sp)
    8000592e:	64f2                	ld	s1,280(sp)
    80005930:	6952                	ld	s2,272(sp)
    80005932:	6155                	addi	sp,sp,304
    80005934:	8082                	ret

0000000080005936 <sys_unlink>:
{
    80005936:	7151                	addi	sp,sp,-240
    80005938:	f586                	sd	ra,232(sp)
    8000593a:	f1a2                	sd	s0,224(sp)
    8000593c:	eda6                	sd	s1,216(sp)
    8000593e:	e9ca                	sd	s2,208(sp)
    80005940:	e5ce                	sd	s3,200(sp)
    80005942:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80005944:	08000613          	li	a2,128
    80005948:	f3040593          	addi	a1,s0,-208
    8000594c:	4501                	li	a0,0
    8000594e:	ffffd097          	auipc	ra,0xffffd
    80005952:	6ae080e7          	jalr	1710(ra) # 80002ffc <argstr>
    80005956:	18054163          	bltz	a0,80005ad8 <sys_unlink+0x1a2>
  begin_op();
    8000595a:	fffff097          	auipc	ra,0xfffff
    8000595e:	bf8080e7          	jalr	-1032(ra) # 80004552 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80005962:	fb040593          	addi	a1,s0,-80
    80005966:	f3040513          	addi	a0,s0,-208
    8000596a:	fffff097          	auipc	ra,0xfffff
    8000596e:	a06080e7          	jalr	-1530(ra) # 80004370 <nameiparent>
    80005972:	84aa                	mv	s1,a0
    80005974:	c979                	beqz	a0,80005a4a <sys_unlink+0x114>
  ilock(dp);
    80005976:	ffffe097          	auipc	ra,0xffffe
    8000597a:	236080e7          	jalr	566(ra) # 80003bac <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    8000597e:	00003597          	auipc	a1,0x3
    80005982:	e3258593          	addi	a1,a1,-462 # 800087b0 <syscalls+0x2b8>
    80005986:	fb040513          	addi	a0,s0,-80
    8000598a:	ffffe097          	auipc	ra,0xffffe
    8000598e:	6ec080e7          	jalr	1772(ra) # 80004076 <namecmp>
    80005992:	14050a63          	beqz	a0,80005ae6 <sys_unlink+0x1b0>
    80005996:	00003597          	auipc	a1,0x3
    8000599a:	e2258593          	addi	a1,a1,-478 # 800087b8 <syscalls+0x2c0>
    8000599e:	fb040513          	addi	a0,s0,-80
    800059a2:	ffffe097          	auipc	ra,0xffffe
    800059a6:	6d4080e7          	jalr	1748(ra) # 80004076 <namecmp>
    800059aa:	12050e63          	beqz	a0,80005ae6 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    800059ae:	f2c40613          	addi	a2,s0,-212
    800059b2:	fb040593          	addi	a1,s0,-80
    800059b6:	8526                	mv	a0,s1
    800059b8:	ffffe097          	auipc	ra,0xffffe
    800059bc:	6d8080e7          	jalr	1752(ra) # 80004090 <dirlookup>
    800059c0:	892a                	mv	s2,a0
    800059c2:	12050263          	beqz	a0,80005ae6 <sys_unlink+0x1b0>
  ilock(ip);
    800059c6:	ffffe097          	auipc	ra,0xffffe
    800059ca:	1e6080e7          	jalr	486(ra) # 80003bac <ilock>
  if(ip->nlink < 1)
    800059ce:	04a91783          	lh	a5,74(s2)
    800059d2:	08f05263          	blez	a5,80005a56 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    800059d6:	04491703          	lh	a4,68(s2)
    800059da:	4785                	li	a5,1
    800059dc:	08f70563          	beq	a4,a5,80005a66 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    800059e0:	4641                	li	a2,16
    800059e2:	4581                	li	a1,0
    800059e4:	fc040513          	addi	a0,s0,-64
    800059e8:	ffffb097          	auipc	ra,0xffffb
    800059ec:	32c080e7          	jalr	812(ra) # 80000d14 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800059f0:	4741                	li	a4,16
    800059f2:	f2c42683          	lw	a3,-212(s0)
    800059f6:	fc040613          	addi	a2,s0,-64
    800059fa:	4581                	li	a1,0
    800059fc:	8526                	mv	a0,s1
    800059fe:	ffffe097          	auipc	ra,0xffffe
    80005a02:	55a080e7          	jalr	1370(ra) # 80003f58 <writei>
    80005a06:	47c1                	li	a5,16
    80005a08:	0af51563          	bne	a0,a5,80005ab2 <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    80005a0c:	04491703          	lh	a4,68(s2)
    80005a10:	4785                	li	a5,1
    80005a12:	0af70863          	beq	a4,a5,80005ac2 <sys_unlink+0x18c>
  iunlockput(dp);
    80005a16:	8526                	mv	a0,s1
    80005a18:	ffffe097          	auipc	ra,0xffffe
    80005a1c:	3f6080e7          	jalr	1014(ra) # 80003e0e <iunlockput>
  ip->nlink--;
    80005a20:	04a95783          	lhu	a5,74(s2)
    80005a24:	37fd                	addiw	a5,a5,-1
    80005a26:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80005a2a:	854a                	mv	a0,s2
    80005a2c:	ffffe097          	auipc	ra,0xffffe
    80005a30:	0b4080e7          	jalr	180(ra) # 80003ae0 <iupdate>
  iunlockput(ip);
    80005a34:	854a                	mv	a0,s2
    80005a36:	ffffe097          	auipc	ra,0xffffe
    80005a3a:	3d8080e7          	jalr	984(ra) # 80003e0e <iunlockput>
  end_op();
    80005a3e:	fffff097          	auipc	ra,0xfffff
    80005a42:	b8e080e7          	jalr	-1138(ra) # 800045cc <end_op>
  return 0;
    80005a46:	4501                	li	a0,0
    80005a48:	a84d                	j	80005afa <sys_unlink+0x1c4>
    end_op();
    80005a4a:	fffff097          	auipc	ra,0xfffff
    80005a4e:	b82080e7          	jalr	-1150(ra) # 800045cc <end_op>
    return -1;
    80005a52:	557d                	li	a0,-1
    80005a54:	a05d                	j	80005afa <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80005a56:	00003517          	auipc	a0,0x3
    80005a5a:	d6a50513          	addi	a0,a0,-662 # 800087c0 <syscalls+0x2c8>
    80005a5e:	ffffb097          	auipc	ra,0xffffb
    80005a62:	b24080e7          	jalr	-1244(ra) # 80000582 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005a66:	04c92703          	lw	a4,76(s2)
    80005a6a:	02000793          	li	a5,32
    80005a6e:	f6e7f9e3          	bgeu	a5,a4,800059e0 <sys_unlink+0xaa>
    80005a72:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005a76:	4741                	li	a4,16
    80005a78:	86ce                	mv	a3,s3
    80005a7a:	f1840613          	addi	a2,s0,-232
    80005a7e:	4581                	li	a1,0
    80005a80:	854a                	mv	a0,s2
    80005a82:	ffffe097          	auipc	ra,0xffffe
    80005a86:	3de080e7          	jalr	990(ra) # 80003e60 <readi>
    80005a8a:	47c1                	li	a5,16
    80005a8c:	00f51b63          	bne	a0,a5,80005aa2 <sys_unlink+0x16c>
    if(de.inum != 0)
    80005a90:	f1845783          	lhu	a5,-232(s0)
    80005a94:	e7a1                	bnez	a5,80005adc <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005a96:	29c1                	addiw	s3,s3,16
    80005a98:	04c92783          	lw	a5,76(s2)
    80005a9c:	fcf9ede3          	bltu	s3,a5,80005a76 <sys_unlink+0x140>
    80005aa0:	b781                	j	800059e0 <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80005aa2:	00003517          	auipc	a0,0x3
    80005aa6:	d3650513          	addi	a0,a0,-714 # 800087d8 <syscalls+0x2e0>
    80005aaa:	ffffb097          	auipc	ra,0xffffb
    80005aae:	ad8080e7          	jalr	-1320(ra) # 80000582 <panic>
    panic("unlink: writei");
    80005ab2:	00003517          	auipc	a0,0x3
    80005ab6:	d3e50513          	addi	a0,a0,-706 # 800087f0 <syscalls+0x2f8>
    80005aba:	ffffb097          	auipc	ra,0xffffb
    80005abe:	ac8080e7          	jalr	-1336(ra) # 80000582 <panic>
    dp->nlink--;
    80005ac2:	04a4d783          	lhu	a5,74(s1)
    80005ac6:	37fd                	addiw	a5,a5,-1
    80005ac8:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80005acc:	8526                	mv	a0,s1
    80005ace:	ffffe097          	auipc	ra,0xffffe
    80005ad2:	012080e7          	jalr	18(ra) # 80003ae0 <iupdate>
    80005ad6:	b781                	j	80005a16 <sys_unlink+0xe0>
    return -1;
    80005ad8:	557d                	li	a0,-1
    80005ada:	a005                	j	80005afa <sys_unlink+0x1c4>
    iunlockput(ip);
    80005adc:	854a                	mv	a0,s2
    80005ade:	ffffe097          	auipc	ra,0xffffe
    80005ae2:	330080e7          	jalr	816(ra) # 80003e0e <iunlockput>
  iunlockput(dp);
    80005ae6:	8526                	mv	a0,s1
    80005ae8:	ffffe097          	auipc	ra,0xffffe
    80005aec:	326080e7          	jalr	806(ra) # 80003e0e <iunlockput>
  end_op();
    80005af0:	fffff097          	auipc	ra,0xfffff
    80005af4:	adc080e7          	jalr	-1316(ra) # 800045cc <end_op>
  return -1;
    80005af8:	557d                	li	a0,-1
}
    80005afa:	70ae                	ld	ra,232(sp)
    80005afc:	740e                	ld	s0,224(sp)
    80005afe:	64ee                	ld	s1,216(sp)
    80005b00:	694e                	ld	s2,208(sp)
    80005b02:	69ae                	ld	s3,200(sp)
    80005b04:	616d                	addi	sp,sp,240
    80005b06:	8082                	ret

0000000080005b08 <sys_open>:

uint64
sys_open(void)
{
    80005b08:	7131                	addi	sp,sp,-192
    80005b0a:	fd06                	sd	ra,184(sp)
    80005b0c:	f922                	sd	s0,176(sp)
    80005b0e:	f526                	sd	s1,168(sp)
    80005b10:	f14a                	sd	s2,160(sp)
    80005b12:	ed4e                	sd	s3,152(sp)
    80005b14:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80005b16:	f4c40593          	addi	a1,s0,-180
    80005b1a:	4505                	li	a0,1
    80005b1c:	ffffd097          	auipc	ra,0xffffd
    80005b20:	4a0080e7          	jalr	1184(ra) # 80002fbc <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    80005b24:	08000613          	li	a2,128
    80005b28:	f5040593          	addi	a1,s0,-176
    80005b2c:	4501                	li	a0,0
    80005b2e:	ffffd097          	auipc	ra,0xffffd
    80005b32:	4ce080e7          	jalr	1230(ra) # 80002ffc <argstr>
    80005b36:	87aa                	mv	a5,a0
    return -1;
    80005b38:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    80005b3a:	0a07c863          	bltz	a5,80005bea <sys_open+0xe2>

  begin_op();
    80005b3e:	fffff097          	auipc	ra,0xfffff
    80005b42:	a14080e7          	jalr	-1516(ra) # 80004552 <begin_op>

  if(omode & O_CREATE){
    80005b46:	f4c42783          	lw	a5,-180(s0)
    80005b4a:	2007f793          	andi	a5,a5,512
    80005b4e:	cbdd                	beqz	a5,80005c04 <sys_open+0xfc>
    ip = create(path, T_FILE, 0, 0);
    80005b50:	4681                	li	a3,0
    80005b52:	4601                	li	a2,0
    80005b54:	4589                	li	a1,2
    80005b56:	f5040513          	addi	a0,s0,-176
    80005b5a:	00000097          	auipc	ra,0x0
    80005b5e:	97a080e7          	jalr	-1670(ra) # 800054d4 <create>
    80005b62:	84aa                	mv	s1,a0
    if(ip == 0){
    80005b64:	c951                	beqz	a0,80005bf8 <sys_open+0xf0>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80005b66:	04449703          	lh	a4,68(s1)
    80005b6a:	478d                	li	a5,3
    80005b6c:	00f71763          	bne	a4,a5,80005b7a <sys_open+0x72>
    80005b70:	0464d703          	lhu	a4,70(s1)
    80005b74:	47a5                	li	a5,9
    80005b76:	0ce7ec63          	bltu	a5,a4,80005c4e <sys_open+0x146>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80005b7a:	fffff097          	auipc	ra,0xfffff
    80005b7e:	de0080e7          	jalr	-544(ra) # 8000495a <filealloc>
    80005b82:	892a                	mv	s2,a0
    80005b84:	c56d                	beqz	a0,80005c6e <sys_open+0x166>
    80005b86:	00000097          	auipc	ra,0x0
    80005b8a:	90c080e7          	jalr	-1780(ra) # 80005492 <fdalloc>
    80005b8e:	89aa                	mv	s3,a0
    80005b90:	0c054a63          	bltz	a0,80005c64 <sys_open+0x15c>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80005b94:	04449703          	lh	a4,68(s1)
    80005b98:	478d                	li	a5,3
    80005b9a:	0ef70563          	beq	a4,a5,80005c84 <sys_open+0x17c>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80005b9e:	4789                	li	a5,2
    80005ba0:	00f92023          	sw	a5,0(s2)
    f->off = 0;
    80005ba4:	02092023          	sw	zero,32(s2)
  }
  f->ip = ip;
    80005ba8:	00993c23          	sd	s1,24(s2)
  f->readable = !(omode & O_WRONLY);
    80005bac:	f4c42783          	lw	a5,-180(s0)
    80005bb0:	0017c713          	xori	a4,a5,1
    80005bb4:	8b05                	andi	a4,a4,1
    80005bb6:	00e90423          	sb	a4,8(s2)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80005bba:	0037f713          	andi	a4,a5,3
    80005bbe:	00e03733          	snez	a4,a4
    80005bc2:	00e904a3          	sb	a4,9(s2)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80005bc6:	4007f793          	andi	a5,a5,1024
    80005bca:	c791                	beqz	a5,80005bd6 <sys_open+0xce>
    80005bcc:	04449703          	lh	a4,68(s1)
    80005bd0:	4789                	li	a5,2
    80005bd2:	0cf70063          	beq	a4,a5,80005c92 <sys_open+0x18a>
    itrunc(ip);
  }

  iunlock(ip);
    80005bd6:	8526                	mv	a0,s1
    80005bd8:	ffffe097          	auipc	ra,0xffffe
    80005bdc:	096080e7          	jalr	150(ra) # 80003c6e <iunlock>
  end_op();
    80005be0:	fffff097          	auipc	ra,0xfffff
    80005be4:	9ec080e7          	jalr	-1556(ra) # 800045cc <end_op>

  return fd;
    80005be8:	854e                	mv	a0,s3
}
    80005bea:	70ea                	ld	ra,184(sp)
    80005bec:	744a                	ld	s0,176(sp)
    80005bee:	74aa                	ld	s1,168(sp)
    80005bf0:	790a                	ld	s2,160(sp)
    80005bf2:	69ea                	ld	s3,152(sp)
    80005bf4:	6129                	addi	sp,sp,192
    80005bf6:	8082                	ret
      end_op();
    80005bf8:	fffff097          	auipc	ra,0xfffff
    80005bfc:	9d4080e7          	jalr	-1580(ra) # 800045cc <end_op>
      return -1;
    80005c00:	557d                	li	a0,-1
    80005c02:	b7e5                	j	80005bea <sys_open+0xe2>
    if((ip = namei(path)) == 0){
    80005c04:	f5040513          	addi	a0,s0,-176
    80005c08:	ffffe097          	auipc	ra,0xffffe
    80005c0c:	74a080e7          	jalr	1866(ra) # 80004352 <namei>
    80005c10:	84aa                	mv	s1,a0
    80005c12:	c905                	beqz	a0,80005c42 <sys_open+0x13a>
    ilock(ip);
    80005c14:	ffffe097          	auipc	ra,0xffffe
    80005c18:	f98080e7          	jalr	-104(ra) # 80003bac <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80005c1c:	04449703          	lh	a4,68(s1)
    80005c20:	4785                	li	a5,1
    80005c22:	f4f712e3          	bne	a4,a5,80005b66 <sys_open+0x5e>
    80005c26:	f4c42783          	lw	a5,-180(s0)
    80005c2a:	dba1                	beqz	a5,80005b7a <sys_open+0x72>
      iunlockput(ip);
    80005c2c:	8526                	mv	a0,s1
    80005c2e:	ffffe097          	auipc	ra,0xffffe
    80005c32:	1e0080e7          	jalr	480(ra) # 80003e0e <iunlockput>
      end_op();
    80005c36:	fffff097          	auipc	ra,0xfffff
    80005c3a:	996080e7          	jalr	-1642(ra) # 800045cc <end_op>
      return -1;
    80005c3e:	557d                	li	a0,-1
    80005c40:	b76d                	j	80005bea <sys_open+0xe2>
      end_op();
    80005c42:	fffff097          	auipc	ra,0xfffff
    80005c46:	98a080e7          	jalr	-1654(ra) # 800045cc <end_op>
      return -1;
    80005c4a:	557d                	li	a0,-1
    80005c4c:	bf79                	j	80005bea <sys_open+0xe2>
    iunlockput(ip);
    80005c4e:	8526                	mv	a0,s1
    80005c50:	ffffe097          	auipc	ra,0xffffe
    80005c54:	1be080e7          	jalr	446(ra) # 80003e0e <iunlockput>
    end_op();
    80005c58:	fffff097          	auipc	ra,0xfffff
    80005c5c:	974080e7          	jalr	-1676(ra) # 800045cc <end_op>
    return -1;
    80005c60:	557d                	li	a0,-1
    80005c62:	b761                	j	80005bea <sys_open+0xe2>
      fileclose(f);
    80005c64:	854a                	mv	a0,s2
    80005c66:	fffff097          	auipc	ra,0xfffff
    80005c6a:	db0080e7          	jalr	-592(ra) # 80004a16 <fileclose>
    iunlockput(ip);
    80005c6e:	8526                	mv	a0,s1
    80005c70:	ffffe097          	auipc	ra,0xffffe
    80005c74:	19e080e7          	jalr	414(ra) # 80003e0e <iunlockput>
    end_op();
    80005c78:	fffff097          	auipc	ra,0xfffff
    80005c7c:	954080e7          	jalr	-1708(ra) # 800045cc <end_op>
    return -1;
    80005c80:	557d                	li	a0,-1
    80005c82:	b7a5                	j	80005bea <sys_open+0xe2>
    f->type = FD_DEVICE;
    80005c84:	00f92023          	sw	a5,0(s2)
    f->major = ip->major;
    80005c88:	04649783          	lh	a5,70(s1)
    80005c8c:	02f91223          	sh	a5,36(s2)
    80005c90:	bf21                	j	80005ba8 <sys_open+0xa0>
    itrunc(ip);
    80005c92:	8526                	mv	a0,s1
    80005c94:	ffffe097          	auipc	ra,0xffffe
    80005c98:	026080e7          	jalr	38(ra) # 80003cba <itrunc>
    80005c9c:	bf2d                	j	80005bd6 <sys_open+0xce>

0000000080005c9e <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80005c9e:	7175                	addi	sp,sp,-144
    80005ca0:	e506                	sd	ra,136(sp)
    80005ca2:	e122                	sd	s0,128(sp)
    80005ca4:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80005ca6:	fffff097          	auipc	ra,0xfffff
    80005caa:	8ac080e7          	jalr	-1876(ra) # 80004552 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80005cae:	08000613          	li	a2,128
    80005cb2:	f7040593          	addi	a1,s0,-144
    80005cb6:	4501                	li	a0,0
    80005cb8:	ffffd097          	auipc	ra,0xffffd
    80005cbc:	344080e7          	jalr	836(ra) # 80002ffc <argstr>
    80005cc0:	02054963          	bltz	a0,80005cf2 <sys_mkdir+0x54>
    80005cc4:	4681                	li	a3,0
    80005cc6:	4601                	li	a2,0
    80005cc8:	4585                	li	a1,1
    80005cca:	f7040513          	addi	a0,s0,-144
    80005cce:	00000097          	auipc	ra,0x0
    80005cd2:	806080e7          	jalr	-2042(ra) # 800054d4 <create>
    80005cd6:	cd11                	beqz	a0,80005cf2 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005cd8:	ffffe097          	auipc	ra,0xffffe
    80005cdc:	136080e7          	jalr	310(ra) # 80003e0e <iunlockput>
  end_op();
    80005ce0:	fffff097          	auipc	ra,0xfffff
    80005ce4:	8ec080e7          	jalr	-1812(ra) # 800045cc <end_op>
  return 0;
    80005ce8:	4501                	li	a0,0
}
    80005cea:	60aa                	ld	ra,136(sp)
    80005cec:	640a                	ld	s0,128(sp)
    80005cee:	6149                	addi	sp,sp,144
    80005cf0:	8082                	ret
    end_op();
    80005cf2:	fffff097          	auipc	ra,0xfffff
    80005cf6:	8da080e7          	jalr	-1830(ra) # 800045cc <end_op>
    return -1;
    80005cfa:	557d                	li	a0,-1
    80005cfc:	b7fd                	j	80005cea <sys_mkdir+0x4c>

0000000080005cfe <sys_mknod>:

uint64
sys_mknod(void)
{
    80005cfe:	7135                	addi	sp,sp,-160
    80005d00:	ed06                	sd	ra,152(sp)
    80005d02:	e922                	sd	s0,144(sp)
    80005d04:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80005d06:	fffff097          	auipc	ra,0xfffff
    80005d0a:	84c080e7          	jalr	-1972(ra) # 80004552 <begin_op>
  argint(1, &major);
    80005d0e:	f6c40593          	addi	a1,s0,-148
    80005d12:	4505                	li	a0,1
    80005d14:	ffffd097          	auipc	ra,0xffffd
    80005d18:	2a8080e7          	jalr	680(ra) # 80002fbc <argint>
  argint(2, &minor);
    80005d1c:	f6840593          	addi	a1,s0,-152
    80005d20:	4509                	li	a0,2
    80005d22:	ffffd097          	auipc	ra,0xffffd
    80005d26:	29a080e7          	jalr	666(ra) # 80002fbc <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005d2a:	08000613          	li	a2,128
    80005d2e:	f7040593          	addi	a1,s0,-144
    80005d32:	4501                	li	a0,0
    80005d34:	ffffd097          	auipc	ra,0xffffd
    80005d38:	2c8080e7          	jalr	712(ra) # 80002ffc <argstr>
    80005d3c:	02054b63          	bltz	a0,80005d72 <sys_mknod+0x74>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80005d40:	f6841683          	lh	a3,-152(s0)
    80005d44:	f6c41603          	lh	a2,-148(s0)
    80005d48:	458d                	li	a1,3
    80005d4a:	f7040513          	addi	a0,s0,-144
    80005d4e:	fffff097          	auipc	ra,0xfffff
    80005d52:	786080e7          	jalr	1926(ra) # 800054d4 <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80005d56:	cd11                	beqz	a0,80005d72 <sys_mknod+0x74>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005d58:	ffffe097          	auipc	ra,0xffffe
    80005d5c:	0b6080e7          	jalr	182(ra) # 80003e0e <iunlockput>
  end_op();
    80005d60:	fffff097          	auipc	ra,0xfffff
    80005d64:	86c080e7          	jalr	-1940(ra) # 800045cc <end_op>
  return 0;
    80005d68:	4501                	li	a0,0
}
    80005d6a:	60ea                	ld	ra,152(sp)
    80005d6c:	644a                	ld	s0,144(sp)
    80005d6e:	610d                	addi	sp,sp,160
    80005d70:	8082                	ret
    end_op();
    80005d72:	fffff097          	auipc	ra,0xfffff
    80005d76:	85a080e7          	jalr	-1958(ra) # 800045cc <end_op>
    return -1;
    80005d7a:	557d                	li	a0,-1
    80005d7c:	b7fd                	j	80005d6a <sys_mknod+0x6c>

0000000080005d7e <sys_chdir>:

uint64
sys_chdir(void)
{
    80005d7e:	7135                	addi	sp,sp,-160
    80005d80:	ed06                	sd	ra,152(sp)
    80005d82:	e922                	sd	s0,144(sp)
    80005d84:	e526                	sd	s1,136(sp)
    80005d86:	e14a                	sd	s2,128(sp)
    80005d88:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80005d8a:	ffffc097          	auipc	ra,0xffffc
    80005d8e:	eca080e7          	jalr	-310(ra) # 80001c54 <myproc>
    80005d92:	892a                	mv	s2,a0
  
  begin_op();
    80005d94:	ffffe097          	auipc	ra,0xffffe
    80005d98:	7be080e7          	jalr	1982(ra) # 80004552 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80005d9c:	08000613          	li	a2,128
    80005da0:	f6040593          	addi	a1,s0,-160
    80005da4:	4501                	li	a0,0
    80005da6:	ffffd097          	auipc	ra,0xffffd
    80005daa:	256080e7          	jalr	598(ra) # 80002ffc <argstr>
    80005dae:	04054b63          	bltz	a0,80005e04 <sys_chdir+0x86>
    80005db2:	f6040513          	addi	a0,s0,-160
    80005db6:	ffffe097          	auipc	ra,0xffffe
    80005dba:	59c080e7          	jalr	1436(ra) # 80004352 <namei>
    80005dbe:	84aa                	mv	s1,a0
    80005dc0:	c131                	beqz	a0,80005e04 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80005dc2:	ffffe097          	auipc	ra,0xffffe
    80005dc6:	dea080e7          	jalr	-534(ra) # 80003bac <ilock>
  if(ip->type != T_DIR){
    80005dca:	04449703          	lh	a4,68(s1)
    80005dce:	4785                	li	a5,1
    80005dd0:	04f71063          	bne	a4,a5,80005e10 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80005dd4:	8526                	mv	a0,s1
    80005dd6:	ffffe097          	auipc	ra,0xffffe
    80005dda:	e98080e7          	jalr	-360(ra) # 80003c6e <iunlock>
  iput(p->cwd);
    80005dde:	15893503          	ld	a0,344(s2)
    80005de2:	ffffe097          	auipc	ra,0xffffe
    80005de6:	f84080e7          	jalr	-124(ra) # 80003d66 <iput>
  end_op();
    80005dea:	ffffe097          	auipc	ra,0xffffe
    80005dee:	7e2080e7          	jalr	2018(ra) # 800045cc <end_op>
  p->cwd = ip;
    80005df2:	14993c23          	sd	s1,344(s2)
  return 0;
    80005df6:	4501                	li	a0,0
}
    80005df8:	60ea                	ld	ra,152(sp)
    80005dfa:	644a                	ld	s0,144(sp)
    80005dfc:	64aa                	ld	s1,136(sp)
    80005dfe:	690a                	ld	s2,128(sp)
    80005e00:	610d                	addi	sp,sp,160
    80005e02:	8082                	ret
    end_op();
    80005e04:	ffffe097          	auipc	ra,0xffffe
    80005e08:	7c8080e7          	jalr	1992(ra) # 800045cc <end_op>
    return -1;
    80005e0c:	557d                	li	a0,-1
    80005e0e:	b7ed                	j	80005df8 <sys_chdir+0x7a>
    iunlockput(ip);
    80005e10:	8526                	mv	a0,s1
    80005e12:	ffffe097          	auipc	ra,0xffffe
    80005e16:	ffc080e7          	jalr	-4(ra) # 80003e0e <iunlockput>
    end_op();
    80005e1a:	ffffe097          	auipc	ra,0xffffe
    80005e1e:	7b2080e7          	jalr	1970(ra) # 800045cc <end_op>
    return -1;
    80005e22:	557d                	li	a0,-1
    80005e24:	bfd1                	j	80005df8 <sys_chdir+0x7a>

0000000080005e26 <sys_exec>:

uint64
sys_exec(void)
{
    80005e26:	7121                	addi	sp,sp,-448
    80005e28:	ff06                	sd	ra,440(sp)
    80005e2a:	fb22                	sd	s0,432(sp)
    80005e2c:	f726                	sd	s1,424(sp)
    80005e2e:	f34a                	sd	s2,416(sp)
    80005e30:	ef4e                	sd	s3,408(sp)
    80005e32:	eb52                	sd	s4,400(sp)
    80005e34:	0380                	addi	s0,sp,448
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80005e36:	e4840593          	addi	a1,s0,-440
    80005e3a:	4505                	li	a0,1
    80005e3c:	ffffd097          	auipc	ra,0xffffd
    80005e40:	1a0080e7          	jalr	416(ra) # 80002fdc <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    80005e44:	08000613          	li	a2,128
    80005e48:	f5040593          	addi	a1,s0,-176
    80005e4c:	4501                	li	a0,0
    80005e4e:	ffffd097          	auipc	ra,0xffffd
    80005e52:	1ae080e7          	jalr	430(ra) # 80002ffc <argstr>
    80005e56:	87aa                	mv	a5,a0
    return -1;
    80005e58:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    80005e5a:	0c07c263          	bltz	a5,80005f1e <sys_exec+0xf8>
  }
  memset(argv, 0, sizeof(argv));
    80005e5e:	10000613          	li	a2,256
    80005e62:	4581                	li	a1,0
    80005e64:	e5040513          	addi	a0,s0,-432
    80005e68:	ffffb097          	auipc	ra,0xffffb
    80005e6c:	eac080e7          	jalr	-340(ra) # 80000d14 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80005e70:	e5040493          	addi	s1,s0,-432
  memset(argv, 0, sizeof(argv));
    80005e74:	89a6                	mv	s3,s1
    80005e76:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80005e78:	02000a13          	li	s4,32
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80005e7c:	00391513          	slli	a0,s2,0x3
    80005e80:	e4040593          	addi	a1,s0,-448
    80005e84:	e4843783          	ld	a5,-440(s0)
    80005e88:	953e                	add	a0,a0,a5
    80005e8a:	ffffd097          	auipc	ra,0xffffd
    80005e8e:	094080e7          	jalr	148(ra) # 80002f1e <fetchaddr>
    80005e92:	02054a63          	bltz	a0,80005ec6 <sys_exec+0xa0>
      goto bad;
    }
    if(uarg == 0){
    80005e96:	e4043783          	ld	a5,-448(s0)
    80005e9a:	c3b9                	beqz	a5,80005ee0 <sys_exec+0xba>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80005e9c:	ffffb097          	auipc	ra,0xffffb
    80005ea0:	c8c080e7          	jalr	-884(ra) # 80000b28 <kalloc>
    80005ea4:	85aa                	mv	a1,a0
    80005ea6:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80005eaa:	cd11                	beqz	a0,80005ec6 <sys_exec+0xa0>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80005eac:	6605                	lui	a2,0x1
    80005eae:	e4043503          	ld	a0,-448(s0)
    80005eb2:	ffffd097          	auipc	ra,0xffffd
    80005eb6:	0be080e7          	jalr	190(ra) # 80002f70 <fetchstr>
    80005eba:	00054663          	bltz	a0,80005ec6 <sys_exec+0xa0>
    if(i >= NELEM(argv)){
    80005ebe:	0905                	addi	s2,s2,1
    80005ec0:	09a1                	addi	s3,s3,8
    80005ec2:	fb491de3          	bne	s2,s4,80005e7c <sys_exec+0x56>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005ec6:	f5040913          	addi	s2,s0,-176
    80005eca:	6088                	ld	a0,0(s1)
    80005ecc:	c921                	beqz	a0,80005f1c <sys_exec+0xf6>
    kfree(argv[i]);
    80005ece:	ffffb097          	auipc	ra,0xffffb
    80005ed2:	b5c080e7          	jalr	-1188(ra) # 80000a2a <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005ed6:	04a1                	addi	s1,s1,8
    80005ed8:	ff2499e3          	bne	s1,s2,80005eca <sys_exec+0xa4>
  return -1;
    80005edc:	557d                	li	a0,-1
    80005ede:	a081                	j	80005f1e <sys_exec+0xf8>
      argv[i] = 0;
    80005ee0:	0009079b          	sext.w	a5,s2
    80005ee4:	078e                	slli	a5,a5,0x3
    80005ee6:	fd078793          	addi	a5,a5,-48
    80005eea:	97a2                	add	a5,a5,s0
    80005eec:	e807b023          	sd	zero,-384(a5)
  int ret = exec(path, argv);
    80005ef0:	e5040593          	addi	a1,s0,-432
    80005ef4:	f5040513          	addi	a0,s0,-176
    80005ef8:	fffff097          	auipc	ra,0xfffff
    80005efc:	194080e7          	jalr	404(ra) # 8000508c <exec>
    80005f00:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005f02:	f5040993          	addi	s3,s0,-176
    80005f06:	6088                	ld	a0,0(s1)
    80005f08:	c901                	beqz	a0,80005f18 <sys_exec+0xf2>
    kfree(argv[i]);
    80005f0a:	ffffb097          	auipc	ra,0xffffb
    80005f0e:	b20080e7          	jalr	-1248(ra) # 80000a2a <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005f12:	04a1                	addi	s1,s1,8
    80005f14:	ff3499e3          	bne	s1,s3,80005f06 <sys_exec+0xe0>
  return ret;
    80005f18:	854a                	mv	a0,s2
    80005f1a:	a011                	j	80005f1e <sys_exec+0xf8>
  return -1;
    80005f1c:	557d                	li	a0,-1
}
    80005f1e:	70fa                	ld	ra,440(sp)
    80005f20:	745a                	ld	s0,432(sp)
    80005f22:	74ba                	ld	s1,424(sp)
    80005f24:	791a                	ld	s2,416(sp)
    80005f26:	69fa                	ld	s3,408(sp)
    80005f28:	6a5a                	ld	s4,400(sp)
    80005f2a:	6139                	addi	sp,sp,448
    80005f2c:	8082                	ret

0000000080005f2e <sys_pipe>:

uint64
sys_pipe(void)
{
    80005f2e:	7139                	addi	sp,sp,-64
    80005f30:	fc06                	sd	ra,56(sp)
    80005f32:	f822                	sd	s0,48(sp)
    80005f34:	f426                	sd	s1,40(sp)
    80005f36:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005f38:	ffffc097          	auipc	ra,0xffffc
    80005f3c:	d1c080e7          	jalr	-740(ra) # 80001c54 <myproc>
    80005f40:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    80005f42:	fd840593          	addi	a1,s0,-40
    80005f46:	4501                	li	a0,0
    80005f48:	ffffd097          	auipc	ra,0xffffd
    80005f4c:	094080e7          	jalr	148(ra) # 80002fdc <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    80005f50:	fc840593          	addi	a1,s0,-56
    80005f54:	fd040513          	addi	a0,s0,-48
    80005f58:	fffff097          	auipc	ra,0xfffff
    80005f5c:	dea080e7          	jalr	-534(ra) # 80004d42 <pipealloc>
    return -1;
    80005f60:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80005f62:	0c054463          	bltz	a0,8000602a <sys_pipe+0xfc>
  fd0 = -1;
    80005f66:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005f6a:	fd043503          	ld	a0,-48(s0)
    80005f6e:	fffff097          	auipc	ra,0xfffff
    80005f72:	524080e7          	jalr	1316(ra) # 80005492 <fdalloc>
    80005f76:	fca42223          	sw	a0,-60(s0)
    80005f7a:	08054b63          	bltz	a0,80006010 <sys_pipe+0xe2>
    80005f7e:	fc843503          	ld	a0,-56(s0)
    80005f82:	fffff097          	auipc	ra,0xfffff
    80005f86:	510080e7          	jalr	1296(ra) # 80005492 <fdalloc>
    80005f8a:	fca42023          	sw	a0,-64(s0)
    80005f8e:	06054863          	bltz	a0,80005ffe <sys_pipe+0xd0>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005f92:	4691                	li	a3,4
    80005f94:	fc440613          	addi	a2,s0,-60
    80005f98:	fd843583          	ld	a1,-40(s0)
    80005f9c:	6ca8                	ld	a0,88(s1)
    80005f9e:	ffffb097          	auipc	ra,0xffffb
    80005fa2:	70e080e7          	jalr	1806(ra) # 800016ac <copyout>
    80005fa6:	02054063          	bltz	a0,80005fc6 <sys_pipe+0x98>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80005faa:	4691                	li	a3,4
    80005fac:	fc040613          	addi	a2,s0,-64
    80005fb0:	fd843583          	ld	a1,-40(s0)
    80005fb4:	0591                	addi	a1,a1,4
    80005fb6:	6ca8                	ld	a0,88(s1)
    80005fb8:	ffffb097          	auipc	ra,0xffffb
    80005fbc:	6f4080e7          	jalr	1780(ra) # 800016ac <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005fc0:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005fc2:	06055463          	bgez	a0,8000602a <sys_pipe+0xfc>
    p->ofile[fd0] = 0;
    80005fc6:	fc442783          	lw	a5,-60(s0)
    80005fca:	07e9                	addi	a5,a5,26
    80005fcc:	078e                	slli	a5,a5,0x3
    80005fce:	97a6                	add	a5,a5,s1
    80005fd0:	0007b423          	sd	zero,8(a5)
    p->ofile[fd1] = 0;
    80005fd4:	fc042783          	lw	a5,-64(s0)
    80005fd8:	07e9                	addi	a5,a5,26
    80005fda:	078e                	slli	a5,a5,0x3
    80005fdc:	94be                	add	s1,s1,a5
    80005fde:	0004b423          	sd	zero,8(s1)
    fileclose(rf);
    80005fe2:	fd043503          	ld	a0,-48(s0)
    80005fe6:	fffff097          	auipc	ra,0xfffff
    80005fea:	a30080e7          	jalr	-1488(ra) # 80004a16 <fileclose>
    fileclose(wf);
    80005fee:	fc843503          	ld	a0,-56(s0)
    80005ff2:	fffff097          	auipc	ra,0xfffff
    80005ff6:	a24080e7          	jalr	-1500(ra) # 80004a16 <fileclose>
    return -1;
    80005ffa:	57fd                	li	a5,-1
    80005ffc:	a03d                	j	8000602a <sys_pipe+0xfc>
    if(fd0 >= 0)
    80005ffe:	fc442783          	lw	a5,-60(s0)
    80006002:	0007c763          	bltz	a5,80006010 <sys_pipe+0xe2>
      p->ofile[fd0] = 0;
    80006006:	07e9                	addi	a5,a5,26
    80006008:	078e                	slli	a5,a5,0x3
    8000600a:	97a6                	add	a5,a5,s1
    8000600c:	0007b423          	sd	zero,8(a5)
    fileclose(rf);
    80006010:	fd043503          	ld	a0,-48(s0)
    80006014:	fffff097          	auipc	ra,0xfffff
    80006018:	a02080e7          	jalr	-1534(ra) # 80004a16 <fileclose>
    fileclose(wf);
    8000601c:	fc843503          	ld	a0,-56(s0)
    80006020:	fffff097          	auipc	ra,0xfffff
    80006024:	9f6080e7          	jalr	-1546(ra) # 80004a16 <fileclose>
    return -1;
    80006028:	57fd                	li	a5,-1
}
    8000602a:	853e                	mv	a0,a5
    8000602c:	70e2                	ld	ra,56(sp)
    8000602e:	7442                	ld	s0,48(sp)
    80006030:	74a2                	ld	s1,40(sp)
    80006032:	6121                	addi	sp,sp,64
    80006034:	8082                	ret
	...

0000000080006040 <kernelvec>:
    80006040:	7111                	addi	sp,sp,-256
    80006042:	e006                	sd	ra,0(sp)
    80006044:	e40a                	sd	sp,8(sp)
    80006046:	e80e                	sd	gp,16(sp)
    80006048:	ec12                	sd	tp,24(sp)
    8000604a:	f016                	sd	t0,32(sp)
    8000604c:	f41a                	sd	t1,40(sp)
    8000604e:	f81e                	sd	t2,48(sp)
    80006050:	fc22                	sd	s0,56(sp)
    80006052:	e0a6                	sd	s1,64(sp)
    80006054:	e4aa                	sd	a0,72(sp)
    80006056:	e8ae                	sd	a1,80(sp)
    80006058:	ecb2                	sd	a2,88(sp)
    8000605a:	f0b6                	sd	a3,96(sp)
    8000605c:	f4ba                	sd	a4,104(sp)
    8000605e:	f8be                	sd	a5,112(sp)
    80006060:	fcc2                	sd	a6,120(sp)
    80006062:	e146                	sd	a7,128(sp)
    80006064:	e54a                	sd	s2,136(sp)
    80006066:	e94e                	sd	s3,144(sp)
    80006068:	ed52                	sd	s4,152(sp)
    8000606a:	f156                	sd	s5,160(sp)
    8000606c:	f55a                	sd	s6,168(sp)
    8000606e:	f95e                	sd	s7,176(sp)
    80006070:	fd62                	sd	s8,184(sp)
    80006072:	e1e6                	sd	s9,192(sp)
    80006074:	e5ea                	sd	s10,200(sp)
    80006076:	e9ee                	sd	s11,208(sp)
    80006078:	edf2                	sd	t3,216(sp)
    8000607a:	f1f6                	sd	t4,224(sp)
    8000607c:	f5fa                	sd	t5,232(sp)
    8000607e:	f9fe                	sd	t6,240(sp)
    80006080:	d69fc0ef          	jal	ra,80002de8 <kerneltrap>
    80006084:	6082                	ld	ra,0(sp)
    80006086:	6122                	ld	sp,8(sp)
    80006088:	61c2                	ld	gp,16(sp)
    8000608a:	7282                	ld	t0,32(sp)
    8000608c:	7322                	ld	t1,40(sp)
    8000608e:	73c2                	ld	t2,48(sp)
    80006090:	7462                	ld	s0,56(sp)
    80006092:	6486                	ld	s1,64(sp)
    80006094:	6526                	ld	a0,72(sp)
    80006096:	65c6                	ld	a1,80(sp)
    80006098:	6666                	ld	a2,88(sp)
    8000609a:	7686                	ld	a3,96(sp)
    8000609c:	7726                	ld	a4,104(sp)
    8000609e:	77c6                	ld	a5,112(sp)
    800060a0:	7866                	ld	a6,120(sp)
    800060a2:	688a                	ld	a7,128(sp)
    800060a4:	692a                	ld	s2,136(sp)
    800060a6:	69ca                	ld	s3,144(sp)
    800060a8:	6a6a                	ld	s4,152(sp)
    800060aa:	7a8a                	ld	s5,160(sp)
    800060ac:	7b2a                	ld	s6,168(sp)
    800060ae:	7bca                	ld	s7,176(sp)
    800060b0:	7c6a                	ld	s8,184(sp)
    800060b2:	6c8e                	ld	s9,192(sp)
    800060b4:	6d2e                	ld	s10,200(sp)
    800060b6:	6dce                	ld	s11,208(sp)
    800060b8:	6e6e                	ld	t3,216(sp)
    800060ba:	7e8e                	ld	t4,224(sp)
    800060bc:	7f2e                	ld	t5,232(sp)
    800060be:	7fce                	ld	t6,240(sp)
    800060c0:	6111                	addi	sp,sp,256
    800060c2:	10200073          	sret
    800060c6:	00000013          	nop
    800060ca:	00000013          	nop
    800060ce:	0001                	nop

00000000800060d0 <timervec>:
    800060d0:	34051573          	csrrw	a0,mscratch,a0
    800060d4:	e10c                	sd	a1,0(a0)
    800060d6:	e510                	sd	a2,8(a0)
    800060d8:	e914                	sd	a3,16(a0)
    800060da:	6d0c                	ld	a1,24(a0)
    800060dc:	7110                	ld	a2,32(a0)
    800060de:	6194                	ld	a3,0(a1)
    800060e0:	96b2                	add	a3,a3,a2
    800060e2:	e194                	sd	a3,0(a1)
    800060e4:	4589                	li	a1,2
    800060e6:	14459073          	csrw	sip,a1
    800060ea:	6914                	ld	a3,16(a0)
    800060ec:	6510                	ld	a2,8(a0)
    800060ee:	610c                	ld	a1,0(a0)
    800060f0:	34051573          	csrrw	a0,mscratch,a0
    800060f4:	30200073          	mret
	...

00000000800060fa <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    800060fa:	1141                	addi	sp,sp,-16
    800060fc:	e422                	sd	s0,8(sp)
    800060fe:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80006100:	0c0007b7          	lui	a5,0xc000
    80006104:	4705                	li	a4,1
    80006106:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80006108:	c3d8                	sw	a4,4(a5)
}
    8000610a:	6422                	ld	s0,8(sp)
    8000610c:	0141                	addi	sp,sp,16
    8000610e:	8082                	ret

0000000080006110 <plicinithart>:

void
plicinithart(void)
{
    80006110:	1141                	addi	sp,sp,-16
    80006112:	e406                	sd	ra,8(sp)
    80006114:	e022                	sd	s0,0(sp)
    80006116:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80006118:	ffffc097          	auipc	ra,0xffffc
    8000611c:	b10080e7          	jalr	-1264(ra) # 80001c28 <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80006120:	0085171b          	slliw	a4,a0,0x8
    80006124:	0c0027b7          	lui	a5,0xc002
    80006128:	97ba                	add	a5,a5,a4
    8000612a:	40200713          	li	a4,1026
    8000612e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80006132:	00d5151b          	slliw	a0,a0,0xd
    80006136:	0c2017b7          	lui	a5,0xc201
    8000613a:	97aa                	add	a5,a5,a0
    8000613c:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80006140:	60a2                	ld	ra,8(sp)
    80006142:	6402                	ld	s0,0(sp)
    80006144:	0141                	addi	sp,sp,16
    80006146:	8082                	ret

0000000080006148 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80006148:	1141                	addi	sp,sp,-16
    8000614a:	e406                	sd	ra,8(sp)
    8000614c:	e022                	sd	s0,0(sp)
    8000614e:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80006150:	ffffc097          	auipc	ra,0xffffc
    80006154:	ad8080e7          	jalr	-1320(ra) # 80001c28 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80006158:	00d5151b          	slliw	a0,a0,0xd
    8000615c:	0c2017b7          	lui	a5,0xc201
    80006160:	97aa                	add	a5,a5,a0
  return irq;
}
    80006162:	43c8                	lw	a0,4(a5)
    80006164:	60a2                	ld	ra,8(sp)
    80006166:	6402                	ld	s0,0(sp)
    80006168:	0141                	addi	sp,sp,16
    8000616a:	8082                	ret

000000008000616c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    8000616c:	1101                	addi	sp,sp,-32
    8000616e:	ec06                	sd	ra,24(sp)
    80006170:	e822                	sd	s0,16(sp)
    80006172:	e426                	sd	s1,8(sp)
    80006174:	1000                	addi	s0,sp,32
    80006176:	84aa                	mv	s1,a0
  int hart = cpuid();
    80006178:	ffffc097          	auipc	ra,0xffffc
    8000617c:	ab0080e7          	jalr	-1360(ra) # 80001c28 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80006180:	00d5151b          	slliw	a0,a0,0xd
    80006184:	0c2017b7          	lui	a5,0xc201
    80006188:	97aa                	add	a5,a5,a0
    8000618a:	c3c4                	sw	s1,4(a5)
}
    8000618c:	60e2                	ld	ra,24(sp)
    8000618e:	6442                	ld	s0,16(sp)
    80006190:	64a2                	ld	s1,8(sp)
    80006192:	6105                	addi	sp,sp,32
    80006194:	8082                	ret

0000000080006196 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80006196:	1141                	addi	sp,sp,-16
    80006198:	e406                	sd	ra,8(sp)
    8000619a:	e022                	sd	s0,0(sp)
    8000619c:	0800                	addi	s0,sp,16
  if(i >= NUM)
    8000619e:	479d                	li	a5,7
    800061a0:	04a7cc63          	blt	a5,a0,800061f8 <free_desc+0x62>
    panic("free_desc 1");
  if(disk.free[i])
    800061a4:	0001c797          	auipc	a5,0x1c
    800061a8:	d6c78793          	addi	a5,a5,-660 # 80021f10 <disk>
    800061ac:	97aa                	add	a5,a5,a0
    800061ae:	0187c783          	lbu	a5,24(a5)
    800061b2:	ebb9                	bnez	a5,80006208 <free_desc+0x72>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    800061b4:	00451693          	slli	a3,a0,0x4
    800061b8:	0001c797          	auipc	a5,0x1c
    800061bc:	d5878793          	addi	a5,a5,-680 # 80021f10 <disk>
    800061c0:	6398                	ld	a4,0(a5)
    800061c2:	9736                	add	a4,a4,a3
    800061c4:	00073023          	sd	zero,0(a4)
  disk.desc[i].len = 0;
    800061c8:	6398                	ld	a4,0(a5)
    800061ca:	9736                	add	a4,a4,a3
    800061cc:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    800061d0:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    800061d4:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    800061d8:	97aa                	add	a5,a5,a0
    800061da:	4705                	li	a4,1
    800061dc:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    800061e0:	0001c517          	auipc	a0,0x1c
    800061e4:	d4850513          	addi	a0,a0,-696 # 80021f28 <disk+0x18>
    800061e8:	ffffc097          	auipc	ra,0xffffc
    800061ec:	294080e7          	jalr	660(ra) # 8000247c <wakeup>
}
    800061f0:	60a2                	ld	ra,8(sp)
    800061f2:	6402                	ld	s0,0(sp)
    800061f4:	0141                	addi	sp,sp,16
    800061f6:	8082                	ret
    panic("free_desc 1");
    800061f8:	00002517          	auipc	a0,0x2
    800061fc:	60850513          	addi	a0,a0,1544 # 80008800 <syscalls+0x308>
    80006200:	ffffa097          	auipc	ra,0xffffa
    80006204:	382080e7          	jalr	898(ra) # 80000582 <panic>
    panic("free_desc 2");
    80006208:	00002517          	auipc	a0,0x2
    8000620c:	60850513          	addi	a0,a0,1544 # 80008810 <syscalls+0x318>
    80006210:	ffffa097          	auipc	ra,0xffffa
    80006214:	372080e7          	jalr	882(ra) # 80000582 <panic>

0000000080006218 <virtio_disk_init>:
{
    80006218:	1101                	addi	sp,sp,-32
    8000621a:	ec06                	sd	ra,24(sp)
    8000621c:	e822                	sd	s0,16(sp)
    8000621e:	e426                	sd	s1,8(sp)
    80006220:	e04a                	sd	s2,0(sp)
    80006222:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80006224:	00002597          	auipc	a1,0x2
    80006228:	5fc58593          	addi	a1,a1,1532 # 80008820 <syscalls+0x328>
    8000622c:	0001c517          	auipc	a0,0x1c
    80006230:	e0c50513          	addi	a0,a0,-500 # 80022038 <disk+0x128>
    80006234:	ffffb097          	auipc	ra,0xffffb
    80006238:	954080e7          	jalr	-1708(ra) # 80000b88 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    8000623c:	100017b7          	lui	a5,0x10001
    80006240:	4398                	lw	a4,0(a5)
    80006242:	2701                	sext.w	a4,a4
    80006244:	747277b7          	lui	a5,0x74727
    80006248:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    8000624c:	14f71b63          	bne	a4,a5,800063a2 <virtio_disk_init+0x18a>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80006250:	100017b7          	lui	a5,0x10001
    80006254:	43dc                	lw	a5,4(a5)
    80006256:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80006258:	4709                	li	a4,2
    8000625a:	14e79463          	bne	a5,a4,800063a2 <virtio_disk_init+0x18a>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000625e:	100017b7          	lui	a5,0x10001
    80006262:	479c                	lw	a5,8(a5)
    80006264:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80006266:	12e79e63          	bne	a5,a4,800063a2 <virtio_disk_init+0x18a>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    8000626a:	100017b7          	lui	a5,0x10001
    8000626e:	47d8                	lw	a4,12(a5)
    80006270:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80006272:	554d47b7          	lui	a5,0x554d4
    80006276:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    8000627a:	12f71463          	bne	a4,a5,800063a2 <virtio_disk_init+0x18a>
  *R(VIRTIO_MMIO_STATUS) = status;
    8000627e:	100017b7          	lui	a5,0x10001
    80006282:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    80006286:	4705                	li	a4,1
    80006288:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000628a:	470d                	li	a4,3
    8000628c:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    8000628e:	4b98                	lw	a4,16(a5)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80006290:	c7ffe6b7          	lui	a3,0xc7ffe
    80006294:	75f68693          	addi	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fdc70f>
    80006298:	8f75                	and	a4,a4,a3
    8000629a:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000629c:	472d                	li	a4,11
    8000629e:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    800062a0:	5bbc                	lw	a5,112(a5)
    800062a2:	0007891b          	sext.w	s2,a5
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    800062a6:	8ba1                	andi	a5,a5,8
    800062a8:	10078563          	beqz	a5,800063b2 <virtio_disk_init+0x19a>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    800062ac:	100017b7          	lui	a5,0x10001
    800062b0:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    800062b4:	43fc                	lw	a5,68(a5)
    800062b6:	2781                	sext.w	a5,a5
    800062b8:	10079563          	bnez	a5,800063c2 <virtio_disk_init+0x1aa>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    800062bc:	100017b7          	lui	a5,0x10001
    800062c0:	5bdc                	lw	a5,52(a5)
    800062c2:	2781                	sext.w	a5,a5
  if(max == 0)
    800062c4:	10078763          	beqz	a5,800063d2 <virtio_disk_init+0x1ba>
  if(max < NUM)
    800062c8:	471d                	li	a4,7
    800062ca:	10f77c63          	bgeu	a4,a5,800063e2 <virtio_disk_init+0x1ca>
  disk.desc = kalloc();
    800062ce:	ffffb097          	auipc	ra,0xffffb
    800062d2:	85a080e7          	jalr	-1958(ra) # 80000b28 <kalloc>
    800062d6:	0001c497          	auipc	s1,0x1c
    800062da:	c3a48493          	addi	s1,s1,-966 # 80021f10 <disk>
    800062de:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    800062e0:	ffffb097          	auipc	ra,0xffffb
    800062e4:	848080e7          	jalr	-1976(ra) # 80000b28 <kalloc>
    800062e8:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    800062ea:	ffffb097          	auipc	ra,0xffffb
    800062ee:	83e080e7          	jalr	-1986(ra) # 80000b28 <kalloc>
    800062f2:	87aa                	mv	a5,a0
    800062f4:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    800062f6:	6088                	ld	a0,0(s1)
    800062f8:	cd6d                	beqz	a0,800063f2 <virtio_disk_init+0x1da>
    800062fa:	0001c717          	auipc	a4,0x1c
    800062fe:	c1e73703          	ld	a4,-994(a4) # 80021f18 <disk+0x8>
    80006302:	cb65                	beqz	a4,800063f2 <virtio_disk_init+0x1da>
    80006304:	c7fd                	beqz	a5,800063f2 <virtio_disk_init+0x1da>
  memset(disk.desc, 0, PGSIZE);
    80006306:	6605                	lui	a2,0x1
    80006308:	4581                	li	a1,0
    8000630a:	ffffb097          	auipc	ra,0xffffb
    8000630e:	a0a080e7          	jalr	-1526(ra) # 80000d14 <memset>
  memset(disk.avail, 0, PGSIZE);
    80006312:	0001c497          	auipc	s1,0x1c
    80006316:	bfe48493          	addi	s1,s1,-1026 # 80021f10 <disk>
    8000631a:	6605                	lui	a2,0x1
    8000631c:	4581                	li	a1,0
    8000631e:	6488                	ld	a0,8(s1)
    80006320:	ffffb097          	auipc	ra,0xffffb
    80006324:	9f4080e7          	jalr	-1548(ra) # 80000d14 <memset>
  memset(disk.used, 0, PGSIZE);
    80006328:	6605                	lui	a2,0x1
    8000632a:	4581                	li	a1,0
    8000632c:	6888                	ld	a0,16(s1)
    8000632e:	ffffb097          	auipc	ra,0xffffb
    80006332:	9e6080e7          	jalr	-1562(ra) # 80000d14 <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80006336:	100017b7          	lui	a5,0x10001
    8000633a:	4721                	li	a4,8
    8000633c:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    8000633e:	4098                	lw	a4,0(s1)
    80006340:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80006344:	40d8                	lw	a4,4(s1)
    80006346:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    8000634a:	6498                	ld	a4,8(s1)
    8000634c:	0007069b          	sext.w	a3,a4
    80006350:	08d7a823          	sw	a3,144(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80006354:	9701                	srai	a4,a4,0x20
    80006356:	08e7aa23          	sw	a4,148(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    8000635a:	6898                	ld	a4,16(s1)
    8000635c:	0007069b          	sext.w	a3,a4
    80006360:	0ad7a023          	sw	a3,160(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    80006364:	9701                	srai	a4,a4,0x20
    80006366:	0ae7a223          	sw	a4,164(a5)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    8000636a:	4705                	li	a4,1
    8000636c:	c3f8                	sw	a4,68(a5)
    disk.free[i] = 1;
    8000636e:	00e48c23          	sb	a4,24(s1)
    80006372:	00e48ca3          	sb	a4,25(s1)
    80006376:	00e48d23          	sb	a4,26(s1)
    8000637a:	00e48da3          	sb	a4,27(s1)
    8000637e:	00e48e23          	sb	a4,28(s1)
    80006382:	00e48ea3          	sb	a4,29(s1)
    80006386:	00e48f23          	sb	a4,30(s1)
    8000638a:	00e48fa3          	sb	a4,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    8000638e:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80006392:	0727a823          	sw	s2,112(a5)
}
    80006396:	60e2                	ld	ra,24(sp)
    80006398:	6442                	ld	s0,16(sp)
    8000639a:	64a2                	ld	s1,8(sp)
    8000639c:	6902                	ld	s2,0(sp)
    8000639e:	6105                	addi	sp,sp,32
    800063a0:	8082                	ret
    panic("could not find virtio disk");
    800063a2:	00002517          	auipc	a0,0x2
    800063a6:	48e50513          	addi	a0,a0,1166 # 80008830 <syscalls+0x338>
    800063aa:	ffffa097          	auipc	ra,0xffffa
    800063ae:	1d8080e7          	jalr	472(ra) # 80000582 <panic>
    panic("virtio disk FEATURES_OK unset");
    800063b2:	00002517          	auipc	a0,0x2
    800063b6:	49e50513          	addi	a0,a0,1182 # 80008850 <syscalls+0x358>
    800063ba:	ffffa097          	auipc	ra,0xffffa
    800063be:	1c8080e7          	jalr	456(ra) # 80000582 <panic>
    panic("virtio disk should not be ready");
    800063c2:	00002517          	auipc	a0,0x2
    800063c6:	4ae50513          	addi	a0,a0,1198 # 80008870 <syscalls+0x378>
    800063ca:	ffffa097          	auipc	ra,0xffffa
    800063ce:	1b8080e7          	jalr	440(ra) # 80000582 <panic>
    panic("virtio disk has no queue 0");
    800063d2:	00002517          	auipc	a0,0x2
    800063d6:	4be50513          	addi	a0,a0,1214 # 80008890 <syscalls+0x398>
    800063da:	ffffa097          	auipc	ra,0xffffa
    800063de:	1a8080e7          	jalr	424(ra) # 80000582 <panic>
    panic("virtio disk max queue too short");
    800063e2:	00002517          	auipc	a0,0x2
    800063e6:	4ce50513          	addi	a0,a0,1230 # 800088b0 <syscalls+0x3b8>
    800063ea:	ffffa097          	auipc	ra,0xffffa
    800063ee:	198080e7          	jalr	408(ra) # 80000582 <panic>
    panic("virtio disk kalloc");
    800063f2:	00002517          	auipc	a0,0x2
    800063f6:	4de50513          	addi	a0,a0,1246 # 800088d0 <syscalls+0x3d8>
    800063fa:	ffffa097          	auipc	ra,0xffffa
    800063fe:	188080e7          	jalr	392(ra) # 80000582 <panic>

0000000080006402 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80006402:	7159                	addi	sp,sp,-112
    80006404:	f486                	sd	ra,104(sp)
    80006406:	f0a2                	sd	s0,96(sp)
    80006408:	eca6                	sd	s1,88(sp)
    8000640a:	e8ca                	sd	s2,80(sp)
    8000640c:	e4ce                	sd	s3,72(sp)
    8000640e:	e0d2                	sd	s4,64(sp)
    80006410:	fc56                	sd	s5,56(sp)
    80006412:	f85a                	sd	s6,48(sp)
    80006414:	f45e                	sd	s7,40(sp)
    80006416:	f062                	sd	s8,32(sp)
    80006418:	ec66                	sd	s9,24(sp)
    8000641a:	e86a                	sd	s10,16(sp)
    8000641c:	1880                	addi	s0,sp,112
    8000641e:	8a2a                	mv	s4,a0
    80006420:	8bae                	mv	s7,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80006422:	00c52c83          	lw	s9,12(a0)
    80006426:	001c9c9b          	slliw	s9,s9,0x1
    8000642a:	1c82                	slli	s9,s9,0x20
    8000642c:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80006430:	0001c517          	auipc	a0,0x1c
    80006434:	c0850513          	addi	a0,a0,-1016 # 80022038 <disk+0x128>
    80006438:	ffffa097          	auipc	ra,0xffffa
    8000643c:	7e0080e7          	jalr	2016(ra) # 80000c18 <acquire>
  for(int i = 0; i < 3; i++){
    80006440:	4901                	li	s2,0
  for(int i = 0; i < NUM; i++){
    80006442:	44a1                	li	s1,8
      disk.free[i] = 0;
    80006444:	0001cb17          	auipc	s6,0x1c
    80006448:	accb0b13          	addi	s6,s6,-1332 # 80021f10 <disk>
  for(int i = 0; i < 3; i++){
    8000644c:	4a8d                	li	s5,3
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    8000644e:	0001cc17          	auipc	s8,0x1c
    80006452:	beac0c13          	addi	s8,s8,-1046 # 80022038 <disk+0x128>
    80006456:	a095                	j	800064ba <virtio_disk_rw+0xb8>
      disk.free[i] = 0;
    80006458:	00fb0733          	add	a4,s6,a5
    8000645c:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80006460:	c11c                	sw	a5,0(a0)
    if(idx[i] < 0){
    80006462:	0207c563          	bltz	a5,8000648c <virtio_disk_rw+0x8a>
  for(int i = 0; i < 3; i++){
    80006466:	2605                	addiw	a2,a2,1 # 1001 <_entry-0x7fffefff>
    80006468:	0591                	addi	a1,a1,4
    8000646a:	05560d63          	beq	a2,s5,800064c4 <virtio_disk_rw+0xc2>
    idx[i] = alloc_desc();
    8000646e:	852e                	mv	a0,a1
  for(int i = 0; i < NUM; i++){
    80006470:	0001c717          	auipc	a4,0x1c
    80006474:	aa070713          	addi	a4,a4,-1376 # 80021f10 <disk>
    80006478:	87ca                	mv	a5,s2
    if(disk.free[i]){
    8000647a:	01874683          	lbu	a3,24(a4)
    8000647e:	fee9                	bnez	a3,80006458 <virtio_disk_rw+0x56>
  for(int i = 0; i < NUM; i++){
    80006480:	2785                	addiw	a5,a5,1
    80006482:	0705                	addi	a4,a4,1
    80006484:	fe979be3          	bne	a5,s1,8000647a <virtio_disk_rw+0x78>
    idx[i] = alloc_desc();
    80006488:	57fd                	li	a5,-1
    8000648a:	c11c                	sw	a5,0(a0)
      for(int j = 0; j < i; j++)
    8000648c:	00c05e63          	blez	a2,800064a8 <virtio_disk_rw+0xa6>
    80006490:	060a                	slli	a2,a2,0x2
    80006492:	01360d33          	add	s10,a2,s3
        free_desc(idx[j]);
    80006496:	0009a503          	lw	a0,0(s3)
    8000649a:	00000097          	auipc	ra,0x0
    8000649e:	cfc080e7          	jalr	-772(ra) # 80006196 <free_desc>
      for(int j = 0; j < i; j++)
    800064a2:	0991                	addi	s3,s3,4
    800064a4:	ffa999e3          	bne	s3,s10,80006496 <virtio_disk_rw+0x94>
    sleep(&disk.free[0], &disk.vdisk_lock);
    800064a8:	85e2                	mv	a1,s8
    800064aa:	0001c517          	auipc	a0,0x1c
    800064ae:	a7e50513          	addi	a0,a0,-1410 # 80021f28 <disk+0x18>
    800064b2:	ffffc097          	auipc	ra,0xffffc
    800064b6:	f66080e7          	jalr	-154(ra) # 80002418 <sleep>
  for(int i = 0; i < 3; i++){
    800064ba:	f9040993          	addi	s3,s0,-112
{
    800064be:	85ce                	mv	a1,s3
  for(int i = 0; i < 3; i++){
    800064c0:	864a                	mv	a2,s2
    800064c2:	b775                	j	8000646e <virtio_disk_rw+0x6c>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800064c4:	f9042503          	lw	a0,-112(s0)
    800064c8:	00a50713          	addi	a4,a0,10
    800064cc:	0712                	slli	a4,a4,0x4

  if(write)
    800064ce:	0001c797          	auipc	a5,0x1c
    800064d2:	a4278793          	addi	a5,a5,-1470 # 80021f10 <disk>
    800064d6:	00e786b3          	add	a3,a5,a4
    800064da:	01703633          	snez	a2,s7
    800064de:	c690                	sw	a2,8(a3)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    800064e0:	0006a623          	sw	zero,12(a3)
  buf0->sector = sector;
    800064e4:	0196b823          	sd	s9,16(a3)

  disk.desc[idx[0]].addr = (uint64) buf0;
    800064e8:	f6070613          	addi	a2,a4,-160
    800064ec:	6394                	ld	a3,0(a5)
    800064ee:	96b2                	add	a3,a3,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800064f0:	00870593          	addi	a1,a4,8
    800064f4:	95be                	add	a1,a1,a5
  disk.desc[idx[0]].addr = (uint64) buf0;
    800064f6:	e28c                	sd	a1,0(a3)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    800064f8:	0007b803          	ld	a6,0(a5)
    800064fc:	9642                	add	a2,a2,a6
    800064fe:	46c1                	li	a3,16
    80006500:	c614                	sw	a3,8(a2)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80006502:	4585                	li	a1,1
    80006504:	00b61623          	sh	a1,12(a2)
  disk.desc[idx[0]].next = idx[1];
    80006508:	f9442683          	lw	a3,-108(s0)
    8000650c:	00d61723          	sh	a3,14(a2)

  disk.desc[idx[1]].addr = (uint64) b->data;
    80006510:	0692                	slli	a3,a3,0x4
    80006512:	9836                	add	a6,a6,a3
    80006514:	058a0613          	addi	a2,s4,88
    80006518:	00c83023          	sd	a2,0(a6)
  disk.desc[idx[1]].len = BSIZE;
    8000651c:	0007b803          	ld	a6,0(a5)
    80006520:	96c2                	add	a3,a3,a6
    80006522:	40000613          	li	a2,1024
    80006526:	c690                	sw	a2,8(a3)
  if(write)
    80006528:	001bb613          	seqz	a2,s7
    8000652c:	0016161b          	slliw	a2,a2,0x1
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80006530:	00166613          	ori	a2,a2,1
    80006534:	00c69623          	sh	a2,12(a3)
  disk.desc[idx[1]].next = idx[2];
    80006538:	f9842603          	lw	a2,-104(s0)
    8000653c:	00c69723          	sh	a2,14(a3)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80006540:	00250693          	addi	a3,a0,2
    80006544:	0692                	slli	a3,a3,0x4
    80006546:	96be                	add	a3,a3,a5
    80006548:	58fd                	li	a7,-1
    8000654a:	01168823          	sb	a7,16(a3)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    8000654e:	0612                	slli	a2,a2,0x4
    80006550:	9832                	add	a6,a6,a2
    80006552:	f9070713          	addi	a4,a4,-112
    80006556:	973e                	add	a4,a4,a5
    80006558:	00e83023          	sd	a4,0(a6)
  disk.desc[idx[2]].len = 1;
    8000655c:	6398                	ld	a4,0(a5)
    8000655e:	9732                	add	a4,a4,a2
    80006560:	c70c                	sw	a1,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80006562:	4609                	li	a2,2
    80006564:	00c71623          	sh	a2,12(a4)
  disk.desc[idx[2]].next = 0;
    80006568:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    8000656c:	00ba2223          	sw	a1,4(s4)
  disk.info[idx[0]].b = b;
    80006570:	0146b423          	sd	s4,8(a3)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80006574:	6794                	ld	a3,8(a5)
    80006576:	0026d703          	lhu	a4,2(a3)
    8000657a:	8b1d                	andi	a4,a4,7
    8000657c:	0706                	slli	a4,a4,0x1
    8000657e:	96ba                	add	a3,a3,a4
    80006580:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    80006584:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80006588:	6798                	ld	a4,8(a5)
    8000658a:	00275783          	lhu	a5,2(a4)
    8000658e:	2785                	addiw	a5,a5,1
    80006590:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80006594:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80006598:	100017b7          	lui	a5,0x10001
    8000659c:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    800065a0:	004a2783          	lw	a5,4(s4)
    sleep(b, &disk.vdisk_lock);
    800065a4:	0001c917          	auipc	s2,0x1c
    800065a8:	a9490913          	addi	s2,s2,-1388 # 80022038 <disk+0x128>
  while(b->disk == 1) {
    800065ac:	4485                	li	s1,1
    800065ae:	00b79c63          	bne	a5,a1,800065c6 <virtio_disk_rw+0x1c4>
    sleep(b, &disk.vdisk_lock);
    800065b2:	85ca                	mv	a1,s2
    800065b4:	8552                	mv	a0,s4
    800065b6:	ffffc097          	auipc	ra,0xffffc
    800065ba:	e62080e7          	jalr	-414(ra) # 80002418 <sleep>
  while(b->disk == 1) {
    800065be:	004a2783          	lw	a5,4(s4)
    800065c2:	fe9788e3          	beq	a5,s1,800065b2 <virtio_disk_rw+0x1b0>
  }

  disk.info[idx[0]].b = 0;
    800065c6:	f9042903          	lw	s2,-112(s0)
    800065ca:	00290713          	addi	a4,s2,2
    800065ce:	0712                	slli	a4,a4,0x4
    800065d0:	0001c797          	auipc	a5,0x1c
    800065d4:	94078793          	addi	a5,a5,-1728 # 80021f10 <disk>
    800065d8:	97ba                	add	a5,a5,a4
    800065da:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    800065de:	0001c997          	auipc	s3,0x1c
    800065e2:	93298993          	addi	s3,s3,-1742 # 80021f10 <disk>
    800065e6:	00491713          	slli	a4,s2,0x4
    800065ea:	0009b783          	ld	a5,0(s3)
    800065ee:	97ba                	add	a5,a5,a4
    800065f0:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    800065f4:	854a                	mv	a0,s2
    800065f6:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    800065fa:	00000097          	auipc	ra,0x0
    800065fe:	b9c080e7          	jalr	-1124(ra) # 80006196 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80006602:	8885                	andi	s1,s1,1
    80006604:	f0ed                	bnez	s1,800065e6 <virtio_disk_rw+0x1e4>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80006606:	0001c517          	auipc	a0,0x1c
    8000660a:	a3250513          	addi	a0,a0,-1486 # 80022038 <disk+0x128>
    8000660e:	ffffa097          	auipc	ra,0xffffa
    80006612:	6be080e7          	jalr	1726(ra) # 80000ccc <release>
}
    80006616:	70a6                	ld	ra,104(sp)
    80006618:	7406                	ld	s0,96(sp)
    8000661a:	64e6                	ld	s1,88(sp)
    8000661c:	6946                	ld	s2,80(sp)
    8000661e:	69a6                	ld	s3,72(sp)
    80006620:	6a06                	ld	s4,64(sp)
    80006622:	7ae2                	ld	s5,56(sp)
    80006624:	7b42                	ld	s6,48(sp)
    80006626:	7ba2                	ld	s7,40(sp)
    80006628:	7c02                	ld	s8,32(sp)
    8000662a:	6ce2                	ld	s9,24(sp)
    8000662c:	6d42                	ld	s10,16(sp)
    8000662e:	6165                	addi	sp,sp,112
    80006630:	8082                	ret

0000000080006632 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80006632:	1101                	addi	sp,sp,-32
    80006634:	ec06                	sd	ra,24(sp)
    80006636:	e822                	sd	s0,16(sp)
    80006638:	e426                	sd	s1,8(sp)
    8000663a:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    8000663c:	0001c497          	auipc	s1,0x1c
    80006640:	8d448493          	addi	s1,s1,-1836 # 80021f10 <disk>
    80006644:	0001c517          	auipc	a0,0x1c
    80006648:	9f450513          	addi	a0,a0,-1548 # 80022038 <disk+0x128>
    8000664c:	ffffa097          	auipc	ra,0xffffa
    80006650:	5cc080e7          	jalr	1484(ra) # 80000c18 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80006654:	10001737          	lui	a4,0x10001
    80006658:	533c                	lw	a5,96(a4)
    8000665a:	8b8d                	andi	a5,a5,3
    8000665c:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    8000665e:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80006662:	689c                	ld	a5,16(s1)
    80006664:	0204d703          	lhu	a4,32(s1)
    80006668:	0027d783          	lhu	a5,2(a5)
    8000666c:	04f70863          	beq	a4,a5,800066bc <virtio_disk_intr+0x8a>
    __sync_synchronize();
    80006670:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80006674:	6898                	ld	a4,16(s1)
    80006676:	0204d783          	lhu	a5,32(s1)
    8000667a:	8b9d                	andi	a5,a5,7
    8000667c:	078e                	slli	a5,a5,0x3
    8000667e:	97ba                	add	a5,a5,a4
    80006680:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80006682:	00278713          	addi	a4,a5,2
    80006686:	0712                	slli	a4,a4,0x4
    80006688:	9726                	add	a4,a4,s1
    8000668a:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    8000668e:	e721                	bnez	a4,800066d6 <virtio_disk_intr+0xa4>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80006690:	0789                	addi	a5,a5,2
    80006692:	0792                	slli	a5,a5,0x4
    80006694:	97a6                	add	a5,a5,s1
    80006696:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    80006698:	00052223          	sw	zero,4(a0)
    wakeup(b);
    8000669c:	ffffc097          	auipc	ra,0xffffc
    800066a0:	de0080e7          	jalr	-544(ra) # 8000247c <wakeup>

    disk.used_idx += 1;
    800066a4:	0204d783          	lhu	a5,32(s1)
    800066a8:	2785                	addiw	a5,a5,1
    800066aa:	17c2                	slli	a5,a5,0x30
    800066ac:	93c1                	srli	a5,a5,0x30
    800066ae:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    800066b2:	6898                	ld	a4,16(s1)
    800066b4:	00275703          	lhu	a4,2(a4)
    800066b8:	faf71ce3          	bne	a4,a5,80006670 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    800066bc:	0001c517          	auipc	a0,0x1c
    800066c0:	97c50513          	addi	a0,a0,-1668 # 80022038 <disk+0x128>
    800066c4:	ffffa097          	auipc	ra,0xffffa
    800066c8:	608080e7          	jalr	1544(ra) # 80000ccc <release>
}
    800066cc:	60e2                	ld	ra,24(sp)
    800066ce:	6442                	ld	s0,16(sp)
    800066d0:	64a2                	ld	s1,8(sp)
    800066d2:	6105                	addi	sp,sp,32
    800066d4:	8082                	ret
      panic("virtio_disk_intr status");
    800066d6:	00002517          	auipc	a0,0x2
    800066da:	21250513          	addi	a0,a0,530 # 800088e8 <syscalls+0x3f0>
    800066de:	ffffa097          	auipc	ra,0xffffa
    800066e2:	ea4080e7          	jalr	-348(ra) # 80000582 <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051073          	csrw	sscratch,a0
    80007004:	02000537          	lui	a0,0x2000
    80007008:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000700a:	0536                	slli	a0,a0,0xd
    8000700c:	02153423          	sd	ra,40(a0)
    80007010:	02253823          	sd	sp,48(a0)
    80007014:	02353c23          	sd	gp,56(a0)
    80007018:	04453023          	sd	tp,64(a0)
    8000701c:	04553423          	sd	t0,72(a0)
    80007020:	04653823          	sd	t1,80(a0)
    80007024:	04753c23          	sd	t2,88(a0)
    80007028:	f120                	sd	s0,96(a0)
    8000702a:	f524                	sd	s1,104(a0)
    8000702c:	fd2c                	sd	a1,120(a0)
    8000702e:	e150                	sd	a2,128(a0)
    80007030:	e554                	sd	a3,136(a0)
    80007032:	e958                	sd	a4,144(a0)
    80007034:	ed5c                	sd	a5,152(a0)
    80007036:	0b053023          	sd	a6,160(a0)
    8000703a:	0b153423          	sd	a7,168(a0)
    8000703e:	0b253823          	sd	s2,176(a0)
    80007042:	0b353c23          	sd	s3,184(a0)
    80007046:	0d453023          	sd	s4,192(a0)
    8000704a:	0d553423          	sd	s5,200(a0)
    8000704e:	0d653823          	sd	s6,208(a0)
    80007052:	0d753c23          	sd	s7,216(a0)
    80007056:	0f853023          	sd	s8,224(a0)
    8000705a:	0f953423          	sd	s9,232(a0)
    8000705e:	0fa53823          	sd	s10,240(a0)
    80007062:	0fb53c23          	sd	s11,248(a0)
    80007066:	11c53023          	sd	t3,256(a0)
    8000706a:	11d53423          	sd	t4,264(a0)
    8000706e:	11e53823          	sd	t5,272(a0)
    80007072:	11f53c23          	sd	t6,280(a0)
    80007076:	140022f3          	csrr	t0,sscratch
    8000707a:	06553823          	sd	t0,112(a0)
    8000707e:	00853103          	ld	sp,8(a0)
    80007082:	02053203          	ld	tp,32(a0)
    80007086:	01053283          	ld	t0,16(a0)
    8000708a:	00053303          	ld	t1,0(a0)
    8000708e:	12000073          	sfence.vma
    80007092:	18031073          	csrw	satp,t1
    80007096:	12000073          	sfence.vma
    8000709a:	8282                	jr	t0

000000008000709c <userret>:
    8000709c:	12000073          	sfence.vma
    800070a0:	18051073          	csrw	satp,a0
    800070a4:	12000073          	sfence.vma
    800070a8:	02000537          	lui	a0,0x2000
    800070ac:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    800070ae:	0536                	slli	a0,a0,0xd
    800070b0:	02853083          	ld	ra,40(a0)
    800070b4:	03053103          	ld	sp,48(a0)
    800070b8:	03853183          	ld	gp,56(a0)
    800070bc:	04053203          	ld	tp,64(a0)
    800070c0:	04853283          	ld	t0,72(a0)
    800070c4:	05053303          	ld	t1,80(a0)
    800070c8:	05853383          	ld	t2,88(a0)
    800070cc:	7120                	ld	s0,96(a0)
    800070ce:	7524                	ld	s1,104(a0)
    800070d0:	7d2c                	ld	a1,120(a0)
    800070d2:	6150                	ld	a2,128(a0)
    800070d4:	6554                	ld	a3,136(a0)
    800070d6:	6958                	ld	a4,144(a0)
    800070d8:	6d5c                	ld	a5,152(a0)
    800070da:	0a053803          	ld	a6,160(a0)
    800070de:	0a853883          	ld	a7,168(a0)
    800070e2:	0b053903          	ld	s2,176(a0)
    800070e6:	0b853983          	ld	s3,184(a0)
    800070ea:	0c053a03          	ld	s4,192(a0)
    800070ee:	0c853a83          	ld	s5,200(a0)
    800070f2:	0d053b03          	ld	s6,208(a0)
    800070f6:	0d853b83          	ld	s7,216(a0)
    800070fa:	0e053c03          	ld	s8,224(a0)
    800070fe:	0e853c83          	ld	s9,232(a0)
    80007102:	0f053d03          	ld	s10,240(a0)
    80007106:	0f853d83          	ld	s11,248(a0)
    8000710a:	10053e03          	ld	t3,256(a0)
    8000710e:	10853e83          	ld	t4,264(a0)
    80007112:	11053f03          	ld	t5,272(a0)
    80007116:	11853f83          	ld	t6,280(a0)
    8000711a:	7928                	ld	a0,112(a0)
    8000711c:	10200073          	sret
	...
