
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
  3c:	cb8a0a13          	addi	s4,s4,-840 # cf0 <malloc+0xe8>
        inword = 0;
  40:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  42:	a805                	j	72 <wc+0x72>
      if(strchr(" \r\t\n\v", buf[i]))
  44:	8552                	mv	a0,s4
  46:	00000097          	auipc	ra,0x0
  4a:	5b2080e7          	jalr	1458(ra) # 5f8 <strchr>
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
  80:	76c080e7          	jalr	1900(ra) # 7e8 <read>
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
  aa:	c6250513          	addi	a0,a0,-926 # d08 <malloc+0x100>
  ae:	00001097          	auipc	ra,0x1
  b2:	aa2080e7          	jalr	-1374(ra) # b50 <printf>
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
  d8:	c2450513          	addi	a0,a0,-988 # cf8 <malloc+0xf0>
  dc:	00001097          	auipc	ra,0x1
  e0:	a74080e7          	jalr	-1420(ra) # b50 <printf>
    exit(1);
  e4:	4505                	li	a0,1
  e6:	00000097          	auipc	ra,0x0
  ea:	6ea080e7          	jalr	1770(ra) # 7d0 <exit>

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
 120:	6f4080e7          	jalr	1780(ra) # 810 <open>
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
 13c:	6c0080e7          	jalr	1728(ra) # 7f8 <close>
  for(i = 1; i < argc; i++){
 140:	0921                	addi	s2,s2,8
 142:	fd391ae3          	bne	s2,s3,116 <main+0x28>
  }
  exit(0);
 146:	4501                	li	a0,0
 148:	00000097          	auipc	ra,0x0
 14c:	688080e7          	jalr	1672(ra) # 7d0 <exit>
    wc(0, "");
 150:	00001597          	auipc	a1,0x1
 154:	bc858593          	addi	a1,a1,-1080 # d18 <malloc+0x110>
 158:	4501                	li	a0,0
 15a:	00000097          	auipc	ra,0x0
 15e:	ea6080e7          	jalr	-346(ra) # 0 <wc>
    exit(0);
 162:	4501                	li	a0,0
 164:	00000097          	auipc	ra,0x0
 168:	66c080e7          	jalr	1644(ra) # 7d0 <exit>
      printf("wc: cannot open %s\n", argv[i]);
 16c:	00093583          	ld	a1,0(s2)
 170:	00001517          	auipc	a0,0x1
 174:	bb050513          	addi	a0,a0,-1104 # d20 <malloc+0x118>
 178:	00001097          	auipc	ra,0x1
 17c:	9d8080e7          	jalr	-1576(ra) # b50 <printf>
      exit(1);
 180:	4505                	li	a0,1
 182:	00000097          	auipc	ra,0x0
 186:	64e080e7          	jalr	1614(ra) # 7d0 <exit>

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
 1be:	2c4080e7          	jalr	708(ra) # 47e <twhoami>
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
 20a:	b3250513          	addi	a0,a0,-1230 # d38 <malloc+0x130>
 20e:	00001097          	auipc	ra,0x1
 212:	942080e7          	jalr	-1726(ra) # b50 <printf>
        exit(-1);
 216:	557d                	li	a0,-1
 218:	00000097          	auipc	ra,0x0
 21c:	5b8080e7          	jalr	1464(ra) # 7d0 <exit>
    {
        // give up the cpu for other threads
        tyield();
 220:	00000097          	auipc	ra,0x0
 224:	1dc080e7          	jalr	476(ra) # 3fc <tyield>
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
 23e:	244080e7          	jalr	580(ra) # 47e <twhoami>
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
 282:	17e080e7          	jalr	382(ra) # 3fc <tyield>
}
 286:	60e2                	ld	ra,24(sp)
 288:	6442                	ld	s0,16(sp)
 28a:	64a2                	ld	s1,8(sp)
 28c:	6105                	addi	sp,sp,32
 28e:	8082                	ret
        printf("releasing lock we are not holding");
 290:	00001517          	auipc	a0,0x1
 294:	ad050513          	addi	a0,a0,-1328 # d60 <malloc+0x158>
 298:	00001097          	auipc	ra,0x1
 29c:	8b8080e7          	jalr	-1864(ra) # b50 <printf>
        exit(-1);
 2a0:	557d                	li	a0,-1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	52e080e7          	jalr	1326(ra) # 7d0 <exit>

00000000000002aa <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 2aa:	00001517          	auipc	a0,0x1
 2ae:	d6653503          	ld	a0,-666(a0) # 1010 <current_thread>
 2b2:	00001717          	auipc	a4,0x1
 2b6:	f6e70713          	addi	a4,a4,-146 # 1220 <threads>
    for (int i = 0; i < 16; i++) {
 2ba:	4781                	li	a5,0
 2bc:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 2be:	6314                	ld	a3,0(a4)
 2c0:	00a68763          	beq	a3,a0,2ce <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 2c4:	2785                	addiw	a5,a5,1
 2c6:	0721                	addi	a4,a4,8
 2c8:	fec79be3          	bne	a5,a2,2be <tsched+0x14>
    int current_index = 0;
 2cc:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 2ce:	0017869b          	addiw	a3,a5,1
 2d2:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 2d6:	00001817          	auipc	a6,0x1
 2da:	f4a80813          	addi	a6,a6,-182 # 1220 <threads>
 2de:	488d                	li	a7,3
 2e0:	a021                	j	2e8 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 2e2:	2685                	addiw	a3,a3,1
 2e4:	04c68363          	beq	a3,a2,32a <tsched+0x80>
        int next_index = (current_index + i) % 16;
 2e8:	41f6d71b          	sraiw	a4,a3,0x1f
 2ec:	01c7571b          	srliw	a4,a4,0x1c
 2f0:	00d707bb          	addw	a5,a4,a3
 2f4:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 2f6:	9f99                	subw	a5,a5,a4
 2f8:	078e                	slli	a5,a5,0x3
 2fa:	97c2                	add	a5,a5,a6
 2fc:	638c                	ld	a1,0(a5)
 2fe:	d1f5                	beqz	a1,2e2 <tsched+0x38>
 300:	5dbc                	lw	a5,120(a1)
 302:	ff1790e3          	bne	a5,a7,2e2 <tsched+0x38>
{
 306:	1141                	addi	sp,sp,-16
 308:	e406                	sd	ra,8(sp)
 30a:	e022                	sd	s0,0(sp)
 30c:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 30e:	00001797          	auipc	a5,0x1
 312:	d0b7b123          	sd	a1,-766(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 316:	05a1                	addi	a1,a1,8
 318:	0521                	addi	a0,a0,8
 31a:	00000097          	auipc	ra,0x0
 31e:	17c080e7          	jalr	380(ra) # 496 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 322:	60a2                	ld	ra,8(sp)
 324:	6402                	ld	s0,0(sp)
 326:	0141                	addi	sp,sp,16
 328:	8082                	ret
 32a:	8082                	ret

000000000000032c <thread_wrapper>:
{
 32c:	1101                	addi	sp,sp,-32
 32e:	ec06                	sd	ra,24(sp)
 330:	e822                	sd	s0,16(sp)
 332:	e426                	sd	s1,8(sp)
 334:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
 336:	00001497          	auipc	s1,0x1
 33a:	cda48493          	addi	s1,s1,-806 # 1010 <current_thread>
 33e:	609c                	ld	a5,0(s1)
 340:	67d8                	ld	a4,136(a5)
 342:	63c8                	ld	a0,128(a5)
 344:	9702                	jalr	a4
    current_thread->state = EXITED;
 346:	609c                	ld	a5,0(s1)
 348:	4719                	li	a4,6
 34a:	dfb8                	sw	a4,120(a5)
    tsched();
 34c:	00000097          	auipc	ra,0x0
 350:	f5e080e7          	jalr	-162(ra) # 2aa <tsched>
}
 354:	60e2                	ld	ra,24(sp)
 356:	6442                	ld	s0,16(sp)
 358:	64a2                	ld	s1,8(sp)
 35a:	6105                	addi	sp,sp,32
 35c:	8082                	ret

000000000000035e <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 35e:	7179                	addi	sp,sp,-48
 360:	f406                	sd	ra,40(sp)
 362:	f022                	sd	s0,32(sp)
 364:	ec26                	sd	s1,24(sp)
 366:	e84a                	sd	s2,16(sp)
 368:	e44e                	sd	s3,8(sp)
 36a:	1800                	addi	s0,sp,48
 36c:	84aa                	mv	s1,a0
 36e:	89b2                	mv	s3,a2
 370:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 372:	09800513          	li	a0,152
 376:	00001097          	auipc	ra,0x1
 37a:	892080e7          	jalr	-1902(ra) # c08 <malloc>
 37e:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 380:	478d                	li	a5,3
 382:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 384:	609c                	ld	a5,0(s1)
 386:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 38a:	609c                	ld	a5,0(s1)
 38c:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
 390:	6098                	ld	a4,0(s1)
 392:	00001797          	auipc	a5,0x1
 396:	c6e78793          	addi	a5,a5,-914 # 1000 <next_tid>
 39a:	4394                	lw	a3,0(a5)
 39c:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 3a0:	4398                	lw	a4,0(a5)
 3a2:	2705                	addiw	a4,a4,1
 3a4:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
 3a6:	6505                	lui	a0,0x1
 3a8:	00001097          	auipc	ra,0x1
 3ac:	860080e7          	jalr	-1952(ra) # c08 <malloc>
 3b0:	609c                	ld	a5,0(s1)
 3b2:	6705                	lui	a4,0x1
 3b4:	953a                	add	a0,a0,a4
 3b6:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 3b8:	609c                	ld	a5,0(s1)
 3ba:	00000717          	auipc	a4,0x0
 3be:	f7270713          	addi	a4,a4,-142 # 32c <thread_wrapper>
 3c2:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 3c4:	00001717          	auipc	a4,0x1
 3c8:	e5c70713          	addi	a4,a4,-420 # 1220 <threads>
 3cc:	4781                	li	a5,0
 3ce:	4641                	li	a2,16
        if (threads[i] == NULL) {
 3d0:	6314                	ld	a3,0(a4)
 3d2:	ce81                	beqz	a3,3ea <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
 3d4:	2785                	addiw	a5,a5,1
 3d6:	0721                	addi	a4,a4,8
 3d8:	fec79ce3          	bne	a5,a2,3d0 <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
 3dc:	70a2                	ld	ra,40(sp)
 3de:	7402                	ld	s0,32(sp)
 3e0:	64e2                	ld	s1,24(sp)
 3e2:	6942                	ld	s2,16(sp)
 3e4:	69a2                	ld	s3,8(sp)
 3e6:	6145                	addi	sp,sp,48
 3e8:	8082                	ret
            threads[i] = *thread;
 3ea:	6094                	ld	a3,0(s1)
 3ec:	078e                	slli	a5,a5,0x3
 3ee:	00001717          	auipc	a4,0x1
 3f2:	e3270713          	addi	a4,a4,-462 # 1220 <threads>
 3f6:	97ba                	add	a5,a5,a4
 3f8:	e394                	sd	a3,0(a5)
            break;
 3fa:	b7cd                	j	3dc <tcreate+0x7e>

00000000000003fc <tyield>:
    return 0;
}


void tyield()
{
 3fc:	1141                	addi	sp,sp,-16
 3fe:	e406                	sd	ra,8(sp)
 400:	e022                	sd	s0,0(sp)
 402:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 404:	00001797          	auipc	a5,0x1
 408:	c0c7b783          	ld	a5,-1012(a5) # 1010 <current_thread>
 40c:	470d                	li	a4,3
 40e:	dfb8                	sw	a4,120(a5)
    tsched();
 410:	00000097          	auipc	ra,0x0
 414:	e9a080e7          	jalr	-358(ra) # 2aa <tsched>
}
 418:	60a2                	ld	ra,8(sp)
 41a:	6402                	ld	s0,0(sp)
 41c:	0141                	addi	sp,sp,16
 41e:	8082                	ret

0000000000000420 <tjoin>:
{
 420:	1101                	addi	sp,sp,-32
 422:	ec06                	sd	ra,24(sp)
 424:	e822                	sd	s0,16(sp)
 426:	e426                	sd	s1,8(sp)
 428:	e04a                	sd	s2,0(sp)
 42a:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 42c:	00001797          	auipc	a5,0x1
 430:	df478793          	addi	a5,a5,-524 # 1220 <threads>
 434:	00001697          	auipc	a3,0x1
 438:	e6c68693          	addi	a3,a3,-404 # 12a0 <base>
 43c:	a021                	j	444 <tjoin+0x24>
 43e:	07a1                	addi	a5,a5,8
 440:	02d78b63          	beq	a5,a3,476 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 444:	6384                	ld	s1,0(a5)
 446:	dce5                	beqz	s1,43e <tjoin+0x1e>
 448:	0004c703          	lbu	a4,0(s1)
 44c:	fea719e3          	bne	a4,a0,43e <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 450:	5cb8                	lw	a4,120(s1)
 452:	4799                	li	a5,6
 454:	4919                	li	s2,6
 456:	02f70263          	beq	a4,a5,47a <tjoin+0x5a>
        tyield();
 45a:	00000097          	auipc	ra,0x0
 45e:	fa2080e7          	jalr	-94(ra) # 3fc <tyield>
    while (target_thread->state != EXITED) {
 462:	5cbc                	lw	a5,120(s1)
 464:	ff279be3          	bne	a5,s2,45a <tjoin+0x3a>
    return 0;
 468:	4501                	li	a0,0
}
 46a:	60e2                	ld	ra,24(sp)
 46c:	6442                	ld	s0,16(sp)
 46e:	64a2                	ld	s1,8(sp)
 470:	6902                	ld	s2,0(sp)
 472:	6105                	addi	sp,sp,32
 474:	8082                	ret
        return -1;
 476:	557d                	li	a0,-1
 478:	bfcd                	j	46a <tjoin+0x4a>
    return 0;
 47a:	4501                	li	a0,0
 47c:	b7fd                	j	46a <tjoin+0x4a>

000000000000047e <twhoami>:

uint8 twhoami()
{
 47e:	1141                	addi	sp,sp,-16
 480:	e422                	sd	s0,8(sp)
 482:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 484:	00001797          	auipc	a5,0x1
 488:	b8c7b783          	ld	a5,-1140(a5) # 1010 <current_thread>
 48c:	0007c503          	lbu	a0,0(a5)
 490:	6422                	ld	s0,8(sp)
 492:	0141                	addi	sp,sp,16
 494:	8082                	ret

0000000000000496 <tswtch>:
 496:	00153023          	sd	ra,0(a0) # 1000 <next_tid>
 49a:	00253423          	sd	sp,8(a0)
 49e:	e900                	sd	s0,16(a0)
 4a0:	ed04                	sd	s1,24(a0)
 4a2:	03253023          	sd	s2,32(a0)
 4a6:	03353423          	sd	s3,40(a0)
 4aa:	03453823          	sd	s4,48(a0)
 4ae:	03553c23          	sd	s5,56(a0)
 4b2:	05653023          	sd	s6,64(a0)
 4b6:	05753423          	sd	s7,72(a0)
 4ba:	05853823          	sd	s8,80(a0)
 4be:	05953c23          	sd	s9,88(a0)
 4c2:	07a53023          	sd	s10,96(a0)
 4c6:	07b53423          	sd	s11,104(a0)
 4ca:	0005b083          	ld	ra,0(a1)
 4ce:	0085b103          	ld	sp,8(a1)
 4d2:	6980                	ld	s0,16(a1)
 4d4:	6d84                	ld	s1,24(a1)
 4d6:	0205b903          	ld	s2,32(a1)
 4da:	0285b983          	ld	s3,40(a1)
 4de:	0305ba03          	ld	s4,48(a1)
 4e2:	0385ba83          	ld	s5,56(a1)
 4e6:	0405bb03          	ld	s6,64(a1)
 4ea:	0485bb83          	ld	s7,72(a1)
 4ee:	0505bc03          	ld	s8,80(a1)
 4f2:	0585bc83          	ld	s9,88(a1)
 4f6:	0605bd03          	ld	s10,96(a1)
 4fa:	0685bd83          	ld	s11,104(a1)
 4fe:	8082                	ret

0000000000000500 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 500:	1101                	addi	sp,sp,-32
 502:	ec06                	sd	ra,24(sp)
 504:	e822                	sd	s0,16(sp)
 506:	e426                	sd	s1,8(sp)
 508:	e04a                	sd	s2,0(sp)
 50a:	1000                	addi	s0,sp,32
 50c:	84aa                	mv	s1,a0
 50e:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 510:	09800513          	li	a0,152
 514:	00000097          	auipc	ra,0x0
 518:	6f4080e7          	jalr	1780(ra) # c08 <malloc>

    main_thread->tid = 1;
 51c:	4785                	li	a5,1
 51e:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
 522:	4791                	li	a5,4
 524:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 526:	00001797          	auipc	a5,0x1
 52a:	aea7b523          	sd	a0,-1302(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 52e:	00001797          	auipc	a5,0x1
 532:	cf278793          	addi	a5,a5,-782 # 1220 <threads>
 536:	00001717          	auipc	a4,0x1
 53a:	d6a70713          	addi	a4,a4,-662 # 12a0 <base>
        threads[i] = NULL;
 53e:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 542:	07a1                	addi	a5,a5,8
 544:	fee79de3          	bne	a5,a4,53e <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 548:	00001797          	auipc	a5,0x1
 54c:	cca7bc23          	sd	a0,-808(a5) # 1220 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 550:	85ca                	mv	a1,s2
 552:	8526                	mv	a0,s1
 554:	00000097          	auipc	ra,0x0
 558:	b9a080e7          	jalr	-1126(ra) # ee <main>
    //tsched();

    exit(res);
 55c:	00000097          	auipc	ra,0x0
 560:	274080e7          	jalr	628(ra) # 7d0 <exit>

0000000000000564 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 564:	1141                	addi	sp,sp,-16
 566:	e422                	sd	s0,8(sp)
 568:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 56a:	87aa                	mv	a5,a0
 56c:	0585                	addi	a1,a1,1
 56e:	0785                	addi	a5,a5,1
 570:	fff5c703          	lbu	a4,-1(a1)
 574:	fee78fa3          	sb	a4,-1(a5)
 578:	fb75                	bnez	a4,56c <strcpy+0x8>
        ;
    return os;
}
 57a:	6422                	ld	s0,8(sp)
 57c:	0141                	addi	sp,sp,16
 57e:	8082                	ret

0000000000000580 <strcmp>:

int strcmp(const char *p, const char *q)
{
 580:	1141                	addi	sp,sp,-16
 582:	e422                	sd	s0,8(sp)
 584:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 586:	00054783          	lbu	a5,0(a0)
 58a:	cb91                	beqz	a5,59e <strcmp+0x1e>
 58c:	0005c703          	lbu	a4,0(a1)
 590:	00f71763          	bne	a4,a5,59e <strcmp+0x1e>
        p++, q++;
 594:	0505                	addi	a0,a0,1
 596:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 598:	00054783          	lbu	a5,0(a0)
 59c:	fbe5                	bnez	a5,58c <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 59e:	0005c503          	lbu	a0,0(a1)
}
 5a2:	40a7853b          	subw	a0,a5,a0
 5a6:	6422                	ld	s0,8(sp)
 5a8:	0141                	addi	sp,sp,16
 5aa:	8082                	ret

00000000000005ac <strlen>:

uint strlen(const char *s)
{
 5ac:	1141                	addi	sp,sp,-16
 5ae:	e422                	sd	s0,8(sp)
 5b0:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 5b2:	00054783          	lbu	a5,0(a0)
 5b6:	cf91                	beqz	a5,5d2 <strlen+0x26>
 5b8:	0505                	addi	a0,a0,1
 5ba:	87aa                	mv	a5,a0
 5bc:	86be                	mv	a3,a5
 5be:	0785                	addi	a5,a5,1
 5c0:	fff7c703          	lbu	a4,-1(a5)
 5c4:	ff65                	bnez	a4,5bc <strlen+0x10>
 5c6:	40a6853b          	subw	a0,a3,a0
 5ca:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 5cc:	6422                	ld	s0,8(sp)
 5ce:	0141                	addi	sp,sp,16
 5d0:	8082                	ret
    for (n = 0; s[n]; n++)
 5d2:	4501                	li	a0,0
 5d4:	bfe5                	j	5cc <strlen+0x20>

00000000000005d6 <memset>:

void *
memset(void *dst, int c, uint n)
{
 5d6:	1141                	addi	sp,sp,-16
 5d8:	e422                	sd	s0,8(sp)
 5da:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 5dc:	ca19                	beqz	a2,5f2 <memset+0x1c>
 5de:	87aa                	mv	a5,a0
 5e0:	1602                	slli	a2,a2,0x20
 5e2:	9201                	srli	a2,a2,0x20
 5e4:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 5e8:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 5ec:	0785                	addi	a5,a5,1
 5ee:	fee79de3          	bne	a5,a4,5e8 <memset+0x12>
    }
    return dst;
}
 5f2:	6422                	ld	s0,8(sp)
 5f4:	0141                	addi	sp,sp,16
 5f6:	8082                	ret

00000000000005f8 <strchr>:

char *
strchr(const char *s, char c)
{
 5f8:	1141                	addi	sp,sp,-16
 5fa:	e422                	sd	s0,8(sp)
 5fc:	0800                	addi	s0,sp,16
    for (; *s; s++)
 5fe:	00054783          	lbu	a5,0(a0)
 602:	cb99                	beqz	a5,618 <strchr+0x20>
        if (*s == c)
 604:	00f58763          	beq	a1,a5,612 <strchr+0x1a>
    for (; *s; s++)
 608:	0505                	addi	a0,a0,1
 60a:	00054783          	lbu	a5,0(a0)
 60e:	fbfd                	bnez	a5,604 <strchr+0xc>
            return (char *)s;
    return 0;
 610:	4501                	li	a0,0
}
 612:	6422                	ld	s0,8(sp)
 614:	0141                	addi	sp,sp,16
 616:	8082                	ret
    return 0;
 618:	4501                	li	a0,0
 61a:	bfe5                	j	612 <strchr+0x1a>

000000000000061c <gets>:

char *
gets(char *buf, int max)
{
 61c:	711d                	addi	sp,sp,-96
 61e:	ec86                	sd	ra,88(sp)
 620:	e8a2                	sd	s0,80(sp)
 622:	e4a6                	sd	s1,72(sp)
 624:	e0ca                	sd	s2,64(sp)
 626:	fc4e                	sd	s3,56(sp)
 628:	f852                	sd	s4,48(sp)
 62a:	f456                	sd	s5,40(sp)
 62c:	f05a                	sd	s6,32(sp)
 62e:	ec5e                	sd	s7,24(sp)
 630:	1080                	addi	s0,sp,96
 632:	8baa                	mv	s7,a0
 634:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 636:	892a                	mv	s2,a0
 638:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 63a:	4aa9                	li	s5,10
 63c:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 63e:	89a6                	mv	s3,s1
 640:	2485                	addiw	s1,s1,1
 642:	0344d863          	bge	s1,s4,672 <gets+0x56>
        cc = read(0, &c, 1);
 646:	4605                	li	a2,1
 648:	faf40593          	addi	a1,s0,-81
 64c:	4501                	li	a0,0
 64e:	00000097          	auipc	ra,0x0
 652:	19a080e7          	jalr	410(ra) # 7e8 <read>
        if (cc < 1)
 656:	00a05e63          	blez	a0,672 <gets+0x56>
        buf[i++] = c;
 65a:	faf44783          	lbu	a5,-81(s0)
 65e:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 662:	01578763          	beq	a5,s5,670 <gets+0x54>
 666:	0905                	addi	s2,s2,1
 668:	fd679be3          	bne	a5,s6,63e <gets+0x22>
    for (i = 0; i + 1 < max;)
 66c:	89a6                	mv	s3,s1
 66e:	a011                	j	672 <gets+0x56>
 670:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 672:	99de                	add	s3,s3,s7
 674:	00098023          	sb	zero,0(s3)
    return buf;
}
 678:	855e                	mv	a0,s7
 67a:	60e6                	ld	ra,88(sp)
 67c:	6446                	ld	s0,80(sp)
 67e:	64a6                	ld	s1,72(sp)
 680:	6906                	ld	s2,64(sp)
 682:	79e2                	ld	s3,56(sp)
 684:	7a42                	ld	s4,48(sp)
 686:	7aa2                	ld	s5,40(sp)
 688:	7b02                	ld	s6,32(sp)
 68a:	6be2                	ld	s7,24(sp)
 68c:	6125                	addi	sp,sp,96
 68e:	8082                	ret

0000000000000690 <stat>:

int stat(const char *n, struct stat *st)
{
 690:	1101                	addi	sp,sp,-32
 692:	ec06                	sd	ra,24(sp)
 694:	e822                	sd	s0,16(sp)
 696:	e426                	sd	s1,8(sp)
 698:	e04a                	sd	s2,0(sp)
 69a:	1000                	addi	s0,sp,32
 69c:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 69e:	4581                	li	a1,0
 6a0:	00000097          	auipc	ra,0x0
 6a4:	170080e7          	jalr	368(ra) # 810 <open>
    if (fd < 0)
 6a8:	02054563          	bltz	a0,6d2 <stat+0x42>
 6ac:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 6ae:	85ca                	mv	a1,s2
 6b0:	00000097          	auipc	ra,0x0
 6b4:	178080e7          	jalr	376(ra) # 828 <fstat>
 6b8:	892a                	mv	s2,a0
    close(fd);
 6ba:	8526                	mv	a0,s1
 6bc:	00000097          	auipc	ra,0x0
 6c0:	13c080e7          	jalr	316(ra) # 7f8 <close>
    return r;
}
 6c4:	854a                	mv	a0,s2
 6c6:	60e2                	ld	ra,24(sp)
 6c8:	6442                	ld	s0,16(sp)
 6ca:	64a2                	ld	s1,8(sp)
 6cc:	6902                	ld	s2,0(sp)
 6ce:	6105                	addi	sp,sp,32
 6d0:	8082                	ret
        return -1;
 6d2:	597d                	li	s2,-1
 6d4:	bfc5                	j	6c4 <stat+0x34>

00000000000006d6 <atoi>:

int atoi(const char *s)
{
 6d6:	1141                	addi	sp,sp,-16
 6d8:	e422                	sd	s0,8(sp)
 6da:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 6dc:	00054683          	lbu	a3,0(a0)
 6e0:	fd06879b          	addiw	a5,a3,-48
 6e4:	0ff7f793          	zext.b	a5,a5
 6e8:	4625                	li	a2,9
 6ea:	02f66863          	bltu	a2,a5,71a <atoi+0x44>
 6ee:	872a                	mv	a4,a0
    n = 0;
 6f0:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 6f2:	0705                	addi	a4,a4,1
 6f4:	0025179b          	slliw	a5,a0,0x2
 6f8:	9fa9                	addw	a5,a5,a0
 6fa:	0017979b          	slliw	a5,a5,0x1
 6fe:	9fb5                	addw	a5,a5,a3
 700:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 704:	00074683          	lbu	a3,0(a4)
 708:	fd06879b          	addiw	a5,a3,-48
 70c:	0ff7f793          	zext.b	a5,a5
 710:	fef671e3          	bgeu	a2,a5,6f2 <atoi+0x1c>
    return n;
}
 714:	6422                	ld	s0,8(sp)
 716:	0141                	addi	sp,sp,16
 718:	8082                	ret
    n = 0;
 71a:	4501                	li	a0,0
 71c:	bfe5                	j	714 <atoi+0x3e>

000000000000071e <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 71e:	1141                	addi	sp,sp,-16
 720:	e422                	sd	s0,8(sp)
 722:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 724:	02b57463          	bgeu	a0,a1,74c <memmove+0x2e>
    {
        while (n-- > 0)
 728:	00c05f63          	blez	a2,746 <memmove+0x28>
 72c:	1602                	slli	a2,a2,0x20
 72e:	9201                	srli	a2,a2,0x20
 730:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 734:	872a                	mv	a4,a0
            *dst++ = *src++;
 736:	0585                	addi	a1,a1,1
 738:	0705                	addi	a4,a4,1
 73a:	fff5c683          	lbu	a3,-1(a1)
 73e:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 742:	fee79ae3          	bne	a5,a4,736 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 746:	6422                	ld	s0,8(sp)
 748:	0141                	addi	sp,sp,16
 74a:	8082                	ret
        dst += n;
 74c:	00c50733          	add	a4,a0,a2
        src += n;
 750:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 752:	fec05ae3          	blez	a2,746 <memmove+0x28>
 756:	fff6079b          	addiw	a5,a2,-1
 75a:	1782                	slli	a5,a5,0x20
 75c:	9381                	srli	a5,a5,0x20
 75e:	fff7c793          	not	a5,a5
 762:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 764:	15fd                	addi	a1,a1,-1
 766:	177d                	addi	a4,a4,-1
 768:	0005c683          	lbu	a3,0(a1)
 76c:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 770:	fee79ae3          	bne	a5,a4,764 <memmove+0x46>
 774:	bfc9                	j	746 <memmove+0x28>

0000000000000776 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 776:	1141                	addi	sp,sp,-16
 778:	e422                	sd	s0,8(sp)
 77a:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 77c:	ca05                	beqz	a2,7ac <memcmp+0x36>
 77e:	fff6069b          	addiw	a3,a2,-1
 782:	1682                	slli	a3,a3,0x20
 784:	9281                	srli	a3,a3,0x20
 786:	0685                	addi	a3,a3,1
 788:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 78a:	00054783          	lbu	a5,0(a0)
 78e:	0005c703          	lbu	a4,0(a1)
 792:	00e79863          	bne	a5,a4,7a2 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 796:	0505                	addi	a0,a0,1
        p2++;
 798:	0585                	addi	a1,a1,1
    while (n-- > 0)
 79a:	fed518e3          	bne	a0,a3,78a <memcmp+0x14>
    }
    return 0;
 79e:	4501                	li	a0,0
 7a0:	a019                	j	7a6 <memcmp+0x30>
            return *p1 - *p2;
 7a2:	40e7853b          	subw	a0,a5,a4
}
 7a6:	6422                	ld	s0,8(sp)
 7a8:	0141                	addi	sp,sp,16
 7aa:	8082                	ret
    return 0;
 7ac:	4501                	li	a0,0
 7ae:	bfe5                	j	7a6 <memcmp+0x30>

00000000000007b0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 7b0:	1141                	addi	sp,sp,-16
 7b2:	e406                	sd	ra,8(sp)
 7b4:	e022                	sd	s0,0(sp)
 7b6:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 7b8:	00000097          	auipc	ra,0x0
 7bc:	f66080e7          	jalr	-154(ra) # 71e <memmove>
}
 7c0:	60a2                	ld	ra,8(sp)
 7c2:	6402                	ld	s0,0(sp)
 7c4:	0141                	addi	sp,sp,16
 7c6:	8082                	ret

00000000000007c8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 7c8:	4885                	li	a7,1
 ecall
 7ca:	00000073          	ecall
 ret
 7ce:	8082                	ret

00000000000007d0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 7d0:	4889                	li	a7,2
 ecall
 7d2:	00000073          	ecall
 ret
 7d6:	8082                	ret

00000000000007d8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 7d8:	488d                	li	a7,3
 ecall
 7da:	00000073          	ecall
 ret
 7de:	8082                	ret

00000000000007e0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 7e0:	4891                	li	a7,4
 ecall
 7e2:	00000073          	ecall
 ret
 7e6:	8082                	ret

00000000000007e8 <read>:
.global read
read:
 li a7, SYS_read
 7e8:	4895                	li	a7,5
 ecall
 7ea:	00000073          	ecall
 ret
 7ee:	8082                	ret

00000000000007f0 <write>:
.global write
write:
 li a7, SYS_write
 7f0:	48c1                	li	a7,16
 ecall
 7f2:	00000073          	ecall
 ret
 7f6:	8082                	ret

00000000000007f8 <close>:
.global close
close:
 li a7, SYS_close
 7f8:	48d5                	li	a7,21
 ecall
 7fa:	00000073          	ecall
 ret
 7fe:	8082                	ret

0000000000000800 <kill>:
.global kill
kill:
 li a7, SYS_kill
 800:	4899                	li	a7,6
 ecall
 802:	00000073          	ecall
 ret
 806:	8082                	ret

0000000000000808 <exec>:
.global exec
exec:
 li a7, SYS_exec
 808:	489d                	li	a7,7
 ecall
 80a:	00000073          	ecall
 ret
 80e:	8082                	ret

0000000000000810 <open>:
.global open
open:
 li a7, SYS_open
 810:	48bd                	li	a7,15
 ecall
 812:	00000073          	ecall
 ret
 816:	8082                	ret

0000000000000818 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 818:	48c5                	li	a7,17
 ecall
 81a:	00000073          	ecall
 ret
 81e:	8082                	ret

0000000000000820 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 820:	48c9                	li	a7,18
 ecall
 822:	00000073          	ecall
 ret
 826:	8082                	ret

0000000000000828 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 828:	48a1                	li	a7,8
 ecall
 82a:	00000073          	ecall
 ret
 82e:	8082                	ret

0000000000000830 <link>:
.global link
link:
 li a7, SYS_link
 830:	48cd                	li	a7,19
 ecall
 832:	00000073          	ecall
 ret
 836:	8082                	ret

0000000000000838 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 838:	48d1                	li	a7,20
 ecall
 83a:	00000073          	ecall
 ret
 83e:	8082                	ret

0000000000000840 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 840:	48a5                	li	a7,9
 ecall
 842:	00000073          	ecall
 ret
 846:	8082                	ret

0000000000000848 <dup>:
.global dup
dup:
 li a7, SYS_dup
 848:	48a9                	li	a7,10
 ecall
 84a:	00000073          	ecall
 ret
 84e:	8082                	ret

0000000000000850 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 850:	48ad                	li	a7,11
 ecall
 852:	00000073          	ecall
 ret
 856:	8082                	ret

0000000000000858 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 858:	48b1                	li	a7,12
 ecall
 85a:	00000073          	ecall
 ret
 85e:	8082                	ret

0000000000000860 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 860:	48b5                	li	a7,13
 ecall
 862:	00000073          	ecall
 ret
 866:	8082                	ret

0000000000000868 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 868:	48b9                	li	a7,14
 ecall
 86a:	00000073          	ecall
 ret
 86e:	8082                	ret

0000000000000870 <ps>:
.global ps
ps:
 li a7, SYS_ps
 870:	48d9                	li	a7,22
 ecall
 872:	00000073          	ecall
 ret
 876:	8082                	ret

0000000000000878 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 878:	48dd                	li	a7,23
 ecall
 87a:	00000073          	ecall
 ret
 87e:	8082                	ret

0000000000000880 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 880:	48e1                	li	a7,24
 ecall
 882:	00000073          	ecall
 ret
 886:	8082                	ret

0000000000000888 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 888:	1101                	addi	sp,sp,-32
 88a:	ec06                	sd	ra,24(sp)
 88c:	e822                	sd	s0,16(sp)
 88e:	1000                	addi	s0,sp,32
 890:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 894:	4605                	li	a2,1
 896:	fef40593          	addi	a1,s0,-17
 89a:	00000097          	auipc	ra,0x0
 89e:	f56080e7          	jalr	-170(ra) # 7f0 <write>
}
 8a2:	60e2                	ld	ra,24(sp)
 8a4:	6442                	ld	s0,16(sp)
 8a6:	6105                	addi	sp,sp,32
 8a8:	8082                	ret

00000000000008aa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 8aa:	7139                	addi	sp,sp,-64
 8ac:	fc06                	sd	ra,56(sp)
 8ae:	f822                	sd	s0,48(sp)
 8b0:	f426                	sd	s1,40(sp)
 8b2:	f04a                	sd	s2,32(sp)
 8b4:	ec4e                	sd	s3,24(sp)
 8b6:	0080                	addi	s0,sp,64
 8b8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 8ba:	c299                	beqz	a3,8c0 <printint+0x16>
 8bc:	0805c963          	bltz	a1,94e <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 8c0:	2581                	sext.w	a1,a1
  neg = 0;
 8c2:	4881                	li	a7,0
 8c4:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 8c8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 8ca:	2601                	sext.w	a2,a2
 8cc:	00000517          	auipc	a0,0x0
 8d0:	51c50513          	addi	a0,a0,1308 # de8 <digits>
 8d4:	883a                	mv	a6,a4
 8d6:	2705                	addiw	a4,a4,1
 8d8:	02c5f7bb          	remuw	a5,a1,a2
 8dc:	1782                	slli	a5,a5,0x20
 8de:	9381                	srli	a5,a5,0x20
 8e0:	97aa                	add	a5,a5,a0
 8e2:	0007c783          	lbu	a5,0(a5)
 8e6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 8ea:	0005879b          	sext.w	a5,a1
 8ee:	02c5d5bb          	divuw	a1,a1,a2
 8f2:	0685                	addi	a3,a3,1
 8f4:	fec7f0e3          	bgeu	a5,a2,8d4 <printint+0x2a>
  if(neg)
 8f8:	00088c63          	beqz	a7,910 <printint+0x66>
    buf[i++] = '-';
 8fc:	fd070793          	addi	a5,a4,-48
 900:	00878733          	add	a4,a5,s0
 904:	02d00793          	li	a5,45
 908:	fef70823          	sb	a5,-16(a4)
 90c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 910:	02e05863          	blez	a4,940 <printint+0x96>
 914:	fc040793          	addi	a5,s0,-64
 918:	00e78933          	add	s2,a5,a4
 91c:	fff78993          	addi	s3,a5,-1
 920:	99ba                	add	s3,s3,a4
 922:	377d                	addiw	a4,a4,-1
 924:	1702                	slli	a4,a4,0x20
 926:	9301                	srli	a4,a4,0x20
 928:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 92c:	fff94583          	lbu	a1,-1(s2)
 930:	8526                	mv	a0,s1
 932:	00000097          	auipc	ra,0x0
 936:	f56080e7          	jalr	-170(ra) # 888 <putc>
  while(--i >= 0)
 93a:	197d                	addi	s2,s2,-1
 93c:	ff3918e3          	bne	s2,s3,92c <printint+0x82>
}
 940:	70e2                	ld	ra,56(sp)
 942:	7442                	ld	s0,48(sp)
 944:	74a2                	ld	s1,40(sp)
 946:	7902                	ld	s2,32(sp)
 948:	69e2                	ld	s3,24(sp)
 94a:	6121                	addi	sp,sp,64
 94c:	8082                	ret
    x = -xx;
 94e:	40b005bb          	negw	a1,a1
    neg = 1;
 952:	4885                	li	a7,1
    x = -xx;
 954:	bf85                	j	8c4 <printint+0x1a>

0000000000000956 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 956:	715d                	addi	sp,sp,-80
 958:	e486                	sd	ra,72(sp)
 95a:	e0a2                	sd	s0,64(sp)
 95c:	fc26                	sd	s1,56(sp)
 95e:	f84a                	sd	s2,48(sp)
 960:	f44e                	sd	s3,40(sp)
 962:	f052                	sd	s4,32(sp)
 964:	ec56                	sd	s5,24(sp)
 966:	e85a                	sd	s6,16(sp)
 968:	e45e                	sd	s7,8(sp)
 96a:	e062                	sd	s8,0(sp)
 96c:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 96e:	0005c903          	lbu	s2,0(a1)
 972:	18090c63          	beqz	s2,b0a <vprintf+0x1b4>
 976:	8aaa                	mv	s5,a0
 978:	8bb2                	mv	s7,a2
 97a:	00158493          	addi	s1,a1,1
  state = 0;
 97e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 980:	02500a13          	li	s4,37
 984:	4b55                	li	s6,21
 986:	a839                	j	9a4 <vprintf+0x4e>
        putc(fd, c);
 988:	85ca                	mv	a1,s2
 98a:	8556                	mv	a0,s5
 98c:	00000097          	auipc	ra,0x0
 990:	efc080e7          	jalr	-260(ra) # 888 <putc>
 994:	a019                	j	99a <vprintf+0x44>
    } else if(state == '%'){
 996:	01498d63          	beq	s3,s4,9b0 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 99a:	0485                	addi	s1,s1,1
 99c:	fff4c903          	lbu	s2,-1(s1)
 9a0:	16090563          	beqz	s2,b0a <vprintf+0x1b4>
    if(state == 0){
 9a4:	fe0999e3          	bnez	s3,996 <vprintf+0x40>
      if(c == '%'){
 9a8:	ff4910e3          	bne	s2,s4,988 <vprintf+0x32>
        state = '%';
 9ac:	89d2                	mv	s3,s4
 9ae:	b7f5                	j	99a <vprintf+0x44>
      if(c == 'd'){
 9b0:	13490263          	beq	s2,s4,ad4 <vprintf+0x17e>
 9b4:	f9d9079b          	addiw	a5,s2,-99
 9b8:	0ff7f793          	zext.b	a5,a5
 9bc:	12fb6563          	bltu	s6,a5,ae6 <vprintf+0x190>
 9c0:	f9d9079b          	addiw	a5,s2,-99
 9c4:	0ff7f713          	zext.b	a4,a5
 9c8:	10eb6f63          	bltu	s6,a4,ae6 <vprintf+0x190>
 9cc:	00271793          	slli	a5,a4,0x2
 9d0:	00000717          	auipc	a4,0x0
 9d4:	3c070713          	addi	a4,a4,960 # d90 <malloc+0x188>
 9d8:	97ba                	add	a5,a5,a4
 9da:	439c                	lw	a5,0(a5)
 9dc:	97ba                	add	a5,a5,a4
 9de:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 9e0:	008b8913          	addi	s2,s7,8
 9e4:	4685                	li	a3,1
 9e6:	4629                	li	a2,10
 9e8:	000ba583          	lw	a1,0(s7)
 9ec:	8556                	mv	a0,s5
 9ee:	00000097          	auipc	ra,0x0
 9f2:	ebc080e7          	jalr	-324(ra) # 8aa <printint>
 9f6:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9f8:	4981                	li	s3,0
 9fa:	b745                	j	99a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9fc:	008b8913          	addi	s2,s7,8
 a00:	4681                	li	a3,0
 a02:	4629                	li	a2,10
 a04:	000ba583          	lw	a1,0(s7)
 a08:	8556                	mv	a0,s5
 a0a:	00000097          	auipc	ra,0x0
 a0e:	ea0080e7          	jalr	-352(ra) # 8aa <printint>
 a12:	8bca                	mv	s7,s2
      state = 0;
 a14:	4981                	li	s3,0
 a16:	b751                	j	99a <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 a18:	008b8913          	addi	s2,s7,8
 a1c:	4681                	li	a3,0
 a1e:	4641                	li	a2,16
 a20:	000ba583          	lw	a1,0(s7)
 a24:	8556                	mv	a0,s5
 a26:	00000097          	auipc	ra,0x0
 a2a:	e84080e7          	jalr	-380(ra) # 8aa <printint>
 a2e:	8bca                	mv	s7,s2
      state = 0;
 a30:	4981                	li	s3,0
 a32:	b7a5                	j	99a <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 a34:	008b8c13          	addi	s8,s7,8
 a38:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a3c:	03000593          	li	a1,48
 a40:	8556                	mv	a0,s5
 a42:	00000097          	auipc	ra,0x0
 a46:	e46080e7          	jalr	-442(ra) # 888 <putc>
  putc(fd, 'x');
 a4a:	07800593          	li	a1,120
 a4e:	8556                	mv	a0,s5
 a50:	00000097          	auipc	ra,0x0
 a54:	e38080e7          	jalr	-456(ra) # 888 <putc>
 a58:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a5a:	00000b97          	auipc	s7,0x0
 a5e:	38eb8b93          	addi	s7,s7,910 # de8 <digits>
 a62:	03c9d793          	srli	a5,s3,0x3c
 a66:	97de                	add	a5,a5,s7
 a68:	0007c583          	lbu	a1,0(a5)
 a6c:	8556                	mv	a0,s5
 a6e:	00000097          	auipc	ra,0x0
 a72:	e1a080e7          	jalr	-486(ra) # 888 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a76:	0992                	slli	s3,s3,0x4
 a78:	397d                	addiw	s2,s2,-1
 a7a:	fe0914e3          	bnez	s2,a62 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 a7e:	8be2                	mv	s7,s8
      state = 0;
 a80:	4981                	li	s3,0
 a82:	bf21                	j	99a <vprintf+0x44>
        s = va_arg(ap, char*);
 a84:	008b8993          	addi	s3,s7,8
 a88:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a8c:	02090163          	beqz	s2,aae <vprintf+0x158>
        while(*s != 0){
 a90:	00094583          	lbu	a1,0(s2)
 a94:	c9a5                	beqz	a1,b04 <vprintf+0x1ae>
          putc(fd, *s);
 a96:	8556                	mv	a0,s5
 a98:	00000097          	auipc	ra,0x0
 a9c:	df0080e7          	jalr	-528(ra) # 888 <putc>
          s++;
 aa0:	0905                	addi	s2,s2,1
        while(*s != 0){
 aa2:	00094583          	lbu	a1,0(s2)
 aa6:	f9e5                	bnez	a1,a96 <vprintf+0x140>
        s = va_arg(ap, char*);
 aa8:	8bce                	mv	s7,s3
      state = 0;
 aaa:	4981                	li	s3,0
 aac:	b5fd                	j	99a <vprintf+0x44>
          s = "(null)";
 aae:	00000917          	auipc	s2,0x0
 ab2:	2da90913          	addi	s2,s2,730 # d88 <malloc+0x180>
        while(*s != 0){
 ab6:	02800593          	li	a1,40
 aba:	bff1                	j	a96 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 abc:	008b8913          	addi	s2,s7,8
 ac0:	000bc583          	lbu	a1,0(s7)
 ac4:	8556                	mv	a0,s5
 ac6:	00000097          	auipc	ra,0x0
 aca:	dc2080e7          	jalr	-574(ra) # 888 <putc>
 ace:	8bca                	mv	s7,s2
      state = 0;
 ad0:	4981                	li	s3,0
 ad2:	b5e1                	j	99a <vprintf+0x44>
        putc(fd, c);
 ad4:	02500593          	li	a1,37
 ad8:	8556                	mv	a0,s5
 ada:	00000097          	auipc	ra,0x0
 ade:	dae080e7          	jalr	-594(ra) # 888 <putc>
      state = 0;
 ae2:	4981                	li	s3,0
 ae4:	bd5d                	j	99a <vprintf+0x44>
        putc(fd, '%');
 ae6:	02500593          	li	a1,37
 aea:	8556                	mv	a0,s5
 aec:	00000097          	auipc	ra,0x0
 af0:	d9c080e7          	jalr	-612(ra) # 888 <putc>
        putc(fd, c);
 af4:	85ca                	mv	a1,s2
 af6:	8556                	mv	a0,s5
 af8:	00000097          	auipc	ra,0x0
 afc:	d90080e7          	jalr	-624(ra) # 888 <putc>
      state = 0;
 b00:	4981                	li	s3,0
 b02:	bd61                	j	99a <vprintf+0x44>
        s = va_arg(ap, char*);
 b04:	8bce                	mv	s7,s3
      state = 0;
 b06:	4981                	li	s3,0
 b08:	bd49                	j	99a <vprintf+0x44>
    }
  }
}
 b0a:	60a6                	ld	ra,72(sp)
 b0c:	6406                	ld	s0,64(sp)
 b0e:	74e2                	ld	s1,56(sp)
 b10:	7942                	ld	s2,48(sp)
 b12:	79a2                	ld	s3,40(sp)
 b14:	7a02                	ld	s4,32(sp)
 b16:	6ae2                	ld	s5,24(sp)
 b18:	6b42                	ld	s6,16(sp)
 b1a:	6ba2                	ld	s7,8(sp)
 b1c:	6c02                	ld	s8,0(sp)
 b1e:	6161                	addi	sp,sp,80
 b20:	8082                	ret

0000000000000b22 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b22:	715d                	addi	sp,sp,-80
 b24:	ec06                	sd	ra,24(sp)
 b26:	e822                	sd	s0,16(sp)
 b28:	1000                	addi	s0,sp,32
 b2a:	e010                	sd	a2,0(s0)
 b2c:	e414                	sd	a3,8(s0)
 b2e:	e818                	sd	a4,16(s0)
 b30:	ec1c                	sd	a5,24(s0)
 b32:	03043023          	sd	a6,32(s0)
 b36:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b3a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b3e:	8622                	mv	a2,s0
 b40:	00000097          	auipc	ra,0x0
 b44:	e16080e7          	jalr	-490(ra) # 956 <vprintf>
}
 b48:	60e2                	ld	ra,24(sp)
 b4a:	6442                	ld	s0,16(sp)
 b4c:	6161                	addi	sp,sp,80
 b4e:	8082                	ret

0000000000000b50 <printf>:

void
printf(const char *fmt, ...)
{
 b50:	711d                	addi	sp,sp,-96
 b52:	ec06                	sd	ra,24(sp)
 b54:	e822                	sd	s0,16(sp)
 b56:	1000                	addi	s0,sp,32
 b58:	e40c                	sd	a1,8(s0)
 b5a:	e810                	sd	a2,16(s0)
 b5c:	ec14                	sd	a3,24(s0)
 b5e:	f018                	sd	a4,32(s0)
 b60:	f41c                	sd	a5,40(s0)
 b62:	03043823          	sd	a6,48(s0)
 b66:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b6a:	00840613          	addi	a2,s0,8
 b6e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b72:	85aa                	mv	a1,a0
 b74:	4505                	li	a0,1
 b76:	00000097          	auipc	ra,0x0
 b7a:	de0080e7          	jalr	-544(ra) # 956 <vprintf>
}
 b7e:	60e2                	ld	ra,24(sp)
 b80:	6442                	ld	s0,16(sp)
 b82:	6125                	addi	sp,sp,96
 b84:	8082                	ret

0000000000000b86 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 b86:	1141                	addi	sp,sp,-16
 b88:	e422                	sd	s0,8(sp)
 b8a:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 b8c:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b90:	00000797          	auipc	a5,0x0
 b94:	4887b783          	ld	a5,1160(a5) # 1018 <freep>
 b98:	a02d                	j	bc2 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 b9a:	4618                	lw	a4,8(a2)
 b9c:	9f2d                	addw	a4,a4,a1
 b9e:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 ba2:	6398                	ld	a4,0(a5)
 ba4:	6310                	ld	a2,0(a4)
 ba6:	a83d                	j	be4 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 ba8:	ff852703          	lw	a4,-8(a0)
 bac:	9f31                	addw	a4,a4,a2
 bae:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 bb0:	ff053683          	ld	a3,-16(a0)
 bb4:	a091                	j	bf8 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bb6:	6398                	ld	a4,0(a5)
 bb8:	00e7e463          	bltu	a5,a4,bc0 <free+0x3a>
 bbc:	00e6ea63          	bltu	a3,a4,bd0 <free+0x4a>
{
 bc0:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bc2:	fed7fae3          	bgeu	a5,a3,bb6 <free+0x30>
 bc6:	6398                	ld	a4,0(a5)
 bc8:	00e6e463          	bltu	a3,a4,bd0 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bcc:	fee7eae3          	bltu	a5,a4,bc0 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 bd0:	ff852583          	lw	a1,-8(a0)
 bd4:	6390                	ld	a2,0(a5)
 bd6:	02059813          	slli	a6,a1,0x20
 bda:	01c85713          	srli	a4,a6,0x1c
 bde:	9736                	add	a4,a4,a3
 be0:	fae60de3          	beq	a2,a4,b9a <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 be4:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 be8:	4790                	lw	a2,8(a5)
 bea:	02061593          	slli	a1,a2,0x20
 bee:	01c5d713          	srli	a4,a1,0x1c
 bf2:	973e                	add	a4,a4,a5
 bf4:	fae68ae3          	beq	a3,a4,ba8 <free+0x22>
        p->s.ptr = bp->s.ptr;
 bf8:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 bfa:	00000717          	auipc	a4,0x0
 bfe:	40f73f23          	sd	a5,1054(a4) # 1018 <freep>
}
 c02:	6422                	ld	s0,8(sp)
 c04:	0141                	addi	sp,sp,16
 c06:	8082                	ret

0000000000000c08 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 c08:	7139                	addi	sp,sp,-64
 c0a:	fc06                	sd	ra,56(sp)
 c0c:	f822                	sd	s0,48(sp)
 c0e:	f426                	sd	s1,40(sp)
 c10:	f04a                	sd	s2,32(sp)
 c12:	ec4e                	sd	s3,24(sp)
 c14:	e852                	sd	s4,16(sp)
 c16:	e456                	sd	s5,8(sp)
 c18:	e05a                	sd	s6,0(sp)
 c1a:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 c1c:	02051493          	slli	s1,a0,0x20
 c20:	9081                	srli	s1,s1,0x20
 c22:	04bd                	addi	s1,s1,15
 c24:	8091                	srli	s1,s1,0x4
 c26:	0014899b          	addiw	s3,s1,1
 c2a:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 c2c:	00000517          	auipc	a0,0x0
 c30:	3ec53503          	ld	a0,1004(a0) # 1018 <freep>
 c34:	c515                	beqz	a0,c60 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c36:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 c38:	4798                	lw	a4,8(a5)
 c3a:	02977f63          	bgeu	a4,s1,c78 <malloc+0x70>
    if (nu < 4096)
 c3e:	8a4e                	mv	s4,s3
 c40:	0009871b          	sext.w	a4,s3
 c44:	6685                	lui	a3,0x1
 c46:	00d77363          	bgeu	a4,a3,c4c <malloc+0x44>
 c4a:	6a05                	lui	s4,0x1
 c4c:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 c50:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 c54:	00000917          	auipc	s2,0x0
 c58:	3c490913          	addi	s2,s2,964 # 1018 <freep>
    if (p == (char *)-1)
 c5c:	5afd                	li	s5,-1
 c5e:	a895                	j	cd2 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 c60:	00000797          	auipc	a5,0x0
 c64:	64078793          	addi	a5,a5,1600 # 12a0 <base>
 c68:	00000717          	auipc	a4,0x0
 c6c:	3af73823          	sd	a5,944(a4) # 1018 <freep>
 c70:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 c72:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 c76:	b7e1                	j	c3e <malloc+0x36>
            if (p->s.size == nunits)
 c78:	02e48c63          	beq	s1,a4,cb0 <malloc+0xa8>
                p->s.size -= nunits;
 c7c:	4137073b          	subw	a4,a4,s3
 c80:	c798                	sw	a4,8(a5)
                p += p->s.size;
 c82:	02071693          	slli	a3,a4,0x20
 c86:	01c6d713          	srli	a4,a3,0x1c
 c8a:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 c8c:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 c90:	00000717          	auipc	a4,0x0
 c94:	38a73423          	sd	a0,904(a4) # 1018 <freep>
            return (void *)(p + 1);
 c98:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 c9c:	70e2                	ld	ra,56(sp)
 c9e:	7442                	ld	s0,48(sp)
 ca0:	74a2                	ld	s1,40(sp)
 ca2:	7902                	ld	s2,32(sp)
 ca4:	69e2                	ld	s3,24(sp)
 ca6:	6a42                	ld	s4,16(sp)
 ca8:	6aa2                	ld	s5,8(sp)
 caa:	6b02                	ld	s6,0(sp)
 cac:	6121                	addi	sp,sp,64
 cae:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 cb0:	6398                	ld	a4,0(a5)
 cb2:	e118                	sd	a4,0(a0)
 cb4:	bff1                	j	c90 <malloc+0x88>
    hp->s.size = nu;
 cb6:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 cba:	0541                	addi	a0,a0,16
 cbc:	00000097          	auipc	ra,0x0
 cc0:	eca080e7          	jalr	-310(ra) # b86 <free>
    return freep;
 cc4:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 cc8:	d971                	beqz	a0,c9c <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 cca:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 ccc:	4798                	lw	a4,8(a5)
 cce:	fa9775e3          	bgeu	a4,s1,c78 <malloc+0x70>
        if (p == freep)
 cd2:	00093703          	ld	a4,0(s2)
 cd6:	853e                	mv	a0,a5
 cd8:	fef719e3          	bne	a4,a5,cca <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 cdc:	8552                	mv	a0,s4
 cde:	00000097          	auipc	ra,0x0
 ce2:	b7a080e7          	jalr	-1158(ra) # 858 <sbrk>
    if (p == (char *)-1)
 ce6:	fd5518e3          	bne	a0,s5,cb6 <malloc+0xae>
                return 0;
 cea:	4501                	li	a0,0
 cec:	bf45                	j	c9c <malloc+0x94>
