
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
 140:	ed4a8a93          	addi	s5,s5,-300 # 1010 <buf>
 144:	a0a1                	j	18c <grep+0x72>
      p = q+1;
 146:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 14a:	45a9                	li	a1,10
 14c:	854a                	mv	a0,s2
 14e:	00000097          	auipc	ra,0x0
 152:	43e080e7          	jalr	1086(ra) # 58c <strchr>
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
 182:	606080e7          	jalr	1542(ra) # 784 <write>
 186:	b7c1                	j	146 <grep+0x2c>
    if(m > 0){
 188:	03404763          	bgtz	s4,1b6 <grep+0x9c>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 18c:	414b863b          	subw	a2,s7,s4
 190:	014a85b3          	add	a1,s5,s4
 194:	855a                	mv	a0,s6
 196:	00000097          	auipc	ra,0x0
 19a:	5e6080e7          	jalr	1510(ra) # 77c <read>
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
 1ba:	e5a50513          	addi	a0,a0,-422 # 1010 <buf>
 1be:	40a90a33          	sub	s4,s2,a0
 1c2:	414c0a3b          	subw	s4,s8,s4
      memmove(buf, p, m);
 1c6:	8652                	mv	a2,s4
 1c8:	85ca                	mv	a1,s2
 1ca:	00000097          	auipc	ra,0x0
 1ce:	4e8080e7          	jalr	1256(ra) # 6b2 <memmove>
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
 22a:	57e080e7          	jalr	1406(ra) # 7a4 <open>
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
 246:	54a080e7          	jalr	1354(ra) # 78c <close>
  for(i = 2; i < argc; i++){
 24a:	0921                	addi	s2,s2,8
 24c:	fd391ae3          	bne	s2,s3,220 <main+0x34>
  exit(0);
 250:	4501                	li	a0,0
 252:	00000097          	auipc	ra,0x0
 256:	512080e7          	jalr	1298(ra) # 764 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 25a:	00001597          	auipc	a1,0x1
 25e:	a3658593          	addi	a1,a1,-1482 # c90 <malloc+0xf4>
 262:	4509                	li	a0,2
 264:	00001097          	auipc	ra,0x1
 268:	852080e7          	jalr	-1966(ra) # ab6 <fprintf>
    exit(1);
 26c:	4505                	li	a0,1
 26e:	00000097          	auipc	ra,0x0
 272:	4f6080e7          	jalr	1270(ra) # 764 <exit>
    grep(pattern, 0);
 276:	4581                	li	a1,0
 278:	8552                	mv	a0,s4
 27a:	00000097          	auipc	ra,0x0
 27e:	ea0080e7          	jalr	-352(ra) # 11a <grep>
    exit(0);
 282:	4501                	li	a0,0
 284:	00000097          	auipc	ra,0x0
 288:	4e0080e7          	jalr	1248(ra) # 764 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 28c:	00093583          	ld	a1,0(s2)
 290:	00001517          	auipc	a0,0x1
 294:	a2050513          	addi	a0,a0,-1504 # cb0 <malloc+0x114>
 298:	00001097          	auipc	ra,0x1
 29c:	84c080e7          	jalr	-1972(ra) # ae4 <printf>
      exit(1);
 2a0:	4505                	li	a0,1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	4c2080e7          	jalr	1218(ra) # 764 <exit>

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
 2de:	172080e7          	jalr	370(ra) # 44c <twhoami>
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
 32a:	9a250513          	addi	a0,a0,-1630 # cc8 <malloc+0x12c>
 32e:	00000097          	auipc	ra,0x0
 332:	7b6080e7          	jalr	1974(ra) # ae4 <printf>
        exit(-1);
 336:	557d                	li	a0,-1
 338:	00000097          	auipc	ra,0x0
 33c:	42c080e7          	jalr	1068(ra) # 764 <exit>
    {
        // give up the cpu for other threads
        tyield();
 340:	00000097          	auipc	ra,0x0
 344:	0f4080e7          	jalr	244(ra) # 434 <tyield>
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
 35e:	0f2080e7          	jalr	242(ra) # 44c <twhoami>
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
 3a2:	096080e7          	jalr	150(ra) # 434 <tyield>
}
 3a6:	60e2                	ld	ra,24(sp)
 3a8:	6442                	ld	s0,16(sp)
 3aa:	64a2                	ld	s1,8(sp)
 3ac:	6105                	addi	sp,sp,32
 3ae:	8082                	ret
        printf("releasing lock we are not holding");
 3b0:	00001517          	auipc	a0,0x1
 3b4:	94050513          	addi	a0,a0,-1728 # cf0 <malloc+0x154>
 3b8:	00000097          	auipc	ra,0x0
 3bc:	72c080e7          	jalr	1836(ra) # ae4 <printf>
        exit(-1);
 3c0:	557d                	li	a0,-1
 3c2:	00000097          	auipc	ra,0x0
 3c6:	3a2080e7          	jalr	930(ra) # 764 <exit>

00000000000003ca <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 3ca:	1141                	addi	sp,sp,-16
 3cc:	e422                	sd	s0,8(sp)
 3ce:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 3d0:	00001717          	auipc	a4,0x1
 3d4:	c3073703          	ld	a4,-976(a4) # 1000 <current_thread>
 3d8:	47c1                	li	a5,16
 3da:	c319                	beqz	a4,3e0 <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 3dc:	37fd                	addiw	a5,a5,-1
 3de:	fff5                	bnez	a5,3da <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 3e0:	6422                	ld	s0,8(sp)
 3e2:	0141                	addi	sp,sp,16
 3e4:	8082                	ret

00000000000003e6 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 3e6:	7179                	addi	sp,sp,-48
 3e8:	f406                	sd	ra,40(sp)
 3ea:	f022                	sd	s0,32(sp)
 3ec:	ec26                	sd	s1,24(sp)
 3ee:	e84a                	sd	s2,16(sp)
 3f0:	e44e                	sd	s3,8(sp)
 3f2:	1800                	addi	s0,sp,48
 3f4:	84aa                	mv	s1,a0
 3f6:	89b2                	mv	s3,a2
 3f8:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 3fa:	09000513          	li	a0,144
 3fe:	00000097          	auipc	ra,0x0
 402:	79e080e7          	jalr	1950(ra) # b9c <malloc>
 406:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 408:	478d                	li	a5,3
 40a:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 40c:	609c                	ld	a5,0(s1)
 40e:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 412:	609c                	ld	a5,0(s1)
 414:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 418:	70a2                	ld	ra,40(sp)
 41a:	7402                	ld	s0,32(sp)
 41c:	64e2                	ld	s1,24(sp)
 41e:	6942                	ld	s2,16(sp)
 420:	69a2                	ld	s3,8(sp)
 422:	6145                	addi	sp,sp,48
 424:	8082                	ret

0000000000000426 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 426:	1141                	addi	sp,sp,-16
 428:	e422                	sd	s0,8(sp)
 42a:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 42c:	4501                	li	a0,0
 42e:	6422                	ld	s0,8(sp)
 430:	0141                	addi	sp,sp,16
 432:	8082                	ret

0000000000000434 <tyield>:

void tyield()
{
 434:	1141                	addi	sp,sp,-16
 436:	e422                	sd	s0,8(sp)
 438:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 43a:	00001797          	auipc	a5,0x1
 43e:	bc67b783          	ld	a5,-1082(a5) # 1000 <current_thread>
 442:	470d                	li	a4,3
 444:	dfb8                	sw	a4,120(a5)
    tsched();
}
 446:	6422                	ld	s0,8(sp)
 448:	0141                	addi	sp,sp,16
 44a:	8082                	ret

000000000000044c <twhoami>:

uint8 twhoami()
{
 44c:	1141                	addi	sp,sp,-16
 44e:	e422                	sd	s0,8(sp)
 450:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 452:	4501                	li	a0,0
 454:	6422                	ld	s0,8(sp)
 456:	0141                	addi	sp,sp,16
 458:	8082                	ret

000000000000045a <tswtch>:
 45a:	00153023          	sd	ra,0(a0)
 45e:	00253423          	sd	sp,8(a0)
 462:	e900                	sd	s0,16(a0)
 464:	ed04                	sd	s1,24(a0)
 466:	03253023          	sd	s2,32(a0)
 46a:	03353423          	sd	s3,40(a0)
 46e:	03453823          	sd	s4,48(a0)
 472:	03553c23          	sd	s5,56(a0)
 476:	05653023          	sd	s6,64(a0)
 47a:	05753423          	sd	s7,72(a0)
 47e:	05853823          	sd	s8,80(a0)
 482:	05953c23          	sd	s9,88(a0)
 486:	07a53023          	sd	s10,96(a0)
 48a:	07b53423          	sd	s11,104(a0)
 48e:	0005b083          	ld	ra,0(a1)
 492:	0085b103          	ld	sp,8(a1)
 496:	6980                	ld	s0,16(a1)
 498:	6d84                	ld	s1,24(a1)
 49a:	0205b903          	ld	s2,32(a1)
 49e:	0285b983          	ld	s3,40(a1)
 4a2:	0305ba03          	ld	s4,48(a1)
 4a6:	0385ba83          	ld	s5,56(a1)
 4aa:	0405bb03          	ld	s6,64(a1)
 4ae:	0485bb83          	ld	s7,72(a1)
 4b2:	0505bc03          	ld	s8,80(a1)
 4b6:	0585bc83          	ld	s9,88(a1)
 4ba:	0605bd03          	ld	s10,96(a1)
 4be:	0685bd83          	ld	s11,104(a1)
 4c2:	8082                	ret

00000000000004c4 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 4c4:	1101                	addi	sp,sp,-32
 4c6:	ec06                	sd	ra,24(sp)
 4c8:	e822                	sd	s0,16(sp)
 4ca:	e426                	sd	s1,8(sp)
 4cc:	e04a                	sd	s2,0(sp)
 4ce:	1000                	addi	s0,sp,32
 4d0:	84aa                	mv	s1,a0
 4d2:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 4d4:	09000513          	li	a0,144
 4d8:	00000097          	auipc	ra,0x0
 4dc:	6c4080e7          	jalr	1732(ra) # b9c <malloc>

    main_thread->tid = 0;
 4e0:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 4e4:	85ca                	mv	a1,s2
 4e6:	8526                	mv	a0,s1
 4e8:	00000097          	auipc	ra,0x0
 4ec:	d04080e7          	jalr	-764(ra) # 1ec <main>
    exit(res);
 4f0:	00000097          	auipc	ra,0x0
 4f4:	274080e7          	jalr	628(ra) # 764 <exit>

00000000000004f8 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 4f8:	1141                	addi	sp,sp,-16
 4fa:	e422                	sd	s0,8(sp)
 4fc:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 4fe:	87aa                	mv	a5,a0
 500:	0585                	addi	a1,a1,1
 502:	0785                	addi	a5,a5,1
 504:	fff5c703          	lbu	a4,-1(a1)
 508:	fee78fa3          	sb	a4,-1(a5)
 50c:	fb75                	bnez	a4,500 <strcpy+0x8>
        ;
    return os;
}
 50e:	6422                	ld	s0,8(sp)
 510:	0141                	addi	sp,sp,16
 512:	8082                	ret

0000000000000514 <strcmp>:

int strcmp(const char *p, const char *q)
{
 514:	1141                	addi	sp,sp,-16
 516:	e422                	sd	s0,8(sp)
 518:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 51a:	00054783          	lbu	a5,0(a0)
 51e:	cb91                	beqz	a5,532 <strcmp+0x1e>
 520:	0005c703          	lbu	a4,0(a1)
 524:	00f71763          	bne	a4,a5,532 <strcmp+0x1e>
        p++, q++;
 528:	0505                	addi	a0,a0,1
 52a:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 52c:	00054783          	lbu	a5,0(a0)
 530:	fbe5                	bnez	a5,520 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 532:	0005c503          	lbu	a0,0(a1)
}
 536:	40a7853b          	subw	a0,a5,a0
 53a:	6422                	ld	s0,8(sp)
 53c:	0141                	addi	sp,sp,16
 53e:	8082                	ret

0000000000000540 <strlen>:

uint strlen(const char *s)
{
 540:	1141                	addi	sp,sp,-16
 542:	e422                	sd	s0,8(sp)
 544:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 546:	00054783          	lbu	a5,0(a0)
 54a:	cf91                	beqz	a5,566 <strlen+0x26>
 54c:	0505                	addi	a0,a0,1
 54e:	87aa                	mv	a5,a0
 550:	86be                	mv	a3,a5
 552:	0785                	addi	a5,a5,1
 554:	fff7c703          	lbu	a4,-1(a5)
 558:	ff65                	bnez	a4,550 <strlen+0x10>
 55a:	40a6853b          	subw	a0,a3,a0
 55e:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 560:	6422                	ld	s0,8(sp)
 562:	0141                	addi	sp,sp,16
 564:	8082                	ret
    for (n = 0; s[n]; n++)
 566:	4501                	li	a0,0
 568:	bfe5                	j	560 <strlen+0x20>

000000000000056a <memset>:

void *
memset(void *dst, int c, uint n)
{
 56a:	1141                	addi	sp,sp,-16
 56c:	e422                	sd	s0,8(sp)
 56e:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 570:	ca19                	beqz	a2,586 <memset+0x1c>
 572:	87aa                	mv	a5,a0
 574:	1602                	slli	a2,a2,0x20
 576:	9201                	srli	a2,a2,0x20
 578:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 57c:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 580:	0785                	addi	a5,a5,1
 582:	fee79de3          	bne	a5,a4,57c <memset+0x12>
    }
    return dst;
}
 586:	6422                	ld	s0,8(sp)
 588:	0141                	addi	sp,sp,16
 58a:	8082                	ret

000000000000058c <strchr>:

char *
strchr(const char *s, char c)
{
 58c:	1141                	addi	sp,sp,-16
 58e:	e422                	sd	s0,8(sp)
 590:	0800                	addi	s0,sp,16
    for (; *s; s++)
 592:	00054783          	lbu	a5,0(a0)
 596:	cb99                	beqz	a5,5ac <strchr+0x20>
        if (*s == c)
 598:	00f58763          	beq	a1,a5,5a6 <strchr+0x1a>
    for (; *s; s++)
 59c:	0505                	addi	a0,a0,1
 59e:	00054783          	lbu	a5,0(a0)
 5a2:	fbfd                	bnez	a5,598 <strchr+0xc>
            return (char *)s;
    return 0;
 5a4:	4501                	li	a0,0
}
 5a6:	6422                	ld	s0,8(sp)
 5a8:	0141                	addi	sp,sp,16
 5aa:	8082                	ret
    return 0;
 5ac:	4501                	li	a0,0
 5ae:	bfe5                	j	5a6 <strchr+0x1a>

00000000000005b0 <gets>:

char *
gets(char *buf, int max)
{
 5b0:	711d                	addi	sp,sp,-96
 5b2:	ec86                	sd	ra,88(sp)
 5b4:	e8a2                	sd	s0,80(sp)
 5b6:	e4a6                	sd	s1,72(sp)
 5b8:	e0ca                	sd	s2,64(sp)
 5ba:	fc4e                	sd	s3,56(sp)
 5bc:	f852                	sd	s4,48(sp)
 5be:	f456                	sd	s5,40(sp)
 5c0:	f05a                	sd	s6,32(sp)
 5c2:	ec5e                	sd	s7,24(sp)
 5c4:	1080                	addi	s0,sp,96
 5c6:	8baa                	mv	s7,a0
 5c8:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 5ca:	892a                	mv	s2,a0
 5cc:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 5ce:	4aa9                	li	s5,10
 5d0:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 5d2:	89a6                	mv	s3,s1
 5d4:	2485                	addiw	s1,s1,1
 5d6:	0344d863          	bge	s1,s4,606 <gets+0x56>
        cc = read(0, &c, 1);
 5da:	4605                	li	a2,1
 5dc:	faf40593          	addi	a1,s0,-81
 5e0:	4501                	li	a0,0
 5e2:	00000097          	auipc	ra,0x0
 5e6:	19a080e7          	jalr	410(ra) # 77c <read>
        if (cc < 1)
 5ea:	00a05e63          	blez	a0,606 <gets+0x56>
        buf[i++] = c;
 5ee:	faf44783          	lbu	a5,-81(s0)
 5f2:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 5f6:	01578763          	beq	a5,s5,604 <gets+0x54>
 5fa:	0905                	addi	s2,s2,1
 5fc:	fd679be3          	bne	a5,s6,5d2 <gets+0x22>
    for (i = 0; i + 1 < max;)
 600:	89a6                	mv	s3,s1
 602:	a011                	j	606 <gets+0x56>
 604:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 606:	99de                	add	s3,s3,s7
 608:	00098023          	sb	zero,0(s3)
    return buf;
}
 60c:	855e                	mv	a0,s7
 60e:	60e6                	ld	ra,88(sp)
 610:	6446                	ld	s0,80(sp)
 612:	64a6                	ld	s1,72(sp)
 614:	6906                	ld	s2,64(sp)
 616:	79e2                	ld	s3,56(sp)
 618:	7a42                	ld	s4,48(sp)
 61a:	7aa2                	ld	s5,40(sp)
 61c:	7b02                	ld	s6,32(sp)
 61e:	6be2                	ld	s7,24(sp)
 620:	6125                	addi	sp,sp,96
 622:	8082                	ret

0000000000000624 <stat>:

int stat(const char *n, struct stat *st)
{
 624:	1101                	addi	sp,sp,-32
 626:	ec06                	sd	ra,24(sp)
 628:	e822                	sd	s0,16(sp)
 62a:	e426                	sd	s1,8(sp)
 62c:	e04a                	sd	s2,0(sp)
 62e:	1000                	addi	s0,sp,32
 630:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 632:	4581                	li	a1,0
 634:	00000097          	auipc	ra,0x0
 638:	170080e7          	jalr	368(ra) # 7a4 <open>
    if (fd < 0)
 63c:	02054563          	bltz	a0,666 <stat+0x42>
 640:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 642:	85ca                	mv	a1,s2
 644:	00000097          	auipc	ra,0x0
 648:	178080e7          	jalr	376(ra) # 7bc <fstat>
 64c:	892a                	mv	s2,a0
    close(fd);
 64e:	8526                	mv	a0,s1
 650:	00000097          	auipc	ra,0x0
 654:	13c080e7          	jalr	316(ra) # 78c <close>
    return r;
}
 658:	854a                	mv	a0,s2
 65a:	60e2                	ld	ra,24(sp)
 65c:	6442                	ld	s0,16(sp)
 65e:	64a2                	ld	s1,8(sp)
 660:	6902                	ld	s2,0(sp)
 662:	6105                	addi	sp,sp,32
 664:	8082                	ret
        return -1;
 666:	597d                	li	s2,-1
 668:	bfc5                	j	658 <stat+0x34>

000000000000066a <atoi>:

int atoi(const char *s)
{
 66a:	1141                	addi	sp,sp,-16
 66c:	e422                	sd	s0,8(sp)
 66e:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 670:	00054683          	lbu	a3,0(a0)
 674:	fd06879b          	addiw	a5,a3,-48
 678:	0ff7f793          	zext.b	a5,a5
 67c:	4625                	li	a2,9
 67e:	02f66863          	bltu	a2,a5,6ae <atoi+0x44>
 682:	872a                	mv	a4,a0
    n = 0;
 684:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 686:	0705                	addi	a4,a4,1
 688:	0025179b          	slliw	a5,a0,0x2
 68c:	9fa9                	addw	a5,a5,a0
 68e:	0017979b          	slliw	a5,a5,0x1
 692:	9fb5                	addw	a5,a5,a3
 694:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 698:	00074683          	lbu	a3,0(a4)
 69c:	fd06879b          	addiw	a5,a3,-48
 6a0:	0ff7f793          	zext.b	a5,a5
 6a4:	fef671e3          	bgeu	a2,a5,686 <atoi+0x1c>
    return n;
}
 6a8:	6422                	ld	s0,8(sp)
 6aa:	0141                	addi	sp,sp,16
 6ac:	8082                	ret
    n = 0;
 6ae:	4501                	li	a0,0
 6b0:	bfe5                	j	6a8 <atoi+0x3e>

00000000000006b2 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 6b2:	1141                	addi	sp,sp,-16
 6b4:	e422                	sd	s0,8(sp)
 6b6:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 6b8:	02b57463          	bgeu	a0,a1,6e0 <memmove+0x2e>
    {
        while (n-- > 0)
 6bc:	00c05f63          	blez	a2,6da <memmove+0x28>
 6c0:	1602                	slli	a2,a2,0x20
 6c2:	9201                	srli	a2,a2,0x20
 6c4:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 6c8:	872a                	mv	a4,a0
            *dst++ = *src++;
 6ca:	0585                	addi	a1,a1,1
 6cc:	0705                	addi	a4,a4,1
 6ce:	fff5c683          	lbu	a3,-1(a1)
 6d2:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 6d6:	fee79ae3          	bne	a5,a4,6ca <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 6da:	6422                	ld	s0,8(sp)
 6dc:	0141                	addi	sp,sp,16
 6de:	8082                	ret
        dst += n;
 6e0:	00c50733          	add	a4,a0,a2
        src += n;
 6e4:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 6e6:	fec05ae3          	blez	a2,6da <memmove+0x28>
 6ea:	fff6079b          	addiw	a5,a2,-1
 6ee:	1782                	slli	a5,a5,0x20
 6f0:	9381                	srli	a5,a5,0x20
 6f2:	fff7c793          	not	a5,a5
 6f6:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 6f8:	15fd                	addi	a1,a1,-1
 6fa:	177d                	addi	a4,a4,-1
 6fc:	0005c683          	lbu	a3,0(a1)
 700:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 704:	fee79ae3          	bne	a5,a4,6f8 <memmove+0x46>
 708:	bfc9                	j	6da <memmove+0x28>

000000000000070a <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 70a:	1141                	addi	sp,sp,-16
 70c:	e422                	sd	s0,8(sp)
 70e:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 710:	ca05                	beqz	a2,740 <memcmp+0x36>
 712:	fff6069b          	addiw	a3,a2,-1
 716:	1682                	slli	a3,a3,0x20
 718:	9281                	srli	a3,a3,0x20
 71a:	0685                	addi	a3,a3,1
 71c:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 71e:	00054783          	lbu	a5,0(a0)
 722:	0005c703          	lbu	a4,0(a1)
 726:	00e79863          	bne	a5,a4,736 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 72a:	0505                	addi	a0,a0,1
        p2++;
 72c:	0585                	addi	a1,a1,1
    while (n-- > 0)
 72e:	fed518e3          	bne	a0,a3,71e <memcmp+0x14>
    }
    return 0;
 732:	4501                	li	a0,0
 734:	a019                	j	73a <memcmp+0x30>
            return *p1 - *p2;
 736:	40e7853b          	subw	a0,a5,a4
}
 73a:	6422                	ld	s0,8(sp)
 73c:	0141                	addi	sp,sp,16
 73e:	8082                	ret
    return 0;
 740:	4501                	li	a0,0
 742:	bfe5                	j	73a <memcmp+0x30>

0000000000000744 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 744:	1141                	addi	sp,sp,-16
 746:	e406                	sd	ra,8(sp)
 748:	e022                	sd	s0,0(sp)
 74a:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 74c:	00000097          	auipc	ra,0x0
 750:	f66080e7          	jalr	-154(ra) # 6b2 <memmove>
}
 754:	60a2                	ld	ra,8(sp)
 756:	6402                	ld	s0,0(sp)
 758:	0141                	addi	sp,sp,16
 75a:	8082                	ret

000000000000075c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 75c:	4885                	li	a7,1
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <exit>:
.global exit
exit:
 li a7, SYS_exit
 764:	4889                	li	a7,2
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <wait>:
.global wait
wait:
 li a7, SYS_wait
 76c:	488d                	li	a7,3
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 774:	4891                	li	a7,4
 ecall
 776:	00000073          	ecall
 ret
 77a:	8082                	ret

000000000000077c <read>:
.global read
read:
 li a7, SYS_read
 77c:	4895                	li	a7,5
 ecall
 77e:	00000073          	ecall
 ret
 782:	8082                	ret

0000000000000784 <write>:
.global write
write:
 li a7, SYS_write
 784:	48c1                	li	a7,16
 ecall
 786:	00000073          	ecall
 ret
 78a:	8082                	ret

000000000000078c <close>:
.global close
close:
 li a7, SYS_close
 78c:	48d5                	li	a7,21
 ecall
 78e:	00000073          	ecall
 ret
 792:	8082                	ret

0000000000000794 <kill>:
.global kill
kill:
 li a7, SYS_kill
 794:	4899                	li	a7,6
 ecall
 796:	00000073          	ecall
 ret
 79a:	8082                	ret

000000000000079c <exec>:
.global exec
exec:
 li a7, SYS_exec
 79c:	489d                	li	a7,7
 ecall
 79e:	00000073          	ecall
 ret
 7a2:	8082                	ret

00000000000007a4 <open>:
.global open
open:
 li a7, SYS_open
 7a4:	48bd                	li	a7,15
 ecall
 7a6:	00000073          	ecall
 ret
 7aa:	8082                	ret

00000000000007ac <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7ac:	48c5                	li	a7,17
 ecall
 7ae:	00000073          	ecall
 ret
 7b2:	8082                	ret

00000000000007b4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7b4:	48c9                	li	a7,18
 ecall
 7b6:	00000073          	ecall
 ret
 7ba:	8082                	ret

00000000000007bc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7bc:	48a1                	li	a7,8
 ecall
 7be:	00000073          	ecall
 ret
 7c2:	8082                	ret

00000000000007c4 <link>:
.global link
link:
 li a7, SYS_link
 7c4:	48cd                	li	a7,19
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7cc:	48d1                	li	a7,20
 ecall
 7ce:	00000073          	ecall
 ret
 7d2:	8082                	ret

00000000000007d4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7d4:	48a5                	li	a7,9
 ecall
 7d6:	00000073          	ecall
 ret
 7da:	8082                	ret

00000000000007dc <dup>:
.global dup
dup:
 li a7, SYS_dup
 7dc:	48a9                	li	a7,10
 ecall
 7de:	00000073          	ecall
 ret
 7e2:	8082                	ret

00000000000007e4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7e4:	48ad                	li	a7,11
 ecall
 7e6:	00000073          	ecall
 ret
 7ea:	8082                	ret

00000000000007ec <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7ec:	48b1                	li	a7,12
 ecall
 7ee:	00000073          	ecall
 ret
 7f2:	8082                	ret

00000000000007f4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7f4:	48b5                	li	a7,13
 ecall
 7f6:	00000073          	ecall
 ret
 7fa:	8082                	ret

00000000000007fc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7fc:	48b9                	li	a7,14
 ecall
 7fe:	00000073          	ecall
 ret
 802:	8082                	ret

0000000000000804 <ps>:
.global ps
ps:
 li a7, SYS_ps
 804:	48d9                	li	a7,22
 ecall
 806:	00000073          	ecall
 ret
 80a:	8082                	ret

000000000000080c <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 80c:	48dd                	li	a7,23
 ecall
 80e:	00000073          	ecall
 ret
 812:	8082                	ret

0000000000000814 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 814:	48e1                	li	a7,24
 ecall
 816:	00000073          	ecall
 ret
 81a:	8082                	ret

000000000000081c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 81c:	1101                	addi	sp,sp,-32
 81e:	ec06                	sd	ra,24(sp)
 820:	e822                	sd	s0,16(sp)
 822:	1000                	addi	s0,sp,32
 824:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 828:	4605                	li	a2,1
 82a:	fef40593          	addi	a1,s0,-17
 82e:	00000097          	auipc	ra,0x0
 832:	f56080e7          	jalr	-170(ra) # 784 <write>
}
 836:	60e2                	ld	ra,24(sp)
 838:	6442                	ld	s0,16(sp)
 83a:	6105                	addi	sp,sp,32
 83c:	8082                	ret

000000000000083e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 83e:	7139                	addi	sp,sp,-64
 840:	fc06                	sd	ra,56(sp)
 842:	f822                	sd	s0,48(sp)
 844:	f426                	sd	s1,40(sp)
 846:	f04a                	sd	s2,32(sp)
 848:	ec4e                	sd	s3,24(sp)
 84a:	0080                	addi	s0,sp,64
 84c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 84e:	c299                	beqz	a3,854 <printint+0x16>
 850:	0805c963          	bltz	a1,8e2 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 854:	2581                	sext.w	a1,a1
  neg = 0;
 856:	4881                	li	a7,0
 858:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 85c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 85e:	2601                	sext.w	a2,a2
 860:	00000517          	auipc	a0,0x0
 864:	51850513          	addi	a0,a0,1304 # d78 <digits>
 868:	883a                	mv	a6,a4
 86a:	2705                	addiw	a4,a4,1
 86c:	02c5f7bb          	remuw	a5,a1,a2
 870:	1782                	slli	a5,a5,0x20
 872:	9381                	srli	a5,a5,0x20
 874:	97aa                	add	a5,a5,a0
 876:	0007c783          	lbu	a5,0(a5)
 87a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 87e:	0005879b          	sext.w	a5,a1
 882:	02c5d5bb          	divuw	a1,a1,a2
 886:	0685                	addi	a3,a3,1
 888:	fec7f0e3          	bgeu	a5,a2,868 <printint+0x2a>
  if(neg)
 88c:	00088c63          	beqz	a7,8a4 <printint+0x66>
    buf[i++] = '-';
 890:	fd070793          	addi	a5,a4,-48
 894:	00878733          	add	a4,a5,s0
 898:	02d00793          	li	a5,45
 89c:	fef70823          	sb	a5,-16(a4)
 8a0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 8a4:	02e05863          	blez	a4,8d4 <printint+0x96>
 8a8:	fc040793          	addi	a5,s0,-64
 8ac:	00e78933          	add	s2,a5,a4
 8b0:	fff78993          	addi	s3,a5,-1
 8b4:	99ba                	add	s3,s3,a4
 8b6:	377d                	addiw	a4,a4,-1
 8b8:	1702                	slli	a4,a4,0x20
 8ba:	9301                	srli	a4,a4,0x20
 8bc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8c0:	fff94583          	lbu	a1,-1(s2)
 8c4:	8526                	mv	a0,s1
 8c6:	00000097          	auipc	ra,0x0
 8ca:	f56080e7          	jalr	-170(ra) # 81c <putc>
  while(--i >= 0)
 8ce:	197d                	addi	s2,s2,-1
 8d0:	ff3918e3          	bne	s2,s3,8c0 <printint+0x82>
}
 8d4:	70e2                	ld	ra,56(sp)
 8d6:	7442                	ld	s0,48(sp)
 8d8:	74a2                	ld	s1,40(sp)
 8da:	7902                	ld	s2,32(sp)
 8dc:	69e2                	ld	s3,24(sp)
 8de:	6121                	addi	sp,sp,64
 8e0:	8082                	ret
    x = -xx;
 8e2:	40b005bb          	negw	a1,a1
    neg = 1;
 8e6:	4885                	li	a7,1
    x = -xx;
 8e8:	bf85                	j	858 <printint+0x1a>

00000000000008ea <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8ea:	715d                	addi	sp,sp,-80
 8ec:	e486                	sd	ra,72(sp)
 8ee:	e0a2                	sd	s0,64(sp)
 8f0:	fc26                	sd	s1,56(sp)
 8f2:	f84a                	sd	s2,48(sp)
 8f4:	f44e                	sd	s3,40(sp)
 8f6:	f052                	sd	s4,32(sp)
 8f8:	ec56                	sd	s5,24(sp)
 8fa:	e85a                	sd	s6,16(sp)
 8fc:	e45e                	sd	s7,8(sp)
 8fe:	e062                	sd	s8,0(sp)
 900:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 902:	0005c903          	lbu	s2,0(a1)
 906:	18090c63          	beqz	s2,a9e <vprintf+0x1b4>
 90a:	8aaa                	mv	s5,a0
 90c:	8bb2                	mv	s7,a2
 90e:	00158493          	addi	s1,a1,1
  state = 0;
 912:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 914:	02500a13          	li	s4,37
 918:	4b55                	li	s6,21
 91a:	a839                	j	938 <vprintf+0x4e>
        putc(fd, c);
 91c:	85ca                	mv	a1,s2
 91e:	8556                	mv	a0,s5
 920:	00000097          	auipc	ra,0x0
 924:	efc080e7          	jalr	-260(ra) # 81c <putc>
 928:	a019                	j	92e <vprintf+0x44>
    } else if(state == '%'){
 92a:	01498d63          	beq	s3,s4,944 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 92e:	0485                	addi	s1,s1,1
 930:	fff4c903          	lbu	s2,-1(s1)
 934:	16090563          	beqz	s2,a9e <vprintf+0x1b4>
    if(state == 0){
 938:	fe0999e3          	bnez	s3,92a <vprintf+0x40>
      if(c == '%'){
 93c:	ff4910e3          	bne	s2,s4,91c <vprintf+0x32>
        state = '%';
 940:	89d2                	mv	s3,s4
 942:	b7f5                	j	92e <vprintf+0x44>
      if(c == 'd'){
 944:	13490263          	beq	s2,s4,a68 <vprintf+0x17e>
 948:	f9d9079b          	addiw	a5,s2,-99
 94c:	0ff7f793          	zext.b	a5,a5
 950:	12fb6563          	bltu	s6,a5,a7a <vprintf+0x190>
 954:	f9d9079b          	addiw	a5,s2,-99
 958:	0ff7f713          	zext.b	a4,a5
 95c:	10eb6f63          	bltu	s6,a4,a7a <vprintf+0x190>
 960:	00271793          	slli	a5,a4,0x2
 964:	00000717          	auipc	a4,0x0
 968:	3bc70713          	addi	a4,a4,956 # d20 <malloc+0x184>
 96c:	97ba                	add	a5,a5,a4
 96e:	439c                	lw	a5,0(a5)
 970:	97ba                	add	a5,a5,a4
 972:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 974:	008b8913          	addi	s2,s7,8
 978:	4685                	li	a3,1
 97a:	4629                	li	a2,10
 97c:	000ba583          	lw	a1,0(s7)
 980:	8556                	mv	a0,s5
 982:	00000097          	auipc	ra,0x0
 986:	ebc080e7          	jalr	-324(ra) # 83e <printint>
 98a:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 98c:	4981                	li	s3,0
 98e:	b745                	j	92e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 990:	008b8913          	addi	s2,s7,8
 994:	4681                	li	a3,0
 996:	4629                	li	a2,10
 998:	000ba583          	lw	a1,0(s7)
 99c:	8556                	mv	a0,s5
 99e:	00000097          	auipc	ra,0x0
 9a2:	ea0080e7          	jalr	-352(ra) # 83e <printint>
 9a6:	8bca                	mv	s7,s2
      state = 0;
 9a8:	4981                	li	s3,0
 9aa:	b751                	j	92e <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 9ac:	008b8913          	addi	s2,s7,8
 9b0:	4681                	li	a3,0
 9b2:	4641                	li	a2,16
 9b4:	000ba583          	lw	a1,0(s7)
 9b8:	8556                	mv	a0,s5
 9ba:	00000097          	auipc	ra,0x0
 9be:	e84080e7          	jalr	-380(ra) # 83e <printint>
 9c2:	8bca                	mv	s7,s2
      state = 0;
 9c4:	4981                	li	s3,0
 9c6:	b7a5                	j	92e <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 9c8:	008b8c13          	addi	s8,s7,8
 9cc:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9d0:	03000593          	li	a1,48
 9d4:	8556                	mv	a0,s5
 9d6:	00000097          	auipc	ra,0x0
 9da:	e46080e7          	jalr	-442(ra) # 81c <putc>
  putc(fd, 'x');
 9de:	07800593          	li	a1,120
 9e2:	8556                	mv	a0,s5
 9e4:	00000097          	auipc	ra,0x0
 9e8:	e38080e7          	jalr	-456(ra) # 81c <putc>
 9ec:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9ee:	00000b97          	auipc	s7,0x0
 9f2:	38ab8b93          	addi	s7,s7,906 # d78 <digits>
 9f6:	03c9d793          	srli	a5,s3,0x3c
 9fa:	97de                	add	a5,a5,s7
 9fc:	0007c583          	lbu	a1,0(a5)
 a00:	8556                	mv	a0,s5
 a02:	00000097          	auipc	ra,0x0
 a06:	e1a080e7          	jalr	-486(ra) # 81c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a0a:	0992                	slli	s3,s3,0x4
 a0c:	397d                	addiw	s2,s2,-1
 a0e:	fe0914e3          	bnez	s2,9f6 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 a12:	8be2                	mv	s7,s8
      state = 0;
 a14:	4981                	li	s3,0
 a16:	bf21                	j	92e <vprintf+0x44>
        s = va_arg(ap, char*);
 a18:	008b8993          	addi	s3,s7,8
 a1c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a20:	02090163          	beqz	s2,a42 <vprintf+0x158>
        while(*s != 0){
 a24:	00094583          	lbu	a1,0(s2)
 a28:	c9a5                	beqz	a1,a98 <vprintf+0x1ae>
          putc(fd, *s);
 a2a:	8556                	mv	a0,s5
 a2c:	00000097          	auipc	ra,0x0
 a30:	df0080e7          	jalr	-528(ra) # 81c <putc>
          s++;
 a34:	0905                	addi	s2,s2,1
        while(*s != 0){
 a36:	00094583          	lbu	a1,0(s2)
 a3a:	f9e5                	bnez	a1,a2a <vprintf+0x140>
        s = va_arg(ap, char*);
 a3c:	8bce                	mv	s7,s3
      state = 0;
 a3e:	4981                	li	s3,0
 a40:	b5fd                	j	92e <vprintf+0x44>
          s = "(null)";
 a42:	00000917          	auipc	s2,0x0
 a46:	2d690913          	addi	s2,s2,726 # d18 <malloc+0x17c>
        while(*s != 0){
 a4a:	02800593          	li	a1,40
 a4e:	bff1                	j	a2a <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a50:	008b8913          	addi	s2,s7,8
 a54:	000bc583          	lbu	a1,0(s7)
 a58:	8556                	mv	a0,s5
 a5a:	00000097          	auipc	ra,0x0
 a5e:	dc2080e7          	jalr	-574(ra) # 81c <putc>
 a62:	8bca                	mv	s7,s2
      state = 0;
 a64:	4981                	li	s3,0
 a66:	b5e1                	j	92e <vprintf+0x44>
        putc(fd, c);
 a68:	02500593          	li	a1,37
 a6c:	8556                	mv	a0,s5
 a6e:	00000097          	auipc	ra,0x0
 a72:	dae080e7          	jalr	-594(ra) # 81c <putc>
      state = 0;
 a76:	4981                	li	s3,0
 a78:	bd5d                	j	92e <vprintf+0x44>
        putc(fd, '%');
 a7a:	02500593          	li	a1,37
 a7e:	8556                	mv	a0,s5
 a80:	00000097          	auipc	ra,0x0
 a84:	d9c080e7          	jalr	-612(ra) # 81c <putc>
        putc(fd, c);
 a88:	85ca                	mv	a1,s2
 a8a:	8556                	mv	a0,s5
 a8c:	00000097          	auipc	ra,0x0
 a90:	d90080e7          	jalr	-624(ra) # 81c <putc>
      state = 0;
 a94:	4981                	li	s3,0
 a96:	bd61                	j	92e <vprintf+0x44>
        s = va_arg(ap, char*);
 a98:	8bce                	mv	s7,s3
      state = 0;
 a9a:	4981                	li	s3,0
 a9c:	bd49                	j	92e <vprintf+0x44>
    }
  }
}
 a9e:	60a6                	ld	ra,72(sp)
 aa0:	6406                	ld	s0,64(sp)
 aa2:	74e2                	ld	s1,56(sp)
 aa4:	7942                	ld	s2,48(sp)
 aa6:	79a2                	ld	s3,40(sp)
 aa8:	7a02                	ld	s4,32(sp)
 aaa:	6ae2                	ld	s5,24(sp)
 aac:	6b42                	ld	s6,16(sp)
 aae:	6ba2                	ld	s7,8(sp)
 ab0:	6c02                	ld	s8,0(sp)
 ab2:	6161                	addi	sp,sp,80
 ab4:	8082                	ret

0000000000000ab6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ab6:	715d                	addi	sp,sp,-80
 ab8:	ec06                	sd	ra,24(sp)
 aba:	e822                	sd	s0,16(sp)
 abc:	1000                	addi	s0,sp,32
 abe:	e010                	sd	a2,0(s0)
 ac0:	e414                	sd	a3,8(s0)
 ac2:	e818                	sd	a4,16(s0)
 ac4:	ec1c                	sd	a5,24(s0)
 ac6:	03043023          	sd	a6,32(s0)
 aca:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 ace:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 ad2:	8622                	mv	a2,s0
 ad4:	00000097          	auipc	ra,0x0
 ad8:	e16080e7          	jalr	-490(ra) # 8ea <vprintf>
}
 adc:	60e2                	ld	ra,24(sp)
 ade:	6442                	ld	s0,16(sp)
 ae0:	6161                	addi	sp,sp,80
 ae2:	8082                	ret

0000000000000ae4 <printf>:

void
printf(const char *fmt, ...)
{
 ae4:	711d                	addi	sp,sp,-96
 ae6:	ec06                	sd	ra,24(sp)
 ae8:	e822                	sd	s0,16(sp)
 aea:	1000                	addi	s0,sp,32
 aec:	e40c                	sd	a1,8(s0)
 aee:	e810                	sd	a2,16(s0)
 af0:	ec14                	sd	a3,24(s0)
 af2:	f018                	sd	a4,32(s0)
 af4:	f41c                	sd	a5,40(s0)
 af6:	03043823          	sd	a6,48(s0)
 afa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 afe:	00840613          	addi	a2,s0,8
 b02:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b06:	85aa                	mv	a1,a0
 b08:	4505                	li	a0,1
 b0a:	00000097          	auipc	ra,0x0
 b0e:	de0080e7          	jalr	-544(ra) # 8ea <vprintf>
}
 b12:	60e2                	ld	ra,24(sp)
 b14:	6442                	ld	s0,16(sp)
 b16:	6125                	addi	sp,sp,96
 b18:	8082                	ret

0000000000000b1a <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 b1a:	1141                	addi	sp,sp,-16
 b1c:	e422                	sd	s0,8(sp)
 b1e:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 b20:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b24:	00000797          	auipc	a5,0x0
 b28:	4e47b783          	ld	a5,1252(a5) # 1008 <freep>
 b2c:	a02d                	j	b56 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 b2e:	4618                	lw	a4,8(a2)
 b30:	9f2d                	addw	a4,a4,a1
 b32:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 b36:	6398                	ld	a4,0(a5)
 b38:	6310                	ld	a2,0(a4)
 b3a:	a83d                	j	b78 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 b3c:	ff852703          	lw	a4,-8(a0)
 b40:	9f31                	addw	a4,a4,a2
 b42:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 b44:	ff053683          	ld	a3,-16(a0)
 b48:	a091                	j	b8c <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b4a:	6398                	ld	a4,0(a5)
 b4c:	00e7e463          	bltu	a5,a4,b54 <free+0x3a>
 b50:	00e6ea63          	bltu	a3,a4,b64 <free+0x4a>
{
 b54:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b56:	fed7fae3          	bgeu	a5,a3,b4a <free+0x30>
 b5a:	6398                	ld	a4,0(a5)
 b5c:	00e6e463          	bltu	a3,a4,b64 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b60:	fee7eae3          	bltu	a5,a4,b54 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b64:	ff852583          	lw	a1,-8(a0)
 b68:	6390                	ld	a2,0(a5)
 b6a:	02059813          	slli	a6,a1,0x20
 b6e:	01c85713          	srli	a4,a6,0x1c
 b72:	9736                	add	a4,a4,a3
 b74:	fae60de3          	beq	a2,a4,b2e <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b78:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b7c:	4790                	lw	a2,8(a5)
 b7e:	02061593          	slli	a1,a2,0x20
 b82:	01c5d713          	srli	a4,a1,0x1c
 b86:	973e                	add	a4,a4,a5
 b88:	fae68ae3          	beq	a3,a4,b3c <free+0x22>
        p->s.ptr = bp->s.ptr;
 b8c:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b8e:	00000717          	auipc	a4,0x0
 b92:	46f73d23          	sd	a5,1146(a4) # 1008 <freep>
}
 b96:	6422                	ld	s0,8(sp)
 b98:	0141                	addi	sp,sp,16
 b9a:	8082                	ret

0000000000000b9c <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b9c:	7139                	addi	sp,sp,-64
 b9e:	fc06                	sd	ra,56(sp)
 ba0:	f822                	sd	s0,48(sp)
 ba2:	f426                	sd	s1,40(sp)
 ba4:	f04a                	sd	s2,32(sp)
 ba6:	ec4e                	sd	s3,24(sp)
 ba8:	e852                	sd	s4,16(sp)
 baa:	e456                	sd	s5,8(sp)
 bac:	e05a                	sd	s6,0(sp)
 bae:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 bb0:	02051493          	slli	s1,a0,0x20
 bb4:	9081                	srli	s1,s1,0x20
 bb6:	04bd                	addi	s1,s1,15
 bb8:	8091                	srli	s1,s1,0x4
 bba:	0014899b          	addiw	s3,s1,1
 bbe:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 bc0:	00000517          	auipc	a0,0x0
 bc4:	44853503          	ld	a0,1096(a0) # 1008 <freep>
 bc8:	c515                	beqz	a0,bf4 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 bca:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 bcc:	4798                	lw	a4,8(a5)
 bce:	02977f63          	bgeu	a4,s1,c0c <malloc+0x70>
    if (nu < 4096)
 bd2:	8a4e                	mv	s4,s3
 bd4:	0009871b          	sext.w	a4,s3
 bd8:	6685                	lui	a3,0x1
 bda:	00d77363          	bgeu	a4,a3,be0 <malloc+0x44>
 bde:	6a05                	lui	s4,0x1
 be0:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 be4:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 be8:	00000917          	auipc	s2,0x0
 bec:	42090913          	addi	s2,s2,1056 # 1008 <freep>
    if (p == (char *)-1)
 bf0:	5afd                	li	s5,-1
 bf2:	a895                	j	c66 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 bf4:	00001797          	auipc	a5,0x1
 bf8:	81c78793          	addi	a5,a5,-2020 # 1410 <base>
 bfc:	00000717          	auipc	a4,0x0
 c00:	40f73623          	sd	a5,1036(a4) # 1008 <freep>
 c04:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 c06:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 c0a:	b7e1                	j	bd2 <malloc+0x36>
            if (p->s.size == nunits)
 c0c:	02e48c63          	beq	s1,a4,c44 <malloc+0xa8>
                p->s.size -= nunits;
 c10:	4137073b          	subw	a4,a4,s3
 c14:	c798                	sw	a4,8(a5)
                p += p->s.size;
 c16:	02071693          	slli	a3,a4,0x20
 c1a:	01c6d713          	srli	a4,a3,0x1c
 c1e:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 c20:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 c24:	00000717          	auipc	a4,0x0
 c28:	3ea73223          	sd	a0,996(a4) # 1008 <freep>
            return (void *)(p + 1);
 c2c:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 c30:	70e2                	ld	ra,56(sp)
 c32:	7442                	ld	s0,48(sp)
 c34:	74a2                	ld	s1,40(sp)
 c36:	7902                	ld	s2,32(sp)
 c38:	69e2                	ld	s3,24(sp)
 c3a:	6a42                	ld	s4,16(sp)
 c3c:	6aa2                	ld	s5,8(sp)
 c3e:	6b02                	ld	s6,0(sp)
 c40:	6121                	addi	sp,sp,64
 c42:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 c44:	6398                	ld	a4,0(a5)
 c46:	e118                	sd	a4,0(a0)
 c48:	bff1                	j	c24 <malloc+0x88>
    hp->s.size = nu;
 c4a:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c4e:	0541                	addi	a0,a0,16
 c50:	00000097          	auipc	ra,0x0
 c54:	eca080e7          	jalr	-310(ra) # b1a <free>
    return freep;
 c58:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c5c:	d971                	beqz	a0,c30 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c5e:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c60:	4798                	lw	a4,8(a5)
 c62:	fa9775e3          	bgeu	a4,s1,c0c <malloc+0x70>
        if (p == freep)
 c66:	00093703          	ld	a4,0(s2)
 c6a:	853e                	mv	a0,a5
 c6c:	fef719e3          	bne	a4,a5,c5e <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c70:	8552                	mv	a0,s4
 c72:	00000097          	auipc	ra,0x0
 c76:	b7a080e7          	jalr	-1158(ra) # 7ec <sbrk>
    if (p == (char *)-1)
 c7a:	fd5518e3          	bne	a0,s5,c4a <malloc+0xae>
                return 0;
 c7e:	4501                	li	a0,0
 c80:	bf45                	j	c30 <malloc+0x94>
