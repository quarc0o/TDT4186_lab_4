
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
 152:	5ca080e7          	jalr	1482(ra) # 718 <strchr>
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
 182:	792080e7          	jalr	1938(ra) # 910 <write>
 186:	b7c1                	j	146 <grep+0x2c>
    if(m > 0){
 188:	03404763          	bgtz	s4,1b6 <grep+0x9c>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 18c:	414b863b          	subw	a2,s7,s4
 190:	014a85b3          	add	a1,s5,s4
 194:	855a                	mv	a0,s6
 196:	00000097          	auipc	ra,0x0
 19a:	772080e7          	jalr	1906(ra) # 908 <read>
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
 1ce:	674080e7          	jalr	1652(ra) # 83e <memmove>
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
 22a:	70a080e7          	jalr	1802(ra) # 930 <open>
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
 246:	6d6080e7          	jalr	1750(ra) # 918 <close>
  for(i = 2; i < argc; i++){
 24a:	0921                	addi	s2,s2,8
 24c:	fd391ae3          	bne	s2,s3,220 <main+0x34>
  exit(0);
 250:	4501                	li	a0,0
 252:	00000097          	auipc	ra,0x0
 256:	69e080e7          	jalr	1694(ra) # 8f0 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 25a:	00001597          	auipc	a1,0x1
 25e:	bb658593          	addi	a1,a1,-1098 # e10 <malloc+0xe8>
 262:	4509                	li	a0,2
 264:	00001097          	auipc	ra,0x1
 268:	9de080e7          	jalr	-1570(ra) # c42 <fprintf>
    exit(1);
 26c:	4505                	li	a0,1
 26e:	00000097          	auipc	ra,0x0
 272:	682080e7          	jalr	1666(ra) # 8f0 <exit>
    grep(pattern, 0);
 276:	4581                	li	a1,0
 278:	8552                	mv	a0,s4
 27a:	00000097          	auipc	ra,0x0
 27e:	ea0080e7          	jalr	-352(ra) # 11a <grep>
    exit(0);
 282:	4501                	li	a0,0
 284:	00000097          	auipc	ra,0x0
 288:	66c080e7          	jalr	1644(ra) # 8f0 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 28c:	00093583          	ld	a1,0(s2)
 290:	00001517          	auipc	a0,0x1
 294:	ba050513          	addi	a0,a0,-1120 # e30 <malloc+0x108>
 298:	00001097          	auipc	ra,0x1
 29c:	9d8080e7          	jalr	-1576(ra) # c70 <printf>
      exit(1);
 2a0:	4505                	li	a0,1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	64e080e7          	jalr	1614(ra) # 8f0 <exit>

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
 2de:	2c4080e7          	jalr	708(ra) # 59e <twhoami>
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
 32a:	b2250513          	addi	a0,a0,-1246 # e48 <malloc+0x120>
 32e:	00001097          	auipc	ra,0x1
 332:	942080e7          	jalr	-1726(ra) # c70 <printf>
        exit(-1);
 336:	557d                	li	a0,-1
 338:	00000097          	auipc	ra,0x0
 33c:	5b8080e7          	jalr	1464(ra) # 8f0 <exit>
    {
        // give up the cpu for other threads
        tyield();
 340:	00000097          	auipc	ra,0x0
 344:	1dc080e7          	jalr	476(ra) # 51c <tyield>
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
 35e:	244080e7          	jalr	580(ra) # 59e <twhoami>
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
 3a2:	17e080e7          	jalr	382(ra) # 51c <tyield>
}
 3a6:	60e2                	ld	ra,24(sp)
 3a8:	6442                	ld	s0,16(sp)
 3aa:	64a2                	ld	s1,8(sp)
 3ac:	6105                	addi	sp,sp,32
 3ae:	8082                	ret
        printf("releasing lock we are not holding");
 3b0:	00001517          	auipc	a0,0x1
 3b4:	ac050513          	addi	a0,a0,-1344 # e70 <malloc+0x148>
 3b8:	00001097          	auipc	ra,0x1
 3bc:	8b8080e7          	jalr	-1864(ra) # c70 <printf>
        exit(-1);
 3c0:	557d                	li	a0,-1
 3c2:	00000097          	auipc	ra,0x0
 3c6:	52e080e7          	jalr	1326(ra) # 8f0 <exit>

00000000000003ca <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 3ca:	00001517          	auipc	a0,0x1
 3ce:	c4653503          	ld	a0,-954(a0) # 1010 <current_thread>
 3d2:	00001717          	auipc	a4,0x1
 3d6:	04e70713          	addi	a4,a4,78 # 1420 <threads>
    for (int i = 0; i < 16; i++) {
 3da:	4781                	li	a5,0
 3dc:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 3de:	6314                	ld	a3,0(a4)
 3e0:	00a68763          	beq	a3,a0,3ee <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 3e4:	2785                	addiw	a5,a5,1
 3e6:	0721                	addi	a4,a4,8
 3e8:	fec79be3          	bne	a5,a2,3de <tsched+0x14>
    int current_index = 0;
 3ec:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 3ee:	0017869b          	addiw	a3,a5,1
 3f2:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 3f6:	00001817          	auipc	a6,0x1
 3fa:	02a80813          	addi	a6,a6,42 # 1420 <threads>
 3fe:	488d                	li	a7,3
 400:	a021                	j	408 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 402:	2685                	addiw	a3,a3,1
 404:	04c68363          	beq	a3,a2,44a <tsched+0x80>
        int next_index = (current_index + i) % 16;
 408:	41f6d71b          	sraiw	a4,a3,0x1f
 40c:	01c7571b          	srliw	a4,a4,0x1c
 410:	00d707bb          	addw	a5,a4,a3
 414:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 416:	9f99                	subw	a5,a5,a4
 418:	078e                	slli	a5,a5,0x3
 41a:	97c2                	add	a5,a5,a6
 41c:	638c                	ld	a1,0(a5)
 41e:	d1f5                	beqz	a1,402 <tsched+0x38>
 420:	5dbc                	lw	a5,120(a1)
 422:	ff1790e3          	bne	a5,a7,402 <tsched+0x38>
{
 426:	1141                	addi	sp,sp,-16
 428:	e406                	sd	ra,8(sp)
 42a:	e022                	sd	s0,0(sp)
 42c:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 42e:	00001797          	auipc	a5,0x1
 432:	beb7b123          	sd	a1,-1054(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 436:	05a1                	addi	a1,a1,8
 438:	0521                	addi	a0,a0,8
 43a:	00000097          	auipc	ra,0x0
 43e:	17c080e7          	jalr	380(ra) # 5b6 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 442:	60a2                	ld	ra,8(sp)
 444:	6402                	ld	s0,0(sp)
 446:	0141                	addi	sp,sp,16
 448:	8082                	ret
 44a:	8082                	ret

000000000000044c <thread_wrapper>:
{
 44c:	1101                	addi	sp,sp,-32
 44e:	ec06                	sd	ra,24(sp)
 450:	e822                	sd	s0,16(sp)
 452:	e426                	sd	s1,8(sp)
 454:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
 456:	00001497          	auipc	s1,0x1
 45a:	bba48493          	addi	s1,s1,-1094 # 1010 <current_thread>
 45e:	609c                	ld	a5,0(s1)
 460:	67d8                	ld	a4,136(a5)
 462:	63c8                	ld	a0,128(a5)
 464:	9702                	jalr	a4
    current_thread->state = EXITED;
 466:	609c                	ld	a5,0(s1)
 468:	4719                	li	a4,6
 46a:	dfb8                	sw	a4,120(a5)
    tsched();
 46c:	00000097          	auipc	ra,0x0
 470:	f5e080e7          	jalr	-162(ra) # 3ca <tsched>
}
 474:	60e2                	ld	ra,24(sp)
 476:	6442                	ld	s0,16(sp)
 478:	64a2                	ld	s1,8(sp)
 47a:	6105                	addi	sp,sp,32
 47c:	8082                	ret

000000000000047e <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 47e:	7179                	addi	sp,sp,-48
 480:	f406                	sd	ra,40(sp)
 482:	f022                	sd	s0,32(sp)
 484:	ec26                	sd	s1,24(sp)
 486:	e84a                	sd	s2,16(sp)
 488:	e44e                	sd	s3,8(sp)
 48a:	1800                	addi	s0,sp,48
 48c:	84aa                	mv	s1,a0
 48e:	89b2                	mv	s3,a2
 490:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 492:	09800513          	li	a0,152
 496:	00001097          	auipc	ra,0x1
 49a:	892080e7          	jalr	-1902(ra) # d28 <malloc>
 49e:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 4a0:	478d                	li	a5,3
 4a2:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 4a4:	609c                	ld	a5,0(s1)
 4a6:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 4aa:	609c                	ld	a5,0(s1)
 4ac:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
 4b0:	6098                	ld	a4,0(s1)
 4b2:	00001797          	auipc	a5,0x1
 4b6:	b4e78793          	addi	a5,a5,-1202 # 1000 <next_tid>
 4ba:	4394                	lw	a3,0(a5)
 4bc:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 4c0:	4398                	lw	a4,0(a5)
 4c2:	2705                	addiw	a4,a4,1
 4c4:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
 4c6:	6505                	lui	a0,0x1
 4c8:	00001097          	auipc	ra,0x1
 4cc:	860080e7          	jalr	-1952(ra) # d28 <malloc>
 4d0:	609c                	ld	a5,0(s1)
 4d2:	6705                	lui	a4,0x1
 4d4:	953a                	add	a0,a0,a4
 4d6:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 4d8:	609c                	ld	a5,0(s1)
 4da:	00000717          	auipc	a4,0x0
 4de:	f7270713          	addi	a4,a4,-142 # 44c <thread_wrapper>
 4e2:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 4e4:	00001717          	auipc	a4,0x1
 4e8:	f3c70713          	addi	a4,a4,-196 # 1420 <threads>
 4ec:	4781                	li	a5,0
 4ee:	4641                	li	a2,16
        if (threads[i] == NULL) {
 4f0:	6314                	ld	a3,0(a4)
 4f2:	ce81                	beqz	a3,50a <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
 4f4:	2785                	addiw	a5,a5,1
 4f6:	0721                	addi	a4,a4,8
 4f8:	fec79ce3          	bne	a5,a2,4f0 <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
 4fc:	70a2                	ld	ra,40(sp)
 4fe:	7402                	ld	s0,32(sp)
 500:	64e2                	ld	s1,24(sp)
 502:	6942                	ld	s2,16(sp)
 504:	69a2                	ld	s3,8(sp)
 506:	6145                	addi	sp,sp,48
 508:	8082                	ret
            threads[i] = *thread;
 50a:	6094                	ld	a3,0(s1)
 50c:	078e                	slli	a5,a5,0x3
 50e:	00001717          	auipc	a4,0x1
 512:	f1270713          	addi	a4,a4,-238 # 1420 <threads>
 516:	97ba                	add	a5,a5,a4
 518:	e394                	sd	a3,0(a5)
            break;
 51a:	b7cd                	j	4fc <tcreate+0x7e>

000000000000051c <tyield>:
    return 0;
}


void tyield()
{
 51c:	1141                	addi	sp,sp,-16
 51e:	e406                	sd	ra,8(sp)
 520:	e022                	sd	s0,0(sp)
 522:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 524:	00001797          	auipc	a5,0x1
 528:	aec7b783          	ld	a5,-1300(a5) # 1010 <current_thread>
 52c:	470d                	li	a4,3
 52e:	dfb8                	sw	a4,120(a5)
    tsched();
 530:	00000097          	auipc	ra,0x0
 534:	e9a080e7          	jalr	-358(ra) # 3ca <tsched>
}
 538:	60a2                	ld	ra,8(sp)
 53a:	6402                	ld	s0,0(sp)
 53c:	0141                	addi	sp,sp,16
 53e:	8082                	ret

0000000000000540 <tjoin>:
{
 540:	1101                	addi	sp,sp,-32
 542:	ec06                	sd	ra,24(sp)
 544:	e822                	sd	s0,16(sp)
 546:	e426                	sd	s1,8(sp)
 548:	e04a                	sd	s2,0(sp)
 54a:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 54c:	00001797          	auipc	a5,0x1
 550:	ed478793          	addi	a5,a5,-300 # 1420 <threads>
 554:	00001697          	auipc	a3,0x1
 558:	f4c68693          	addi	a3,a3,-180 # 14a0 <base>
 55c:	a021                	j	564 <tjoin+0x24>
 55e:	07a1                	addi	a5,a5,8
 560:	02d78b63          	beq	a5,a3,596 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 564:	6384                	ld	s1,0(a5)
 566:	dce5                	beqz	s1,55e <tjoin+0x1e>
 568:	0004c703          	lbu	a4,0(s1)
 56c:	fea719e3          	bne	a4,a0,55e <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 570:	5cb8                	lw	a4,120(s1)
 572:	4799                	li	a5,6
 574:	4919                	li	s2,6
 576:	02f70263          	beq	a4,a5,59a <tjoin+0x5a>
        tyield();
 57a:	00000097          	auipc	ra,0x0
 57e:	fa2080e7          	jalr	-94(ra) # 51c <tyield>
    while (target_thread->state != EXITED) {
 582:	5cbc                	lw	a5,120(s1)
 584:	ff279be3          	bne	a5,s2,57a <tjoin+0x3a>
    return 0;
 588:	4501                	li	a0,0
}
 58a:	60e2                	ld	ra,24(sp)
 58c:	6442                	ld	s0,16(sp)
 58e:	64a2                	ld	s1,8(sp)
 590:	6902                	ld	s2,0(sp)
 592:	6105                	addi	sp,sp,32
 594:	8082                	ret
        return -1;
 596:	557d                	li	a0,-1
 598:	bfcd                	j	58a <tjoin+0x4a>
    return 0;
 59a:	4501                	li	a0,0
 59c:	b7fd                	j	58a <tjoin+0x4a>

000000000000059e <twhoami>:

uint8 twhoami()
{
 59e:	1141                	addi	sp,sp,-16
 5a0:	e422                	sd	s0,8(sp)
 5a2:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 5a4:	00001797          	auipc	a5,0x1
 5a8:	a6c7b783          	ld	a5,-1428(a5) # 1010 <current_thread>
 5ac:	0007c503          	lbu	a0,0(a5)
 5b0:	6422                	ld	s0,8(sp)
 5b2:	0141                	addi	sp,sp,16
 5b4:	8082                	ret

00000000000005b6 <tswtch>:
 5b6:	00153023          	sd	ra,0(a0) # 1000 <next_tid>
 5ba:	00253423          	sd	sp,8(a0)
 5be:	e900                	sd	s0,16(a0)
 5c0:	ed04                	sd	s1,24(a0)
 5c2:	03253023          	sd	s2,32(a0)
 5c6:	03353423          	sd	s3,40(a0)
 5ca:	03453823          	sd	s4,48(a0)
 5ce:	03553c23          	sd	s5,56(a0)
 5d2:	05653023          	sd	s6,64(a0)
 5d6:	05753423          	sd	s7,72(a0)
 5da:	05853823          	sd	s8,80(a0)
 5de:	05953c23          	sd	s9,88(a0)
 5e2:	07a53023          	sd	s10,96(a0)
 5e6:	07b53423          	sd	s11,104(a0)
 5ea:	0005b083          	ld	ra,0(a1)
 5ee:	0085b103          	ld	sp,8(a1)
 5f2:	6980                	ld	s0,16(a1)
 5f4:	6d84                	ld	s1,24(a1)
 5f6:	0205b903          	ld	s2,32(a1)
 5fa:	0285b983          	ld	s3,40(a1)
 5fe:	0305ba03          	ld	s4,48(a1)
 602:	0385ba83          	ld	s5,56(a1)
 606:	0405bb03          	ld	s6,64(a1)
 60a:	0485bb83          	ld	s7,72(a1)
 60e:	0505bc03          	ld	s8,80(a1)
 612:	0585bc83          	ld	s9,88(a1)
 616:	0605bd03          	ld	s10,96(a1)
 61a:	0685bd83          	ld	s11,104(a1)
 61e:	8082                	ret

0000000000000620 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 620:	1101                	addi	sp,sp,-32
 622:	ec06                	sd	ra,24(sp)
 624:	e822                	sd	s0,16(sp)
 626:	e426                	sd	s1,8(sp)
 628:	e04a                	sd	s2,0(sp)
 62a:	1000                	addi	s0,sp,32
 62c:	84aa                	mv	s1,a0
 62e:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 630:	09800513          	li	a0,152
 634:	00000097          	auipc	ra,0x0
 638:	6f4080e7          	jalr	1780(ra) # d28 <malloc>

    main_thread->tid = 1;
 63c:	4785                	li	a5,1
 63e:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
 642:	4791                	li	a5,4
 644:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 646:	00001797          	auipc	a5,0x1
 64a:	9ca7b523          	sd	a0,-1590(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 64e:	00001797          	auipc	a5,0x1
 652:	dd278793          	addi	a5,a5,-558 # 1420 <threads>
 656:	00001717          	auipc	a4,0x1
 65a:	e4a70713          	addi	a4,a4,-438 # 14a0 <base>
        threads[i] = NULL;
 65e:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 662:	07a1                	addi	a5,a5,8
 664:	fee79de3          	bne	a5,a4,65e <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 668:	00001797          	auipc	a5,0x1
 66c:	daa7bc23          	sd	a0,-584(a5) # 1420 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 670:	85ca                	mv	a1,s2
 672:	8526                	mv	a0,s1
 674:	00000097          	auipc	ra,0x0
 678:	b78080e7          	jalr	-1160(ra) # 1ec <main>
    //tsched();

    exit(res);
 67c:	00000097          	auipc	ra,0x0
 680:	274080e7          	jalr	628(ra) # 8f0 <exit>

0000000000000684 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 684:	1141                	addi	sp,sp,-16
 686:	e422                	sd	s0,8(sp)
 688:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 68a:	87aa                	mv	a5,a0
 68c:	0585                	addi	a1,a1,1
 68e:	0785                	addi	a5,a5,1
 690:	fff5c703          	lbu	a4,-1(a1)
 694:	fee78fa3          	sb	a4,-1(a5)
 698:	fb75                	bnez	a4,68c <strcpy+0x8>
        ;
    return os;
}
 69a:	6422                	ld	s0,8(sp)
 69c:	0141                	addi	sp,sp,16
 69e:	8082                	ret

00000000000006a0 <strcmp>:

int strcmp(const char *p, const char *q)
{
 6a0:	1141                	addi	sp,sp,-16
 6a2:	e422                	sd	s0,8(sp)
 6a4:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 6a6:	00054783          	lbu	a5,0(a0)
 6aa:	cb91                	beqz	a5,6be <strcmp+0x1e>
 6ac:	0005c703          	lbu	a4,0(a1)
 6b0:	00f71763          	bne	a4,a5,6be <strcmp+0x1e>
        p++, q++;
 6b4:	0505                	addi	a0,a0,1
 6b6:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 6b8:	00054783          	lbu	a5,0(a0)
 6bc:	fbe5                	bnez	a5,6ac <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 6be:	0005c503          	lbu	a0,0(a1)
}
 6c2:	40a7853b          	subw	a0,a5,a0
 6c6:	6422                	ld	s0,8(sp)
 6c8:	0141                	addi	sp,sp,16
 6ca:	8082                	ret

00000000000006cc <strlen>:

uint strlen(const char *s)
{
 6cc:	1141                	addi	sp,sp,-16
 6ce:	e422                	sd	s0,8(sp)
 6d0:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 6d2:	00054783          	lbu	a5,0(a0)
 6d6:	cf91                	beqz	a5,6f2 <strlen+0x26>
 6d8:	0505                	addi	a0,a0,1
 6da:	87aa                	mv	a5,a0
 6dc:	86be                	mv	a3,a5
 6de:	0785                	addi	a5,a5,1
 6e0:	fff7c703          	lbu	a4,-1(a5)
 6e4:	ff65                	bnez	a4,6dc <strlen+0x10>
 6e6:	40a6853b          	subw	a0,a3,a0
 6ea:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 6ec:	6422                	ld	s0,8(sp)
 6ee:	0141                	addi	sp,sp,16
 6f0:	8082                	ret
    for (n = 0; s[n]; n++)
 6f2:	4501                	li	a0,0
 6f4:	bfe5                	j	6ec <strlen+0x20>

00000000000006f6 <memset>:

void *
memset(void *dst, int c, uint n)
{
 6f6:	1141                	addi	sp,sp,-16
 6f8:	e422                	sd	s0,8(sp)
 6fa:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 6fc:	ca19                	beqz	a2,712 <memset+0x1c>
 6fe:	87aa                	mv	a5,a0
 700:	1602                	slli	a2,a2,0x20
 702:	9201                	srli	a2,a2,0x20
 704:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 708:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 70c:	0785                	addi	a5,a5,1
 70e:	fee79de3          	bne	a5,a4,708 <memset+0x12>
    }
    return dst;
}
 712:	6422                	ld	s0,8(sp)
 714:	0141                	addi	sp,sp,16
 716:	8082                	ret

0000000000000718 <strchr>:

char *
strchr(const char *s, char c)
{
 718:	1141                	addi	sp,sp,-16
 71a:	e422                	sd	s0,8(sp)
 71c:	0800                	addi	s0,sp,16
    for (; *s; s++)
 71e:	00054783          	lbu	a5,0(a0)
 722:	cb99                	beqz	a5,738 <strchr+0x20>
        if (*s == c)
 724:	00f58763          	beq	a1,a5,732 <strchr+0x1a>
    for (; *s; s++)
 728:	0505                	addi	a0,a0,1
 72a:	00054783          	lbu	a5,0(a0)
 72e:	fbfd                	bnez	a5,724 <strchr+0xc>
            return (char *)s;
    return 0;
 730:	4501                	li	a0,0
}
 732:	6422                	ld	s0,8(sp)
 734:	0141                	addi	sp,sp,16
 736:	8082                	ret
    return 0;
 738:	4501                	li	a0,0
 73a:	bfe5                	j	732 <strchr+0x1a>

000000000000073c <gets>:

char *
gets(char *buf, int max)
{
 73c:	711d                	addi	sp,sp,-96
 73e:	ec86                	sd	ra,88(sp)
 740:	e8a2                	sd	s0,80(sp)
 742:	e4a6                	sd	s1,72(sp)
 744:	e0ca                	sd	s2,64(sp)
 746:	fc4e                	sd	s3,56(sp)
 748:	f852                	sd	s4,48(sp)
 74a:	f456                	sd	s5,40(sp)
 74c:	f05a                	sd	s6,32(sp)
 74e:	ec5e                	sd	s7,24(sp)
 750:	1080                	addi	s0,sp,96
 752:	8baa                	mv	s7,a0
 754:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 756:	892a                	mv	s2,a0
 758:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 75a:	4aa9                	li	s5,10
 75c:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 75e:	89a6                	mv	s3,s1
 760:	2485                	addiw	s1,s1,1
 762:	0344d863          	bge	s1,s4,792 <gets+0x56>
        cc = read(0, &c, 1);
 766:	4605                	li	a2,1
 768:	faf40593          	addi	a1,s0,-81
 76c:	4501                	li	a0,0
 76e:	00000097          	auipc	ra,0x0
 772:	19a080e7          	jalr	410(ra) # 908 <read>
        if (cc < 1)
 776:	00a05e63          	blez	a0,792 <gets+0x56>
        buf[i++] = c;
 77a:	faf44783          	lbu	a5,-81(s0)
 77e:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 782:	01578763          	beq	a5,s5,790 <gets+0x54>
 786:	0905                	addi	s2,s2,1
 788:	fd679be3          	bne	a5,s6,75e <gets+0x22>
    for (i = 0; i + 1 < max;)
 78c:	89a6                	mv	s3,s1
 78e:	a011                	j	792 <gets+0x56>
 790:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 792:	99de                	add	s3,s3,s7
 794:	00098023          	sb	zero,0(s3)
    return buf;
}
 798:	855e                	mv	a0,s7
 79a:	60e6                	ld	ra,88(sp)
 79c:	6446                	ld	s0,80(sp)
 79e:	64a6                	ld	s1,72(sp)
 7a0:	6906                	ld	s2,64(sp)
 7a2:	79e2                	ld	s3,56(sp)
 7a4:	7a42                	ld	s4,48(sp)
 7a6:	7aa2                	ld	s5,40(sp)
 7a8:	7b02                	ld	s6,32(sp)
 7aa:	6be2                	ld	s7,24(sp)
 7ac:	6125                	addi	sp,sp,96
 7ae:	8082                	ret

00000000000007b0 <stat>:

int stat(const char *n, struct stat *st)
{
 7b0:	1101                	addi	sp,sp,-32
 7b2:	ec06                	sd	ra,24(sp)
 7b4:	e822                	sd	s0,16(sp)
 7b6:	e426                	sd	s1,8(sp)
 7b8:	e04a                	sd	s2,0(sp)
 7ba:	1000                	addi	s0,sp,32
 7bc:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 7be:	4581                	li	a1,0
 7c0:	00000097          	auipc	ra,0x0
 7c4:	170080e7          	jalr	368(ra) # 930 <open>
    if (fd < 0)
 7c8:	02054563          	bltz	a0,7f2 <stat+0x42>
 7cc:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 7ce:	85ca                	mv	a1,s2
 7d0:	00000097          	auipc	ra,0x0
 7d4:	178080e7          	jalr	376(ra) # 948 <fstat>
 7d8:	892a                	mv	s2,a0
    close(fd);
 7da:	8526                	mv	a0,s1
 7dc:	00000097          	auipc	ra,0x0
 7e0:	13c080e7          	jalr	316(ra) # 918 <close>
    return r;
}
 7e4:	854a                	mv	a0,s2
 7e6:	60e2                	ld	ra,24(sp)
 7e8:	6442                	ld	s0,16(sp)
 7ea:	64a2                	ld	s1,8(sp)
 7ec:	6902                	ld	s2,0(sp)
 7ee:	6105                	addi	sp,sp,32
 7f0:	8082                	ret
        return -1;
 7f2:	597d                	li	s2,-1
 7f4:	bfc5                	j	7e4 <stat+0x34>

00000000000007f6 <atoi>:

int atoi(const char *s)
{
 7f6:	1141                	addi	sp,sp,-16
 7f8:	e422                	sd	s0,8(sp)
 7fa:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 7fc:	00054683          	lbu	a3,0(a0)
 800:	fd06879b          	addiw	a5,a3,-48
 804:	0ff7f793          	zext.b	a5,a5
 808:	4625                	li	a2,9
 80a:	02f66863          	bltu	a2,a5,83a <atoi+0x44>
 80e:	872a                	mv	a4,a0
    n = 0;
 810:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 812:	0705                	addi	a4,a4,1
 814:	0025179b          	slliw	a5,a0,0x2
 818:	9fa9                	addw	a5,a5,a0
 81a:	0017979b          	slliw	a5,a5,0x1
 81e:	9fb5                	addw	a5,a5,a3
 820:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 824:	00074683          	lbu	a3,0(a4)
 828:	fd06879b          	addiw	a5,a3,-48
 82c:	0ff7f793          	zext.b	a5,a5
 830:	fef671e3          	bgeu	a2,a5,812 <atoi+0x1c>
    return n;
}
 834:	6422                	ld	s0,8(sp)
 836:	0141                	addi	sp,sp,16
 838:	8082                	ret
    n = 0;
 83a:	4501                	li	a0,0
 83c:	bfe5                	j	834 <atoi+0x3e>

000000000000083e <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 83e:	1141                	addi	sp,sp,-16
 840:	e422                	sd	s0,8(sp)
 842:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 844:	02b57463          	bgeu	a0,a1,86c <memmove+0x2e>
    {
        while (n-- > 0)
 848:	00c05f63          	blez	a2,866 <memmove+0x28>
 84c:	1602                	slli	a2,a2,0x20
 84e:	9201                	srli	a2,a2,0x20
 850:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 854:	872a                	mv	a4,a0
            *dst++ = *src++;
 856:	0585                	addi	a1,a1,1
 858:	0705                	addi	a4,a4,1
 85a:	fff5c683          	lbu	a3,-1(a1)
 85e:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 862:	fee79ae3          	bne	a5,a4,856 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 866:	6422                	ld	s0,8(sp)
 868:	0141                	addi	sp,sp,16
 86a:	8082                	ret
        dst += n;
 86c:	00c50733          	add	a4,a0,a2
        src += n;
 870:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 872:	fec05ae3          	blez	a2,866 <memmove+0x28>
 876:	fff6079b          	addiw	a5,a2,-1
 87a:	1782                	slli	a5,a5,0x20
 87c:	9381                	srli	a5,a5,0x20
 87e:	fff7c793          	not	a5,a5
 882:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 884:	15fd                	addi	a1,a1,-1
 886:	177d                	addi	a4,a4,-1
 888:	0005c683          	lbu	a3,0(a1)
 88c:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 890:	fee79ae3          	bne	a5,a4,884 <memmove+0x46>
 894:	bfc9                	j	866 <memmove+0x28>

0000000000000896 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 896:	1141                	addi	sp,sp,-16
 898:	e422                	sd	s0,8(sp)
 89a:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 89c:	ca05                	beqz	a2,8cc <memcmp+0x36>
 89e:	fff6069b          	addiw	a3,a2,-1
 8a2:	1682                	slli	a3,a3,0x20
 8a4:	9281                	srli	a3,a3,0x20
 8a6:	0685                	addi	a3,a3,1
 8a8:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 8aa:	00054783          	lbu	a5,0(a0)
 8ae:	0005c703          	lbu	a4,0(a1)
 8b2:	00e79863          	bne	a5,a4,8c2 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 8b6:	0505                	addi	a0,a0,1
        p2++;
 8b8:	0585                	addi	a1,a1,1
    while (n-- > 0)
 8ba:	fed518e3          	bne	a0,a3,8aa <memcmp+0x14>
    }
    return 0;
 8be:	4501                	li	a0,0
 8c0:	a019                	j	8c6 <memcmp+0x30>
            return *p1 - *p2;
 8c2:	40e7853b          	subw	a0,a5,a4
}
 8c6:	6422                	ld	s0,8(sp)
 8c8:	0141                	addi	sp,sp,16
 8ca:	8082                	ret
    return 0;
 8cc:	4501                	li	a0,0
 8ce:	bfe5                	j	8c6 <memcmp+0x30>

00000000000008d0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 8d0:	1141                	addi	sp,sp,-16
 8d2:	e406                	sd	ra,8(sp)
 8d4:	e022                	sd	s0,0(sp)
 8d6:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 8d8:	00000097          	auipc	ra,0x0
 8dc:	f66080e7          	jalr	-154(ra) # 83e <memmove>
}
 8e0:	60a2                	ld	ra,8(sp)
 8e2:	6402                	ld	s0,0(sp)
 8e4:	0141                	addi	sp,sp,16
 8e6:	8082                	ret

00000000000008e8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 8e8:	4885                	li	a7,1
 ecall
 8ea:	00000073          	ecall
 ret
 8ee:	8082                	ret

00000000000008f0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 8f0:	4889                	li	a7,2
 ecall
 8f2:	00000073          	ecall
 ret
 8f6:	8082                	ret

00000000000008f8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 8f8:	488d                	li	a7,3
 ecall
 8fa:	00000073          	ecall
 ret
 8fe:	8082                	ret

0000000000000900 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 900:	4891                	li	a7,4
 ecall
 902:	00000073          	ecall
 ret
 906:	8082                	ret

0000000000000908 <read>:
.global read
read:
 li a7, SYS_read
 908:	4895                	li	a7,5
 ecall
 90a:	00000073          	ecall
 ret
 90e:	8082                	ret

0000000000000910 <write>:
.global write
write:
 li a7, SYS_write
 910:	48c1                	li	a7,16
 ecall
 912:	00000073          	ecall
 ret
 916:	8082                	ret

0000000000000918 <close>:
.global close
close:
 li a7, SYS_close
 918:	48d5                	li	a7,21
 ecall
 91a:	00000073          	ecall
 ret
 91e:	8082                	ret

0000000000000920 <kill>:
.global kill
kill:
 li a7, SYS_kill
 920:	4899                	li	a7,6
 ecall
 922:	00000073          	ecall
 ret
 926:	8082                	ret

0000000000000928 <exec>:
.global exec
exec:
 li a7, SYS_exec
 928:	489d                	li	a7,7
 ecall
 92a:	00000073          	ecall
 ret
 92e:	8082                	ret

0000000000000930 <open>:
.global open
open:
 li a7, SYS_open
 930:	48bd                	li	a7,15
 ecall
 932:	00000073          	ecall
 ret
 936:	8082                	ret

0000000000000938 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 938:	48c5                	li	a7,17
 ecall
 93a:	00000073          	ecall
 ret
 93e:	8082                	ret

0000000000000940 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 940:	48c9                	li	a7,18
 ecall
 942:	00000073          	ecall
 ret
 946:	8082                	ret

0000000000000948 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 948:	48a1                	li	a7,8
 ecall
 94a:	00000073          	ecall
 ret
 94e:	8082                	ret

0000000000000950 <link>:
.global link
link:
 li a7, SYS_link
 950:	48cd                	li	a7,19
 ecall
 952:	00000073          	ecall
 ret
 956:	8082                	ret

0000000000000958 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 958:	48d1                	li	a7,20
 ecall
 95a:	00000073          	ecall
 ret
 95e:	8082                	ret

0000000000000960 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 960:	48a5                	li	a7,9
 ecall
 962:	00000073          	ecall
 ret
 966:	8082                	ret

0000000000000968 <dup>:
.global dup
dup:
 li a7, SYS_dup
 968:	48a9                	li	a7,10
 ecall
 96a:	00000073          	ecall
 ret
 96e:	8082                	ret

0000000000000970 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 970:	48ad                	li	a7,11
 ecall
 972:	00000073          	ecall
 ret
 976:	8082                	ret

0000000000000978 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 978:	48b1                	li	a7,12
 ecall
 97a:	00000073          	ecall
 ret
 97e:	8082                	ret

0000000000000980 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 980:	48b5                	li	a7,13
 ecall
 982:	00000073          	ecall
 ret
 986:	8082                	ret

0000000000000988 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 988:	48b9                	li	a7,14
 ecall
 98a:	00000073          	ecall
 ret
 98e:	8082                	ret

0000000000000990 <ps>:
.global ps
ps:
 li a7, SYS_ps
 990:	48d9                	li	a7,22
 ecall
 992:	00000073          	ecall
 ret
 996:	8082                	ret

0000000000000998 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 998:	48dd                	li	a7,23
 ecall
 99a:	00000073          	ecall
 ret
 99e:	8082                	ret

00000000000009a0 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 9a0:	48e1                	li	a7,24
 ecall
 9a2:	00000073          	ecall
 ret
 9a6:	8082                	ret

00000000000009a8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 9a8:	1101                	addi	sp,sp,-32
 9aa:	ec06                	sd	ra,24(sp)
 9ac:	e822                	sd	s0,16(sp)
 9ae:	1000                	addi	s0,sp,32
 9b0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 9b4:	4605                	li	a2,1
 9b6:	fef40593          	addi	a1,s0,-17
 9ba:	00000097          	auipc	ra,0x0
 9be:	f56080e7          	jalr	-170(ra) # 910 <write>
}
 9c2:	60e2                	ld	ra,24(sp)
 9c4:	6442                	ld	s0,16(sp)
 9c6:	6105                	addi	sp,sp,32
 9c8:	8082                	ret

00000000000009ca <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 9ca:	7139                	addi	sp,sp,-64
 9cc:	fc06                	sd	ra,56(sp)
 9ce:	f822                	sd	s0,48(sp)
 9d0:	f426                	sd	s1,40(sp)
 9d2:	f04a                	sd	s2,32(sp)
 9d4:	ec4e                	sd	s3,24(sp)
 9d6:	0080                	addi	s0,sp,64
 9d8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 9da:	c299                	beqz	a3,9e0 <printint+0x16>
 9dc:	0805c963          	bltz	a1,a6e <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 9e0:	2581                	sext.w	a1,a1
  neg = 0;
 9e2:	4881                	li	a7,0
 9e4:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 9e8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 9ea:	2601                	sext.w	a2,a2
 9ec:	00000517          	auipc	a0,0x0
 9f0:	50c50513          	addi	a0,a0,1292 # ef8 <digits>
 9f4:	883a                	mv	a6,a4
 9f6:	2705                	addiw	a4,a4,1
 9f8:	02c5f7bb          	remuw	a5,a1,a2
 9fc:	1782                	slli	a5,a5,0x20
 9fe:	9381                	srli	a5,a5,0x20
 a00:	97aa                	add	a5,a5,a0
 a02:	0007c783          	lbu	a5,0(a5)
 a06:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 a0a:	0005879b          	sext.w	a5,a1
 a0e:	02c5d5bb          	divuw	a1,a1,a2
 a12:	0685                	addi	a3,a3,1
 a14:	fec7f0e3          	bgeu	a5,a2,9f4 <printint+0x2a>
  if(neg)
 a18:	00088c63          	beqz	a7,a30 <printint+0x66>
    buf[i++] = '-';
 a1c:	fd070793          	addi	a5,a4,-48
 a20:	00878733          	add	a4,a5,s0
 a24:	02d00793          	li	a5,45
 a28:	fef70823          	sb	a5,-16(a4)
 a2c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 a30:	02e05863          	blez	a4,a60 <printint+0x96>
 a34:	fc040793          	addi	a5,s0,-64
 a38:	00e78933          	add	s2,a5,a4
 a3c:	fff78993          	addi	s3,a5,-1
 a40:	99ba                	add	s3,s3,a4
 a42:	377d                	addiw	a4,a4,-1
 a44:	1702                	slli	a4,a4,0x20
 a46:	9301                	srli	a4,a4,0x20
 a48:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 a4c:	fff94583          	lbu	a1,-1(s2)
 a50:	8526                	mv	a0,s1
 a52:	00000097          	auipc	ra,0x0
 a56:	f56080e7          	jalr	-170(ra) # 9a8 <putc>
  while(--i >= 0)
 a5a:	197d                	addi	s2,s2,-1
 a5c:	ff3918e3          	bne	s2,s3,a4c <printint+0x82>
}
 a60:	70e2                	ld	ra,56(sp)
 a62:	7442                	ld	s0,48(sp)
 a64:	74a2                	ld	s1,40(sp)
 a66:	7902                	ld	s2,32(sp)
 a68:	69e2                	ld	s3,24(sp)
 a6a:	6121                	addi	sp,sp,64
 a6c:	8082                	ret
    x = -xx;
 a6e:	40b005bb          	negw	a1,a1
    neg = 1;
 a72:	4885                	li	a7,1
    x = -xx;
 a74:	bf85                	j	9e4 <printint+0x1a>

0000000000000a76 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 a76:	715d                	addi	sp,sp,-80
 a78:	e486                	sd	ra,72(sp)
 a7a:	e0a2                	sd	s0,64(sp)
 a7c:	fc26                	sd	s1,56(sp)
 a7e:	f84a                	sd	s2,48(sp)
 a80:	f44e                	sd	s3,40(sp)
 a82:	f052                	sd	s4,32(sp)
 a84:	ec56                	sd	s5,24(sp)
 a86:	e85a                	sd	s6,16(sp)
 a88:	e45e                	sd	s7,8(sp)
 a8a:	e062                	sd	s8,0(sp)
 a8c:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 a8e:	0005c903          	lbu	s2,0(a1)
 a92:	18090c63          	beqz	s2,c2a <vprintf+0x1b4>
 a96:	8aaa                	mv	s5,a0
 a98:	8bb2                	mv	s7,a2
 a9a:	00158493          	addi	s1,a1,1
  state = 0;
 a9e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 aa0:	02500a13          	li	s4,37
 aa4:	4b55                	li	s6,21
 aa6:	a839                	j	ac4 <vprintf+0x4e>
        putc(fd, c);
 aa8:	85ca                	mv	a1,s2
 aaa:	8556                	mv	a0,s5
 aac:	00000097          	auipc	ra,0x0
 ab0:	efc080e7          	jalr	-260(ra) # 9a8 <putc>
 ab4:	a019                	j	aba <vprintf+0x44>
    } else if(state == '%'){
 ab6:	01498d63          	beq	s3,s4,ad0 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 aba:	0485                	addi	s1,s1,1
 abc:	fff4c903          	lbu	s2,-1(s1)
 ac0:	16090563          	beqz	s2,c2a <vprintf+0x1b4>
    if(state == 0){
 ac4:	fe0999e3          	bnez	s3,ab6 <vprintf+0x40>
      if(c == '%'){
 ac8:	ff4910e3          	bne	s2,s4,aa8 <vprintf+0x32>
        state = '%';
 acc:	89d2                	mv	s3,s4
 ace:	b7f5                	j	aba <vprintf+0x44>
      if(c == 'd'){
 ad0:	13490263          	beq	s2,s4,bf4 <vprintf+0x17e>
 ad4:	f9d9079b          	addiw	a5,s2,-99
 ad8:	0ff7f793          	zext.b	a5,a5
 adc:	12fb6563          	bltu	s6,a5,c06 <vprintf+0x190>
 ae0:	f9d9079b          	addiw	a5,s2,-99
 ae4:	0ff7f713          	zext.b	a4,a5
 ae8:	10eb6f63          	bltu	s6,a4,c06 <vprintf+0x190>
 aec:	00271793          	slli	a5,a4,0x2
 af0:	00000717          	auipc	a4,0x0
 af4:	3b070713          	addi	a4,a4,944 # ea0 <malloc+0x178>
 af8:	97ba                	add	a5,a5,a4
 afa:	439c                	lw	a5,0(a5)
 afc:	97ba                	add	a5,a5,a4
 afe:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 b00:	008b8913          	addi	s2,s7,8
 b04:	4685                	li	a3,1
 b06:	4629                	li	a2,10
 b08:	000ba583          	lw	a1,0(s7)
 b0c:	8556                	mv	a0,s5
 b0e:	00000097          	auipc	ra,0x0
 b12:	ebc080e7          	jalr	-324(ra) # 9ca <printint>
 b16:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 b18:	4981                	li	s3,0
 b1a:	b745                	j	aba <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 b1c:	008b8913          	addi	s2,s7,8
 b20:	4681                	li	a3,0
 b22:	4629                	li	a2,10
 b24:	000ba583          	lw	a1,0(s7)
 b28:	8556                	mv	a0,s5
 b2a:	00000097          	auipc	ra,0x0
 b2e:	ea0080e7          	jalr	-352(ra) # 9ca <printint>
 b32:	8bca                	mv	s7,s2
      state = 0;
 b34:	4981                	li	s3,0
 b36:	b751                	j	aba <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 b38:	008b8913          	addi	s2,s7,8
 b3c:	4681                	li	a3,0
 b3e:	4641                	li	a2,16
 b40:	000ba583          	lw	a1,0(s7)
 b44:	8556                	mv	a0,s5
 b46:	00000097          	auipc	ra,0x0
 b4a:	e84080e7          	jalr	-380(ra) # 9ca <printint>
 b4e:	8bca                	mv	s7,s2
      state = 0;
 b50:	4981                	li	s3,0
 b52:	b7a5                	j	aba <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 b54:	008b8c13          	addi	s8,s7,8
 b58:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 b5c:	03000593          	li	a1,48
 b60:	8556                	mv	a0,s5
 b62:	00000097          	auipc	ra,0x0
 b66:	e46080e7          	jalr	-442(ra) # 9a8 <putc>
  putc(fd, 'x');
 b6a:	07800593          	li	a1,120
 b6e:	8556                	mv	a0,s5
 b70:	00000097          	auipc	ra,0x0
 b74:	e38080e7          	jalr	-456(ra) # 9a8 <putc>
 b78:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 b7a:	00000b97          	auipc	s7,0x0
 b7e:	37eb8b93          	addi	s7,s7,894 # ef8 <digits>
 b82:	03c9d793          	srli	a5,s3,0x3c
 b86:	97de                	add	a5,a5,s7
 b88:	0007c583          	lbu	a1,0(a5)
 b8c:	8556                	mv	a0,s5
 b8e:	00000097          	auipc	ra,0x0
 b92:	e1a080e7          	jalr	-486(ra) # 9a8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 b96:	0992                	slli	s3,s3,0x4
 b98:	397d                	addiw	s2,s2,-1
 b9a:	fe0914e3          	bnez	s2,b82 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 b9e:	8be2                	mv	s7,s8
      state = 0;
 ba0:	4981                	li	s3,0
 ba2:	bf21                	j	aba <vprintf+0x44>
        s = va_arg(ap, char*);
 ba4:	008b8993          	addi	s3,s7,8
 ba8:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 bac:	02090163          	beqz	s2,bce <vprintf+0x158>
        while(*s != 0){
 bb0:	00094583          	lbu	a1,0(s2)
 bb4:	c9a5                	beqz	a1,c24 <vprintf+0x1ae>
          putc(fd, *s);
 bb6:	8556                	mv	a0,s5
 bb8:	00000097          	auipc	ra,0x0
 bbc:	df0080e7          	jalr	-528(ra) # 9a8 <putc>
          s++;
 bc0:	0905                	addi	s2,s2,1
        while(*s != 0){
 bc2:	00094583          	lbu	a1,0(s2)
 bc6:	f9e5                	bnez	a1,bb6 <vprintf+0x140>
        s = va_arg(ap, char*);
 bc8:	8bce                	mv	s7,s3
      state = 0;
 bca:	4981                	li	s3,0
 bcc:	b5fd                	j	aba <vprintf+0x44>
          s = "(null)";
 bce:	00000917          	auipc	s2,0x0
 bd2:	2ca90913          	addi	s2,s2,714 # e98 <malloc+0x170>
        while(*s != 0){
 bd6:	02800593          	li	a1,40
 bda:	bff1                	j	bb6 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 bdc:	008b8913          	addi	s2,s7,8
 be0:	000bc583          	lbu	a1,0(s7)
 be4:	8556                	mv	a0,s5
 be6:	00000097          	auipc	ra,0x0
 bea:	dc2080e7          	jalr	-574(ra) # 9a8 <putc>
 bee:	8bca                	mv	s7,s2
      state = 0;
 bf0:	4981                	li	s3,0
 bf2:	b5e1                	j	aba <vprintf+0x44>
        putc(fd, c);
 bf4:	02500593          	li	a1,37
 bf8:	8556                	mv	a0,s5
 bfa:	00000097          	auipc	ra,0x0
 bfe:	dae080e7          	jalr	-594(ra) # 9a8 <putc>
      state = 0;
 c02:	4981                	li	s3,0
 c04:	bd5d                	j	aba <vprintf+0x44>
        putc(fd, '%');
 c06:	02500593          	li	a1,37
 c0a:	8556                	mv	a0,s5
 c0c:	00000097          	auipc	ra,0x0
 c10:	d9c080e7          	jalr	-612(ra) # 9a8 <putc>
        putc(fd, c);
 c14:	85ca                	mv	a1,s2
 c16:	8556                	mv	a0,s5
 c18:	00000097          	auipc	ra,0x0
 c1c:	d90080e7          	jalr	-624(ra) # 9a8 <putc>
      state = 0;
 c20:	4981                	li	s3,0
 c22:	bd61                	j	aba <vprintf+0x44>
        s = va_arg(ap, char*);
 c24:	8bce                	mv	s7,s3
      state = 0;
 c26:	4981                	li	s3,0
 c28:	bd49                	j	aba <vprintf+0x44>
    }
  }
}
 c2a:	60a6                	ld	ra,72(sp)
 c2c:	6406                	ld	s0,64(sp)
 c2e:	74e2                	ld	s1,56(sp)
 c30:	7942                	ld	s2,48(sp)
 c32:	79a2                	ld	s3,40(sp)
 c34:	7a02                	ld	s4,32(sp)
 c36:	6ae2                	ld	s5,24(sp)
 c38:	6b42                	ld	s6,16(sp)
 c3a:	6ba2                	ld	s7,8(sp)
 c3c:	6c02                	ld	s8,0(sp)
 c3e:	6161                	addi	sp,sp,80
 c40:	8082                	ret

0000000000000c42 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 c42:	715d                	addi	sp,sp,-80
 c44:	ec06                	sd	ra,24(sp)
 c46:	e822                	sd	s0,16(sp)
 c48:	1000                	addi	s0,sp,32
 c4a:	e010                	sd	a2,0(s0)
 c4c:	e414                	sd	a3,8(s0)
 c4e:	e818                	sd	a4,16(s0)
 c50:	ec1c                	sd	a5,24(s0)
 c52:	03043023          	sd	a6,32(s0)
 c56:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 c5a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 c5e:	8622                	mv	a2,s0
 c60:	00000097          	auipc	ra,0x0
 c64:	e16080e7          	jalr	-490(ra) # a76 <vprintf>
}
 c68:	60e2                	ld	ra,24(sp)
 c6a:	6442                	ld	s0,16(sp)
 c6c:	6161                	addi	sp,sp,80
 c6e:	8082                	ret

0000000000000c70 <printf>:

void
printf(const char *fmt, ...)
{
 c70:	711d                	addi	sp,sp,-96
 c72:	ec06                	sd	ra,24(sp)
 c74:	e822                	sd	s0,16(sp)
 c76:	1000                	addi	s0,sp,32
 c78:	e40c                	sd	a1,8(s0)
 c7a:	e810                	sd	a2,16(s0)
 c7c:	ec14                	sd	a3,24(s0)
 c7e:	f018                	sd	a4,32(s0)
 c80:	f41c                	sd	a5,40(s0)
 c82:	03043823          	sd	a6,48(s0)
 c86:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 c8a:	00840613          	addi	a2,s0,8
 c8e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 c92:	85aa                	mv	a1,a0
 c94:	4505                	li	a0,1
 c96:	00000097          	auipc	ra,0x0
 c9a:	de0080e7          	jalr	-544(ra) # a76 <vprintf>
}
 c9e:	60e2                	ld	ra,24(sp)
 ca0:	6442                	ld	s0,16(sp)
 ca2:	6125                	addi	sp,sp,96
 ca4:	8082                	ret

0000000000000ca6 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 ca6:	1141                	addi	sp,sp,-16
 ca8:	e422                	sd	s0,8(sp)
 caa:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 cac:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cb0:	00000797          	auipc	a5,0x0
 cb4:	3687b783          	ld	a5,872(a5) # 1018 <freep>
 cb8:	a02d                	j	ce2 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 cba:	4618                	lw	a4,8(a2)
 cbc:	9f2d                	addw	a4,a4,a1
 cbe:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 cc2:	6398                	ld	a4,0(a5)
 cc4:	6310                	ld	a2,0(a4)
 cc6:	a83d                	j	d04 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 cc8:	ff852703          	lw	a4,-8(a0)
 ccc:	9f31                	addw	a4,a4,a2
 cce:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 cd0:	ff053683          	ld	a3,-16(a0)
 cd4:	a091                	j	d18 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cd6:	6398                	ld	a4,0(a5)
 cd8:	00e7e463          	bltu	a5,a4,ce0 <free+0x3a>
 cdc:	00e6ea63          	bltu	a3,a4,cf0 <free+0x4a>
{
 ce0:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ce2:	fed7fae3          	bgeu	a5,a3,cd6 <free+0x30>
 ce6:	6398                	ld	a4,0(a5)
 ce8:	00e6e463          	bltu	a3,a4,cf0 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cec:	fee7eae3          	bltu	a5,a4,ce0 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 cf0:	ff852583          	lw	a1,-8(a0)
 cf4:	6390                	ld	a2,0(a5)
 cf6:	02059813          	slli	a6,a1,0x20
 cfa:	01c85713          	srli	a4,a6,0x1c
 cfe:	9736                	add	a4,a4,a3
 d00:	fae60de3          	beq	a2,a4,cba <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 d04:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 d08:	4790                	lw	a2,8(a5)
 d0a:	02061593          	slli	a1,a2,0x20
 d0e:	01c5d713          	srli	a4,a1,0x1c
 d12:	973e                	add	a4,a4,a5
 d14:	fae68ae3          	beq	a3,a4,cc8 <free+0x22>
        p->s.ptr = bp->s.ptr;
 d18:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 d1a:	00000717          	auipc	a4,0x0
 d1e:	2ef73f23          	sd	a5,766(a4) # 1018 <freep>
}
 d22:	6422                	ld	s0,8(sp)
 d24:	0141                	addi	sp,sp,16
 d26:	8082                	ret

0000000000000d28 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 d28:	7139                	addi	sp,sp,-64
 d2a:	fc06                	sd	ra,56(sp)
 d2c:	f822                	sd	s0,48(sp)
 d2e:	f426                	sd	s1,40(sp)
 d30:	f04a                	sd	s2,32(sp)
 d32:	ec4e                	sd	s3,24(sp)
 d34:	e852                	sd	s4,16(sp)
 d36:	e456                	sd	s5,8(sp)
 d38:	e05a                	sd	s6,0(sp)
 d3a:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 d3c:	02051493          	slli	s1,a0,0x20
 d40:	9081                	srli	s1,s1,0x20
 d42:	04bd                	addi	s1,s1,15
 d44:	8091                	srli	s1,s1,0x4
 d46:	0014899b          	addiw	s3,s1,1
 d4a:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 d4c:	00000517          	auipc	a0,0x0
 d50:	2cc53503          	ld	a0,716(a0) # 1018 <freep>
 d54:	c515                	beqz	a0,d80 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 d56:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 d58:	4798                	lw	a4,8(a5)
 d5a:	02977f63          	bgeu	a4,s1,d98 <malloc+0x70>
    if (nu < 4096)
 d5e:	8a4e                	mv	s4,s3
 d60:	0009871b          	sext.w	a4,s3
 d64:	6685                	lui	a3,0x1
 d66:	00d77363          	bgeu	a4,a3,d6c <malloc+0x44>
 d6a:	6a05                	lui	s4,0x1
 d6c:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 d70:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 d74:	00000917          	auipc	s2,0x0
 d78:	2a490913          	addi	s2,s2,676 # 1018 <freep>
    if (p == (char *)-1)
 d7c:	5afd                	li	s5,-1
 d7e:	a895                	j	df2 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 d80:	00000797          	auipc	a5,0x0
 d84:	72078793          	addi	a5,a5,1824 # 14a0 <base>
 d88:	00000717          	auipc	a4,0x0
 d8c:	28f73823          	sd	a5,656(a4) # 1018 <freep>
 d90:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 d92:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 d96:	b7e1                	j	d5e <malloc+0x36>
            if (p->s.size == nunits)
 d98:	02e48c63          	beq	s1,a4,dd0 <malloc+0xa8>
                p->s.size -= nunits;
 d9c:	4137073b          	subw	a4,a4,s3
 da0:	c798                	sw	a4,8(a5)
                p += p->s.size;
 da2:	02071693          	slli	a3,a4,0x20
 da6:	01c6d713          	srli	a4,a3,0x1c
 daa:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 dac:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 db0:	00000717          	auipc	a4,0x0
 db4:	26a73423          	sd	a0,616(a4) # 1018 <freep>
            return (void *)(p + 1);
 db8:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 dbc:	70e2                	ld	ra,56(sp)
 dbe:	7442                	ld	s0,48(sp)
 dc0:	74a2                	ld	s1,40(sp)
 dc2:	7902                	ld	s2,32(sp)
 dc4:	69e2                	ld	s3,24(sp)
 dc6:	6a42                	ld	s4,16(sp)
 dc8:	6aa2                	ld	s5,8(sp)
 dca:	6b02                	ld	s6,0(sp)
 dcc:	6121                	addi	sp,sp,64
 dce:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 dd0:	6398                	ld	a4,0(a5)
 dd2:	e118                	sd	a4,0(a0)
 dd4:	bff1                	j	db0 <malloc+0x88>
    hp->s.size = nu;
 dd6:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 dda:	0541                	addi	a0,a0,16
 ddc:	00000097          	auipc	ra,0x0
 de0:	eca080e7          	jalr	-310(ra) # ca6 <free>
    return freep;
 de4:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 de8:	d971                	beqz	a0,dbc <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 dea:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 dec:	4798                	lw	a4,8(a5)
 dee:	fa9775e3          	bgeu	a4,s1,d98 <malloc+0x70>
        if (p == freep)
 df2:	00093703          	ld	a4,0(s2)
 df6:	853e                	mv	a0,a5
 df8:	fef719e3          	bne	a4,a5,dea <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 dfc:	8552                	mv	a0,s4
 dfe:	00000097          	auipc	ra,0x0
 e02:	b7a080e7          	jalr	-1158(ra) # 978 <sbrk>
    if (p == (char *)-1)
 e06:	fd5518e3          	bne	a0,s5,dd6 <malloc+0xae>
                return 0;
 e0a:	4501                	li	a0,0
 e0c:	bf45                	j	dbc <malloc+0x94>
