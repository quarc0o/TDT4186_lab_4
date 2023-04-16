
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
 13c:	00002a97          	auipc	s5,0x2
 140:	ee4a8a93          	addi	s5,s5,-284 # 2020 <buf>
 144:	a0a1                	j	18c <grep+0x72>
      p = q+1;
 146:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 14a:	45a9                	li	a1,10
 14c:	854a                	mv	a0,s2
 14e:	00000097          	auipc	ra,0x0
 152:	640080e7          	jalr	1600(ra) # 78e <strchr>
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
 17e:	00001097          	auipc	ra,0x1
 182:	808080e7          	jalr	-2040(ra) # 986 <write>
 186:	b7c1                	j	146 <grep+0x2c>
    if(m > 0){
 188:	03404763          	bgtz	s4,1b6 <grep+0x9c>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 18c:	414b863b          	subw	a2,s7,s4
 190:	014a85b3          	add	a1,s5,s4
 194:	855a                	mv	a0,s6
 196:	00000097          	auipc	ra,0x0
 19a:	7e8080e7          	jalr	2024(ra) # 97e <read>
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
 1b6:	00002517          	auipc	a0,0x2
 1ba:	e6a50513          	addi	a0,a0,-406 # 2020 <buf>
 1be:	40a90a33          	sub	s4,s2,a0
 1c2:	414c0a3b          	subw	s4,s8,s4
      memmove(buf, p, m);
 1c6:	8652                	mv	a2,s4
 1c8:	85ca                	mv	a1,s2
 1ca:	00000097          	auipc	ra,0x0
 1ce:	6ea080e7          	jalr	1770(ra) # 8b4 <memmove>
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
 22a:	780080e7          	jalr	1920(ra) # 9a6 <open>
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
 246:	74c080e7          	jalr	1868(ra) # 98e <close>
  for(i = 2; i < argc; i++){
 24a:	0921                	addi	s2,s2,8
 24c:	fd391ae3          	bne	s2,s3,220 <main+0x34>
  exit(0);
 250:	4501                	li	a0,0
 252:	00000097          	auipc	ra,0x0
 256:	714080e7          	jalr	1812(ra) # 966 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 25a:	00001597          	auipc	a1,0x1
 25e:	c3658593          	addi	a1,a1,-970 # e90 <malloc+0xf2>
 262:	4509                	li	a0,2
 264:	00001097          	auipc	ra,0x1
 268:	a54080e7          	jalr	-1452(ra) # cb8 <fprintf>
    exit(1);
 26c:	4505                	li	a0,1
 26e:	00000097          	auipc	ra,0x0
 272:	6f8080e7          	jalr	1784(ra) # 966 <exit>
    grep(pattern, 0);
 276:	4581                	li	a1,0
 278:	8552                	mv	a0,s4
 27a:	00000097          	auipc	ra,0x0
 27e:	ea0080e7          	jalr	-352(ra) # 11a <grep>
    exit(0);
 282:	4501                	li	a0,0
 284:	00000097          	auipc	ra,0x0
 288:	6e2080e7          	jalr	1762(ra) # 966 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 28c:	00093583          	ld	a1,0(s2)
 290:	00001517          	auipc	a0,0x1
 294:	c2050513          	addi	a0,a0,-992 # eb0 <malloc+0x112>
 298:	00001097          	auipc	ra,0x1
 29c:	a4e080e7          	jalr	-1458(ra) # ce6 <printf>
      exit(1);
 2a0:	4505                	li	a0,1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	6c4080e7          	jalr	1732(ra) # 966 <exit>

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
 2de:	2dc080e7          	jalr	732(ra) # 5b6 <twhoami>
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
 32a:	ba250513          	addi	a0,a0,-1118 # ec8 <malloc+0x12a>
 32e:	00001097          	auipc	ra,0x1
 332:	9b8080e7          	jalr	-1608(ra) # ce6 <printf>
        exit(-1);
 336:	557d                	li	a0,-1
 338:	00000097          	auipc	ra,0x0
 33c:	62e080e7          	jalr	1582(ra) # 966 <exit>
    {
        // give up the cpu for other threads
        tyield();
 340:	00000097          	auipc	ra,0x0
 344:	252080e7          	jalr	594(ra) # 592 <tyield>
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
 35e:	25c080e7          	jalr	604(ra) # 5b6 <twhoami>
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
 3a2:	1f4080e7          	jalr	500(ra) # 592 <tyield>
}
 3a6:	60e2                	ld	ra,24(sp)
 3a8:	6442                	ld	s0,16(sp)
 3aa:	64a2                	ld	s1,8(sp)
 3ac:	6105                	addi	sp,sp,32
 3ae:	8082                	ret
        printf("releasing lock we are not holding");
 3b0:	00001517          	auipc	a0,0x1
 3b4:	b4050513          	addi	a0,a0,-1216 # ef0 <malloc+0x152>
 3b8:	00001097          	auipc	ra,0x1
 3bc:	92e080e7          	jalr	-1746(ra) # ce6 <printf>
        exit(-1);
 3c0:	557d                	li	a0,-1
 3c2:	00000097          	auipc	ra,0x0
 3c6:	5a4080e7          	jalr	1444(ra) # 966 <exit>

00000000000003ca <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 3ca:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 3cc:	00002617          	auipc	a2,0x2
 3d0:	05460613          	addi	a2,a2,84 # 2420 <threads>
 3d4:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 3d6:	45c1                	li	a1,16
 3d8:	a021                	j	3e0 <tsched+0x16>
 3da:	2685                	addiw	a3,a3,1
 3dc:	08b68c63          	beq	a3,a1,474 <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 3e0:	41f6d71b          	sraiw	a4,a3,0x1f
 3e4:	01c7571b          	srliw	a4,a4,0x1c
 3e8:	00d707bb          	addw	a5,a4,a3
 3ec:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 3ee:	9f99                	subw	a5,a5,a4
 3f0:	078e                	slli	a5,a5,0x3
 3f2:	97b2                	add	a5,a5,a2
 3f4:	639c                	ld	a5,0(a5)
 3f6:	d3f5                	beqz	a5,3da <tsched+0x10>
 3f8:	5fb8                	lw	a4,120(a5)
 3fa:	fea710e3          	bne	a4,a0,3da <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 3fe:	00002717          	auipc	a4,0x2
 402:	02273703          	ld	a4,34(a4) # 2420 <threads>
 406:	5f30                	lw	a2,120(a4)
 408:	468d                	li	a3,3
 40a:	06d60363          	beq	a2,a3,470 <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 40e:	c3a5                	beqz	a5,46e <tsched+0xa4>
{
 410:	1101                	addi	sp,sp,-32
 412:	ec06                	sd	ra,24(sp)
 414:	e822                	sd	s0,16(sp)
 416:	e426                	sd	s1,8(sp)
 418:	e04a                	sd	s2,0(sp)
 41a:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 41c:	00002497          	auipc	s1,0x2
 420:	bf448493          	addi	s1,s1,-1036 # 2010 <current_thread>
 424:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 428:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 42a:	0007c603          	lbu	a2,0(a5)
 42e:	00094583          	lbu	a1,0(s2)
 432:	00001517          	auipc	a0,0x1
 436:	ae650513          	addi	a0,a0,-1306 # f18 <malloc+0x17a>
 43a:	00001097          	auipc	ra,0x1
 43e:	8ac080e7          	jalr	-1876(ra) # ce6 <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 442:	608c                	ld	a1,0(s1)
 444:	05a1                	addi	a1,a1,8
 446:	00890513          	addi	a0,s2,8
 44a:	00000097          	auipc	ra,0x0
 44e:	184080e7          	jalr	388(ra) # 5ce <tswtch>
        printf("Thread switch complete\n");
 452:	00001517          	auipc	a0,0x1
 456:	aee50513          	addi	a0,a0,-1298 # f40 <malloc+0x1a2>
 45a:	00001097          	auipc	ra,0x1
 45e:	88c080e7          	jalr	-1908(ra) # ce6 <printf>
    }
}
 462:	60e2                	ld	ra,24(sp)
 464:	6442                	ld	s0,16(sp)
 466:	64a2                	ld	s1,8(sp)
 468:	6902                	ld	s2,0(sp)
 46a:	6105                	addi	sp,sp,32
 46c:	8082                	ret
 46e:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 470:	87ba                	mv	a5,a4
 472:	bf79                	j	410 <tsched+0x46>
 474:	00002797          	auipc	a5,0x2
 478:	fac7b783          	ld	a5,-84(a5) # 2420 <threads>
 47c:	5fb4                	lw	a3,120(a5)
 47e:	470d                	li	a4,3
 480:	f8e688e3          	beq	a3,a4,410 <tsched+0x46>
 484:	8082                	ret

0000000000000486 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 486:	7179                	addi	sp,sp,-48
 488:	f406                	sd	ra,40(sp)
 48a:	f022                	sd	s0,32(sp)
 48c:	ec26                	sd	s1,24(sp)
 48e:	e84a                	sd	s2,16(sp)
 490:	e44e                	sd	s3,8(sp)
 492:	1800                	addi	s0,sp,48
 494:	84aa                	mv	s1,a0
 496:	89b2                	mv	s3,a2
 498:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 49a:	09000513          	li	a0,144
 49e:	00001097          	auipc	ra,0x1
 4a2:	900080e7          	jalr	-1792(ra) # d9e <malloc>
 4a6:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 4a8:	478d                	li	a5,3
 4aa:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 4ac:	609c                	ld	a5,0(s1)
 4ae:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 4b2:	609c                	ld	a5,0(s1)
 4b4:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 4b8:	00002717          	auipc	a4,0x2
 4bc:	b4870713          	addi	a4,a4,-1208 # 2000 <next_tid>
 4c0:	431c                	lw	a5,0(a4)
 4c2:	0017869b          	addiw	a3,a5,1
 4c6:	c314                	sw	a3,0(a4)
 4c8:	6098                	ld	a4,0(s1)
 4ca:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 4ce:	00002717          	auipc	a4,0x2
 4d2:	f5270713          	addi	a4,a4,-174 # 2420 <threads>
 4d6:	4781                	li	a5,0
 4d8:	4641                	li	a2,16
    if (threads[i] == NULL) {
 4da:	6314                	ld	a3,0(a4)
 4dc:	ce81                	beqz	a3,4f4 <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 4de:	2785                	addiw	a5,a5,1
 4e0:	0721                	addi	a4,a4,8
 4e2:	fec79ce3          	bne	a5,a2,4da <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 4e6:	70a2                	ld	ra,40(sp)
 4e8:	7402                	ld	s0,32(sp)
 4ea:	64e2                	ld	s1,24(sp)
 4ec:	6942                	ld	s2,16(sp)
 4ee:	69a2                	ld	s3,8(sp)
 4f0:	6145                	addi	sp,sp,48
 4f2:	8082                	ret
        threads[i] = *thread;
 4f4:	6094                	ld	a3,0(s1)
 4f6:	078e                	slli	a5,a5,0x3
 4f8:	00002717          	auipc	a4,0x2
 4fc:	f2870713          	addi	a4,a4,-216 # 2420 <threads>
 500:	97ba                	add	a5,a5,a4
 502:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 504:	0006c583          	lbu	a1,0(a3)
 508:	00001517          	auipc	a0,0x1
 50c:	a5050513          	addi	a0,a0,-1456 # f58 <malloc+0x1ba>
 510:	00000097          	auipc	ra,0x0
 514:	7d6080e7          	jalr	2006(ra) # ce6 <printf>
        break;
 518:	b7f9                	j	4e6 <tcreate+0x60>

000000000000051a <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 51a:	7179                	addi	sp,sp,-48
 51c:	f406                	sd	ra,40(sp)
 51e:	f022                	sd	s0,32(sp)
 520:	ec26                	sd	s1,24(sp)
 522:	e84a                	sd	s2,16(sp)
 524:	e44e                	sd	s3,8(sp)
 526:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 528:	00002797          	auipc	a5,0x2
 52c:	ef878793          	addi	a5,a5,-264 # 2420 <threads>
 530:	00002697          	auipc	a3,0x2
 534:	f7068693          	addi	a3,a3,-144 # 24a0 <base>
 538:	a021                	j	540 <tjoin+0x26>
 53a:	07a1                	addi	a5,a5,8
 53c:	04d78763          	beq	a5,a3,58a <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 540:	6384                	ld	s1,0(a5)
 542:	dce5                	beqz	s1,53a <tjoin+0x20>
 544:	0004c703          	lbu	a4,0(s1)
 548:	fea719e3          	bne	a4,a0,53a <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 54c:	5cb8                	lw	a4,120(s1)
 54e:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 550:	00001997          	auipc	s3,0x1
 554:	a3898993          	addi	s3,s3,-1480 # f88 <malloc+0x1ea>
    while (target_thread->state != EXITED) {
 558:	4919                	li	s2,6
 55a:	02f70a63          	beq	a4,a5,58e <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 55e:	0004c583          	lbu	a1,0(s1)
 562:	854e                	mv	a0,s3
 564:	00000097          	auipc	ra,0x0
 568:	782080e7          	jalr	1922(ra) # ce6 <printf>
        tsched();
 56c:	00000097          	auipc	ra,0x0
 570:	e5e080e7          	jalr	-418(ra) # 3ca <tsched>
    while (target_thread->state != EXITED) {
 574:	5cbc                	lw	a5,120(s1)
 576:	ff2794e3          	bne	a5,s2,55e <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 57a:	4501                	li	a0,0
}
 57c:	70a2                	ld	ra,40(sp)
 57e:	7402                	ld	s0,32(sp)
 580:	64e2                	ld	s1,24(sp)
 582:	6942                	ld	s2,16(sp)
 584:	69a2                	ld	s3,8(sp)
 586:	6145                	addi	sp,sp,48
 588:	8082                	ret
        return -1;
 58a:	557d                	li	a0,-1
 58c:	bfc5                	j	57c <tjoin+0x62>
    return 0;
 58e:	4501                	li	a0,0
 590:	b7f5                	j	57c <tjoin+0x62>

0000000000000592 <tyield>:


void tyield()
{
 592:	1141                	addi	sp,sp,-16
 594:	e406                	sd	ra,8(sp)
 596:	e022                	sd	s0,0(sp)
 598:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 59a:	00002797          	auipc	a5,0x2
 59e:	a767b783          	ld	a5,-1418(a5) # 2010 <current_thread>
 5a2:	470d                	li	a4,3
 5a4:	dfb8                	sw	a4,120(a5)
    tsched();
 5a6:	00000097          	auipc	ra,0x0
 5aa:	e24080e7          	jalr	-476(ra) # 3ca <tsched>
}
 5ae:	60a2                	ld	ra,8(sp)
 5b0:	6402                	ld	s0,0(sp)
 5b2:	0141                	addi	sp,sp,16
 5b4:	8082                	ret

00000000000005b6 <twhoami>:

uint8 twhoami()
{
 5b6:	1141                	addi	sp,sp,-16
 5b8:	e422                	sd	s0,8(sp)
 5ba:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
 5bc:	00002797          	auipc	a5,0x2
 5c0:	a547b783          	ld	a5,-1452(a5) # 2010 <current_thread>
 5c4:	0007c503          	lbu	a0,0(a5)
 5c8:	6422                	ld	s0,8(sp)
 5ca:	0141                	addi	sp,sp,16
 5cc:	8082                	ret

00000000000005ce <tswtch>:
 5ce:	00153023          	sd	ra,0(a0)
 5d2:	00253423          	sd	sp,8(a0)
 5d6:	e900                	sd	s0,16(a0)
 5d8:	ed04                	sd	s1,24(a0)
 5da:	03253023          	sd	s2,32(a0)
 5de:	03353423          	sd	s3,40(a0)
 5e2:	03453823          	sd	s4,48(a0)
 5e6:	03553c23          	sd	s5,56(a0)
 5ea:	05653023          	sd	s6,64(a0)
 5ee:	05753423          	sd	s7,72(a0)
 5f2:	05853823          	sd	s8,80(a0)
 5f6:	05953c23          	sd	s9,88(a0)
 5fa:	07a53023          	sd	s10,96(a0)
 5fe:	07b53423          	sd	s11,104(a0)
 602:	0005b083          	ld	ra,0(a1)
 606:	0085b103          	ld	sp,8(a1)
 60a:	6980                	ld	s0,16(a1)
 60c:	6d84                	ld	s1,24(a1)
 60e:	0205b903          	ld	s2,32(a1)
 612:	0285b983          	ld	s3,40(a1)
 616:	0305ba03          	ld	s4,48(a1)
 61a:	0385ba83          	ld	s5,56(a1)
 61e:	0405bb03          	ld	s6,64(a1)
 622:	0485bb83          	ld	s7,72(a1)
 626:	0505bc03          	ld	s8,80(a1)
 62a:	0585bc83          	ld	s9,88(a1)
 62e:	0605bd03          	ld	s10,96(a1)
 632:	0685bd83          	ld	s11,104(a1)
 636:	8082                	ret

0000000000000638 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 638:	715d                	addi	sp,sp,-80
 63a:	e486                	sd	ra,72(sp)
 63c:	e0a2                	sd	s0,64(sp)
 63e:	fc26                	sd	s1,56(sp)
 640:	f84a                	sd	s2,48(sp)
 642:	f44e                	sd	s3,40(sp)
 644:	f052                	sd	s4,32(sp)
 646:	ec56                	sd	s5,24(sp)
 648:	e85a                	sd	s6,16(sp)
 64a:	e45e                	sd	s7,8(sp)
 64c:	0880                	addi	s0,sp,80
 64e:	892a                	mv	s2,a0
 650:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 652:	00001517          	auipc	a0,0x1
 656:	95650513          	addi	a0,a0,-1706 # fa8 <malloc+0x20a>
 65a:	00000097          	auipc	ra,0x0
 65e:	68c080e7          	jalr	1676(ra) # ce6 <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 662:	09000513          	li	a0,144
 666:	00000097          	auipc	ra,0x0
 66a:	738080e7          	jalr	1848(ra) # d9e <malloc>

    main_thread->tid = 0;
 66e:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 672:	4791                	li	a5,4
 674:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 676:	00002797          	auipc	a5,0x2
 67a:	98a7bd23          	sd	a0,-1638(a5) # 2010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 67e:	00002a17          	auipc	s4,0x2
 682:	da2a0a13          	addi	s4,s4,-606 # 2420 <threads>
 686:	00002497          	auipc	s1,0x2
 68a:	e1a48493          	addi	s1,s1,-486 # 24a0 <base>
    current_thread = main_thread;
 68e:	87d2                	mv	a5,s4
        threads[i] = NULL;
 690:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 694:	07a1                	addi	a5,a5,8
 696:	fe979de3          	bne	a5,s1,690 <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 69a:	00002797          	auipc	a5,0x2
 69e:	d8a7b323          	sd	a0,-634(a5) # 2420 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 6a2:	85ce                	mv	a1,s3
 6a4:	854a                	mv	a0,s2
 6a6:	00000097          	auipc	ra,0x0
 6aa:	b46080e7          	jalr	-1210(ra) # 1ec <main>
 6ae:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 6b0:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 6b2:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 6b4:	00001a97          	auipc	s5,0x1
 6b8:	914a8a93          	addi	s5,s5,-1772 # fc8 <malloc+0x22a>
 6bc:	a03d                	j	6ea <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 6be:	07a1                	addi	a5,a5,8
 6c0:	00978963          	beq	a5,s1,6d2 <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 6c4:	6398                	ld	a4,0(a5)
 6c6:	df65                	beqz	a4,6be <_main+0x86>
 6c8:	5f38                	lw	a4,120(a4)
 6ca:	ff370ae3          	beq	a4,s3,6be <_main+0x86>
                running_threads++;
 6ce:	2905                	addiw	s2,s2,1
 6d0:	b7fd                	j	6be <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 6d2:	85ca                	mv	a1,s2
 6d4:	8556                	mv	a0,s5
 6d6:	00000097          	auipc	ra,0x0
 6da:	610080e7          	jalr	1552(ra) # ce6 <printf>
        if (running_threads > 0) {
 6de:	01205963          	blez	s2,6f0 <_main+0xb8>
            tsched(); // Schedule another thread to run
 6e2:	00000097          	auipc	ra,0x0
 6e6:	ce8080e7          	jalr	-792(ra) # 3ca <tsched>
    current_thread = main_thread;
 6ea:	87d2                	mv	a5,s4
        running_threads = 0;
 6ec:	895a                	mv	s2,s6
 6ee:	bfd9                	j	6c4 <_main+0x8c>
        }
    }

    exit(res);
 6f0:	855e                	mv	a0,s7
 6f2:	00000097          	auipc	ra,0x0
 6f6:	274080e7          	jalr	628(ra) # 966 <exit>

00000000000006fa <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 6fa:	1141                	addi	sp,sp,-16
 6fc:	e422                	sd	s0,8(sp)
 6fe:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 700:	87aa                	mv	a5,a0
 702:	0585                	addi	a1,a1,1
 704:	0785                	addi	a5,a5,1
 706:	fff5c703          	lbu	a4,-1(a1)
 70a:	fee78fa3          	sb	a4,-1(a5)
 70e:	fb75                	bnez	a4,702 <strcpy+0x8>
        ;
    return os;
}
 710:	6422                	ld	s0,8(sp)
 712:	0141                	addi	sp,sp,16
 714:	8082                	ret

0000000000000716 <strcmp>:

int strcmp(const char *p, const char *q)
{
 716:	1141                	addi	sp,sp,-16
 718:	e422                	sd	s0,8(sp)
 71a:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 71c:	00054783          	lbu	a5,0(a0)
 720:	cb91                	beqz	a5,734 <strcmp+0x1e>
 722:	0005c703          	lbu	a4,0(a1)
 726:	00f71763          	bne	a4,a5,734 <strcmp+0x1e>
        p++, q++;
 72a:	0505                	addi	a0,a0,1
 72c:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 72e:	00054783          	lbu	a5,0(a0)
 732:	fbe5                	bnez	a5,722 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 734:	0005c503          	lbu	a0,0(a1)
}
 738:	40a7853b          	subw	a0,a5,a0
 73c:	6422                	ld	s0,8(sp)
 73e:	0141                	addi	sp,sp,16
 740:	8082                	ret

0000000000000742 <strlen>:

uint strlen(const char *s)
{
 742:	1141                	addi	sp,sp,-16
 744:	e422                	sd	s0,8(sp)
 746:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 748:	00054783          	lbu	a5,0(a0)
 74c:	cf91                	beqz	a5,768 <strlen+0x26>
 74e:	0505                	addi	a0,a0,1
 750:	87aa                	mv	a5,a0
 752:	86be                	mv	a3,a5
 754:	0785                	addi	a5,a5,1
 756:	fff7c703          	lbu	a4,-1(a5)
 75a:	ff65                	bnez	a4,752 <strlen+0x10>
 75c:	40a6853b          	subw	a0,a3,a0
 760:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 762:	6422                	ld	s0,8(sp)
 764:	0141                	addi	sp,sp,16
 766:	8082                	ret
    for (n = 0; s[n]; n++)
 768:	4501                	li	a0,0
 76a:	bfe5                	j	762 <strlen+0x20>

000000000000076c <memset>:

void *
memset(void *dst, int c, uint n)
{
 76c:	1141                	addi	sp,sp,-16
 76e:	e422                	sd	s0,8(sp)
 770:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 772:	ca19                	beqz	a2,788 <memset+0x1c>
 774:	87aa                	mv	a5,a0
 776:	1602                	slli	a2,a2,0x20
 778:	9201                	srli	a2,a2,0x20
 77a:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 77e:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 782:	0785                	addi	a5,a5,1
 784:	fee79de3          	bne	a5,a4,77e <memset+0x12>
    }
    return dst;
}
 788:	6422                	ld	s0,8(sp)
 78a:	0141                	addi	sp,sp,16
 78c:	8082                	ret

000000000000078e <strchr>:

char *
strchr(const char *s, char c)
{
 78e:	1141                	addi	sp,sp,-16
 790:	e422                	sd	s0,8(sp)
 792:	0800                	addi	s0,sp,16
    for (; *s; s++)
 794:	00054783          	lbu	a5,0(a0)
 798:	cb99                	beqz	a5,7ae <strchr+0x20>
        if (*s == c)
 79a:	00f58763          	beq	a1,a5,7a8 <strchr+0x1a>
    for (; *s; s++)
 79e:	0505                	addi	a0,a0,1
 7a0:	00054783          	lbu	a5,0(a0)
 7a4:	fbfd                	bnez	a5,79a <strchr+0xc>
            return (char *)s;
    return 0;
 7a6:	4501                	li	a0,0
}
 7a8:	6422                	ld	s0,8(sp)
 7aa:	0141                	addi	sp,sp,16
 7ac:	8082                	ret
    return 0;
 7ae:	4501                	li	a0,0
 7b0:	bfe5                	j	7a8 <strchr+0x1a>

00000000000007b2 <gets>:

char *
gets(char *buf, int max)
{
 7b2:	711d                	addi	sp,sp,-96
 7b4:	ec86                	sd	ra,88(sp)
 7b6:	e8a2                	sd	s0,80(sp)
 7b8:	e4a6                	sd	s1,72(sp)
 7ba:	e0ca                	sd	s2,64(sp)
 7bc:	fc4e                	sd	s3,56(sp)
 7be:	f852                	sd	s4,48(sp)
 7c0:	f456                	sd	s5,40(sp)
 7c2:	f05a                	sd	s6,32(sp)
 7c4:	ec5e                	sd	s7,24(sp)
 7c6:	1080                	addi	s0,sp,96
 7c8:	8baa                	mv	s7,a0
 7ca:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 7cc:	892a                	mv	s2,a0
 7ce:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 7d0:	4aa9                	li	s5,10
 7d2:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 7d4:	89a6                	mv	s3,s1
 7d6:	2485                	addiw	s1,s1,1
 7d8:	0344d863          	bge	s1,s4,808 <gets+0x56>
        cc = read(0, &c, 1);
 7dc:	4605                	li	a2,1
 7de:	faf40593          	addi	a1,s0,-81
 7e2:	4501                	li	a0,0
 7e4:	00000097          	auipc	ra,0x0
 7e8:	19a080e7          	jalr	410(ra) # 97e <read>
        if (cc < 1)
 7ec:	00a05e63          	blez	a0,808 <gets+0x56>
        buf[i++] = c;
 7f0:	faf44783          	lbu	a5,-81(s0)
 7f4:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 7f8:	01578763          	beq	a5,s5,806 <gets+0x54>
 7fc:	0905                	addi	s2,s2,1
 7fe:	fd679be3          	bne	a5,s6,7d4 <gets+0x22>
    for (i = 0; i + 1 < max;)
 802:	89a6                	mv	s3,s1
 804:	a011                	j	808 <gets+0x56>
 806:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 808:	99de                	add	s3,s3,s7
 80a:	00098023          	sb	zero,0(s3)
    return buf;
}
 80e:	855e                	mv	a0,s7
 810:	60e6                	ld	ra,88(sp)
 812:	6446                	ld	s0,80(sp)
 814:	64a6                	ld	s1,72(sp)
 816:	6906                	ld	s2,64(sp)
 818:	79e2                	ld	s3,56(sp)
 81a:	7a42                	ld	s4,48(sp)
 81c:	7aa2                	ld	s5,40(sp)
 81e:	7b02                	ld	s6,32(sp)
 820:	6be2                	ld	s7,24(sp)
 822:	6125                	addi	sp,sp,96
 824:	8082                	ret

0000000000000826 <stat>:

int stat(const char *n, struct stat *st)
{
 826:	1101                	addi	sp,sp,-32
 828:	ec06                	sd	ra,24(sp)
 82a:	e822                	sd	s0,16(sp)
 82c:	e426                	sd	s1,8(sp)
 82e:	e04a                	sd	s2,0(sp)
 830:	1000                	addi	s0,sp,32
 832:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 834:	4581                	li	a1,0
 836:	00000097          	auipc	ra,0x0
 83a:	170080e7          	jalr	368(ra) # 9a6 <open>
    if (fd < 0)
 83e:	02054563          	bltz	a0,868 <stat+0x42>
 842:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 844:	85ca                	mv	a1,s2
 846:	00000097          	auipc	ra,0x0
 84a:	178080e7          	jalr	376(ra) # 9be <fstat>
 84e:	892a                	mv	s2,a0
    close(fd);
 850:	8526                	mv	a0,s1
 852:	00000097          	auipc	ra,0x0
 856:	13c080e7          	jalr	316(ra) # 98e <close>
    return r;
}
 85a:	854a                	mv	a0,s2
 85c:	60e2                	ld	ra,24(sp)
 85e:	6442                	ld	s0,16(sp)
 860:	64a2                	ld	s1,8(sp)
 862:	6902                	ld	s2,0(sp)
 864:	6105                	addi	sp,sp,32
 866:	8082                	ret
        return -1;
 868:	597d                	li	s2,-1
 86a:	bfc5                	j	85a <stat+0x34>

000000000000086c <atoi>:

int atoi(const char *s)
{
 86c:	1141                	addi	sp,sp,-16
 86e:	e422                	sd	s0,8(sp)
 870:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 872:	00054683          	lbu	a3,0(a0)
 876:	fd06879b          	addiw	a5,a3,-48
 87a:	0ff7f793          	zext.b	a5,a5
 87e:	4625                	li	a2,9
 880:	02f66863          	bltu	a2,a5,8b0 <atoi+0x44>
 884:	872a                	mv	a4,a0
    n = 0;
 886:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 888:	0705                	addi	a4,a4,1
 88a:	0025179b          	slliw	a5,a0,0x2
 88e:	9fa9                	addw	a5,a5,a0
 890:	0017979b          	slliw	a5,a5,0x1
 894:	9fb5                	addw	a5,a5,a3
 896:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 89a:	00074683          	lbu	a3,0(a4)
 89e:	fd06879b          	addiw	a5,a3,-48
 8a2:	0ff7f793          	zext.b	a5,a5
 8a6:	fef671e3          	bgeu	a2,a5,888 <atoi+0x1c>
    return n;
}
 8aa:	6422                	ld	s0,8(sp)
 8ac:	0141                	addi	sp,sp,16
 8ae:	8082                	ret
    n = 0;
 8b0:	4501                	li	a0,0
 8b2:	bfe5                	j	8aa <atoi+0x3e>

00000000000008b4 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 8b4:	1141                	addi	sp,sp,-16
 8b6:	e422                	sd	s0,8(sp)
 8b8:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 8ba:	02b57463          	bgeu	a0,a1,8e2 <memmove+0x2e>
    {
        while (n-- > 0)
 8be:	00c05f63          	blez	a2,8dc <memmove+0x28>
 8c2:	1602                	slli	a2,a2,0x20
 8c4:	9201                	srli	a2,a2,0x20
 8c6:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 8ca:	872a                	mv	a4,a0
            *dst++ = *src++;
 8cc:	0585                	addi	a1,a1,1
 8ce:	0705                	addi	a4,a4,1
 8d0:	fff5c683          	lbu	a3,-1(a1)
 8d4:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 8d8:	fee79ae3          	bne	a5,a4,8cc <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 8dc:	6422                	ld	s0,8(sp)
 8de:	0141                	addi	sp,sp,16
 8e0:	8082                	ret
        dst += n;
 8e2:	00c50733          	add	a4,a0,a2
        src += n;
 8e6:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 8e8:	fec05ae3          	blez	a2,8dc <memmove+0x28>
 8ec:	fff6079b          	addiw	a5,a2,-1
 8f0:	1782                	slli	a5,a5,0x20
 8f2:	9381                	srli	a5,a5,0x20
 8f4:	fff7c793          	not	a5,a5
 8f8:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 8fa:	15fd                	addi	a1,a1,-1
 8fc:	177d                	addi	a4,a4,-1
 8fe:	0005c683          	lbu	a3,0(a1)
 902:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 906:	fee79ae3          	bne	a5,a4,8fa <memmove+0x46>
 90a:	bfc9                	j	8dc <memmove+0x28>

000000000000090c <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 90c:	1141                	addi	sp,sp,-16
 90e:	e422                	sd	s0,8(sp)
 910:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 912:	ca05                	beqz	a2,942 <memcmp+0x36>
 914:	fff6069b          	addiw	a3,a2,-1
 918:	1682                	slli	a3,a3,0x20
 91a:	9281                	srli	a3,a3,0x20
 91c:	0685                	addi	a3,a3,1
 91e:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 920:	00054783          	lbu	a5,0(a0)
 924:	0005c703          	lbu	a4,0(a1)
 928:	00e79863          	bne	a5,a4,938 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 92c:	0505                	addi	a0,a0,1
        p2++;
 92e:	0585                	addi	a1,a1,1
    while (n-- > 0)
 930:	fed518e3          	bne	a0,a3,920 <memcmp+0x14>
    }
    return 0;
 934:	4501                	li	a0,0
 936:	a019                	j	93c <memcmp+0x30>
            return *p1 - *p2;
 938:	40e7853b          	subw	a0,a5,a4
}
 93c:	6422                	ld	s0,8(sp)
 93e:	0141                	addi	sp,sp,16
 940:	8082                	ret
    return 0;
 942:	4501                	li	a0,0
 944:	bfe5                	j	93c <memcmp+0x30>

0000000000000946 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 946:	1141                	addi	sp,sp,-16
 948:	e406                	sd	ra,8(sp)
 94a:	e022                	sd	s0,0(sp)
 94c:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 94e:	00000097          	auipc	ra,0x0
 952:	f66080e7          	jalr	-154(ra) # 8b4 <memmove>
}
 956:	60a2                	ld	ra,8(sp)
 958:	6402                	ld	s0,0(sp)
 95a:	0141                	addi	sp,sp,16
 95c:	8082                	ret

000000000000095e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 95e:	4885                	li	a7,1
 ecall
 960:	00000073          	ecall
 ret
 964:	8082                	ret

0000000000000966 <exit>:
.global exit
exit:
 li a7, SYS_exit
 966:	4889                	li	a7,2
 ecall
 968:	00000073          	ecall
 ret
 96c:	8082                	ret

000000000000096e <wait>:
.global wait
wait:
 li a7, SYS_wait
 96e:	488d                	li	a7,3
 ecall
 970:	00000073          	ecall
 ret
 974:	8082                	ret

0000000000000976 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 976:	4891                	li	a7,4
 ecall
 978:	00000073          	ecall
 ret
 97c:	8082                	ret

000000000000097e <read>:
.global read
read:
 li a7, SYS_read
 97e:	4895                	li	a7,5
 ecall
 980:	00000073          	ecall
 ret
 984:	8082                	ret

0000000000000986 <write>:
.global write
write:
 li a7, SYS_write
 986:	48c1                	li	a7,16
 ecall
 988:	00000073          	ecall
 ret
 98c:	8082                	ret

000000000000098e <close>:
.global close
close:
 li a7, SYS_close
 98e:	48d5                	li	a7,21
 ecall
 990:	00000073          	ecall
 ret
 994:	8082                	ret

0000000000000996 <kill>:
.global kill
kill:
 li a7, SYS_kill
 996:	4899                	li	a7,6
 ecall
 998:	00000073          	ecall
 ret
 99c:	8082                	ret

000000000000099e <exec>:
.global exec
exec:
 li a7, SYS_exec
 99e:	489d                	li	a7,7
 ecall
 9a0:	00000073          	ecall
 ret
 9a4:	8082                	ret

00000000000009a6 <open>:
.global open
open:
 li a7, SYS_open
 9a6:	48bd                	li	a7,15
 ecall
 9a8:	00000073          	ecall
 ret
 9ac:	8082                	ret

00000000000009ae <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 9ae:	48c5                	li	a7,17
 ecall
 9b0:	00000073          	ecall
 ret
 9b4:	8082                	ret

00000000000009b6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 9b6:	48c9                	li	a7,18
 ecall
 9b8:	00000073          	ecall
 ret
 9bc:	8082                	ret

00000000000009be <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 9be:	48a1                	li	a7,8
 ecall
 9c0:	00000073          	ecall
 ret
 9c4:	8082                	ret

00000000000009c6 <link>:
.global link
link:
 li a7, SYS_link
 9c6:	48cd                	li	a7,19
 ecall
 9c8:	00000073          	ecall
 ret
 9cc:	8082                	ret

00000000000009ce <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 9ce:	48d1                	li	a7,20
 ecall
 9d0:	00000073          	ecall
 ret
 9d4:	8082                	ret

00000000000009d6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 9d6:	48a5                	li	a7,9
 ecall
 9d8:	00000073          	ecall
 ret
 9dc:	8082                	ret

00000000000009de <dup>:
.global dup
dup:
 li a7, SYS_dup
 9de:	48a9                	li	a7,10
 ecall
 9e0:	00000073          	ecall
 ret
 9e4:	8082                	ret

00000000000009e6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 9e6:	48ad                	li	a7,11
 ecall
 9e8:	00000073          	ecall
 ret
 9ec:	8082                	ret

00000000000009ee <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 9ee:	48b1                	li	a7,12
 ecall
 9f0:	00000073          	ecall
 ret
 9f4:	8082                	ret

00000000000009f6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 9f6:	48b5                	li	a7,13
 ecall
 9f8:	00000073          	ecall
 ret
 9fc:	8082                	ret

00000000000009fe <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 9fe:	48b9                	li	a7,14
 ecall
 a00:	00000073          	ecall
 ret
 a04:	8082                	ret

0000000000000a06 <ps>:
.global ps
ps:
 li a7, SYS_ps
 a06:	48d9                	li	a7,22
 ecall
 a08:	00000073          	ecall
 ret
 a0c:	8082                	ret

0000000000000a0e <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 a0e:	48dd                	li	a7,23
 ecall
 a10:	00000073          	ecall
 ret
 a14:	8082                	ret

0000000000000a16 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 a16:	48e1                	li	a7,24
 ecall
 a18:	00000073          	ecall
 ret
 a1c:	8082                	ret

0000000000000a1e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 a1e:	1101                	addi	sp,sp,-32
 a20:	ec06                	sd	ra,24(sp)
 a22:	e822                	sd	s0,16(sp)
 a24:	1000                	addi	s0,sp,32
 a26:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 a2a:	4605                	li	a2,1
 a2c:	fef40593          	addi	a1,s0,-17
 a30:	00000097          	auipc	ra,0x0
 a34:	f56080e7          	jalr	-170(ra) # 986 <write>
}
 a38:	60e2                	ld	ra,24(sp)
 a3a:	6442                	ld	s0,16(sp)
 a3c:	6105                	addi	sp,sp,32
 a3e:	8082                	ret

0000000000000a40 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 a40:	7139                	addi	sp,sp,-64
 a42:	fc06                	sd	ra,56(sp)
 a44:	f822                	sd	s0,48(sp)
 a46:	f426                	sd	s1,40(sp)
 a48:	f04a                	sd	s2,32(sp)
 a4a:	ec4e                	sd	s3,24(sp)
 a4c:	0080                	addi	s0,sp,64
 a4e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 a50:	c299                	beqz	a3,a56 <printint+0x16>
 a52:	0805c963          	bltz	a1,ae4 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 a56:	2581                	sext.w	a1,a1
  neg = 0;
 a58:	4881                	li	a7,0
 a5a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 a5e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 a60:	2601                	sext.w	a2,a2
 a62:	00000517          	auipc	a0,0x0
 a66:	5e650513          	addi	a0,a0,1510 # 1048 <digits>
 a6a:	883a                	mv	a6,a4
 a6c:	2705                	addiw	a4,a4,1
 a6e:	02c5f7bb          	remuw	a5,a1,a2
 a72:	1782                	slli	a5,a5,0x20
 a74:	9381                	srli	a5,a5,0x20
 a76:	97aa                	add	a5,a5,a0
 a78:	0007c783          	lbu	a5,0(a5)
 a7c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 a80:	0005879b          	sext.w	a5,a1
 a84:	02c5d5bb          	divuw	a1,a1,a2
 a88:	0685                	addi	a3,a3,1
 a8a:	fec7f0e3          	bgeu	a5,a2,a6a <printint+0x2a>
  if(neg)
 a8e:	00088c63          	beqz	a7,aa6 <printint+0x66>
    buf[i++] = '-';
 a92:	fd070793          	addi	a5,a4,-48
 a96:	00878733          	add	a4,a5,s0
 a9a:	02d00793          	li	a5,45
 a9e:	fef70823          	sb	a5,-16(a4)
 aa2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 aa6:	02e05863          	blez	a4,ad6 <printint+0x96>
 aaa:	fc040793          	addi	a5,s0,-64
 aae:	00e78933          	add	s2,a5,a4
 ab2:	fff78993          	addi	s3,a5,-1
 ab6:	99ba                	add	s3,s3,a4
 ab8:	377d                	addiw	a4,a4,-1
 aba:	1702                	slli	a4,a4,0x20
 abc:	9301                	srli	a4,a4,0x20
 abe:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 ac2:	fff94583          	lbu	a1,-1(s2)
 ac6:	8526                	mv	a0,s1
 ac8:	00000097          	auipc	ra,0x0
 acc:	f56080e7          	jalr	-170(ra) # a1e <putc>
  while(--i >= 0)
 ad0:	197d                	addi	s2,s2,-1
 ad2:	ff3918e3          	bne	s2,s3,ac2 <printint+0x82>
}
 ad6:	70e2                	ld	ra,56(sp)
 ad8:	7442                	ld	s0,48(sp)
 ada:	74a2                	ld	s1,40(sp)
 adc:	7902                	ld	s2,32(sp)
 ade:	69e2                	ld	s3,24(sp)
 ae0:	6121                	addi	sp,sp,64
 ae2:	8082                	ret
    x = -xx;
 ae4:	40b005bb          	negw	a1,a1
    neg = 1;
 ae8:	4885                	li	a7,1
    x = -xx;
 aea:	bf85                	j	a5a <printint+0x1a>

0000000000000aec <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 aec:	715d                	addi	sp,sp,-80
 aee:	e486                	sd	ra,72(sp)
 af0:	e0a2                	sd	s0,64(sp)
 af2:	fc26                	sd	s1,56(sp)
 af4:	f84a                	sd	s2,48(sp)
 af6:	f44e                	sd	s3,40(sp)
 af8:	f052                	sd	s4,32(sp)
 afa:	ec56                	sd	s5,24(sp)
 afc:	e85a                	sd	s6,16(sp)
 afe:	e45e                	sd	s7,8(sp)
 b00:	e062                	sd	s8,0(sp)
 b02:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 b04:	0005c903          	lbu	s2,0(a1)
 b08:	18090c63          	beqz	s2,ca0 <vprintf+0x1b4>
 b0c:	8aaa                	mv	s5,a0
 b0e:	8bb2                	mv	s7,a2
 b10:	00158493          	addi	s1,a1,1
  state = 0;
 b14:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 b16:	02500a13          	li	s4,37
 b1a:	4b55                	li	s6,21
 b1c:	a839                	j	b3a <vprintf+0x4e>
        putc(fd, c);
 b1e:	85ca                	mv	a1,s2
 b20:	8556                	mv	a0,s5
 b22:	00000097          	auipc	ra,0x0
 b26:	efc080e7          	jalr	-260(ra) # a1e <putc>
 b2a:	a019                	j	b30 <vprintf+0x44>
    } else if(state == '%'){
 b2c:	01498d63          	beq	s3,s4,b46 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 b30:	0485                	addi	s1,s1,1
 b32:	fff4c903          	lbu	s2,-1(s1)
 b36:	16090563          	beqz	s2,ca0 <vprintf+0x1b4>
    if(state == 0){
 b3a:	fe0999e3          	bnez	s3,b2c <vprintf+0x40>
      if(c == '%'){
 b3e:	ff4910e3          	bne	s2,s4,b1e <vprintf+0x32>
        state = '%';
 b42:	89d2                	mv	s3,s4
 b44:	b7f5                	j	b30 <vprintf+0x44>
      if(c == 'd'){
 b46:	13490263          	beq	s2,s4,c6a <vprintf+0x17e>
 b4a:	f9d9079b          	addiw	a5,s2,-99
 b4e:	0ff7f793          	zext.b	a5,a5
 b52:	12fb6563          	bltu	s6,a5,c7c <vprintf+0x190>
 b56:	f9d9079b          	addiw	a5,s2,-99
 b5a:	0ff7f713          	zext.b	a4,a5
 b5e:	10eb6f63          	bltu	s6,a4,c7c <vprintf+0x190>
 b62:	00271793          	slli	a5,a4,0x2
 b66:	00000717          	auipc	a4,0x0
 b6a:	48a70713          	addi	a4,a4,1162 # ff0 <malloc+0x252>
 b6e:	97ba                	add	a5,a5,a4
 b70:	439c                	lw	a5,0(a5)
 b72:	97ba                	add	a5,a5,a4
 b74:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 b76:	008b8913          	addi	s2,s7,8
 b7a:	4685                	li	a3,1
 b7c:	4629                	li	a2,10
 b7e:	000ba583          	lw	a1,0(s7)
 b82:	8556                	mv	a0,s5
 b84:	00000097          	auipc	ra,0x0
 b88:	ebc080e7          	jalr	-324(ra) # a40 <printint>
 b8c:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 b8e:	4981                	li	s3,0
 b90:	b745                	j	b30 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 b92:	008b8913          	addi	s2,s7,8
 b96:	4681                	li	a3,0
 b98:	4629                	li	a2,10
 b9a:	000ba583          	lw	a1,0(s7)
 b9e:	8556                	mv	a0,s5
 ba0:	00000097          	auipc	ra,0x0
 ba4:	ea0080e7          	jalr	-352(ra) # a40 <printint>
 ba8:	8bca                	mv	s7,s2
      state = 0;
 baa:	4981                	li	s3,0
 bac:	b751                	j	b30 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 bae:	008b8913          	addi	s2,s7,8
 bb2:	4681                	li	a3,0
 bb4:	4641                	li	a2,16
 bb6:	000ba583          	lw	a1,0(s7)
 bba:	8556                	mv	a0,s5
 bbc:	00000097          	auipc	ra,0x0
 bc0:	e84080e7          	jalr	-380(ra) # a40 <printint>
 bc4:	8bca                	mv	s7,s2
      state = 0;
 bc6:	4981                	li	s3,0
 bc8:	b7a5                	j	b30 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 bca:	008b8c13          	addi	s8,s7,8
 bce:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 bd2:	03000593          	li	a1,48
 bd6:	8556                	mv	a0,s5
 bd8:	00000097          	auipc	ra,0x0
 bdc:	e46080e7          	jalr	-442(ra) # a1e <putc>
  putc(fd, 'x');
 be0:	07800593          	li	a1,120
 be4:	8556                	mv	a0,s5
 be6:	00000097          	auipc	ra,0x0
 bea:	e38080e7          	jalr	-456(ra) # a1e <putc>
 bee:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 bf0:	00000b97          	auipc	s7,0x0
 bf4:	458b8b93          	addi	s7,s7,1112 # 1048 <digits>
 bf8:	03c9d793          	srli	a5,s3,0x3c
 bfc:	97de                	add	a5,a5,s7
 bfe:	0007c583          	lbu	a1,0(a5)
 c02:	8556                	mv	a0,s5
 c04:	00000097          	auipc	ra,0x0
 c08:	e1a080e7          	jalr	-486(ra) # a1e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 c0c:	0992                	slli	s3,s3,0x4
 c0e:	397d                	addiw	s2,s2,-1
 c10:	fe0914e3          	bnez	s2,bf8 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 c14:	8be2                	mv	s7,s8
      state = 0;
 c16:	4981                	li	s3,0
 c18:	bf21                	j	b30 <vprintf+0x44>
        s = va_arg(ap, char*);
 c1a:	008b8993          	addi	s3,s7,8
 c1e:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 c22:	02090163          	beqz	s2,c44 <vprintf+0x158>
        while(*s != 0){
 c26:	00094583          	lbu	a1,0(s2)
 c2a:	c9a5                	beqz	a1,c9a <vprintf+0x1ae>
          putc(fd, *s);
 c2c:	8556                	mv	a0,s5
 c2e:	00000097          	auipc	ra,0x0
 c32:	df0080e7          	jalr	-528(ra) # a1e <putc>
          s++;
 c36:	0905                	addi	s2,s2,1
        while(*s != 0){
 c38:	00094583          	lbu	a1,0(s2)
 c3c:	f9e5                	bnez	a1,c2c <vprintf+0x140>
        s = va_arg(ap, char*);
 c3e:	8bce                	mv	s7,s3
      state = 0;
 c40:	4981                	li	s3,0
 c42:	b5fd                	j	b30 <vprintf+0x44>
          s = "(null)";
 c44:	00000917          	auipc	s2,0x0
 c48:	3a490913          	addi	s2,s2,932 # fe8 <malloc+0x24a>
        while(*s != 0){
 c4c:	02800593          	li	a1,40
 c50:	bff1                	j	c2c <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 c52:	008b8913          	addi	s2,s7,8
 c56:	000bc583          	lbu	a1,0(s7)
 c5a:	8556                	mv	a0,s5
 c5c:	00000097          	auipc	ra,0x0
 c60:	dc2080e7          	jalr	-574(ra) # a1e <putc>
 c64:	8bca                	mv	s7,s2
      state = 0;
 c66:	4981                	li	s3,0
 c68:	b5e1                	j	b30 <vprintf+0x44>
        putc(fd, c);
 c6a:	02500593          	li	a1,37
 c6e:	8556                	mv	a0,s5
 c70:	00000097          	auipc	ra,0x0
 c74:	dae080e7          	jalr	-594(ra) # a1e <putc>
      state = 0;
 c78:	4981                	li	s3,0
 c7a:	bd5d                	j	b30 <vprintf+0x44>
        putc(fd, '%');
 c7c:	02500593          	li	a1,37
 c80:	8556                	mv	a0,s5
 c82:	00000097          	auipc	ra,0x0
 c86:	d9c080e7          	jalr	-612(ra) # a1e <putc>
        putc(fd, c);
 c8a:	85ca                	mv	a1,s2
 c8c:	8556                	mv	a0,s5
 c8e:	00000097          	auipc	ra,0x0
 c92:	d90080e7          	jalr	-624(ra) # a1e <putc>
      state = 0;
 c96:	4981                	li	s3,0
 c98:	bd61                	j	b30 <vprintf+0x44>
        s = va_arg(ap, char*);
 c9a:	8bce                	mv	s7,s3
      state = 0;
 c9c:	4981                	li	s3,0
 c9e:	bd49                	j	b30 <vprintf+0x44>
    }
  }
}
 ca0:	60a6                	ld	ra,72(sp)
 ca2:	6406                	ld	s0,64(sp)
 ca4:	74e2                	ld	s1,56(sp)
 ca6:	7942                	ld	s2,48(sp)
 ca8:	79a2                	ld	s3,40(sp)
 caa:	7a02                	ld	s4,32(sp)
 cac:	6ae2                	ld	s5,24(sp)
 cae:	6b42                	ld	s6,16(sp)
 cb0:	6ba2                	ld	s7,8(sp)
 cb2:	6c02                	ld	s8,0(sp)
 cb4:	6161                	addi	sp,sp,80
 cb6:	8082                	ret

0000000000000cb8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 cb8:	715d                	addi	sp,sp,-80
 cba:	ec06                	sd	ra,24(sp)
 cbc:	e822                	sd	s0,16(sp)
 cbe:	1000                	addi	s0,sp,32
 cc0:	e010                	sd	a2,0(s0)
 cc2:	e414                	sd	a3,8(s0)
 cc4:	e818                	sd	a4,16(s0)
 cc6:	ec1c                	sd	a5,24(s0)
 cc8:	03043023          	sd	a6,32(s0)
 ccc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 cd0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 cd4:	8622                	mv	a2,s0
 cd6:	00000097          	auipc	ra,0x0
 cda:	e16080e7          	jalr	-490(ra) # aec <vprintf>
}
 cde:	60e2                	ld	ra,24(sp)
 ce0:	6442                	ld	s0,16(sp)
 ce2:	6161                	addi	sp,sp,80
 ce4:	8082                	ret

0000000000000ce6 <printf>:

void
printf(const char *fmt, ...)
{
 ce6:	711d                	addi	sp,sp,-96
 ce8:	ec06                	sd	ra,24(sp)
 cea:	e822                	sd	s0,16(sp)
 cec:	1000                	addi	s0,sp,32
 cee:	e40c                	sd	a1,8(s0)
 cf0:	e810                	sd	a2,16(s0)
 cf2:	ec14                	sd	a3,24(s0)
 cf4:	f018                	sd	a4,32(s0)
 cf6:	f41c                	sd	a5,40(s0)
 cf8:	03043823          	sd	a6,48(s0)
 cfc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 d00:	00840613          	addi	a2,s0,8
 d04:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 d08:	85aa                	mv	a1,a0
 d0a:	4505                	li	a0,1
 d0c:	00000097          	auipc	ra,0x0
 d10:	de0080e7          	jalr	-544(ra) # aec <vprintf>
}
 d14:	60e2                	ld	ra,24(sp)
 d16:	6442                	ld	s0,16(sp)
 d18:	6125                	addi	sp,sp,96
 d1a:	8082                	ret

0000000000000d1c <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 d1c:	1141                	addi	sp,sp,-16
 d1e:	e422                	sd	s0,8(sp)
 d20:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 d22:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d26:	00001797          	auipc	a5,0x1
 d2a:	2f27b783          	ld	a5,754(a5) # 2018 <freep>
 d2e:	a02d                	j	d58 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 d30:	4618                	lw	a4,8(a2)
 d32:	9f2d                	addw	a4,a4,a1
 d34:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 d38:	6398                	ld	a4,0(a5)
 d3a:	6310                	ld	a2,0(a4)
 d3c:	a83d                	j	d7a <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 d3e:	ff852703          	lw	a4,-8(a0)
 d42:	9f31                	addw	a4,a4,a2
 d44:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 d46:	ff053683          	ld	a3,-16(a0)
 d4a:	a091                	j	d8e <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d4c:	6398                	ld	a4,0(a5)
 d4e:	00e7e463          	bltu	a5,a4,d56 <free+0x3a>
 d52:	00e6ea63          	bltu	a3,a4,d66 <free+0x4a>
{
 d56:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d58:	fed7fae3          	bgeu	a5,a3,d4c <free+0x30>
 d5c:	6398                	ld	a4,0(a5)
 d5e:	00e6e463          	bltu	a3,a4,d66 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d62:	fee7eae3          	bltu	a5,a4,d56 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 d66:	ff852583          	lw	a1,-8(a0)
 d6a:	6390                	ld	a2,0(a5)
 d6c:	02059813          	slli	a6,a1,0x20
 d70:	01c85713          	srli	a4,a6,0x1c
 d74:	9736                	add	a4,a4,a3
 d76:	fae60de3          	beq	a2,a4,d30 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 d7a:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 d7e:	4790                	lw	a2,8(a5)
 d80:	02061593          	slli	a1,a2,0x20
 d84:	01c5d713          	srli	a4,a1,0x1c
 d88:	973e                	add	a4,a4,a5
 d8a:	fae68ae3          	beq	a3,a4,d3e <free+0x22>
        p->s.ptr = bp->s.ptr;
 d8e:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 d90:	00001717          	auipc	a4,0x1
 d94:	28f73423          	sd	a5,648(a4) # 2018 <freep>
}
 d98:	6422                	ld	s0,8(sp)
 d9a:	0141                	addi	sp,sp,16
 d9c:	8082                	ret

0000000000000d9e <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 d9e:	7139                	addi	sp,sp,-64
 da0:	fc06                	sd	ra,56(sp)
 da2:	f822                	sd	s0,48(sp)
 da4:	f426                	sd	s1,40(sp)
 da6:	f04a                	sd	s2,32(sp)
 da8:	ec4e                	sd	s3,24(sp)
 daa:	e852                	sd	s4,16(sp)
 dac:	e456                	sd	s5,8(sp)
 dae:	e05a                	sd	s6,0(sp)
 db0:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 db2:	02051493          	slli	s1,a0,0x20
 db6:	9081                	srli	s1,s1,0x20
 db8:	04bd                	addi	s1,s1,15
 dba:	8091                	srli	s1,s1,0x4
 dbc:	0014899b          	addiw	s3,s1,1
 dc0:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 dc2:	00001517          	auipc	a0,0x1
 dc6:	25653503          	ld	a0,598(a0) # 2018 <freep>
 dca:	c515                	beqz	a0,df6 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 dcc:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 dce:	4798                	lw	a4,8(a5)
 dd0:	02977f63          	bgeu	a4,s1,e0e <malloc+0x70>
    if (nu < 4096)
 dd4:	8a4e                	mv	s4,s3
 dd6:	0009871b          	sext.w	a4,s3
 dda:	6685                	lui	a3,0x1
 ddc:	00d77363          	bgeu	a4,a3,de2 <malloc+0x44>
 de0:	6a05                	lui	s4,0x1
 de2:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 de6:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 dea:	00001917          	auipc	s2,0x1
 dee:	22e90913          	addi	s2,s2,558 # 2018 <freep>
    if (p == (char *)-1)
 df2:	5afd                	li	s5,-1
 df4:	a895                	j	e68 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 df6:	00001797          	auipc	a5,0x1
 dfa:	6aa78793          	addi	a5,a5,1706 # 24a0 <base>
 dfe:	00001717          	auipc	a4,0x1
 e02:	20f73d23          	sd	a5,538(a4) # 2018 <freep>
 e06:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 e08:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 e0c:	b7e1                	j	dd4 <malloc+0x36>
            if (p->s.size == nunits)
 e0e:	02e48c63          	beq	s1,a4,e46 <malloc+0xa8>
                p->s.size -= nunits;
 e12:	4137073b          	subw	a4,a4,s3
 e16:	c798                	sw	a4,8(a5)
                p += p->s.size;
 e18:	02071693          	slli	a3,a4,0x20
 e1c:	01c6d713          	srli	a4,a3,0x1c
 e20:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 e22:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 e26:	00001717          	auipc	a4,0x1
 e2a:	1ea73923          	sd	a0,498(a4) # 2018 <freep>
            return (void *)(p + 1);
 e2e:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 e32:	70e2                	ld	ra,56(sp)
 e34:	7442                	ld	s0,48(sp)
 e36:	74a2                	ld	s1,40(sp)
 e38:	7902                	ld	s2,32(sp)
 e3a:	69e2                	ld	s3,24(sp)
 e3c:	6a42                	ld	s4,16(sp)
 e3e:	6aa2                	ld	s5,8(sp)
 e40:	6b02                	ld	s6,0(sp)
 e42:	6121                	addi	sp,sp,64
 e44:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 e46:	6398                	ld	a4,0(a5)
 e48:	e118                	sd	a4,0(a0)
 e4a:	bff1                	j	e26 <malloc+0x88>
    hp->s.size = nu;
 e4c:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 e50:	0541                	addi	a0,a0,16
 e52:	00000097          	auipc	ra,0x0
 e56:	eca080e7          	jalr	-310(ra) # d1c <free>
    return freep;
 e5a:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 e5e:	d971                	beqz	a0,e32 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 e60:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 e62:	4798                	lw	a4,8(a5)
 e64:	fa9775e3          	bgeu	a4,s1,e0e <malloc+0x70>
        if (p == freep)
 e68:	00093703          	ld	a4,0(s2)
 e6c:	853e                	mv	a0,a5
 e6e:	fef719e3          	bne	a4,a5,e60 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 e72:	8552                	mv	a0,s4
 e74:	00000097          	auipc	ra,0x0
 e78:	b7a080e7          	jalr	-1158(ra) # 9ee <sbrk>
    if (p == (char *)-1)
 e7c:	fd5518e3          	bne	a0,s5,e4c <malloc+0xae>
                return 0;
 e80:	4501                	li	a0,0
 e82:	bf45                	j	e32 <malloc+0x94>
