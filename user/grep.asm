
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	00000097          	auipc	ra,0x0
  22:	030080e7          	jalr	48(ra) # 4e <matchhere>
  26:	e919                	bnez	a0,3c <matchstar+0x3c>
  }while(*text!='\0' && (*text++==c || c=='.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb89                	beqz	a5,3e <matchstar+0x3e>
  2e:	0485                	addi	s1,s1,1
  30:	2781                	sext.w	a5,a5
  32:	ff2784e3          	beq	a5,s2,1a <matchstar+0x1a>
  36:	ff4902e3          	beq	s2,s4,1a <matchstar+0x1a>
  3a:	a011                	j	3e <matchstar+0x3e>
      return 1;
  3c:	4505                	li	a0,1
  return 0;
}
  3e:	70a2                	ld	ra,40(sp)
  40:	7402                	ld	s0,32(sp)
  42:	64e2                	ld	s1,24(sp)
  44:	6942                	ld	s2,16(sp)
  46:	69a2                	ld	s3,8(sp)
  48:	6a02                	ld	s4,0(sp)
  4a:	6145                	addi	sp,sp,48
  4c:	8082                	ret

000000000000004e <matchhere>:
  if(re[0] == '\0')
  4e:	00054703          	lbu	a4,0(a0)
  52:	cb3d                	beqz	a4,c8 <matchhere+0x7a>
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  5c:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5e:	00154683          	lbu	a3,1(a0)
  62:	02a00613          	li	a2,42
  66:	02c68563          	beq	a3,a2,90 <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  6a:	02400613          	li	a2,36
  6e:	02c70a63          	beq	a4,a2,a2 <matchhere+0x54>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  72:	0005c683          	lbu	a3,0(a1)
  return 0;
  76:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  78:	ca81                	beqz	a3,88 <matchhere+0x3a>
  7a:	02e00613          	li	a2,46
  7e:	02c70d63          	beq	a4,a2,b8 <matchhere+0x6a>
  return 0;
  82:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  84:	02d70a63          	beq	a4,a3,b8 <matchhere+0x6a>
}
  88:	60a2                	ld	ra,8(sp)
  8a:	6402                	ld	s0,0(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret
    return matchstar(re[0], re+2, text);
  90:	862e                	mv	a2,a1
  92:	00250593          	addi	a1,a0,2
  96:	853a                	mv	a0,a4
  98:	00000097          	auipc	ra,0x0
  9c:	f68080e7          	jalr	-152(ra) # 0 <matchstar>
  a0:	b7e5                	j	88 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  a2:	c691                	beqz	a3,ae <matchhere+0x60>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  a4:	0005c683          	lbu	a3,0(a1)
  a8:	fee9                	bnez	a3,82 <matchhere+0x34>
  return 0;
  aa:	4501                	li	a0,0
  ac:	bff1                	j	88 <matchhere+0x3a>
    return *text == '\0';
  ae:	0005c503          	lbu	a0,0(a1)
  b2:	00153513          	seqz	a0,a0
  b6:	bfc9                	j	88 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b8:	0585                	addi	a1,a1,1
  ba:	00178513          	addi	a0,a5,1
  be:	00000097          	auipc	ra,0x0
  c2:	f90080e7          	jalr	-112(ra) # 4e <matchhere>
  c6:	b7c9                	j	88 <matchhere+0x3a>
    return 1;
  c8:	4505                	li	a0,1
}
  ca:	8082                	ret

00000000000000cc <match>:
{
  cc:	1101                	addi	sp,sp,-32
  ce:	ec06                	sd	ra,24(sp)
  d0:	e822                	sd	s0,16(sp)
  d2:	e426                	sd	s1,8(sp)
  d4:	e04a                	sd	s2,0(sp)
  d6:	1000                	addi	s0,sp,32
  d8:	892a                	mv	s2,a0
  da:	84ae                	mv	s1,a1
  if(re[0] == '^')
  dc:	00054703          	lbu	a4,0(a0)
  e0:	05e00793          	li	a5,94
  e4:	00f70e63          	beq	a4,a5,100 <match+0x34>
    if(matchhere(re, text))
  e8:	85a6                	mv	a1,s1
  ea:	854a                	mv	a0,s2
  ec:	00000097          	auipc	ra,0x0
  f0:	f62080e7          	jalr	-158(ra) # 4e <matchhere>
  f4:	ed01                	bnez	a0,10c <match+0x40>
  }while(*text++ != '\0');
  f6:	0485                	addi	s1,s1,1
  f8:	fff4c783          	lbu	a5,-1(s1)
  fc:	f7f5                	bnez	a5,e8 <match+0x1c>
  fe:	a801                	j	10e <match+0x42>
    return matchhere(re+1, text);
 100:	0505                	addi	a0,a0,1
 102:	00000097          	auipc	ra,0x0
 106:	f4c080e7          	jalr	-180(ra) # 4e <matchhere>
 10a:	a011                	j	10e <match+0x42>
      return 1;
 10c:	4505                	li	a0,1
}
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	64a2                	ld	s1,8(sp)
 114:	6902                	ld	s2,0(sp)
 116:	6105                	addi	sp,sp,32
 118:	8082                	ret

000000000000011a <grep>:
{
 11a:	715d                	addi	sp,sp,-80
 11c:	e486                	sd	ra,72(sp)
 11e:	e0a2                	sd	s0,64(sp)
 120:	fc26                	sd	s1,56(sp)
 122:	f84a                	sd	s2,48(sp)
 124:	f44e                	sd	s3,40(sp)
 126:	f052                	sd	s4,32(sp)
 128:	ec56                	sd	s5,24(sp)
 12a:	e85a                	sd	s6,16(sp)
 12c:	e45e                	sd	s7,8(sp)
 12e:	e062                	sd	s8,0(sp)
 130:	0880                	addi	s0,sp,80
 132:	89aa                	mv	s3,a0
 134:	8b2e                	mv	s6,a1
  m = 0;
 136:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 138:	3ff00b93          	li	s7,1023
 13c:	00001a97          	auipc	s5,0x1
 140:	ee4a8a93          	addi	s5,s5,-284 # 1020 <buf>
 144:	a0a1                	j	18c <grep+0x72>
      p = q+1;
 146:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 14a:	45a9                	li	a1,10
 14c:	854a                	mv	a0,s2
 14e:	00000097          	auipc	ra,0x0
 152:	60e080e7          	jalr	1550(ra) # 75c <strchr>
 156:	84aa                	mv	s1,a0
 158:	c905                	beqz	a0,188 <grep+0x6e>
      *q = 0;
 15a:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 15e:	85ca                	mv	a1,s2
 160:	854e                	mv	a0,s3
 162:	00000097          	auipc	ra,0x0
 166:	f6a080e7          	jalr	-150(ra) # cc <match>
 16a:	dd71                	beqz	a0,146 <grep+0x2c>
        *q = '\n';
 16c:	47a9                	li	a5,10
 16e:	00f48023          	sb	a5,0(s1)
        write(1, p, q+1 - p);
 172:	00148613          	addi	a2,s1,1
 176:	4126063b          	subw	a2,a2,s2
 17a:	85ca                	mv	a1,s2
 17c:	4505                	li	a0,1
 17e:	00000097          	auipc	ra,0x0
 182:	7d6080e7          	jalr	2006(ra) # 954 <write>
 186:	b7c1                	j	146 <grep+0x2c>
    if(m > 0){
 188:	03404763          	bgtz	s4,1b6 <grep+0x9c>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 18c:	414b863b          	subw	a2,s7,s4
 190:	014a85b3          	add	a1,s5,s4
 194:	855a                	mv	a0,s6
 196:	00000097          	auipc	ra,0x0
 19a:	7b6080e7          	jalr	1974(ra) # 94c <read>
 19e:	02a05b63          	blez	a0,1d4 <grep+0xba>
    m += n;
 1a2:	00aa0c3b          	addw	s8,s4,a0
 1a6:	000c0a1b          	sext.w	s4,s8
    buf[m] = '\0';
 1aa:	014a87b3          	add	a5,s5,s4
 1ae:	00078023          	sb	zero,0(a5)
    p = buf;
 1b2:	8956                	mv	s2,s5
    while((q = strchr(p, '\n')) != 0){
 1b4:	bf59                	j	14a <grep+0x30>
      m -= p - buf;
 1b6:	00001517          	auipc	a0,0x1
 1ba:	e6a50513          	addi	a0,a0,-406 # 1020 <buf>
 1be:	40a90a33          	sub	s4,s2,a0
 1c2:	414c0a3b          	subw	s4,s8,s4
      memmove(buf, p, m);
 1c6:	8652                	mv	a2,s4
 1c8:	85ca                	mv	a1,s2
 1ca:	00000097          	auipc	ra,0x0
 1ce:	6b8080e7          	jalr	1720(ra) # 882 <memmove>
 1d2:	bf6d                	j	18c <grep+0x72>
}
 1d4:	60a6                	ld	ra,72(sp)
 1d6:	6406                	ld	s0,64(sp)
 1d8:	74e2                	ld	s1,56(sp)
 1da:	7942                	ld	s2,48(sp)
 1dc:	79a2                	ld	s3,40(sp)
 1de:	7a02                	ld	s4,32(sp)
 1e0:	6ae2                	ld	s5,24(sp)
 1e2:	6b42                	ld	s6,16(sp)
 1e4:	6ba2                	ld	s7,8(sp)
 1e6:	6c02                	ld	s8,0(sp)
 1e8:	6161                	addi	sp,sp,80
 1ea:	8082                	ret

00000000000001ec <main>:
{
 1ec:	7179                	addi	sp,sp,-48
 1ee:	f406                	sd	ra,40(sp)
 1f0:	f022                	sd	s0,32(sp)
 1f2:	ec26                	sd	s1,24(sp)
 1f4:	e84a                	sd	s2,16(sp)
 1f6:	e44e                	sd	s3,8(sp)
 1f8:	e052                	sd	s4,0(sp)
 1fa:	1800                	addi	s0,sp,48
  if(argc <= 1){
 1fc:	4785                	li	a5,1
 1fe:	04a7de63          	bge	a5,a0,25a <main+0x6e>
  pattern = argv[1];
 202:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 206:	4789                	li	a5,2
 208:	06a7d763          	bge	a5,a0,276 <main+0x8a>
 20c:	01058913          	addi	s2,a1,16
 210:	ffd5099b          	addiw	s3,a0,-3
 214:	02099793          	slli	a5,s3,0x20
 218:	01d7d993          	srli	s3,a5,0x1d
 21c:	05e1                	addi	a1,a1,24
 21e:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], 0)) < 0){
 220:	4581                	li	a1,0
 222:	00093503          	ld	a0,0(s2)
 226:	00000097          	auipc	ra,0x0
 22a:	74e080e7          	jalr	1870(ra) # 974 <open>
 22e:	84aa                	mv	s1,a0
 230:	04054e63          	bltz	a0,28c <main+0xa0>
    grep(pattern, fd);
 234:	85aa                	mv	a1,a0
 236:	8552                	mv	a0,s4
 238:	00000097          	auipc	ra,0x0
 23c:	ee2080e7          	jalr	-286(ra) # 11a <grep>
    close(fd);
 240:	8526                	mv	a0,s1
 242:	00000097          	auipc	ra,0x0
 246:	71a080e7          	jalr	1818(ra) # 95c <close>
  for(i = 2; i < argc; i++){
 24a:	0921                	addi	s2,s2,8
 24c:	fd391ae3          	bne	s2,s3,220 <main+0x34>
  exit(0);
 250:	4501                	li	a0,0
 252:	00000097          	auipc	ra,0x0
 256:	6e2080e7          	jalr	1762(ra) # 934 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 25a:	00001597          	auipc	a1,0x1
 25e:	c0658593          	addi	a1,a1,-1018 # e60 <malloc+0xf4>
 262:	4509                	li	a0,2
 264:	00001097          	auipc	ra,0x1
 268:	a22080e7          	jalr	-1502(ra) # c86 <fprintf>
    exit(1);
 26c:	4505                	li	a0,1
 26e:	00000097          	auipc	ra,0x0
 272:	6c6080e7          	jalr	1734(ra) # 934 <exit>
    grep(pattern, 0);
 276:	4581                	li	a1,0
 278:	8552                	mv	a0,s4
 27a:	00000097          	auipc	ra,0x0
 27e:	ea0080e7          	jalr	-352(ra) # 11a <grep>
    exit(0);
 282:	4501                	li	a0,0
 284:	00000097          	auipc	ra,0x0
 288:	6b0080e7          	jalr	1712(ra) # 934 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 28c:	00093583          	ld	a1,0(s2)
 290:	00001517          	auipc	a0,0x1
 294:	bf050513          	addi	a0,a0,-1040 # e80 <malloc+0x114>
 298:	00001097          	auipc	ra,0x1
 29c:	a1c080e7          	jalr	-1508(ra) # cb4 <printf>
      exit(1);
 2a0:	4505                	li	a0,1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	692080e7          	jalr	1682(ra) # 934 <exit>

00000000000002aa <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e422                	sd	s0,8(sp)
 2ae:	0800                	addi	s0,sp,16
    lk->name = name;
 2b0:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
 2b2:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
 2b6:	57fd                	li	a5,-1
 2b8:	00f50823          	sb	a5,16(a0)
}
 2bc:	6422                	ld	s0,8(sp)
 2be:	0141                	addi	sp,sp,16
 2c0:	8082                	ret

00000000000002c2 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
 2c2:	00054783          	lbu	a5,0(a0)
 2c6:	e399                	bnez	a5,2cc <holding+0xa>
 2c8:	4501                	li	a0,0
}
 2ca:	8082                	ret
{
 2cc:	1101                	addi	sp,sp,-32
 2ce:	ec06                	sd	ra,24(sp)
 2d0:	e822                	sd	s0,16(sp)
 2d2:	e426                	sd	s1,8(sp)
 2d4:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
 2d6:	01054483          	lbu	s1,16(a0)
 2da:	00000097          	auipc	ra,0x0
 2de:	340080e7          	jalr	832(ra) # 61a <twhoami>
 2e2:	2501                	sext.w	a0,a0
 2e4:	40a48533          	sub	a0,s1,a0
 2e8:	00153513          	seqz	a0,a0
}
 2ec:	60e2                	ld	ra,24(sp)
 2ee:	6442                	ld	s0,16(sp)
 2f0:	64a2                	ld	s1,8(sp)
 2f2:	6105                	addi	sp,sp,32
 2f4:	8082                	ret

00000000000002f6 <acquire>:

void acquire(struct lock *lk)
{
 2f6:	7179                	addi	sp,sp,-48
 2f8:	f406                	sd	ra,40(sp)
 2fa:	f022                	sd	s0,32(sp)
 2fc:	ec26                	sd	s1,24(sp)
 2fe:	e84a                	sd	s2,16(sp)
 300:	e44e                	sd	s3,8(sp)
 302:	e052                	sd	s4,0(sp)
 304:	1800                	addi	s0,sp,48
 306:	8a2a                	mv	s4,a0
    if (holding(lk))
 308:	00000097          	auipc	ra,0x0
 30c:	fba080e7          	jalr	-70(ra) # 2c2 <holding>
 310:	e919                	bnez	a0,326 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 312:	ffca7493          	andi	s1,s4,-4
 316:	003a7913          	andi	s2,s4,3
 31a:	0039191b          	slliw	s2,s2,0x3
 31e:	4985                	li	s3,1
 320:	012999bb          	sllw	s3,s3,s2
 324:	a015                	j	348 <acquire+0x52>
        printf("re-acquiring lock we already hold");
 326:	00001517          	auipc	a0,0x1
 32a:	b7250513          	addi	a0,a0,-1166 # e98 <malloc+0x12c>
 32e:	00001097          	auipc	ra,0x1
 332:	986080e7          	jalr	-1658(ra) # cb4 <printf>
        exit(-1);
 336:	557d                	li	a0,-1
 338:	00000097          	auipc	ra,0x0
 33c:	5fc080e7          	jalr	1532(ra) # 934 <exit>
    {
        // give up the cpu for other threads
        tyield();
 340:	00000097          	auipc	ra,0x0
 344:	258080e7          	jalr	600(ra) # 598 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 348:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 34c:	0127d7bb          	srlw	a5,a5,s2
 350:	0ff7f793          	zext.b	a5,a5
 354:	f7f5                	bnez	a5,340 <acquire+0x4a>
    }

    __sync_synchronize();
 356:	0ff0000f          	fence

    lk->tid = twhoami();
 35a:	00000097          	auipc	ra,0x0
 35e:	2c0080e7          	jalr	704(ra) # 61a <twhoami>
 362:	00aa0823          	sb	a0,16(s4)
}
 366:	70a2                	ld	ra,40(sp)
 368:	7402                	ld	s0,32(sp)
 36a:	64e2                	ld	s1,24(sp)
 36c:	6942                	ld	s2,16(sp)
 36e:	69a2                	ld	s3,8(sp)
 370:	6a02                	ld	s4,0(sp)
 372:	6145                	addi	sp,sp,48
 374:	8082                	ret

0000000000000376 <release>:

void release(struct lock *lk)
{
 376:	1101                	addi	sp,sp,-32
 378:	ec06                	sd	ra,24(sp)
 37a:	e822                	sd	s0,16(sp)
 37c:	e426                	sd	s1,8(sp)
 37e:	1000                	addi	s0,sp,32
 380:	84aa                	mv	s1,a0
    if (!holding(lk))
 382:	00000097          	auipc	ra,0x0
 386:	f40080e7          	jalr	-192(ra) # 2c2 <holding>
 38a:	c11d                	beqz	a0,3b0 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 38c:	57fd                	li	a5,-1
 38e:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 392:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 396:	0ff0000f          	fence
 39a:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 39e:	00000097          	auipc	ra,0x0
 3a2:	1fa080e7          	jalr	506(ra) # 598 <tyield>
}
 3a6:	60e2                	ld	ra,24(sp)
 3a8:	6442                	ld	s0,16(sp)
 3aa:	64a2                	ld	s1,8(sp)
 3ac:	6105                	addi	sp,sp,32
 3ae:	8082                	ret
        printf("releasing lock we are not holding");
 3b0:	00001517          	auipc	a0,0x1
 3b4:	b1050513          	addi	a0,a0,-1264 # ec0 <malloc+0x154>
 3b8:	00001097          	auipc	ra,0x1
 3bc:	8fc080e7          	jalr	-1796(ra) # cb4 <printf>
        exit(-1);
 3c0:	557d                	li	a0,-1
 3c2:	00000097          	auipc	ra,0x0
 3c6:	572080e7          	jalr	1394(ra) # 934 <exit>

00000000000003ca <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
 3ca:	1141                	addi	sp,sp,-16
 3cc:	e406                	sd	ra,8(sp)
 3ce:	e022                	sd	s0,0(sp)
 3d0:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 3d2:	09800513          	li	a0,152
 3d6:	00001097          	auipc	ra,0x1
 3da:	996080e7          	jalr	-1642(ra) # d6c <malloc>

    main_thread->tid = next_tid;
 3de:	00001797          	auipc	a5,0x1
 3e2:	c2278793          	addi	a5,a5,-990 # 1000 <next_tid>
 3e6:	4398                	lw	a4,0(a5)
 3e8:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
 3ec:	4398                	lw	a4,0(a5)
 3ee:	2705                	addiw	a4,a4,1
 3f0:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
 3f2:	4791                	li	a5,4
 3f4:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 3f6:	00001797          	auipc	a5,0x1
 3fa:	c0a7bd23          	sd	a0,-998(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 3fe:	00001797          	auipc	a5,0x1
 402:	02278793          	addi	a5,a5,34 # 1420 <threads>
 406:	00001717          	auipc	a4,0x1
 40a:	09a70713          	addi	a4,a4,154 # 14a0 <base>
        threads[i] = NULL;
 40e:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 412:	07a1                	addi	a5,a5,8
 414:	fee79de3          	bne	a5,a4,40e <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 418:	00001797          	auipc	a5,0x1
 41c:	00a7b423          	sd	a0,8(a5) # 1420 <threads>
}
 420:	60a2                	ld	ra,8(sp)
 422:	6402                	ld	s0,0(sp)
 424:	0141                	addi	sp,sp,16
 426:	8082                	ret

0000000000000428 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 428:	00001517          	auipc	a0,0x1
 42c:	be853503          	ld	a0,-1048(a0) # 1010 <current_thread>
 430:	00001717          	auipc	a4,0x1
 434:	ff070713          	addi	a4,a4,-16 # 1420 <threads>
    for (int i = 0; i < 16; i++) {
 438:	4781                	li	a5,0
 43a:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 43c:	6314                	ld	a3,0(a4)
 43e:	00a68763          	beq	a3,a0,44c <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 442:	2785                	addiw	a5,a5,1
 444:	0721                	addi	a4,a4,8
 446:	fec79be3          	bne	a5,a2,43c <tsched+0x14>
    int current_index = 0;
 44a:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 44c:	0017869b          	addiw	a3,a5,1
 450:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 454:	00001817          	auipc	a6,0x1
 458:	fcc80813          	addi	a6,a6,-52 # 1420 <threads>
 45c:	488d                	li	a7,3
 45e:	a021                	j	466 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 460:	2685                	addiw	a3,a3,1
 462:	04c68363          	beq	a3,a2,4a8 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 466:	41f6d71b          	sraiw	a4,a3,0x1f
 46a:	01c7571b          	srliw	a4,a4,0x1c
 46e:	00d707bb          	addw	a5,a4,a3
 472:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 474:	9f99                	subw	a5,a5,a4
 476:	078e                	slli	a5,a5,0x3
 478:	97c2                	add	a5,a5,a6
 47a:	638c                	ld	a1,0(a5)
 47c:	d1f5                	beqz	a1,460 <tsched+0x38>
 47e:	5dbc                	lw	a5,120(a1)
 480:	ff1790e3          	bne	a5,a7,460 <tsched+0x38>
{
 484:	1141                	addi	sp,sp,-16
 486:	e406                	sd	ra,8(sp)
 488:	e022                	sd	s0,0(sp)
 48a:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 48c:	00001797          	auipc	a5,0x1
 490:	b8b7b223          	sd	a1,-1148(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 494:	05a1                	addi	a1,a1,8
 496:	0521                	addi	a0,a0,8
 498:	00000097          	auipc	ra,0x0
 49c:	19a080e7          	jalr	410(ra) # 632 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 4a0:	60a2                	ld	ra,8(sp)
 4a2:	6402                	ld	s0,0(sp)
 4a4:	0141                	addi	sp,sp,16
 4a6:	8082                	ret
 4a8:	8082                	ret

00000000000004aa <thread_wrapper>:
{
 4aa:	1101                	addi	sp,sp,-32
 4ac:	ec06                	sd	ra,24(sp)
 4ae:	e822                	sd	s0,16(sp)
 4b0:	e426                	sd	s1,8(sp)
 4b2:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
 4b4:	00001497          	auipc	s1,0x1
 4b8:	b5c48493          	addi	s1,s1,-1188 # 1010 <current_thread>
 4bc:	609c                	ld	a5,0(s1)
 4be:	6b9c                	ld	a5,16(a5)
    func(arg);
 4c0:	6398                	ld	a4,0(a5)
 4c2:	6788                	ld	a0,8(a5)
 4c4:	9702                	jalr	a4
    current_thread->state = EXITED;
 4c6:	609c                	ld	a5,0(s1)
 4c8:	4719                	li	a4,6
 4ca:	dfb8                	sw	a4,120(a5)
    tsched();
 4cc:	00000097          	auipc	ra,0x0
 4d0:	f5c080e7          	jalr	-164(ra) # 428 <tsched>
}
 4d4:	60e2                	ld	ra,24(sp)
 4d6:	6442                	ld	s0,16(sp)
 4d8:	64a2                	ld	s1,8(sp)
 4da:	6105                	addi	sp,sp,32
 4dc:	8082                	ret

00000000000004de <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 4de:	7179                	addi	sp,sp,-48
 4e0:	f406                	sd	ra,40(sp)
 4e2:	f022                	sd	s0,32(sp)
 4e4:	ec26                	sd	s1,24(sp)
 4e6:	e84a                	sd	s2,16(sp)
 4e8:	e44e                	sd	s3,8(sp)
 4ea:	1800                	addi	s0,sp,48
 4ec:	84aa                	mv	s1,a0
 4ee:	8932                	mv	s2,a2
 4f0:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 4f2:	09800513          	li	a0,152
 4f6:	00001097          	auipc	ra,0x1
 4fa:	876080e7          	jalr	-1930(ra) # d6c <malloc>
 4fe:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 500:	478d                	li	a5,3
 502:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 504:	609c                	ld	a5,0(s1)
 506:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
 50a:	609c                	ld	a5,0(s1)
 50c:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
 510:	6098                	ld	a4,0(s1)
 512:	00001797          	auipc	a5,0x1
 516:	aee78793          	addi	a5,a5,-1298 # 1000 <next_tid>
 51a:	4394                	lw	a3,0(a5)
 51c:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 520:	4398                	lw	a4,0(a5)
 522:	2705                	addiw	a4,a4,1
 524:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
 526:	6505                	lui	a0,0x1
 528:	00001097          	auipc	ra,0x1
 52c:	844080e7          	jalr	-1980(ra) # d6c <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
 530:	6785                	lui	a5,0x1
 532:	00a78733          	add	a4,a5,a0
 536:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
 53a:	17c1                	addi	a5,a5,-16 # ff0 <digits+0xa8>
 53c:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
 53e:	01253023          	sd	s2,0(a0) # 1000 <next_tid>

    (*thread)->tcontext.sp = stack_top;
 542:	609c                	ld	a5,0(s1)
 544:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 546:	609c                	ld	a5,0(s1)
 548:	00000717          	auipc	a4,0x0
 54c:	f6270713          	addi	a4,a4,-158 # 4aa <thread_wrapper>
 550:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 552:	00001717          	auipc	a4,0x1
 556:	ece70713          	addi	a4,a4,-306 # 1420 <threads>
 55a:	4781                	li	a5,0
 55c:	4641                	li	a2,16
        if (threads[i] == NULL) {
 55e:	6314                	ld	a3,0(a4)
 560:	c29d                	beqz	a3,586 <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
 562:	2785                	addiw	a5,a5,1
 564:	0721                	addi	a4,a4,8
 566:	fec79ce3          	bne	a5,a2,55e <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
 56a:	6088                	ld	a0,0(s1)
 56c:	00000097          	auipc	ra,0x0
 570:	77e080e7          	jalr	1918(ra) # cea <free>
        *thread = NULL;
 574:	0004b023          	sd	zero,0(s1)
        return;
    }
}
 578:	70a2                	ld	ra,40(sp)
 57a:	7402                	ld	s0,32(sp)
 57c:	64e2                	ld	s1,24(sp)
 57e:	6942                	ld	s2,16(sp)
 580:	69a2                	ld	s3,8(sp)
 582:	6145                	addi	sp,sp,48
 584:	8082                	ret
            threads[i] = *thread;
 586:	6094                	ld	a3,0(s1)
 588:	078e                	slli	a5,a5,0x3
 58a:	00001717          	auipc	a4,0x1
 58e:	e9670713          	addi	a4,a4,-362 # 1420 <threads>
 592:	97ba                	add	a5,a5,a4
 594:	e394                	sd	a3,0(a5)
    if (!thread_added) {
 596:	b7cd                	j	578 <tcreate+0x9a>

0000000000000598 <tyield>:
    return 0;
}


void tyield()
{
 598:	1141                	addi	sp,sp,-16
 59a:	e406                	sd	ra,8(sp)
 59c:	e022                	sd	s0,0(sp)
 59e:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 5a0:	00001797          	auipc	a5,0x1
 5a4:	a707b783          	ld	a5,-1424(a5) # 1010 <current_thread>
 5a8:	470d                	li	a4,3
 5aa:	dfb8                	sw	a4,120(a5)
    tsched();
 5ac:	00000097          	auipc	ra,0x0
 5b0:	e7c080e7          	jalr	-388(ra) # 428 <tsched>
}
 5b4:	60a2                	ld	ra,8(sp)
 5b6:	6402                	ld	s0,0(sp)
 5b8:	0141                	addi	sp,sp,16
 5ba:	8082                	ret

00000000000005bc <tjoin>:
{
 5bc:	1101                	addi	sp,sp,-32
 5be:	ec06                	sd	ra,24(sp)
 5c0:	e822                	sd	s0,16(sp)
 5c2:	e426                	sd	s1,8(sp)
 5c4:	e04a                	sd	s2,0(sp)
 5c6:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 5c8:	00001797          	auipc	a5,0x1
 5cc:	e5878793          	addi	a5,a5,-424 # 1420 <threads>
 5d0:	00001697          	auipc	a3,0x1
 5d4:	ed068693          	addi	a3,a3,-304 # 14a0 <base>
 5d8:	a021                	j	5e0 <tjoin+0x24>
 5da:	07a1                	addi	a5,a5,8
 5dc:	02d78b63          	beq	a5,a3,612 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 5e0:	6384                	ld	s1,0(a5)
 5e2:	dce5                	beqz	s1,5da <tjoin+0x1e>
 5e4:	0004c703          	lbu	a4,0(s1)
 5e8:	fea719e3          	bne	a4,a0,5da <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 5ec:	5cb8                	lw	a4,120(s1)
 5ee:	4799                	li	a5,6
 5f0:	4919                	li	s2,6
 5f2:	02f70263          	beq	a4,a5,616 <tjoin+0x5a>
        tyield();
 5f6:	00000097          	auipc	ra,0x0
 5fa:	fa2080e7          	jalr	-94(ra) # 598 <tyield>
    while (target_thread->state != EXITED) {
 5fe:	5cbc                	lw	a5,120(s1)
 600:	ff279be3          	bne	a5,s2,5f6 <tjoin+0x3a>
    return 0;
 604:	4501                	li	a0,0
}
 606:	60e2                	ld	ra,24(sp)
 608:	6442                	ld	s0,16(sp)
 60a:	64a2                	ld	s1,8(sp)
 60c:	6902                	ld	s2,0(sp)
 60e:	6105                	addi	sp,sp,32
 610:	8082                	ret
        return -1;
 612:	557d                	li	a0,-1
 614:	bfcd                	j	606 <tjoin+0x4a>
    return 0;
 616:	4501                	li	a0,0
 618:	b7fd                	j	606 <tjoin+0x4a>

000000000000061a <twhoami>:

uint8 twhoami()
{
 61a:	1141                	addi	sp,sp,-16
 61c:	e422                	sd	s0,8(sp)
 61e:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 620:	00001797          	auipc	a5,0x1
 624:	9f07b783          	ld	a5,-1552(a5) # 1010 <current_thread>
 628:	0007c503          	lbu	a0,0(a5)
 62c:	6422                	ld	s0,8(sp)
 62e:	0141                	addi	sp,sp,16
 630:	8082                	ret

0000000000000632 <tswtch>:
 632:	00153023          	sd	ra,0(a0)
 636:	00253423          	sd	sp,8(a0)
 63a:	e900                	sd	s0,16(a0)
 63c:	ed04                	sd	s1,24(a0)
 63e:	03253023          	sd	s2,32(a0)
 642:	03353423          	sd	s3,40(a0)
 646:	03453823          	sd	s4,48(a0)
 64a:	03553c23          	sd	s5,56(a0)
 64e:	05653023          	sd	s6,64(a0)
 652:	05753423          	sd	s7,72(a0)
 656:	05853823          	sd	s8,80(a0)
 65a:	05953c23          	sd	s9,88(a0)
 65e:	07a53023          	sd	s10,96(a0)
 662:	07b53423          	sd	s11,104(a0)
 666:	0005b083          	ld	ra,0(a1)
 66a:	0085b103          	ld	sp,8(a1)
 66e:	6980                	ld	s0,16(a1)
 670:	6d84                	ld	s1,24(a1)
 672:	0205b903          	ld	s2,32(a1)
 676:	0285b983          	ld	s3,40(a1)
 67a:	0305ba03          	ld	s4,48(a1)
 67e:	0385ba83          	ld	s5,56(a1)
 682:	0405bb03          	ld	s6,64(a1)
 686:	0485bb83          	ld	s7,72(a1)
 68a:	0505bc03          	ld	s8,80(a1)
 68e:	0585bc83          	ld	s9,88(a1)
 692:	0605bd03          	ld	s10,96(a1)
 696:	0685bd83          	ld	s11,104(a1)
 69a:	8082                	ret

000000000000069c <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 69c:	1101                	addi	sp,sp,-32
 69e:	ec06                	sd	ra,24(sp)
 6a0:	e822                	sd	s0,16(sp)
 6a2:	e426                	sd	s1,8(sp)
 6a4:	e04a                	sd	s2,0(sp)
 6a6:	1000                	addi	s0,sp,32
 6a8:	84aa                	mv	s1,a0
 6aa:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
 6ac:	00000097          	auipc	ra,0x0
 6b0:	d1e080e7          	jalr	-738(ra) # 3ca <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 6b4:	85ca                	mv	a1,s2
 6b6:	8526                	mv	a0,s1
 6b8:	00000097          	auipc	ra,0x0
 6bc:	b34080e7          	jalr	-1228(ra) # 1ec <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
 6c0:	00000097          	auipc	ra,0x0
 6c4:	274080e7          	jalr	628(ra) # 934 <exit>

00000000000006c8 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 6c8:	1141                	addi	sp,sp,-16
 6ca:	e422                	sd	s0,8(sp)
 6cc:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 6ce:	87aa                	mv	a5,a0
 6d0:	0585                	addi	a1,a1,1
 6d2:	0785                	addi	a5,a5,1
 6d4:	fff5c703          	lbu	a4,-1(a1)
 6d8:	fee78fa3          	sb	a4,-1(a5)
 6dc:	fb75                	bnez	a4,6d0 <strcpy+0x8>
        ;
    return os;
}
 6de:	6422                	ld	s0,8(sp)
 6e0:	0141                	addi	sp,sp,16
 6e2:	8082                	ret

00000000000006e4 <strcmp>:

int strcmp(const char *p, const char *q)
{
 6e4:	1141                	addi	sp,sp,-16
 6e6:	e422                	sd	s0,8(sp)
 6e8:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 6ea:	00054783          	lbu	a5,0(a0)
 6ee:	cb91                	beqz	a5,702 <strcmp+0x1e>
 6f0:	0005c703          	lbu	a4,0(a1)
 6f4:	00f71763          	bne	a4,a5,702 <strcmp+0x1e>
        p++, q++;
 6f8:	0505                	addi	a0,a0,1
 6fa:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 6fc:	00054783          	lbu	a5,0(a0)
 700:	fbe5                	bnez	a5,6f0 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 702:	0005c503          	lbu	a0,0(a1)
}
 706:	40a7853b          	subw	a0,a5,a0
 70a:	6422                	ld	s0,8(sp)
 70c:	0141                	addi	sp,sp,16
 70e:	8082                	ret

0000000000000710 <strlen>:

uint strlen(const char *s)
{
 710:	1141                	addi	sp,sp,-16
 712:	e422                	sd	s0,8(sp)
 714:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 716:	00054783          	lbu	a5,0(a0)
 71a:	cf91                	beqz	a5,736 <strlen+0x26>
 71c:	0505                	addi	a0,a0,1
 71e:	87aa                	mv	a5,a0
 720:	86be                	mv	a3,a5
 722:	0785                	addi	a5,a5,1
 724:	fff7c703          	lbu	a4,-1(a5)
 728:	ff65                	bnez	a4,720 <strlen+0x10>
 72a:	40a6853b          	subw	a0,a3,a0
 72e:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 730:	6422                	ld	s0,8(sp)
 732:	0141                	addi	sp,sp,16
 734:	8082                	ret
    for (n = 0; s[n]; n++)
 736:	4501                	li	a0,0
 738:	bfe5                	j	730 <strlen+0x20>

000000000000073a <memset>:

void *
memset(void *dst, int c, uint n)
{
 73a:	1141                	addi	sp,sp,-16
 73c:	e422                	sd	s0,8(sp)
 73e:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 740:	ca19                	beqz	a2,756 <memset+0x1c>
 742:	87aa                	mv	a5,a0
 744:	1602                	slli	a2,a2,0x20
 746:	9201                	srli	a2,a2,0x20
 748:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 74c:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 750:	0785                	addi	a5,a5,1
 752:	fee79de3          	bne	a5,a4,74c <memset+0x12>
    }
    return dst;
}
 756:	6422                	ld	s0,8(sp)
 758:	0141                	addi	sp,sp,16
 75a:	8082                	ret

000000000000075c <strchr>:

char *
strchr(const char *s, char c)
{
 75c:	1141                	addi	sp,sp,-16
 75e:	e422                	sd	s0,8(sp)
 760:	0800                	addi	s0,sp,16
    for (; *s; s++)
 762:	00054783          	lbu	a5,0(a0)
 766:	cb99                	beqz	a5,77c <strchr+0x20>
        if (*s == c)
 768:	00f58763          	beq	a1,a5,776 <strchr+0x1a>
    for (; *s; s++)
 76c:	0505                	addi	a0,a0,1
 76e:	00054783          	lbu	a5,0(a0)
 772:	fbfd                	bnez	a5,768 <strchr+0xc>
            return (char *)s;
    return 0;
 774:	4501                	li	a0,0
}
 776:	6422                	ld	s0,8(sp)
 778:	0141                	addi	sp,sp,16
 77a:	8082                	ret
    return 0;
 77c:	4501                	li	a0,0
 77e:	bfe5                	j	776 <strchr+0x1a>

0000000000000780 <gets>:

char *
gets(char *buf, int max)
{
 780:	711d                	addi	sp,sp,-96
 782:	ec86                	sd	ra,88(sp)
 784:	e8a2                	sd	s0,80(sp)
 786:	e4a6                	sd	s1,72(sp)
 788:	e0ca                	sd	s2,64(sp)
 78a:	fc4e                	sd	s3,56(sp)
 78c:	f852                	sd	s4,48(sp)
 78e:	f456                	sd	s5,40(sp)
 790:	f05a                	sd	s6,32(sp)
 792:	ec5e                	sd	s7,24(sp)
 794:	1080                	addi	s0,sp,96
 796:	8baa                	mv	s7,a0
 798:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 79a:	892a                	mv	s2,a0
 79c:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 79e:	4aa9                	li	s5,10
 7a0:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 7a2:	89a6                	mv	s3,s1
 7a4:	2485                	addiw	s1,s1,1
 7a6:	0344d863          	bge	s1,s4,7d6 <gets+0x56>
        cc = read(0, &c, 1);
 7aa:	4605                	li	a2,1
 7ac:	faf40593          	addi	a1,s0,-81
 7b0:	4501                	li	a0,0
 7b2:	00000097          	auipc	ra,0x0
 7b6:	19a080e7          	jalr	410(ra) # 94c <read>
        if (cc < 1)
 7ba:	00a05e63          	blez	a0,7d6 <gets+0x56>
        buf[i++] = c;
 7be:	faf44783          	lbu	a5,-81(s0)
 7c2:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 7c6:	01578763          	beq	a5,s5,7d4 <gets+0x54>
 7ca:	0905                	addi	s2,s2,1
 7cc:	fd679be3          	bne	a5,s6,7a2 <gets+0x22>
    for (i = 0; i + 1 < max;)
 7d0:	89a6                	mv	s3,s1
 7d2:	a011                	j	7d6 <gets+0x56>
 7d4:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 7d6:	99de                	add	s3,s3,s7
 7d8:	00098023          	sb	zero,0(s3)
    return buf;
}
 7dc:	855e                	mv	a0,s7
 7de:	60e6                	ld	ra,88(sp)
 7e0:	6446                	ld	s0,80(sp)
 7e2:	64a6                	ld	s1,72(sp)
 7e4:	6906                	ld	s2,64(sp)
 7e6:	79e2                	ld	s3,56(sp)
 7e8:	7a42                	ld	s4,48(sp)
 7ea:	7aa2                	ld	s5,40(sp)
 7ec:	7b02                	ld	s6,32(sp)
 7ee:	6be2                	ld	s7,24(sp)
 7f0:	6125                	addi	sp,sp,96
 7f2:	8082                	ret

00000000000007f4 <stat>:

int stat(const char *n, struct stat *st)
{
 7f4:	1101                	addi	sp,sp,-32
 7f6:	ec06                	sd	ra,24(sp)
 7f8:	e822                	sd	s0,16(sp)
 7fa:	e426                	sd	s1,8(sp)
 7fc:	e04a                	sd	s2,0(sp)
 7fe:	1000                	addi	s0,sp,32
 800:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 802:	4581                	li	a1,0
 804:	00000097          	auipc	ra,0x0
 808:	170080e7          	jalr	368(ra) # 974 <open>
    if (fd < 0)
 80c:	02054563          	bltz	a0,836 <stat+0x42>
 810:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 812:	85ca                	mv	a1,s2
 814:	00000097          	auipc	ra,0x0
 818:	178080e7          	jalr	376(ra) # 98c <fstat>
 81c:	892a                	mv	s2,a0
    close(fd);
 81e:	8526                	mv	a0,s1
 820:	00000097          	auipc	ra,0x0
 824:	13c080e7          	jalr	316(ra) # 95c <close>
    return r;
}
 828:	854a                	mv	a0,s2
 82a:	60e2                	ld	ra,24(sp)
 82c:	6442                	ld	s0,16(sp)
 82e:	64a2                	ld	s1,8(sp)
 830:	6902                	ld	s2,0(sp)
 832:	6105                	addi	sp,sp,32
 834:	8082                	ret
        return -1;
 836:	597d                	li	s2,-1
 838:	bfc5                	j	828 <stat+0x34>

000000000000083a <atoi>:

int atoi(const char *s)
{
 83a:	1141                	addi	sp,sp,-16
 83c:	e422                	sd	s0,8(sp)
 83e:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 840:	00054683          	lbu	a3,0(a0)
 844:	fd06879b          	addiw	a5,a3,-48
 848:	0ff7f793          	zext.b	a5,a5
 84c:	4625                	li	a2,9
 84e:	02f66863          	bltu	a2,a5,87e <atoi+0x44>
 852:	872a                	mv	a4,a0
    n = 0;
 854:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 856:	0705                	addi	a4,a4,1
 858:	0025179b          	slliw	a5,a0,0x2
 85c:	9fa9                	addw	a5,a5,a0
 85e:	0017979b          	slliw	a5,a5,0x1
 862:	9fb5                	addw	a5,a5,a3
 864:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 868:	00074683          	lbu	a3,0(a4)
 86c:	fd06879b          	addiw	a5,a3,-48
 870:	0ff7f793          	zext.b	a5,a5
 874:	fef671e3          	bgeu	a2,a5,856 <atoi+0x1c>
    return n;
}
 878:	6422                	ld	s0,8(sp)
 87a:	0141                	addi	sp,sp,16
 87c:	8082                	ret
    n = 0;
 87e:	4501                	li	a0,0
 880:	bfe5                	j	878 <atoi+0x3e>

0000000000000882 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 882:	1141                	addi	sp,sp,-16
 884:	e422                	sd	s0,8(sp)
 886:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 888:	02b57463          	bgeu	a0,a1,8b0 <memmove+0x2e>
    {
        while (n-- > 0)
 88c:	00c05f63          	blez	a2,8aa <memmove+0x28>
 890:	1602                	slli	a2,a2,0x20
 892:	9201                	srli	a2,a2,0x20
 894:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 898:	872a                	mv	a4,a0
            *dst++ = *src++;
 89a:	0585                	addi	a1,a1,1
 89c:	0705                	addi	a4,a4,1
 89e:	fff5c683          	lbu	a3,-1(a1)
 8a2:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 8a6:	fee79ae3          	bne	a5,a4,89a <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 8aa:	6422                	ld	s0,8(sp)
 8ac:	0141                	addi	sp,sp,16
 8ae:	8082                	ret
        dst += n;
 8b0:	00c50733          	add	a4,a0,a2
        src += n;
 8b4:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 8b6:	fec05ae3          	blez	a2,8aa <memmove+0x28>
 8ba:	fff6079b          	addiw	a5,a2,-1
 8be:	1782                	slli	a5,a5,0x20
 8c0:	9381                	srli	a5,a5,0x20
 8c2:	fff7c793          	not	a5,a5
 8c6:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 8c8:	15fd                	addi	a1,a1,-1
 8ca:	177d                	addi	a4,a4,-1
 8cc:	0005c683          	lbu	a3,0(a1)
 8d0:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 8d4:	fee79ae3          	bne	a5,a4,8c8 <memmove+0x46>
 8d8:	bfc9                	j	8aa <memmove+0x28>

00000000000008da <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 8da:	1141                	addi	sp,sp,-16
 8dc:	e422                	sd	s0,8(sp)
 8de:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 8e0:	ca05                	beqz	a2,910 <memcmp+0x36>
 8e2:	fff6069b          	addiw	a3,a2,-1
 8e6:	1682                	slli	a3,a3,0x20
 8e8:	9281                	srli	a3,a3,0x20
 8ea:	0685                	addi	a3,a3,1
 8ec:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 8ee:	00054783          	lbu	a5,0(a0)
 8f2:	0005c703          	lbu	a4,0(a1)
 8f6:	00e79863          	bne	a5,a4,906 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 8fa:	0505                	addi	a0,a0,1
        p2++;
 8fc:	0585                	addi	a1,a1,1
    while (n-- > 0)
 8fe:	fed518e3          	bne	a0,a3,8ee <memcmp+0x14>
    }
    return 0;
 902:	4501                	li	a0,0
 904:	a019                	j	90a <memcmp+0x30>
            return *p1 - *p2;
 906:	40e7853b          	subw	a0,a5,a4
}
 90a:	6422                	ld	s0,8(sp)
 90c:	0141                	addi	sp,sp,16
 90e:	8082                	ret
    return 0;
 910:	4501                	li	a0,0
 912:	bfe5                	j	90a <memcmp+0x30>

0000000000000914 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 914:	1141                	addi	sp,sp,-16
 916:	e406                	sd	ra,8(sp)
 918:	e022                	sd	s0,0(sp)
 91a:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 91c:	00000097          	auipc	ra,0x0
 920:	f66080e7          	jalr	-154(ra) # 882 <memmove>
}
 924:	60a2                	ld	ra,8(sp)
 926:	6402                	ld	s0,0(sp)
 928:	0141                	addi	sp,sp,16
 92a:	8082                	ret

000000000000092c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 92c:	4885                	li	a7,1
 ecall
 92e:	00000073          	ecall
 ret
 932:	8082                	ret

0000000000000934 <exit>:
.global exit
exit:
 li a7, SYS_exit
 934:	4889                	li	a7,2
 ecall
 936:	00000073          	ecall
 ret
 93a:	8082                	ret

000000000000093c <wait>:
.global wait
wait:
 li a7, SYS_wait
 93c:	488d                	li	a7,3
 ecall
 93e:	00000073          	ecall
 ret
 942:	8082                	ret

0000000000000944 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 944:	4891                	li	a7,4
 ecall
 946:	00000073          	ecall
 ret
 94a:	8082                	ret

000000000000094c <read>:
.global read
read:
 li a7, SYS_read
 94c:	4895                	li	a7,5
 ecall
 94e:	00000073          	ecall
 ret
 952:	8082                	ret

0000000000000954 <write>:
.global write
write:
 li a7, SYS_write
 954:	48c1                	li	a7,16
 ecall
 956:	00000073          	ecall
 ret
 95a:	8082                	ret

000000000000095c <close>:
.global close
close:
 li a7, SYS_close
 95c:	48d5                	li	a7,21
 ecall
 95e:	00000073          	ecall
 ret
 962:	8082                	ret

0000000000000964 <kill>:
.global kill
kill:
 li a7, SYS_kill
 964:	4899                	li	a7,6
 ecall
 966:	00000073          	ecall
 ret
 96a:	8082                	ret

000000000000096c <exec>:
.global exec
exec:
 li a7, SYS_exec
 96c:	489d                	li	a7,7
 ecall
 96e:	00000073          	ecall
 ret
 972:	8082                	ret

0000000000000974 <open>:
.global open
open:
 li a7, SYS_open
 974:	48bd                	li	a7,15
 ecall
 976:	00000073          	ecall
 ret
 97a:	8082                	ret

000000000000097c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 97c:	48c5                	li	a7,17
 ecall
 97e:	00000073          	ecall
 ret
 982:	8082                	ret

0000000000000984 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 984:	48c9                	li	a7,18
 ecall
 986:	00000073          	ecall
 ret
 98a:	8082                	ret

000000000000098c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 98c:	48a1                	li	a7,8
 ecall
 98e:	00000073          	ecall
 ret
 992:	8082                	ret

0000000000000994 <link>:
.global link
link:
 li a7, SYS_link
 994:	48cd                	li	a7,19
 ecall
 996:	00000073          	ecall
 ret
 99a:	8082                	ret

000000000000099c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 99c:	48d1                	li	a7,20
 ecall
 99e:	00000073          	ecall
 ret
 9a2:	8082                	ret

00000000000009a4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 9a4:	48a5                	li	a7,9
 ecall
 9a6:	00000073          	ecall
 ret
 9aa:	8082                	ret

00000000000009ac <dup>:
.global dup
dup:
 li a7, SYS_dup
 9ac:	48a9                	li	a7,10
 ecall
 9ae:	00000073          	ecall
 ret
 9b2:	8082                	ret

00000000000009b4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 9b4:	48ad                	li	a7,11
 ecall
 9b6:	00000073          	ecall
 ret
 9ba:	8082                	ret

00000000000009bc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 9bc:	48b1                	li	a7,12
 ecall
 9be:	00000073          	ecall
 ret
 9c2:	8082                	ret

00000000000009c4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 9c4:	48b5                	li	a7,13
 ecall
 9c6:	00000073          	ecall
 ret
 9ca:	8082                	ret

00000000000009cc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 9cc:	48b9                	li	a7,14
 ecall
 9ce:	00000073          	ecall
 ret
 9d2:	8082                	ret

00000000000009d4 <ps>:
.global ps
ps:
 li a7, SYS_ps
 9d4:	48d9                	li	a7,22
 ecall
 9d6:	00000073          	ecall
 ret
 9da:	8082                	ret

00000000000009dc <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 9dc:	48dd                	li	a7,23
 ecall
 9de:	00000073          	ecall
 ret
 9e2:	8082                	ret

00000000000009e4 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 9e4:	48e1                	li	a7,24
 ecall
 9e6:	00000073          	ecall
 ret
 9ea:	8082                	ret

00000000000009ec <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 9ec:	1101                	addi	sp,sp,-32
 9ee:	ec06                	sd	ra,24(sp)
 9f0:	e822                	sd	s0,16(sp)
 9f2:	1000                	addi	s0,sp,32
 9f4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 9f8:	4605                	li	a2,1
 9fa:	fef40593          	addi	a1,s0,-17
 9fe:	00000097          	auipc	ra,0x0
 a02:	f56080e7          	jalr	-170(ra) # 954 <write>
}
 a06:	60e2                	ld	ra,24(sp)
 a08:	6442                	ld	s0,16(sp)
 a0a:	6105                	addi	sp,sp,32
 a0c:	8082                	ret

0000000000000a0e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 a0e:	7139                	addi	sp,sp,-64
 a10:	fc06                	sd	ra,56(sp)
 a12:	f822                	sd	s0,48(sp)
 a14:	f426                	sd	s1,40(sp)
 a16:	f04a                	sd	s2,32(sp)
 a18:	ec4e                	sd	s3,24(sp)
 a1a:	0080                	addi	s0,sp,64
 a1c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 a1e:	c299                	beqz	a3,a24 <printint+0x16>
 a20:	0805c963          	bltz	a1,ab2 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 a24:	2581                	sext.w	a1,a1
  neg = 0;
 a26:	4881                	li	a7,0
 a28:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 a2c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 a2e:	2601                	sext.w	a2,a2
 a30:	00000517          	auipc	a0,0x0
 a34:	51850513          	addi	a0,a0,1304 # f48 <digits>
 a38:	883a                	mv	a6,a4
 a3a:	2705                	addiw	a4,a4,1
 a3c:	02c5f7bb          	remuw	a5,a1,a2
 a40:	1782                	slli	a5,a5,0x20
 a42:	9381                	srli	a5,a5,0x20
 a44:	97aa                	add	a5,a5,a0
 a46:	0007c783          	lbu	a5,0(a5)
 a4a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 a4e:	0005879b          	sext.w	a5,a1
 a52:	02c5d5bb          	divuw	a1,a1,a2
 a56:	0685                	addi	a3,a3,1
 a58:	fec7f0e3          	bgeu	a5,a2,a38 <printint+0x2a>
  if(neg)
 a5c:	00088c63          	beqz	a7,a74 <printint+0x66>
    buf[i++] = '-';
 a60:	fd070793          	addi	a5,a4,-48
 a64:	00878733          	add	a4,a5,s0
 a68:	02d00793          	li	a5,45
 a6c:	fef70823          	sb	a5,-16(a4)
 a70:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 a74:	02e05863          	blez	a4,aa4 <printint+0x96>
 a78:	fc040793          	addi	a5,s0,-64
 a7c:	00e78933          	add	s2,a5,a4
 a80:	fff78993          	addi	s3,a5,-1
 a84:	99ba                	add	s3,s3,a4
 a86:	377d                	addiw	a4,a4,-1
 a88:	1702                	slli	a4,a4,0x20
 a8a:	9301                	srli	a4,a4,0x20
 a8c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 a90:	fff94583          	lbu	a1,-1(s2)
 a94:	8526                	mv	a0,s1
 a96:	00000097          	auipc	ra,0x0
 a9a:	f56080e7          	jalr	-170(ra) # 9ec <putc>
  while(--i >= 0)
 a9e:	197d                	addi	s2,s2,-1
 aa0:	ff3918e3          	bne	s2,s3,a90 <printint+0x82>
}
 aa4:	70e2                	ld	ra,56(sp)
 aa6:	7442                	ld	s0,48(sp)
 aa8:	74a2                	ld	s1,40(sp)
 aaa:	7902                	ld	s2,32(sp)
 aac:	69e2                	ld	s3,24(sp)
 aae:	6121                	addi	sp,sp,64
 ab0:	8082                	ret
    x = -xx;
 ab2:	40b005bb          	negw	a1,a1
    neg = 1;
 ab6:	4885                	li	a7,1
    x = -xx;
 ab8:	bf85                	j	a28 <printint+0x1a>

0000000000000aba <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 aba:	715d                	addi	sp,sp,-80
 abc:	e486                	sd	ra,72(sp)
 abe:	e0a2                	sd	s0,64(sp)
 ac0:	fc26                	sd	s1,56(sp)
 ac2:	f84a                	sd	s2,48(sp)
 ac4:	f44e                	sd	s3,40(sp)
 ac6:	f052                	sd	s4,32(sp)
 ac8:	ec56                	sd	s5,24(sp)
 aca:	e85a                	sd	s6,16(sp)
 acc:	e45e                	sd	s7,8(sp)
 ace:	e062                	sd	s8,0(sp)
 ad0:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 ad2:	0005c903          	lbu	s2,0(a1)
 ad6:	18090c63          	beqz	s2,c6e <vprintf+0x1b4>
 ada:	8aaa                	mv	s5,a0
 adc:	8bb2                	mv	s7,a2
 ade:	00158493          	addi	s1,a1,1
  state = 0;
 ae2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 ae4:	02500a13          	li	s4,37
 ae8:	4b55                	li	s6,21
 aea:	a839                	j	b08 <vprintf+0x4e>
        putc(fd, c);
 aec:	85ca                	mv	a1,s2
 aee:	8556                	mv	a0,s5
 af0:	00000097          	auipc	ra,0x0
 af4:	efc080e7          	jalr	-260(ra) # 9ec <putc>
 af8:	a019                	j	afe <vprintf+0x44>
    } else if(state == '%'){
 afa:	01498d63          	beq	s3,s4,b14 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 afe:	0485                	addi	s1,s1,1
 b00:	fff4c903          	lbu	s2,-1(s1)
 b04:	16090563          	beqz	s2,c6e <vprintf+0x1b4>
    if(state == 0){
 b08:	fe0999e3          	bnez	s3,afa <vprintf+0x40>
      if(c == '%'){
 b0c:	ff4910e3          	bne	s2,s4,aec <vprintf+0x32>
        state = '%';
 b10:	89d2                	mv	s3,s4
 b12:	b7f5                	j	afe <vprintf+0x44>
      if(c == 'd'){
 b14:	13490263          	beq	s2,s4,c38 <vprintf+0x17e>
 b18:	f9d9079b          	addiw	a5,s2,-99
 b1c:	0ff7f793          	zext.b	a5,a5
 b20:	12fb6563          	bltu	s6,a5,c4a <vprintf+0x190>
 b24:	f9d9079b          	addiw	a5,s2,-99
 b28:	0ff7f713          	zext.b	a4,a5
 b2c:	10eb6f63          	bltu	s6,a4,c4a <vprintf+0x190>
 b30:	00271793          	slli	a5,a4,0x2
 b34:	00000717          	auipc	a4,0x0
 b38:	3bc70713          	addi	a4,a4,956 # ef0 <malloc+0x184>
 b3c:	97ba                	add	a5,a5,a4
 b3e:	439c                	lw	a5,0(a5)
 b40:	97ba                	add	a5,a5,a4
 b42:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 b44:	008b8913          	addi	s2,s7,8
 b48:	4685                	li	a3,1
 b4a:	4629                	li	a2,10
 b4c:	000ba583          	lw	a1,0(s7)
 b50:	8556                	mv	a0,s5
 b52:	00000097          	auipc	ra,0x0
 b56:	ebc080e7          	jalr	-324(ra) # a0e <printint>
 b5a:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 b5c:	4981                	li	s3,0
 b5e:	b745                	j	afe <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 b60:	008b8913          	addi	s2,s7,8
 b64:	4681                	li	a3,0
 b66:	4629                	li	a2,10
 b68:	000ba583          	lw	a1,0(s7)
 b6c:	8556                	mv	a0,s5
 b6e:	00000097          	auipc	ra,0x0
 b72:	ea0080e7          	jalr	-352(ra) # a0e <printint>
 b76:	8bca                	mv	s7,s2
      state = 0;
 b78:	4981                	li	s3,0
 b7a:	b751                	j	afe <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 b7c:	008b8913          	addi	s2,s7,8
 b80:	4681                	li	a3,0
 b82:	4641                	li	a2,16
 b84:	000ba583          	lw	a1,0(s7)
 b88:	8556                	mv	a0,s5
 b8a:	00000097          	auipc	ra,0x0
 b8e:	e84080e7          	jalr	-380(ra) # a0e <printint>
 b92:	8bca                	mv	s7,s2
      state = 0;
 b94:	4981                	li	s3,0
 b96:	b7a5                	j	afe <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 b98:	008b8c13          	addi	s8,s7,8
 b9c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 ba0:	03000593          	li	a1,48
 ba4:	8556                	mv	a0,s5
 ba6:	00000097          	auipc	ra,0x0
 baa:	e46080e7          	jalr	-442(ra) # 9ec <putc>
  putc(fd, 'x');
 bae:	07800593          	li	a1,120
 bb2:	8556                	mv	a0,s5
 bb4:	00000097          	auipc	ra,0x0
 bb8:	e38080e7          	jalr	-456(ra) # 9ec <putc>
 bbc:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 bbe:	00000b97          	auipc	s7,0x0
 bc2:	38ab8b93          	addi	s7,s7,906 # f48 <digits>
 bc6:	03c9d793          	srli	a5,s3,0x3c
 bca:	97de                	add	a5,a5,s7
 bcc:	0007c583          	lbu	a1,0(a5)
 bd0:	8556                	mv	a0,s5
 bd2:	00000097          	auipc	ra,0x0
 bd6:	e1a080e7          	jalr	-486(ra) # 9ec <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 bda:	0992                	slli	s3,s3,0x4
 bdc:	397d                	addiw	s2,s2,-1
 bde:	fe0914e3          	bnez	s2,bc6 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 be2:	8be2                	mv	s7,s8
      state = 0;
 be4:	4981                	li	s3,0
 be6:	bf21                	j	afe <vprintf+0x44>
        s = va_arg(ap, char*);
 be8:	008b8993          	addi	s3,s7,8
 bec:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 bf0:	02090163          	beqz	s2,c12 <vprintf+0x158>
        while(*s != 0){
 bf4:	00094583          	lbu	a1,0(s2)
 bf8:	c9a5                	beqz	a1,c68 <vprintf+0x1ae>
          putc(fd, *s);
 bfa:	8556                	mv	a0,s5
 bfc:	00000097          	auipc	ra,0x0
 c00:	df0080e7          	jalr	-528(ra) # 9ec <putc>
          s++;
 c04:	0905                	addi	s2,s2,1
        while(*s != 0){
 c06:	00094583          	lbu	a1,0(s2)
 c0a:	f9e5                	bnez	a1,bfa <vprintf+0x140>
        s = va_arg(ap, char*);
 c0c:	8bce                	mv	s7,s3
      state = 0;
 c0e:	4981                	li	s3,0
 c10:	b5fd                	j	afe <vprintf+0x44>
          s = "(null)";
 c12:	00000917          	auipc	s2,0x0
 c16:	2d690913          	addi	s2,s2,726 # ee8 <malloc+0x17c>
        while(*s != 0){
 c1a:	02800593          	li	a1,40
 c1e:	bff1                	j	bfa <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 c20:	008b8913          	addi	s2,s7,8
 c24:	000bc583          	lbu	a1,0(s7)
 c28:	8556                	mv	a0,s5
 c2a:	00000097          	auipc	ra,0x0
 c2e:	dc2080e7          	jalr	-574(ra) # 9ec <putc>
 c32:	8bca                	mv	s7,s2
      state = 0;
 c34:	4981                	li	s3,0
 c36:	b5e1                	j	afe <vprintf+0x44>
        putc(fd, c);
 c38:	02500593          	li	a1,37
 c3c:	8556                	mv	a0,s5
 c3e:	00000097          	auipc	ra,0x0
 c42:	dae080e7          	jalr	-594(ra) # 9ec <putc>
      state = 0;
 c46:	4981                	li	s3,0
 c48:	bd5d                	j	afe <vprintf+0x44>
        putc(fd, '%');
 c4a:	02500593          	li	a1,37
 c4e:	8556                	mv	a0,s5
 c50:	00000097          	auipc	ra,0x0
 c54:	d9c080e7          	jalr	-612(ra) # 9ec <putc>
        putc(fd, c);
 c58:	85ca                	mv	a1,s2
 c5a:	8556                	mv	a0,s5
 c5c:	00000097          	auipc	ra,0x0
 c60:	d90080e7          	jalr	-624(ra) # 9ec <putc>
      state = 0;
 c64:	4981                	li	s3,0
 c66:	bd61                	j	afe <vprintf+0x44>
        s = va_arg(ap, char*);
 c68:	8bce                	mv	s7,s3
      state = 0;
 c6a:	4981                	li	s3,0
 c6c:	bd49                	j	afe <vprintf+0x44>
    }
  }
}
 c6e:	60a6                	ld	ra,72(sp)
 c70:	6406                	ld	s0,64(sp)
 c72:	74e2                	ld	s1,56(sp)
 c74:	7942                	ld	s2,48(sp)
 c76:	79a2                	ld	s3,40(sp)
 c78:	7a02                	ld	s4,32(sp)
 c7a:	6ae2                	ld	s5,24(sp)
 c7c:	6b42                	ld	s6,16(sp)
 c7e:	6ba2                	ld	s7,8(sp)
 c80:	6c02                	ld	s8,0(sp)
 c82:	6161                	addi	sp,sp,80
 c84:	8082                	ret

0000000000000c86 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 c86:	715d                	addi	sp,sp,-80
 c88:	ec06                	sd	ra,24(sp)
 c8a:	e822                	sd	s0,16(sp)
 c8c:	1000                	addi	s0,sp,32
 c8e:	e010                	sd	a2,0(s0)
 c90:	e414                	sd	a3,8(s0)
 c92:	e818                	sd	a4,16(s0)
 c94:	ec1c                	sd	a5,24(s0)
 c96:	03043023          	sd	a6,32(s0)
 c9a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 c9e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 ca2:	8622                	mv	a2,s0
 ca4:	00000097          	auipc	ra,0x0
 ca8:	e16080e7          	jalr	-490(ra) # aba <vprintf>
}
 cac:	60e2                	ld	ra,24(sp)
 cae:	6442                	ld	s0,16(sp)
 cb0:	6161                	addi	sp,sp,80
 cb2:	8082                	ret

0000000000000cb4 <printf>:

void
printf(const char *fmt, ...)
{
 cb4:	711d                	addi	sp,sp,-96
 cb6:	ec06                	sd	ra,24(sp)
 cb8:	e822                	sd	s0,16(sp)
 cba:	1000                	addi	s0,sp,32
 cbc:	e40c                	sd	a1,8(s0)
 cbe:	e810                	sd	a2,16(s0)
 cc0:	ec14                	sd	a3,24(s0)
 cc2:	f018                	sd	a4,32(s0)
 cc4:	f41c                	sd	a5,40(s0)
 cc6:	03043823          	sd	a6,48(s0)
 cca:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 cce:	00840613          	addi	a2,s0,8
 cd2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 cd6:	85aa                	mv	a1,a0
 cd8:	4505                	li	a0,1
 cda:	00000097          	auipc	ra,0x0
 cde:	de0080e7          	jalr	-544(ra) # aba <vprintf>
}
 ce2:	60e2                	ld	ra,24(sp)
 ce4:	6442                	ld	s0,16(sp)
 ce6:	6125                	addi	sp,sp,96
 ce8:	8082                	ret

0000000000000cea <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 cea:	1141                	addi	sp,sp,-16
 cec:	e422                	sd	s0,8(sp)
 cee:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 cf0:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cf4:	00000797          	auipc	a5,0x0
 cf8:	3247b783          	ld	a5,804(a5) # 1018 <freep>
 cfc:	a02d                	j	d26 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 cfe:	4618                	lw	a4,8(a2)
 d00:	9f2d                	addw	a4,a4,a1
 d02:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 d06:	6398                	ld	a4,0(a5)
 d08:	6310                	ld	a2,0(a4)
 d0a:	a83d                	j	d48 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 d0c:	ff852703          	lw	a4,-8(a0)
 d10:	9f31                	addw	a4,a4,a2
 d12:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 d14:	ff053683          	ld	a3,-16(a0)
 d18:	a091                	j	d5c <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d1a:	6398                	ld	a4,0(a5)
 d1c:	00e7e463          	bltu	a5,a4,d24 <free+0x3a>
 d20:	00e6ea63          	bltu	a3,a4,d34 <free+0x4a>
{
 d24:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d26:	fed7fae3          	bgeu	a5,a3,d1a <free+0x30>
 d2a:	6398                	ld	a4,0(a5)
 d2c:	00e6e463          	bltu	a3,a4,d34 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d30:	fee7eae3          	bltu	a5,a4,d24 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 d34:	ff852583          	lw	a1,-8(a0)
 d38:	6390                	ld	a2,0(a5)
 d3a:	02059813          	slli	a6,a1,0x20
 d3e:	01c85713          	srli	a4,a6,0x1c
 d42:	9736                	add	a4,a4,a3
 d44:	fae60de3          	beq	a2,a4,cfe <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 d48:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 d4c:	4790                	lw	a2,8(a5)
 d4e:	02061593          	slli	a1,a2,0x20
 d52:	01c5d713          	srli	a4,a1,0x1c
 d56:	973e                	add	a4,a4,a5
 d58:	fae68ae3          	beq	a3,a4,d0c <free+0x22>
        p->s.ptr = bp->s.ptr;
 d5c:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 d5e:	00000717          	auipc	a4,0x0
 d62:	2af73d23          	sd	a5,698(a4) # 1018 <freep>
}
 d66:	6422                	ld	s0,8(sp)
 d68:	0141                	addi	sp,sp,16
 d6a:	8082                	ret

0000000000000d6c <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 d6c:	7139                	addi	sp,sp,-64
 d6e:	fc06                	sd	ra,56(sp)
 d70:	f822                	sd	s0,48(sp)
 d72:	f426                	sd	s1,40(sp)
 d74:	f04a                	sd	s2,32(sp)
 d76:	ec4e                	sd	s3,24(sp)
 d78:	e852                	sd	s4,16(sp)
 d7a:	e456                	sd	s5,8(sp)
 d7c:	e05a                	sd	s6,0(sp)
 d7e:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 d80:	02051493          	slli	s1,a0,0x20
 d84:	9081                	srli	s1,s1,0x20
 d86:	04bd                	addi	s1,s1,15
 d88:	8091                	srli	s1,s1,0x4
 d8a:	0014899b          	addiw	s3,s1,1
 d8e:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 d90:	00000517          	auipc	a0,0x0
 d94:	28853503          	ld	a0,648(a0) # 1018 <freep>
 d98:	c515                	beqz	a0,dc4 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 d9a:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 d9c:	4798                	lw	a4,8(a5)
 d9e:	02977f63          	bgeu	a4,s1,ddc <malloc+0x70>
    if (nu < 4096)
 da2:	8a4e                	mv	s4,s3
 da4:	0009871b          	sext.w	a4,s3
 da8:	6685                	lui	a3,0x1
 daa:	00d77363          	bgeu	a4,a3,db0 <malloc+0x44>
 dae:	6a05                	lui	s4,0x1
 db0:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 db4:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 db8:	00000917          	auipc	s2,0x0
 dbc:	26090913          	addi	s2,s2,608 # 1018 <freep>
    if (p == (char *)-1)
 dc0:	5afd                	li	s5,-1
 dc2:	a895                	j	e36 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 dc4:	00000797          	auipc	a5,0x0
 dc8:	6dc78793          	addi	a5,a5,1756 # 14a0 <base>
 dcc:	00000717          	auipc	a4,0x0
 dd0:	24f73623          	sd	a5,588(a4) # 1018 <freep>
 dd4:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 dd6:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 dda:	b7e1                	j	da2 <malloc+0x36>
            if (p->s.size == nunits)
 ddc:	02e48c63          	beq	s1,a4,e14 <malloc+0xa8>
                p->s.size -= nunits;
 de0:	4137073b          	subw	a4,a4,s3
 de4:	c798                	sw	a4,8(a5)
                p += p->s.size;
 de6:	02071693          	slli	a3,a4,0x20
 dea:	01c6d713          	srli	a4,a3,0x1c
 dee:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 df0:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 df4:	00000717          	auipc	a4,0x0
 df8:	22a73223          	sd	a0,548(a4) # 1018 <freep>
            return (void *)(p + 1);
 dfc:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 e00:	70e2                	ld	ra,56(sp)
 e02:	7442                	ld	s0,48(sp)
 e04:	74a2                	ld	s1,40(sp)
 e06:	7902                	ld	s2,32(sp)
 e08:	69e2                	ld	s3,24(sp)
 e0a:	6a42                	ld	s4,16(sp)
 e0c:	6aa2                	ld	s5,8(sp)
 e0e:	6b02                	ld	s6,0(sp)
 e10:	6121                	addi	sp,sp,64
 e12:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 e14:	6398                	ld	a4,0(a5)
 e16:	e118                	sd	a4,0(a0)
 e18:	bff1                	j	df4 <malloc+0x88>
    hp->s.size = nu;
 e1a:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 e1e:	0541                	addi	a0,a0,16
 e20:	00000097          	auipc	ra,0x0
 e24:	eca080e7          	jalr	-310(ra) # cea <free>
    return freep;
 e28:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 e2c:	d971                	beqz	a0,e00 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 e2e:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 e30:	4798                	lw	a4,8(a5)
 e32:	fa9775e3          	bgeu	a4,s1,ddc <malloc+0x70>
        if (p == freep)
 e36:	00093703          	ld	a4,0(s2)
 e3a:	853e                	mv	a0,a5
 e3c:	fef719e3          	bne	a4,a5,e2e <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 e40:	8552                	mv	a0,s4
 e42:	00000097          	auipc	ra,0x0
 e46:	b7a080e7          	jalr	-1158(ra) # 9bc <sbrk>
    if (p == (char *)-1)
 e4a:	fd5518e3          	bne	a0,s5,e1a <malloc+0xae>
                return 0;
 e4e:	4501                	li	a0,0
 e50:	bf45                	j	e00 <malloc+0x94>
