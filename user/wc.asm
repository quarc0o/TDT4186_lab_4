
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	addi	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4901                	li	s2,0
  l = w = c = 0;
  28:	4d01                	li	s10,0
  2a:	4c81                	li	s9,0
  2c:	4c01                	li	s8,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2e:	00001d97          	auipc	s11,0x1
  32:	ff2d8d93          	addi	s11,s11,-14 # 1020 <buf>
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  36:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  38:	00001a17          	auipc	s4,0x1
  3c:	d08a0a13          	addi	s4,s4,-760 # d40 <malloc+0xf4>
        inword = 0;
  40:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  42:	a805                	j	72 <wc+0x72>
      if(strchr(" \r\t\n\v", buf[i]))
  44:	8552                	mv	a0,s4
  46:	00000097          	auipc	ra,0x0
  4a:	5f6080e7          	jalr	1526(ra) # 63c <strchr>
  4e:	c919                	beqz	a0,64 <wc+0x64>
        inword = 0;
  50:	895e                	mv	s2,s7
    for(i=0; i<n; i++){
  52:	0485                	addi	s1,s1,1
  54:	00998d63          	beq	s3,s1,6e <wc+0x6e>
      if(buf[i] == '\n')
  58:	0004c583          	lbu	a1,0(s1)
  5c:	ff5594e3          	bne	a1,s5,44 <wc+0x44>
        l++;
  60:	2c05                	addiw	s8,s8,1
  62:	b7cd                	j	44 <wc+0x44>
      else if(!inword){
  64:	fe0917e3          	bnez	s2,52 <wc+0x52>
        w++;
  68:	2c85                	addiw	s9,s9,1
        inword = 1;
  6a:	4905                	li	s2,1
  6c:	b7dd                	j	52 <wc+0x52>
      c++;
  6e:	01ab0d3b          	addw	s10,s6,s10
  while((n = read(fd, buf, sizeof(buf))) > 0){
  72:	20000613          	li	a2,512
  76:	85ee                	mv	a1,s11
  78:	f8843503          	ld	a0,-120(s0)
  7c:	00000097          	auipc	ra,0x0
  80:	7b0080e7          	jalr	1968(ra) # 82c <read>
  84:	8b2a                	mv	s6,a0
  86:	00a05963          	blez	a0,98 <wc+0x98>
    for(i=0; i<n; i++){
  8a:	00001497          	auipc	s1,0x1
  8e:	f9648493          	addi	s1,s1,-106 # 1020 <buf>
  92:	009509b3          	add	s3,a0,s1
  96:	b7c9                	j	58 <wc+0x58>
      }
    }
  }
  if(n < 0){
  98:	02054e63          	bltz	a0,d4 <wc+0xd4>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  9c:	f8043703          	ld	a4,-128(s0)
  a0:	86ea                	mv	a3,s10
  a2:	8666                	mv	a2,s9
  a4:	85e2                	mv	a1,s8
  a6:	00001517          	auipc	a0,0x1
  aa:	cb250513          	addi	a0,a0,-846 # d58 <malloc+0x10c>
  ae:	00001097          	auipc	ra,0x1
  b2:	ae6080e7          	jalr	-1306(ra) # b94 <printf>
}
  b6:	70e6                	ld	ra,120(sp)
  b8:	7446                	ld	s0,112(sp)
  ba:	74a6                	ld	s1,104(sp)
  bc:	7906                	ld	s2,96(sp)
  be:	69e6                	ld	s3,88(sp)
  c0:	6a46                	ld	s4,80(sp)
  c2:	6aa6                	ld	s5,72(sp)
  c4:	6b06                	ld	s6,64(sp)
  c6:	7be2                	ld	s7,56(sp)
  c8:	7c42                	ld	s8,48(sp)
  ca:	7ca2                	ld	s9,40(sp)
  cc:	7d02                	ld	s10,32(sp)
  ce:	6de2                	ld	s11,24(sp)
  d0:	6109                	addi	sp,sp,128
  d2:	8082                	ret
    printf("wc: read error\n");
  d4:	00001517          	auipc	a0,0x1
  d8:	c7450513          	addi	a0,a0,-908 # d48 <malloc+0xfc>
  dc:	00001097          	auipc	ra,0x1
  e0:	ab8080e7          	jalr	-1352(ra) # b94 <printf>
    exit(1);
  e4:	4505                	li	a0,1
  e6:	00000097          	auipc	ra,0x0
  ea:	72e080e7          	jalr	1838(ra) # 814 <exit>

00000000000000ee <main>:

int
main(int argc, char *argv[])
{
  ee:	7179                	addi	sp,sp,-48
  f0:	f406                	sd	ra,40(sp)
  f2:	f022                	sd	s0,32(sp)
  f4:	ec26                	sd	s1,24(sp)
  f6:	e84a                	sd	s2,16(sp)
  f8:	e44e                	sd	s3,8(sp)
  fa:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  fc:	4785                	li	a5,1
  fe:	04a7d963          	bge	a5,a0,150 <main+0x62>
 102:	00858913          	addi	s2,a1,8
 106:	ffe5099b          	addiw	s3,a0,-2
 10a:	02099793          	slli	a5,s3,0x20
 10e:	01d7d993          	srli	s3,a5,0x1d
 112:	05c1                	addi	a1,a1,16
 114:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
 116:	4581                	li	a1,0
 118:	00093503          	ld	a0,0(s2)
 11c:	00000097          	auipc	ra,0x0
 120:	738080e7          	jalr	1848(ra) # 854 <open>
 124:	84aa                	mv	s1,a0
 126:	04054363          	bltz	a0,16c <main+0x7e>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 12a:	00093583          	ld	a1,0(s2)
 12e:	00000097          	auipc	ra,0x0
 132:	ed2080e7          	jalr	-302(ra) # 0 <wc>
    close(fd);
 136:	8526                	mv	a0,s1
 138:	00000097          	auipc	ra,0x0
 13c:	704080e7          	jalr	1796(ra) # 83c <close>
  for(i = 1; i < argc; i++){
 140:	0921                	addi	s2,s2,8
 142:	fd391ae3          	bne	s2,s3,116 <main+0x28>
  }
  exit(0);
 146:	4501                	li	a0,0
 148:	00000097          	auipc	ra,0x0
 14c:	6cc080e7          	jalr	1740(ra) # 814 <exit>
    wc(0, "");
 150:	00001597          	auipc	a1,0x1
 154:	c1858593          	addi	a1,a1,-1000 # d68 <malloc+0x11c>
 158:	4501                	li	a0,0
 15a:	00000097          	auipc	ra,0x0
 15e:	ea6080e7          	jalr	-346(ra) # 0 <wc>
    exit(0);
 162:	4501                	li	a0,0
 164:	00000097          	auipc	ra,0x0
 168:	6b0080e7          	jalr	1712(ra) # 814 <exit>
      printf("wc: cannot open %s\n", argv[i]);
 16c:	00093583          	ld	a1,0(s2)
 170:	00001517          	auipc	a0,0x1
 174:	c0050513          	addi	a0,a0,-1024 # d70 <malloc+0x124>
 178:	00001097          	auipc	ra,0x1
 17c:	a1c080e7          	jalr	-1508(ra) # b94 <printf>
      exit(1);
 180:	4505                	li	a0,1
 182:	00000097          	auipc	ra,0x0
 186:	692080e7          	jalr	1682(ra) # 814 <exit>

000000000000018a <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
 18a:	1141                	addi	sp,sp,-16
 18c:	e422                	sd	s0,8(sp)
 18e:	0800                	addi	s0,sp,16
    lk->name = name;
 190:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
 192:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
 196:	57fd                	li	a5,-1
 198:	00f50823          	sb	a5,16(a0)
}
 19c:	6422                	ld	s0,8(sp)
 19e:	0141                	addi	sp,sp,16
 1a0:	8082                	ret

00000000000001a2 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
 1a2:	00054783          	lbu	a5,0(a0)
 1a6:	e399                	bnez	a5,1ac <holding+0xa>
 1a8:	4501                	li	a0,0
}
 1aa:	8082                	ret
{
 1ac:	1101                	addi	sp,sp,-32
 1ae:	ec06                	sd	ra,24(sp)
 1b0:	e822                	sd	s0,16(sp)
 1b2:	e426                	sd	s1,8(sp)
 1b4:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
 1b6:	01054483          	lbu	s1,16(a0)
 1ba:	00000097          	auipc	ra,0x0
 1be:	340080e7          	jalr	832(ra) # 4fa <twhoami>
 1c2:	2501                	sext.w	a0,a0
 1c4:	40a48533          	sub	a0,s1,a0
 1c8:	00153513          	seqz	a0,a0
}
 1cc:	60e2                	ld	ra,24(sp)
 1ce:	6442                	ld	s0,16(sp)
 1d0:	64a2                	ld	s1,8(sp)
 1d2:	6105                	addi	sp,sp,32
 1d4:	8082                	ret

00000000000001d6 <acquire>:

void acquire(struct lock *lk)
{
 1d6:	7179                	addi	sp,sp,-48
 1d8:	f406                	sd	ra,40(sp)
 1da:	f022                	sd	s0,32(sp)
 1dc:	ec26                	sd	s1,24(sp)
 1de:	e84a                	sd	s2,16(sp)
 1e0:	e44e                	sd	s3,8(sp)
 1e2:	e052                	sd	s4,0(sp)
 1e4:	1800                	addi	s0,sp,48
 1e6:	8a2a                	mv	s4,a0
    if (holding(lk))
 1e8:	00000097          	auipc	ra,0x0
 1ec:	fba080e7          	jalr	-70(ra) # 1a2 <holding>
 1f0:	e919                	bnez	a0,206 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 1f2:	ffca7493          	andi	s1,s4,-4
 1f6:	003a7913          	andi	s2,s4,3
 1fa:	0039191b          	slliw	s2,s2,0x3
 1fe:	4985                	li	s3,1
 200:	012999bb          	sllw	s3,s3,s2
 204:	a015                	j	228 <acquire+0x52>
        printf("re-acquiring lock we already hold");
 206:	00001517          	auipc	a0,0x1
 20a:	b8250513          	addi	a0,a0,-1150 # d88 <malloc+0x13c>
 20e:	00001097          	auipc	ra,0x1
 212:	986080e7          	jalr	-1658(ra) # b94 <printf>
        exit(-1);
 216:	557d                	li	a0,-1
 218:	00000097          	auipc	ra,0x0
 21c:	5fc080e7          	jalr	1532(ra) # 814 <exit>
    {
        // give up the cpu for other threads
        tyield();
 220:	00000097          	auipc	ra,0x0
 224:	258080e7          	jalr	600(ra) # 478 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 228:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 22c:	0127d7bb          	srlw	a5,a5,s2
 230:	0ff7f793          	zext.b	a5,a5
 234:	f7f5                	bnez	a5,220 <acquire+0x4a>
    }

    __sync_synchronize();
 236:	0ff0000f          	fence

    lk->tid = twhoami();
 23a:	00000097          	auipc	ra,0x0
 23e:	2c0080e7          	jalr	704(ra) # 4fa <twhoami>
 242:	00aa0823          	sb	a0,16(s4)
}
 246:	70a2                	ld	ra,40(sp)
 248:	7402                	ld	s0,32(sp)
 24a:	64e2                	ld	s1,24(sp)
 24c:	6942                	ld	s2,16(sp)
 24e:	69a2                	ld	s3,8(sp)
 250:	6a02                	ld	s4,0(sp)
 252:	6145                	addi	sp,sp,48
 254:	8082                	ret

0000000000000256 <release>:

void release(struct lock *lk)
{
 256:	1101                	addi	sp,sp,-32
 258:	ec06                	sd	ra,24(sp)
 25a:	e822                	sd	s0,16(sp)
 25c:	e426                	sd	s1,8(sp)
 25e:	1000                	addi	s0,sp,32
 260:	84aa                	mv	s1,a0
    if (!holding(lk))
 262:	00000097          	auipc	ra,0x0
 266:	f40080e7          	jalr	-192(ra) # 1a2 <holding>
 26a:	c11d                	beqz	a0,290 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 26c:	57fd                	li	a5,-1
 26e:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 272:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 276:	0ff0000f          	fence
 27a:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 27e:	00000097          	auipc	ra,0x0
 282:	1fa080e7          	jalr	506(ra) # 478 <tyield>
}
 286:	60e2                	ld	ra,24(sp)
 288:	6442                	ld	s0,16(sp)
 28a:	64a2                	ld	s1,8(sp)
 28c:	6105                	addi	sp,sp,32
 28e:	8082                	ret
        printf("releasing lock we are not holding");
 290:	00001517          	auipc	a0,0x1
 294:	b2050513          	addi	a0,a0,-1248 # db0 <malloc+0x164>
 298:	00001097          	auipc	ra,0x1
 29c:	8fc080e7          	jalr	-1796(ra) # b94 <printf>
        exit(-1);
 2a0:	557d                	li	a0,-1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	572080e7          	jalr	1394(ra) # 814 <exit>

00000000000002aa <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e406                	sd	ra,8(sp)
 2ae:	e022                	sd	s0,0(sp)
 2b0:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 2b2:	09800513          	li	a0,152
 2b6:	00001097          	auipc	ra,0x1
 2ba:	996080e7          	jalr	-1642(ra) # c4c <malloc>

    main_thread->tid = next_tid;
 2be:	00001797          	auipc	a5,0x1
 2c2:	d4278793          	addi	a5,a5,-702 # 1000 <next_tid>
 2c6:	4398                	lw	a4,0(a5)
 2c8:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
 2cc:	4398                	lw	a4,0(a5)
 2ce:	2705                	addiw	a4,a4,1
 2d0:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
 2d2:	4791                	li	a5,4
 2d4:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 2d6:	00001797          	auipc	a5,0x1
 2da:	d2a7bd23          	sd	a0,-710(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 2de:	00001797          	auipc	a5,0x1
 2e2:	f4278793          	addi	a5,a5,-190 # 1220 <threads>
 2e6:	00001717          	auipc	a4,0x1
 2ea:	fba70713          	addi	a4,a4,-70 # 12a0 <base>
        threads[i] = NULL;
 2ee:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 2f2:	07a1                	addi	a5,a5,8
 2f4:	fee79de3          	bne	a5,a4,2ee <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 2f8:	00001797          	auipc	a5,0x1
 2fc:	f2a7b423          	sd	a0,-216(a5) # 1220 <threads>
}
 300:	60a2                	ld	ra,8(sp)
 302:	6402                	ld	s0,0(sp)
 304:	0141                	addi	sp,sp,16
 306:	8082                	ret

0000000000000308 <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 308:	00001517          	auipc	a0,0x1
 30c:	d0853503          	ld	a0,-760(a0) # 1010 <current_thread>
 310:	00001717          	auipc	a4,0x1
 314:	f1070713          	addi	a4,a4,-240 # 1220 <threads>
    for (int i = 0; i < 16; i++) {
 318:	4781                	li	a5,0
 31a:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 31c:	6314                	ld	a3,0(a4)
 31e:	00a68763          	beq	a3,a0,32c <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 322:	2785                	addiw	a5,a5,1
 324:	0721                	addi	a4,a4,8
 326:	fec79be3          	bne	a5,a2,31c <tsched+0x14>
    int current_index = 0;
 32a:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 32c:	0017869b          	addiw	a3,a5,1
 330:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 334:	00001817          	auipc	a6,0x1
 338:	eec80813          	addi	a6,a6,-276 # 1220 <threads>
 33c:	488d                	li	a7,3
 33e:	a021                	j	346 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 340:	2685                	addiw	a3,a3,1
 342:	04c68363          	beq	a3,a2,388 <tsched+0x80>
        int next_index = (current_index + i) % 16;
 346:	41f6d71b          	sraiw	a4,a3,0x1f
 34a:	01c7571b          	srliw	a4,a4,0x1c
 34e:	00d707bb          	addw	a5,a4,a3
 352:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 354:	9f99                	subw	a5,a5,a4
 356:	078e                	slli	a5,a5,0x3
 358:	97c2                	add	a5,a5,a6
 35a:	638c                	ld	a1,0(a5)
 35c:	d1f5                	beqz	a1,340 <tsched+0x38>
 35e:	5dbc                	lw	a5,120(a1)
 360:	ff1790e3          	bne	a5,a7,340 <tsched+0x38>
{
 364:	1141                	addi	sp,sp,-16
 366:	e406                	sd	ra,8(sp)
 368:	e022                	sd	s0,0(sp)
 36a:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 36c:	00001797          	auipc	a5,0x1
 370:	cab7b223          	sd	a1,-860(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 374:	05a1                	addi	a1,a1,8
 376:	0521                	addi	a0,a0,8
 378:	00000097          	auipc	ra,0x0
 37c:	19a080e7          	jalr	410(ra) # 512 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 380:	60a2                	ld	ra,8(sp)
 382:	6402                	ld	s0,0(sp)
 384:	0141                	addi	sp,sp,16
 386:	8082                	ret
 388:	8082                	ret

000000000000038a <thread_wrapper>:
{
 38a:	1101                	addi	sp,sp,-32
 38c:	ec06                	sd	ra,24(sp)
 38e:	e822                	sd	s0,16(sp)
 390:	e426                	sd	s1,8(sp)
 392:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
 394:	00001497          	auipc	s1,0x1
 398:	c7c48493          	addi	s1,s1,-900 # 1010 <current_thread>
 39c:	609c                	ld	a5,0(s1)
 39e:	6b9c                	ld	a5,16(a5)
    func(arg);
 3a0:	6398                	ld	a4,0(a5)
 3a2:	6788                	ld	a0,8(a5)
 3a4:	9702                	jalr	a4
    current_thread->state = EXITED;
 3a6:	609c                	ld	a5,0(s1)
 3a8:	4719                	li	a4,6
 3aa:	dfb8                	sw	a4,120(a5)
    tsched();
 3ac:	00000097          	auipc	ra,0x0
 3b0:	f5c080e7          	jalr	-164(ra) # 308 <tsched>
}
 3b4:	60e2                	ld	ra,24(sp)
 3b6:	6442                	ld	s0,16(sp)
 3b8:	64a2                	ld	s1,8(sp)
 3ba:	6105                	addi	sp,sp,32
 3bc:	8082                	ret

00000000000003be <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 3be:	7179                	addi	sp,sp,-48
 3c0:	f406                	sd	ra,40(sp)
 3c2:	f022                	sd	s0,32(sp)
 3c4:	ec26                	sd	s1,24(sp)
 3c6:	e84a                	sd	s2,16(sp)
 3c8:	e44e                	sd	s3,8(sp)
 3ca:	1800                	addi	s0,sp,48
 3cc:	84aa                	mv	s1,a0
 3ce:	8932                	mv	s2,a2
 3d0:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 3d2:	09800513          	li	a0,152
 3d6:	00001097          	auipc	ra,0x1
 3da:	876080e7          	jalr	-1930(ra) # c4c <malloc>
 3de:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 3e0:	478d                	li	a5,3
 3e2:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 3e4:	609c                	ld	a5,0(s1)
 3e6:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
 3ea:	609c                	ld	a5,0(s1)
 3ec:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
 3f0:	6098                	ld	a4,0(s1)
 3f2:	00001797          	auipc	a5,0x1
 3f6:	c0e78793          	addi	a5,a5,-1010 # 1000 <next_tid>
 3fa:	4394                	lw	a3,0(a5)
 3fc:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 400:	4398                	lw	a4,0(a5)
 402:	2705                	addiw	a4,a4,1
 404:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
 406:	6505                	lui	a0,0x1
 408:	00001097          	auipc	ra,0x1
 40c:	844080e7          	jalr	-1980(ra) # c4c <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
 410:	6785                	lui	a5,0x1
 412:	00a78733          	add	a4,a5,a0
 416:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
 41a:	17c1                	addi	a5,a5,-16 # ff0 <digits+0x1b8>
 41c:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
 41e:	01253023          	sd	s2,0(a0) # 1000 <next_tid>

    (*thread)->tcontext.sp = stack_top;
 422:	609c                	ld	a5,0(s1)
 424:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 426:	609c                	ld	a5,0(s1)
 428:	00000717          	auipc	a4,0x0
 42c:	f6270713          	addi	a4,a4,-158 # 38a <thread_wrapper>
 430:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 432:	00001717          	auipc	a4,0x1
 436:	dee70713          	addi	a4,a4,-530 # 1220 <threads>
 43a:	4781                	li	a5,0
 43c:	4641                	li	a2,16
        if (threads[i] == NULL) {
 43e:	6314                	ld	a3,0(a4)
 440:	c29d                	beqz	a3,466 <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
 442:	2785                	addiw	a5,a5,1
 444:	0721                	addi	a4,a4,8
 446:	fec79ce3          	bne	a5,a2,43e <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
 44a:	6088                	ld	a0,0(s1)
 44c:	00000097          	auipc	ra,0x0
 450:	77e080e7          	jalr	1918(ra) # bca <free>
        *thread = NULL;
 454:	0004b023          	sd	zero,0(s1)
        return;
    }
}
 458:	70a2                	ld	ra,40(sp)
 45a:	7402                	ld	s0,32(sp)
 45c:	64e2                	ld	s1,24(sp)
 45e:	6942                	ld	s2,16(sp)
 460:	69a2                	ld	s3,8(sp)
 462:	6145                	addi	sp,sp,48
 464:	8082                	ret
            threads[i] = *thread;
 466:	6094                	ld	a3,0(s1)
 468:	078e                	slli	a5,a5,0x3
 46a:	00001717          	auipc	a4,0x1
 46e:	db670713          	addi	a4,a4,-586 # 1220 <threads>
 472:	97ba                	add	a5,a5,a4
 474:	e394                	sd	a3,0(a5)
    if (!thread_added) {
 476:	b7cd                	j	458 <tcreate+0x9a>

0000000000000478 <tyield>:
    return 0;
}


void tyield()
{
 478:	1141                	addi	sp,sp,-16
 47a:	e406                	sd	ra,8(sp)
 47c:	e022                	sd	s0,0(sp)
 47e:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 480:	00001797          	auipc	a5,0x1
 484:	b907b783          	ld	a5,-1136(a5) # 1010 <current_thread>
 488:	470d                	li	a4,3
 48a:	dfb8                	sw	a4,120(a5)
    tsched();
 48c:	00000097          	auipc	ra,0x0
 490:	e7c080e7          	jalr	-388(ra) # 308 <tsched>
}
 494:	60a2                	ld	ra,8(sp)
 496:	6402                	ld	s0,0(sp)
 498:	0141                	addi	sp,sp,16
 49a:	8082                	ret

000000000000049c <tjoin>:
{
 49c:	1101                	addi	sp,sp,-32
 49e:	ec06                	sd	ra,24(sp)
 4a0:	e822                	sd	s0,16(sp)
 4a2:	e426                	sd	s1,8(sp)
 4a4:	e04a                	sd	s2,0(sp)
 4a6:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 4a8:	00001797          	auipc	a5,0x1
 4ac:	d7878793          	addi	a5,a5,-648 # 1220 <threads>
 4b0:	00001697          	auipc	a3,0x1
 4b4:	df068693          	addi	a3,a3,-528 # 12a0 <base>
 4b8:	a021                	j	4c0 <tjoin+0x24>
 4ba:	07a1                	addi	a5,a5,8
 4bc:	02d78b63          	beq	a5,a3,4f2 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 4c0:	6384                	ld	s1,0(a5)
 4c2:	dce5                	beqz	s1,4ba <tjoin+0x1e>
 4c4:	0004c703          	lbu	a4,0(s1)
 4c8:	fea719e3          	bne	a4,a0,4ba <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 4cc:	5cb8                	lw	a4,120(s1)
 4ce:	4799                	li	a5,6
 4d0:	4919                	li	s2,6
 4d2:	02f70263          	beq	a4,a5,4f6 <tjoin+0x5a>
        tyield();
 4d6:	00000097          	auipc	ra,0x0
 4da:	fa2080e7          	jalr	-94(ra) # 478 <tyield>
    while (target_thread->state != EXITED) {
 4de:	5cbc                	lw	a5,120(s1)
 4e0:	ff279be3          	bne	a5,s2,4d6 <tjoin+0x3a>
    return 0;
 4e4:	4501                	li	a0,0
}
 4e6:	60e2                	ld	ra,24(sp)
 4e8:	6442                	ld	s0,16(sp)
 4ea:	64a2                	ld	s1,8(sp)
 4ec:	6902                	ld	s2,0(sp)
 4ee:	6105                	addi	sp,sp,32
 4f0:	8082                	ret
        return -1;
 4f2:	557d                	li	a0,-1
 4f4:	bfcd                	j	4e6 <tjoin+0x4a>
    return 0;
 4f6:	4501                	li	a0,0
 4f8:	b7fd                	j	4e6 <tjoin+0x4a>

00000000000004fa <twhoami>:

uint8 twhoami()
{
 4fa:	1141                	addi	sp,sp,-16
 4fc:	e422                	sd	s0,8(sp)
 4fe:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 500:	00001797          	auipc	a5,0x1
 504:	b107b783          	ld	a5,-1264(a5) # 1010 <current_thread>
 508:	0007c503          	lbu	a0,0(a5)
 50c:	6422                	ld	s0,8(sp)
 50e:	0141                	addi	sp,sp,16
 510:	8082                	ret

0000000000000512 <tswtch>:
 512:	00153023          	sd	ra,0(a0)
 516:	00253423          	sd	sp,8(a0)
 51a:	e900                	sd	s0,16(a0)
 51c:	ed04                	sd	s1,24(a0)
 51e:	03253023          	sd	s2,32(a0)
 522:	03353423          	sd	s3,40(a0)
 526:	03453823          	sd	s4,48(a0)
 52a:	03553c23          	sd	s5,56(a0)
 52e:	05653023          	sd	s6,64(a0)
 532:	05753423          	sd	s7,72(a0)
 536:	05853823          	sd	s8,80(a0)
 53a:	05953c23          	sd	s9,88(a0)
 53e:	07a53023          	sd	s10,96(a0)
 542:	07b53423          	sd	s11,104(a0)
 546:	0005b083          	ld	ra,0(a1)
 54a:	0085b103          	ld	sp,8(a1)
 54e:	6980                	ld	s0,16(a1)
 550:	6d84                	ld	s1,24(a1)
 552:	0205b903          	ld	s2,32(a1)
 556:	0285b983          	ld	s3,40(a1)
 55a:	0305ba03          	ld	s4,48(a1)
 55e:	0385ba83          	ld	s5,56(a1)
 562:	0405bb03          	ld	s6,64(a1)
 566:	0485bb83          	ld	s7,72(a1)
 56a:	0505bc03          	ld	s8,80(a1)
 56e:	0585bc83          	ld	s9,88(a1)
 572:	0605bd03          	ld	s10,96(a1)
 576:	0685bd83          	ld	s11,104(a1)
 57a:	8082                	ret

000000000000057c <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 57c:	1101                	addi	sp,sp,-32
 57e:	ec06                	sd	ra,24(sp)
 580:	e822                	sd	s0,16(sp)
 582:	e426                	sd	s1,8(sp)
 584:	e04a                	sd	s2,0(sp)
 586:	1000                	addi	s0,sp,32
 588:	84aa                	mv	s1,a0
 58a:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
 58c:	00000097          	auipc	ra,0x0
 590:	d1e080e7          	jalr	-738(ra) # 2aa <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 594:	85ca                	mv	a1,s2
 596:	8526                	mv	a0,s1
 598:	00000097          	auipc	ra,0x0
 59c:	b56080e7          	jalr	-1194(ra) # ee <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
 5a0:	00000097          	auipc	ra,0x0
 5a4:	274080e7          	jalr	628(ra) # 814 <exit>

00000000000005a8 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 5a8:	1141                	addi	sp,sp,-16
 5aa:	e422                	sd	s0,8(sp)
 5ac:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 5ae:	87aa                	mv	a5,a0
 5b0:	0585                	addi	a1,a1,1
 5b2:	0785                	addi	a5,a5,1
 5b4:	fff5c703          	lbu	a4,-1(a1)
 5b8:	fee78fa3          	sb	a4,-1(a5)
 5bc:	fb75                	bnez	a4,5b0 <strcpy+0x8>
        ;
    return os;
}
 5be:	6422                	ld	s0,8(sp)
 5c0:	0141                	addi	sp,sp,16
 5c2:	8082                	ret

00000000000005c4 <strcmp>:

int strcmp(const char *p, const char *q)
{
 5c4:	1141                	addi	sp,sp,-16
 5c6:	e422                	sd	s0,8(sp)
 5c8:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 5ca:	00054783          	lbu	a5,0(a0)
 5ce:	cb91                	beqz	a5,5e2 <strcmp+0x1e>
 5d0:	0005c703          	lbu	a4,0(a1)
 5d4:	00f71763          	bne	a4,a5,5e2 <strcmp+0x1e>
        p++, q++;
 5d8:	0505                	addi	a0,a0,1
 5da:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 5dc:	00054783          	lbu	a5,0(a0)
 5e0:	fbe5                	bnez	a5,5d0 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 5e2:	0005c503          	lbu	a0,0(a1)
}
 5e6:	40a7853b          	subw	a0,a5,a0
 5ea:	6422                	ld	s0,8(sp)
 5ec:	0141                	addi	sp,sp,16
 5ee:	8082                	ret

00000000000005f0 <strlen>:

uint strlen(const char *s)
{
 5f0:	1141                	addi	sp,sp,-16
 5f2:	e422                	sd	s0,8(sp)
 5f4:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 5f6:	00054783          	lbu	a5,0(a0)
 5fa:	cf91                	beqz	a5,616 <strlen+0x26>
 5fc:	0505                	addi	a0,a0,1
 5fe:	87aa                	mv	a5,a0
 600:	86be                	mv	a3,a5
 602:	0785                	addi	a5,a5,1
 604:	fff7c703          	lbu	a4,-1(a5)
 608:	ff65                	bnez	a4,600 <strlen+0x10>
 60a:	40a6853b          	subw	a0,a3,a0
 60e:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 610:	6422                	ld	s0,8(sp)
 612:	0141                	addi	sp,sp,16
 614:	8082                	ret
    for (n = 0; s[n]; n++)
 616:	4501                	li	a0,0
 618:	bfe5                	j	610 <strlen+0x20>

000000000000061a <memset>:

void *
memset(void *dst, int c, uint n)
{
 61a:	1141                	addi	sp,sp,-16
 61c:	e422                	sd	s0,8(sp)
 61e:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 620:	ca19                	beqz	a2,636 <memset+0x1c>
 622:	87aa                	mv	a5,a0
 624:	1602                	slli	a2,a2,0x20
 626:	9201                	srli	a2,a2,0x20
 628:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 62c:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 630:	0785                	addi	a5,a5,1
 632:	fee79de3          	bne	a5,a4,62c <memset+0x12>
    }
    return dst;
}
 636:	6422                	ld	s0,8(sp)
 638:	0141                	addi	sp,sp,16
 63a:	8082                	ret

000000000000063c <strchr>:

char *
strchr(const char *s, char c)
{
 63c:	1141                	addi	sp,sp,-16
 63e:	e422                	sd	s0,8(sp)
 640:	0800                	addi	s0,sp,16
    for (; *s; s++)
 642:	00054783          	lbu	a5,0(a0)
 646:	cb99                	beqz	a5,65c <strchr+0x20>
        if (*s == c)
 648:	00f58763          	beq	a1,a5,656 <strchr+0x1a>
    for (; *s; s++)
 64c:	0505                	addi	a0,a0,1
 64e:	00054783          	lbu	a5,0(a0)
 652:	fbfd                	bnez	a5,648 <strchr+0xc>
            return (char *)s;
    return 0;
 654:	4501                	li	a0,0
}
 656:	6422                	ld	s0,8(sp)
 658:	0141                	addi	sp,sp,16
 65a:	8082                	ret
    return 0;
 65c:	4501                	li	a0,0
 65e:	bfe5                	j	656 <strchr+0x1a>

0000000000000660 <gets>:

char *
gets(char *buf, int max)
{
 660:	711d                	addi	sp,sp,-96
 662:	ec86                	sd	ra,88(sp)
 664:	e8a2                	sd	s0,80(sp)
 666:	e4a6                	sd	s1,72(sp)
 668:	e0ca                	sd	s2,64(sp)
 66a:	fc4e                	sd	s3,56(sp)
 66c:	f852                	sd	s4,48(sp)
 66e:	f456                	sd	s5,40(sp)
 670:	f05a                	sd	s6,32(sp)
 672:	ec5e                	sd	s7,24(sp)
 674:	1080                	addi	s0,sp,96
 676:	8baa                	mv	s7,a0
 678:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 67a:	892a                	mv	s2,a0
 67c:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 67e:	4aa9                	li	s5,10
 680:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 682:	89a6                	mv	s3,s1
 684:	2485                	addiw	s1,s1,1
 686:	0344d863          	bge	s1,s4,6b6 <gets+0x56>
        cc = read(0, &c, 1);
 68a:	4605                	li	a2,1
 68c:	faf40593          	addi	a1,s0,-81
 690:	4501                	li	a0,0
 692:	00000097          	auipc	ra,0x0
 696:	19a080e7          	jalr	410(ra) # 82c <read>
        if (cc < 1)
 69a:	00a05e63          	blez	a0,6b6 <gets+0x56>
        buf[i++] = c;
 69e:	faf44783          	lbu	a5,-81(s0)
 6a2:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 6a6:	01578763          	beq	a5,s5,6b4 <gets+0x54>
 6aa:	0905                	addi	s2,s2,1
 6ac:	fd679be3          	bne	a5,s6,682 <gets+0x22>
    for (i = 0; i + 1 < max;)
 6b0:	89a6                	mv	s3,s1
 6b2:	a011                	j	6b6 <gets+0x56>
 6b4:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 6b6:	99de                	add	s3,s3,s7
 6b8:	00098023          	sb	zero,0(s3)
    return buf;
}
 6bc:	855e                	mv	a0,s7
 6be:	60e6                	ld	ra,88(sp)
 6c0:	6446                	ld	s0,80(sp)
 6c2:	64a6                	ld	s1,72(sp)
 6c4:	6906                	ld	s2,64(sp)
 6c6:	79e2                	ld	s3,56(sp)
 6c8:	7a42                	ld	s4,48(sp)
 6ca:	7aa2                	ld	s5,40(sp)
 6cc:	7b02                	ld	s6,32(sp)
 6ce:	6be2                	ld	s7,24(sp)
 6d0:	6125                	addi	sp,sp,96
 6d2:	8082                	ret

00000000000006d4 <stat>:

int stat(const char *n, struct stat *st)
{
 6d4:	1101                	addi	sp,sp,-32
 6d6:	ec06                	sd	ra,24(sp)
 6d8:	e822                	sd	s0,16(sp)
 6da:	e426                	sd	s1,8(sp)
 6dc:	e04a                	sd	s2,0(sp)
 6de:	1000                	addi	s0,sp,32
 6e0:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 6e2:	4581                	li	a1,0
 6e4:	00000097          	auipc	ra,0x0
 6e8:	170080e7          	jalr	368(ra) # 854 <open>
    if (fd < 0)
 6ec:	02054563          	bltz	a0,716 <stat+0x42>
 6f0:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 6f2:	85ca                	mv	a1,s2
 6f4:	00000097          	auipc	ra,0x0
 6f8:	178080e7          	jalr	376(ra) # 86c <fstat>
 6fc:	892a                	mv	s2,a0
    close(fd);
 6fe:	8526                	mv	a0,s1
 700:	00000097          	auipc	ra,0x0
 704:	13c080e7          	jalr	316(ra) # 83c <close>
    return r;
}
 708:	854a                	mv	a0,s2
 70a:	60e2                	ld	ra,24(sp)
 70c:	6442                	ld	s0,16(sp)
 70e:	64a2                	ld	s1,8(sp)
 710:	6902                	ld	s2,0(sp)
 712:	6105                	addi	sp,sp,32
 714:	8082                	ret
        return -1;
 716:	597d                	li	s2,-1
 718:	bfc5                	j	708 <stat+0x34>

000000000000071a <atoi>:

int atoi(const char *s)
{
 71a:	1141                	addi	sp,sp,-16
 71c:	e422                	sd	s0,8(sp)
 71e:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 720:	00054683          	lbu	a3,0(a0)
 724:	fd06879b          	addiw	a5,a3,-48
 728:	0ff7f793          	zext.b	a5,a5
 72c:	4625                	li	a2,9
 72e:	02f66863          	bltu	a2,a5,75e <atoi+0x44>
 732:	872a                	mv	a4,a0
    n = 0;
 734:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 736:	0705                	addi	a4,a4,1
 738:	0025179b          	slliw	a5,a0,0x2
 73c:	9fa9                	addw	a5,a5,a0
 73e:	0017979b          	slliw	a5,a5,0x1
 742:	9fb5                	addw	a5,a5,a3
 744:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 748:	00074683          	lbu	a3,0(a4)
 74c:	fd06879b          	addiw	a5,a3,-48
 750:	0ff7f793          	zext.b	a5,a5
 754:	fef671e3          	bgeu	a2,a5,736 <atoi+0x1c>
    return n;
}
 758:	6422                	ld	s0,8(sp)
 75a:	0141                	addi	sp,sp,16
 75c:	8082                	ret
    n = 0;
 75e:	4501                	li	a0,0
 760:	bfe5                	j	758 <atoi+0x3e>

0000000000000762 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 762:	1141                	addi	sp,sp,-16
 764:	e422                	sd	s0,8(sp)
 766:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 768:	02b57463          	bgeu	a0,a1,790 <memmove+0x2e>
    {
        while (n-- > 0)
 76c:	00c05f63          	blez	a2,78a <memmove+0x28>
 770:	1602                	slli	a2,a2,0x20
 772:	9201                	srli	a2,a2,0x20
 774:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 778:	872a                	mv	a4,a0
            *dst++ = *src++;
 77a:	0585                	addi	a1,a1,1
 77c:	0705                	addi	a4,a4,1
 77e:	fff5c683          	lbu	a3,-1(a1)
 782:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 786:	fee79ae3          	bne	a5,a4,77a <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 78a:	6422                	ld	s0,8(sp)
 78c:	0141                	addi	sp,sp,16
 78e:	8082                	ret
        dst += n;
 790:	00c50733          	add	a4,a0,a2
        src += n;
 794:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 796:	fec05ae3          	blez	a2,78a <memmove+0x28>
 79a:	fff6079b          	addiw	a5,a2,-1
 79e:	1782                	slli	a5,a5,0x20
 7a0:	9381                	srli	a5,a5,0x20
 7a2:	fff7c793          	not	a5,a5
 7a6:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 7a8:	15fd                	addi	a1,a1,-1
 7aa:	177d                	addi	a4,a4,-1
 7ac:	0005c683          	lbu	a3,0(a1)
 7b0:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 7b4:	fee79ae3          	bne	a5,a4,7a8 <memmove+0x46>
 7b8:	bfc9                	j	78a <memmove+0x28>

00000000000007ba <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 7ba:	1141                	addi	sp,sp,-16
 7bc:	e422                	sd	s0,8(sp)
 7be:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 7c0:	ca05                	beqz	a2,7f0 <memcmp+0x36>
 7c2:	fff6069b          	addiw	a3,a2,-1
 7c6:	1682                	slli	a3,a3,0x20
 7c8:	9281                	srli	a3,a3,0x20
 7ca:	0685                	addi	a3,a3,1
 7cc:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 7ce:	00054783          	lbu	a5,0(a0)
 7d2:	0005c703          	lbu	a4,0(a1)
 7d6:	00e79863          	bne	a5,a4,7e6 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 7da:	0505                	addi	a0,a0,1
        p2++;
 7dc:	0585                	addi	a1,a1,1
    while (n-- > 0)
 7de:	fed518e3          	bne	a0,a3,7ce <memcmp+0x14>
    }
    return 0;
 7e2:	4501                	li	a0,0
 7e4:	a019                	j	7ea <memcmp+0x30>
            return *p1 - *p2;
 7e6:	40e7853b          	subw	a0,a5,a4
}
 7ea:	6422                	ld	s0,8(sp)
 7ec:	0141                	addi	sp,sp,16
 7ee:	8082                	ret
    return 0;
 7f0:	4501                	li	a0,0
 7f2:	bfe5                	j	7ea <memcmp+0x30>

00000000000007f4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 7f4:	1141                	addi	sp,sp,-16
 7f6:	e406                	sd	ra,8(sp)
 7f8:	e022                	sd	s0,0(sp)
 7fa:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 7fc:	00000097          	auipc	ra,0x0
 800:	f66080e7          	jalr	-154(ra) # 762 <memmove>
}
 804:	60a2                	ld	ra,8(sp)
 806:	6402                	ld	s0,0(sp)
 808:	0141                	addi	sp,sp,16
 80a:	8082                	ret

000000000000080c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 80c:	4885                	li	a7,1
 ecall
 80e:	00000073          	ecall
 ret
 812:	8082                	ret

0000000000000814 <exit>:
.global exit
exit:
 li a7, SYS_exit
 814:	4889                	li	a7,2
 ecall
 816:	00000073          	ecall
 ret
 81a:	8082                	ret

000000000000081c <wait>:
.global wait
wait:
 li a7, SYS_wait
 81c:	488d                	li	a7,3
 ecall
 81e:	00000073          	ecall
 ret
 822:	8082                	ret

0000000000000824 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 824:	4891                	li	a7,4
 ecall
 826:	00000073          	ecall
 ret
 82a:	8082                	ret

000000000000082c <read>:
.global read
read:
 li a7, SYS_read
 82c:	4895                	li	a7,5
 ecall
 82e:	00000073          	ecall
 ret
 832:	8082                	ret

0000000000000834 <write>:
.global write
write:
 li a7, SYS_write
 834:	48c1                	li	a7,16
 ecall
 836:	00000073          	ecall
 ret
 83a:	8082                	ret

000000000000083c <close>:
.global close
close:
 li a7, SYS_close
 83c:	48d5                	li	a7,21
 ecall
 83e:	00000073          	ecall
 ret
 842:	8082                	ret

0000000000000844 <kill>:
.global kill
kill:
 li a7, SYS_kill
 844:	4899                	li	a7,6
 ecall
 846:	00000073          	ecall
 ret
 84a:	8082                	ret

000000000000084c <exec>:
.global exec
exec:
 li a7, SYS_exec
 84c:	489d                	li	a7,7
 ecall
 84e:	00000073          	ecall
 ret
 852:	8082                	ret

0000000000000854 <open>:
.global open
open:
 li a7, SYS_open
 854:	48bd                	li	a7,15
 ecall
 856:	00000073          	ecall
 ret
 85a:	8082                	ret

000000000000085c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 85c:	48c5                	li	a7,17
 ecall
 85e:	00000073          	ecall
 ret
 862:	8082                	ret

0000000000000864 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 864:	48c9                	li	a7,18
 ecall
 866:	00000073          	ecall
 ret
 86a:	8082                	ret

000000000000086c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 86c:	48a1                	li	a7,8
 ecall
 86e:	00000073          	ecall
 ret
 872:	8082                	ret

0000000000000874 <link>:
.global link
link:
 li a7, SYS_link
 874:	48cd                	li	a7,19
 ecall
 876:	00000073          	ecall
 ret
 87a:	8082                	ret

000000000000087c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 87c:	48d1                	li	a7,20
 ecall
 87e:	00000073          	ecall
 ret
 882:	8082                	ret

0000000000000884 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 884:	48a5                	li	a7,9
 ecall
 886:	00000073          	ecall
 ret
 88a:	8082                	ret

000000000000088c <dup>:
.global dup
dup:
 li a7, SYS_dup
 88c:	48a9                	li	a7,10
 ecall
 88e:	00000073          	ecall
 ret
 892:	8082                	ret

0000000000000894 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 894:	48ad                	li	a7,11
 ecall
 896:	00000073          	ecall
 ret
 89a:	8082                	ret

000000000000089c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 89c:	48b1                	li	a7,12
 ecall
 89e:	00000073          	ecall
 ret
 8a2:	8082                	ret

00000000000008a4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 8a4:	48b5                	li	a7,13
 ecall
 8a6:	00000073          	ecall
 ret
 8aa:	8082                	ret

00000000000008ac <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 8ac:	48b9                	li	a7,14
 ecall
 8ae:	00000073          	ecall
 ret
 8b2:	8082                	ret

00000000000008b4 <ps>:
.global ps
ps:
 li a7, SYS_ps
 8b4:	48d9                	li	a7,22
 ecall
 8b6:	00000073          	ecall
 ret
 8ba:	8082                	ret

00000000000008bc <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 8bc:	48dd                	li	a7,23
 ecall
 8be:	00000073          	ecall
 ret
 8c2:	8082                	ret

00000000000008c4 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 8c4:	48e1                	li	a7,24
 ecall
 8c6:	00000073          	ecall
 ret
 8ca:	8082                	ret

00000000000008cc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 8cc:	1101                	addi	sp,sp,-32
 8ce:	ec06                	sd	ra,24(sp)
 8d0:	e822                	sd	s0,16(sp)
 8d2:	1000                	addi	s0,sp,32
 8d4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 8d8:	4605                	li	a2,1
 8da:	fef40593          	addi	a1,s0,-17
 8de:	00000097          	auipc	ra,0x0
 8e2:	f56080e7          	jalr	-170(ra) # 834 <write>
}
 8e6:	60e2                	ld	ra,24(sp)
 8e8:	6442                	ld	s0,16(sp)
 8ea:	6105                	addi	sp,sp,32
 8ec:	8082                	ret

00000000000008ee <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 8ee:	7139                	addi	sp,sp,-64
 8f0:	fc06                	sd	ra,56(sp)
 8f2:	f822                	sd	s0,48(sp)
 8f4:	f426                	sd	s1,40(sp)
 8f6:	f04a                	sd	s2,32(sp)
 8f8:	ec4e                	sd	s3,24(sp)
 8fa:	0080                	addi	s0,sp,64
 8fc:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 8fe:	c299                	beqz	a3,904 <printint+0x16>
 900:	0805c963          	bltz	a1,992 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 904:	2581                	sext.w	a1,a1
  neg = 0;
 906:	4881                	li	a7,0
 908:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 90c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 90e:	2601                	sext.w	a2,a2
 910:	00000517          	auipc	a0,0x0
 914:	52850513          	addi	a0,a0,1320 # e38 <digits>
 918:	883a                	mv	a6,a4
 91a:	2705                	addiw	a4,a4,1
 91c:	02c5f7bb          	remuw	a5,a1,a2
 920:	1782                	slli	a5,a5,0x20
 922:	9381                	srli	a5,a5,0x20
 924:	97aa                	add	a5,a5,a0
 926:	0007c783          	lbu	a5,0(a5)
 92a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 92e:	0005879b          	sext.w	a5,a1
 932:	02c5d5bb          	divuw	a1,a1,a2
 936:	0685                	addi	a3,a3,1
 938:	fec7f0e3          	bgeu	a5,a2,918 <printint+0x2a>
  if(neg)
 93c:	00088c63          	beqz	a7,954 <printint+0x66>
    buf[i++] = '-';
 940:	fd070793          	addi	a5,a4,-48
 944:	00878733          	add	a4,a5,s0
 948:	02d00793          	li	a5,45
 94c:	fef70823          	sb	a5,-16(a4)
 950:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 954:	02e05863          	blez	a4,984 <printint+0x96>
 958:	fc040793          	addi	a5,s0,-64
 95c:	00e78933          	add	s2,a5,a4
 960:	fff78993          	addi	s3,a5,-1
 964:	99ba                	add	s3,s3,a4
 966:	377d                	addiw	a4,a4,-1
 968:	1702                	slli	a4,a4,0x20
 96a:	9301                	srli	a4,a4,0x20
 96c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 970:	fff94583          	lbu	a1,-1(s2)
 974:	8526                	mv	a0,s1
 976:	00000097          	auipc	ra,0x0
 97a:	f56080e7          	jalr	-170(ra) # 8cc <putc>
  while(--i >= 0)
 97e:	197d                	addi	s2,s2,-1
 980:	ff3918e3          	bne	s2,s3,970 <printint+0x82>
}
 984:	70e2                	ld	ra,56(sp)
 986:	7442                	ld	s0,48(sp)
 988:	74a2                	ld	s1,40(sp)
 98a:	7902                	ld	s2,32(sp)
 98c:	69e2                	ld	s3,24(sp)
 98e:	6121                	addi	sp,sp,64
 990:	8082                	ret
    x = -xx;
 992:	40b005bb          	negw	a1,a1
    neg = 1;
 996:	4885                	li	a7,1
    x = -xx;
 998:	bf85                	j	908 <printint+0x1a>

000000000000099a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 99a:	715d                	addi	sp,sp,-80
 99c:	e486                	sd	ra,72(sp)
 99e:	e0a2                	sd	s0,64(sp)
 9a0:	fc26                	sd	s1,56(sp)
 9a2:	f84a                	sd	s2,48(sp)
 9a4:	f44e                	sd	s3,40(sp)
 9a6:	f052                	sd	s4,32(sp)
 9a8:	ec56                	sd	s5,24(sp)
 9aa:	e85a                	sd	s6,16(sp)
 9ac:	e45e                	sd	s7,8(sp)
 9ae:	e062                	sd	s8,0(sp)
 9b0:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 9b2:	0005c903          	lbu	s2,0(a1)
 9b6:	18090c63          	beqz	s2,b4e <vprintf+0x1b4>
 9ba:	8aaa                	mv	s5,a0
 9bc:	8bb2                	mv	s7,a2
 9be:	00158493          	addi	s1,a1,1
  state = 0;
 9c2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 9c4:	02500a13          	li	s4,37
 9c8:	4b55                	li	s6,21
 9ca:	a839                	j	9e8 <vprintf+0x4e>
        putc(fd, c);
 9cc:	85ca                	mv	a1,s2
 9ce:	8556                	mv	a0,s5
 9d0:	00000097          	auipc	ra,0x0
 9d4:	efc080e7          	jalr	-260(ra) # 8cc <putc>
 9d8:	a019                	j	9de <vprintf+0x44>
    } else if(state == '%'){
 9da:	01498d63          	beq	s3,s4,9f4 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 9de:	0485                	addi	s1,s1,1
 9e0:	fff4c903          	lbu	s2,-1(s1)
 9e4:	16090563          	beqz	s2,b4e <vprintf+0x1b4>
    if(state == 0){
 9e8:	fe0999e3          	bnez	s3,9da <vprintf+0x40>
      if(c == '%'){
 9ec:	ff4910e3          	bne	s2,s4,9cc <vprintf+0x32>
        state = '%';
 9f0:	89d2                	mv	s3,s4
 9f2:	b7f5                	j	9de <vprintf+0x44>
      if(c == 'd'){
 9f4:	13490263          	beq	s2,s4,b18 <vprintf+0x17e>
 9f8:	f9d9079b          	addiw	a5,s2,-99
 9fc:	0ff7f793          	zext.b	a5,a5
 a00:	12fb6563          	bltu	s6,a5,b2a <vprintf+0x190>
 a04:	f9d9079b          	addiw	a5,s2,-99
 a08:	0ff7f713          	zext.b	a4,a5
 a0c:	10eb6f63          	bltu	s6,a4,b2a <vprintf+0x190>
 a10:	00271793          	slli	a5,a4,0x2
 a14:	00000717          	auipc	a4,0x0
 a18:	3cc70713          	addi	a4,a4,972 # de0 <malloc+0x194>
 a1c:	97ba                	add	a5,a5,a4
 a1e:	439c                	lw	a5,0(a5)
 a20:	97ba                	add	a5,a5,a4
 a22:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 a24:	008b8913          	addi	s2,s7,8
 a28:	4685                	li	a3,1
 a2a:	4629                	li	a2,10
 a2c:	000ba583          	lw	a1,0(s7)
 a30:	8556                	mv	a0,s5
 a32:	00000097          	auipc	ra,0x0
 a36:	ebc080e7          	jalr	-324(ra) # 8ee <printint>
 a3a:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 a3c:	4981                	li	s3,0
 a3e:	b745                	j	9de <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a40:	008b8913          	addi	s2,s7,8
 a44:	4681                	li	a3,0
 a46:	4629                	li	a2,10
 a48:	000ba583          	lw	a1,0(s7)
 a4c:	8556                	mv	a0,s5
 a4e:	00000097          	auipc	ra,0x0
 a52:	ea0080e7          	jalr	-352(ra) # 8ee <printint>
 a56:	8bca                	mv	s7,s2
      state = 0;
 a58:	4981                	li	s3,0
 a5a:	b751                	j	9de <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 a5c:	008b8913          	addi	s2,s7,8
 a60:	4681                	li	a3,0
 a62:	4641                	li	a2,16
 a64:	000ba583          	lw	a1,0(s7)
 a68:	8556                	mv	a0,s5
 a6a:	00000097          	auipc	ra,0x0
 a6e:	e84080e7          	jalr	-380(ra) # 8ee <printint>
 a72:	8bca                	mv	s7,s2
      state = 0;
 a74:	4981                	li	s3,0
 a76:	b7a5                	j	9de <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 a78:	008b8c13          	addi	s8,s7,8
 a7c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a80:	03000593          	li	a1,48
 a84:	8556                	mv	a0,s5
 a86:	00000097          	auipc	ra,0x0
 a8a:	e46080e7          	jalr	-442(ra) # 8cc <putc>
  putc(fd, 'x');
 a8e:	07800593          	li	a1,120
 a92:	8556                	mv	a0,s5
 a94:	00000097          	auipc	ra,0x0
 a98:	e38080e7          	jalr	-456(ra) # 8cc <putc>
 a9c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a9e:	00000b97          	auipc	s7,0x0
 aa2:	39ab8b93          	addi	s7,s7,922 # e38 <digits>
 aa6:	03c9d793          	srli	a5,s3,0x3c
 aaa:	97de                	add	a5,a5,s7
 aac:	0007c583          	lbu	a1,0(a5)
 ab0:	8556                	mv	a0,s5
 ab2:	00000097          	auipc	ra,0x0
 ab6:	e1a080e7          	jalr	-486(ra) # 8cc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 aba:	0992                	slli	s3,s3,0x4
 abc:	397d                	addiw	s2,s2,-1
 abe:	fe0914e3          	bnez	s2,aa6 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 ac2:	8be2                	mv	s7,s8
      state = 0;
 ac4:	4981                	li	s3,0
 ac6:	bf21                	j	9de <vprintf+0x44>
        s = va_arg(ap, char*);
 ac8:	008b8993          	addi	s3,s7,8
 acc:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 ad0:	02090163          	beqz	s2,af2 <vprintf+0x158>
        while(*s != 0){
 ad4:	00094583          	lbu	a1,0(s2)
 ad8:	c9a5                	beqz	a1,b48 <vprintf+0x1ae>
          putc(fd, *s);
 ada:	8556                	mv	a0,s5
 adc:	00000097          	auipc	ra,0x0
 ae0:	df0080e7          	jalr	-528(ra) # 8cc <putc>
          s++;
 ae4:	0905                	addi	s2,s2,1
        while(*s != 0){
 ae6:	00094583          	lbu	a1,0(s2)
 aea:	f9e5                	bnez	a1,ada <vprintf+0x140>
        s = va_arg(ap, char*);
 aec:	8bce                	mv	s7,s3
      state = 0;
 aee:	4981                	li	s3,0
 af0:	b5fd                	j	9de <vprintf+0x44>
          s = "(null)";
 af2:	00000917          	auipc	s2,0x0
 af6:	2e690913          	addi	s2,s2,742 # dd8 <malloc+0x18c>
        while(*s != 0){
 afa:	02800593          	li	a1,40
 afe:	bff1                	j	ada <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 b00:	008b8913          	addi	s2,s7,8
 b04:	000bc583          	lbu	a1,0(s7)
 b08:	8556                	mv	a0,s5
 b0a:	00000097          	auipc	ra,0x0
 b0e:	dc2080e7          	jalr	-574(ra) # 8cc <putc>
 b12:	8bca                	mv	s7,s2
      state = 0;
 b14:	4981                	li	s3,0
 b16:	b5e1                	j	9de <vprintf+0x44>
        putc(fd, c);
 b18:	02500593          	li	a1,37
 b1c:	8556                	mv	a0,s5
 b1e:	00000097          	auipc	ra,0x0
 b22:	dae080e7          	jalr	-594(ra) # 8cc <putc>
      state = 0;
 b26:	4981                	li	s3,0
 b28:	bd5d                	j	9de <vprintf+0x44>
        putc(fd, '%');
 b2a:	02500593          	li	a1,37
 b2e:	8556                	mv	a0,s5
 b30:	00000097          	auipc	ra,0x0
 b34:	d9c080e7          	jalr	-612(ra) # 8cc <putc>
        putc(fd, c);
 b38:	85ca                	mv	a1,s2
 b3a:	8556                	mv	a0,s5
 b3c:	00000097          	auipc	ra,0x0
 b40:	d90080e7          	jalr	-624(ra) # 8cc <putc>
      state = 0;
 b44:	4981                	li	s3,0
 b46:	bd61                	j	9de <vprintf+0x44>
        s = va_arg(ap, char*);
 b48:	8bce                	mv	s7,s3
      state = 0;
 b4a:	4981                	li	s3,0
 b4c:	bd49                	j	9de <vprintf+0x44>
    }
  }
}
 b4e:	60a6                	ld	ra,72(sp)
 b50:	6406                	ld	s0,64(sp)
 b52:	74e2                	ld	s1,56(sp)
 b54:	7942                	ld	s2,48(sp)
 b56:	79a2                	ld	s3,40(sp)
 b58:	7a02                	ld	s4,32(sp)
 b5a:	6ae2                	ld	s5,24(sp)
 b5c:	6b42                	ld	s6,16(sp)
 b5e:	6ba2                	ld	s7,8(sp)
 b60:	6c02                	ld	s8,0(sp)
 b62:	6161                	addi	sp,sp,80
 b64:	8082                	ret

0000000000000b66 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b66:	715d                	addi	sp,sp,-80
 b68:	ec06                	sd	ra,24(sp)
 b6a:	e822                	sd	s0,16(sp)
 b6c:	1000                	addi	s0,sp,32
 b6e:	e010                	sd	a2,0(s0)
 b70:	e414                	sd	a3,8(s0)
 b72:	e818                	sd	a4,16(s0)
 b74:	ec1c                	sd	a5,24(s0)
 b76:	03043023          	sd	a6,32(s0)
 b7a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b7e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b82:	8622                	mv	a2,s0
 b84:	00000097          	auipc	ra,0x0
 b88:	e16080e7          	jalr	-490(ra) # 99a <vprintf>
}
 b8c:	60e2                	ld	ra,24(sp)
 b8e:	6442                	ld	s0,16(sp)
 b90:	6161                	addi	sp,sp,80
 b92:	8082                	ret

0000000000000b94 <printf>:

void
printf(const char *fmt, ...)
{
 b94:	711d                	addi	sp,sp,-96
 b96:	ec06                	sd	ra,24(sp)
 b98:	e822                	sd	s0,16(sp)
 b9a:	1000                	addi	s0,sp,32
 b9c:	e40c                	sd	a1,8(s0)
 b9e:	e810                	sd	a2,16(s0)
 ba0:	ec14                	sd	a3,24(s0)
 ba2:	f018                	sd	a4,32(s0)
 ba4:	f41c                	sd	a5,40(s0)
 ba6:	03043823          	sd	a6,48(s0)
 baa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 bae:	00840613          	addi	a2,s0,8
 bb2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 bb6:	85aa                	mv	a1,a0
 bb8:	4505                	li	a0,1
 bba:	00000097          	auipc	ra,0x0
 bbe:	de0080e7          	jalr	-544(ra) # 99a <vprintf>
}
 bc2:	60e2                	ld	ra,24(sp)
 bc4:	6442                	ld	s0,16(sp)
 bc6:	6125                	addi	sp,sp,96
 bc8:	8082                	ret

0000000000000bca <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 bca:	1141                	addi	sp,sp,-16
 bcc:	e422                	sd	s0,8(sp)
 bce:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 bd0:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bd4:	00000797          	auipc	a5,0x0
 bd8:	4447b783          	ld	a5,1092(a5) # 1018 <freep>
 bdc:	a02d                	j	c06 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 bde:	4618                	lw	a4,8(a2)
 be0:	9f2d                	addw	a4,a4,a1
 be2:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 be6:	6398                	ld	a4,0(a5)
 be8:	6310                	ld	a2,0(a4)
 bea:	a83d                	j	c28 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 bec:	ff852703          	lw	a4,-8(a0)
 bf0:	9f31                	addw	a4,a4,a2
 bf2:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 bf4:	ff053683          	ld	a3,-16(a0)
 bf8:	a091                	j	c3c <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bfa:	6398                	ld	a4,0(a5)
 bfc:	00e7e463          	bltu	a5,a4,c04 <free+0x3a>
 c00:	00e6ea63          	bltu	a3,a4,c14 <free+0x4a>
{
 c04:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c06:	fed7fae3          	bgeu	a5,a3,bfa <free+0x30>
 c0a:	6398                	ld	a4,0(a5)
 c0c:	00e6e463          	bltu	a3,a4,c14 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c10:	fee7eae3          	bltu	a5,a4,c04 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 c14:	ff852583          	lw	a1,-8(a0)
 c18:	6390                	ld	a2,0(a5)
 c1a:	02059813          	slli	a6,a1,0x20
 c1e:	01c85713          	srli	a4,a6,0x1c
 c22:	9736                	add	a4,a4,a3
 c24:	fae60de3          	beq	a2,a4,bde <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 c28:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 c2c:	4790                	lw	a2,8(a5)
 c2e:	02061593          	slli	a1,a2,0x20
 c32:	01c5d713          	srli	a4,a1,0x1c
 c36:	973e                	add	a4,a4,a5
 c38:	fae68ae3          	beq	a3,a4,bec <free+0x22>
        p->s.ptr = bp->s.ptr;
 c3c:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 c3e:	00000717          	auipc	a4,0x0
 c42:	3cf73d23          	sd	a5,986(a4) # 1018 <freep>
}
 c46:	6422                	ld	s0,8(sp)
 c48:	0141                	addi	sp,sp,16
 c4a:	8082                	ret

0000000000000c4c <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 c4c:	7139                	addi	sp,sp,-64
 c4e:	fc06                	sd	ra,56(sp)
 c50:	f822                	sd	s0,48(sp)
 c52:	f426                	sd	s1,40(sp)
 c54:	f04a                	sd	s2,32(sp)
 c56:	ec4e                	sd	s3,24(sp)
 c58:	e852                	sd	s4,16(sp)
 c5a:	e456                	sd	s5,8(sp)
 c5c:	e05a                	sd	s6,0(sp)
 c5e:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 c60:	02051493          	slli	s1,a0,0x20
 c64:	9081                	srli	s1,s1,0x20
 c66:	04bd                	addi	s1,s1,15
 c68:	8091                	srli	s1,s1,0x4
 c6a:	0014899b          	addiw	s3,s1,1
 c6e:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 c70:	00000517          	auipc	a0,0x0
 c74:	3a853503          	ld	a0,936(a0) # 1018 <freep>
 c78:	c515                	beqz	a0,ca4 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c7a:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 c7c:	4798                	lw	a4,8(a5)
 c7e:	02977f63          	bgeu	a4,s1,cbc <malloc+0x70>
    if (nu < 4096)
 c82:	8a4e                	mv	s4,s3
 c84:	0009871b          	sext.w	a4,s3
 c88:	6685                	lui	a3,0x1
 c8a:	00d77363          	bgeu	a4,a3,c90 <malloc+0x44>
 c8e:	6a05                	lui	s4,0x1
 c90:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 c94:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 c98:	00000917          	auipc	s2,0x0
 c9c:	38090913          	addi	s2,s2,896 # 1018 <freep>
    if (p == (char *)-1)
 ca0:	5afd                	li	s5,-1
 ca2:	a895                	j	d16 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 ca4:	00000797          	auipc	a5,0x0
 ca8:	5fc78793          	addi	a5,a5,1532 # 12a0 <base>
 cac:	00000717          	auipc	a4,0x0
 cb0:	36f73623          	sd	a5,876(a4) # 1018 <freep>
 cb4:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 cb6:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 cba:	b7e1                	j	c82 <malloc+0x36>
            if (p->s.size == nunits)
 cbc:	02e48c63          	beq	s1,a4,cf4 <malloc+0xa8>
                p->s.size -= nunits;
 cc0:	4137073b          	subw	a4,a4,s3
 cc4:	c798                	sw	a4,8(a5)
                p += p->s.size;
 cc6:	02071693          	slli	a3,a4,0x20
 cca:	01c6d713          	srli	a4,a3,0x1c
 cce:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 cd0:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 cd4:	00000717          	auipc	a4,0x0
 cd8:	34a73223          	sd	a0,836(a4) # 1018 <freep>
            return (void *)(p + 1);
 cdc:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 ce0:	70e2                	ld	ra,56(sp)
 ce2:	7442                	ld	s0,48(sp)
 ce4:	74a2                	ld	s1,40(sp)
 ce6:	7902                	ld	s2,32(sp)
 ce8:	69e2                	ld	s3,24(sp)
 cea:	6a42                	ld	s4,16(sp)
 cec:	6aa2                	ld	s5,8(sp)
 cee:	6b02                	ld	s6,0(sp)
 cf0:	6121                	addi	sp,sp,64
 cf2:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 cf4:	6398                	ld	a4,0(a5)
 cf6:	e118                	sd	a4,0(a0)
 cf8:	bff1                	j	cd4 <malloc+0x88>
    hp->s.size = nu;
 cfa:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 cfe:	0541                	addi	a0,a0,16
 d00:	00000097          	auipc	ra,0x0
 d04:	eca080e7          	jalr	-310(ra) # bca <free>
    return freep;
 d08:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 d0c:	d971                	beqz	a0,ce0 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 d0e:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 d10:	4798                	lw	a4,8(a5)
 d12:	fa9775e3          	bgeu	a4,s1,cbc <malloc+0x70>
        if (p == freep)
 d16:	00093703          	ld	a4,0(s2)
 d1a:	853e                	mv	a0,a5
 d1c:	fef719e3          	bne	a4,a5,d0e <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 d20:	8552                	mv	a0,s4
 d22:	00000097          	auipc	ra,0x0
 d26:	b7a080e7          	jalr	-1158(ra) # 89c <sbrk>
    if (p == (char *)-1)
 d2a:	fd5518e3          	bne	a0,s5,cfa <malloc+0xae>
                return 0;
 d2e:	4501                	li	a0,0
 d30:	bf45                	j	ce0 <malloc+0x94>
