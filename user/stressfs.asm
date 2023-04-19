
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dd010113          	addi	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	21213823          	sd	s2,528(sp)
  14:	1c00                	addi	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	c8a78793          	addi	a5,a5,-886 # ca0 <malloc+0x116>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	c4450513          	addi	a0,a0,-956 # c70 <malloc+0xe6>
  34:	00001097          	auipc	ra,0x1
  38:	a9e080e7          	jalr	-1378(ra) # ad2 <printf>
  memset(data, 'a', sizeof(data));
  3c:	20000613          	li	a2,512
  40:	06100593          	li	a1,97
  44:	dd040513          	addi	a0,s0,-560
  48:	00000097          	auipc	ra,0x0
  4c:	510080e7          	jalr	1296(ra) # 558 <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	00000097          	auipc	ra,0x0
  58:	6f6080e7          	jalr	1782(ra) # 74a <fork>
  5c:	00a04563          	bgtz	a0,66 <main+0x66>
  for(i = 0; i < 4; i++)
  60:	2485                	addiw	s1,s1,1
  62:	ff2499e3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  66:	85a6                	mv	a1,s1
  68:	00001517          	auipc	a0,0x1
  6c:	c2050513          	addi	a0,a0,-992 # c88 <malloc+0xfe>
  70:	00001097          	auipc	ra,0x1
  74:	a62080e7          	jalr	-1438(ra) # ad2 <printf>

  path[8] += i;
  78:	fd844783          	lbu	a5,-40(s0)
  7c:	9fa5                	addw	a5,a5,s1
  7e:	fcf40c23          	sb	a5,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  82:	20200593          	li	a1,514
  86:	fd040513          	addi	a0,s0,-48
  8a:	00000097          	auipc	ra,0x0
  8e:	708080e7          	jalr	1800(ra) # 792 <open>
  92:	892a                	mv	s2,a0
  94:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  96:	20000613          	li	a2,512
  9a:	dd040593          	addi	a1,s0,-560
  9e:	854a                	mv	a0,s2
  a0:	00000097          	auipc	ra,0x0
  a4:	6d2080e7          	jalr	1746(ra) # 772 <write>
  for(i = 0; i < 20; i++)
  a8:	34fd                	addiw	s1,s1,-1
  aa:	f4f5                	bnez	s1,96 <main+0x96>
  close(fd);
  ac:	854a                	mv	a0,s2
  ae:	00000097          	auipc	ra,0x0
  b2:	6cc080e7          	jalr	1740(ra) # 77a <close>

  printf("read\n");
  b6:	00001517          	auipc	a0,0x1
  ba:	be250513          	addi	a0,a0,-1054 # c98 <malloc+0x10e>
  be:	00001097          	auipc	ra,0x1
  c2:	a14080e7          	jalr	-1516(ra) # ad2 <printf>

  fd = open(path, O_RDONLY);
  c6:	4581                	li	a1,0
  c8:	fd040513          	addi	a0,s0,-48
  cc:	00000097          	auipc	ra,0x0
  d0:	6c6080e7          	jalr	1734(ra) # 792 <open>
  d4:	892a                	mv	s2,a0
  d6:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  d8:	20000613          	li	a2,512
  dc:	dd040593          	addi	a1,s0,-560
  e0:	854a                	mv	a0,s2
  e2:	00000097          	auipc	ra,0x0
  e6:	688080e7          	jalr	1672(ra) # 76a <read>
  for (i = 0; i < 20; i++)
  ea:	34fd                	addiw	s1,s1,-1
  ec:	f4f5                	bnez	s1,d8 <main+0xd8>
  close(fd);
  ee:	854a                	mv	a0,s2
  f0:	00000097          	auipc	ra,0x0
  f4:	68a080e7          	jalr	1674(ra) # 77a <close>

  wait(0);
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	660080e7          	jalr	1632(ra) # 75a <wait>

  exit(0);
 102:	4501                	li	a0,0
 104:	00000097          	auipc	ra,0x0
 108:	64e080e7          	jalr	1614(ra) # 752 <exit>

000000000000010c <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
 10c:	1141                	addi	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	addi	s0,sp,16
    lk->name = name;
 112:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
 114:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
 118:	57fd                	li	a5,-1
 11a:	00f50823          	sb	a5,16(a0)
}
 11e:	6422                	ld	s0,8(sp)
 120:	0141                	addi	sp,sp,16
 122:	8082                	ret

0000000000000124 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
 124:	00054783          	lbu	a5,0(a0)
 128:	e399                	bnez	a5,12e <holding+0xa>
 12a:	4501                	li	a0,0
}
 12c:	8082                	ret
{
 12e:	1101                	addi	sp,sp,-32
 130:	ec06                	sd	ra,24(sp)
 132:	e822                	sd	s0,16(sp)
 134:	e426                	sd	s1,8(sp)
 136:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
 138:	01054483          	lbu	s1,16(a0)
 13c:	00000097          	auipc	ra,0x0
 140:	2c4080e7          	jalr	708(ra) # 400 <twhoami>
 144:	2501                	sext.w	a0,a0
 146:	40a48533          	sub	a0,s1,a0
 14a:	00153513          	seqz	a0,a0
}
 14e:	60e2                	ld	ra,24(sp)
 150:	6442                	ld	s0,16(sp)
 152:	64a2                	ld	s1,8(sp)
 154:	6105                	addi	sp,sp,32
 156:	8082                	ret

0000000000000158 <acquire>:

void acquire(struct lock *lk)
{
 158:	7179                	addi	sp,sp,-48
 15a:	f406                	sd	ra,40(sp)
 15c:	f022                	sd	s0,32(sp)
 15e:	ec26                	sd	s1,24(sp)
 160:	e84a                	sd	s2,16(sp)
 162:	e44e                	sd	s3,8(sp)
 164:	e052                	sd	s4,0(sp)
 166:	1800                	addi	s0,sp,48
 168:	8a2a                	mv	s4,a0
    if (holding(lk))
 16a:	00000097          	auipc	ra,0x0
 16e:	fba080e7          	jalr	-70(ra) # 124 <holding>
 172:	e919                	bnez	a0,188 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 174:	ffca7493          	andi	s1,s4,-4
 178:	003a7913          	andi	s2,s4,3
 17c:	0039191b          	slliw	s2,s2,0x3
 180:	4985                	li	s3,1
 182:	012999bb          	sllw	s3,s3,s2
 186:	a015                	j	1aa <acquire+0x52>
        printf("re-acquiring lock we already hold");
 188:	00001517          	auipc	a0,0x1
 18c:	b2850513          	addi	a0,a0,-1240 # cb0 <malloc+0x126>
 190:	00001097          	auipc	ra,0x1
 194:	942080e7          	jalr	-1726(ra) # ad2 <printf>
        exit(-1);
 198:	557d                	li	a0,-1
 19a:	00000097          	auipc	ra,0x0
 19e:	5b8080e7          	jalr	1464(ra) # 752 <exit>
    {
        // give up the cpu for other threads
        tyield();
 1a2:	00000097          	auipc	ra,0x0
 1a6:	1dc080e7          	jalr	476(ra) # 37e <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 1aa:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 1ae:	0127d7bb          	srlw	a5,a5,s2
 1b2:	0ff7f793          	zext.b	a5,a5
 1b6:	f7f5                	bnez	a5,1a2 <acquire+0x4a>
    }

    __sync_synchronize();
 1b8:	0ff0000f          	fence

    lk->tid = twhoami();
 1bc:	00000097          	auipc	ra,0x0
 1c0:	244080e7          	jalr	580(ra) # 400 <twhoami>
 1c4:	00aa0823          	sb	a0,16(s4)
}
 1c8:	70a2                	ld	ra,40(sp)
 1ca:	7402                	ld	s0,32(sp)
 1cc:	64e2                	ld	s1,24(sp)
 1ce:	6942                	ld	s2,16(sp)
 1d0:	69a2                	ld	s3,8(sp)
 1d2:	6a02                	ld	s4,0(sp)
 1d4:	6145                	addi	sp,sp,48
 1d6:	8082                	ret

00000000000001d8 <release>:

void release(struct lock *lk)
{
 1d8:	1101                	addi	sp,sp,-32
 1da:	ec06                	sd	ra,24(sp)
 1dc:	e822                	sd	s0,16(sp)
 1de:	e426                	sd	s1,8(sp)
 1e0:	1000                	addi	s0,sp,32
 1e2:	84aa                	mv	s1,a0
    if (!holding(lk))
 1e4:	00000097          	auipc	ra,0x0
 1e8:	f40080e7          	jalr	-192(ra) # 124 <holding>
 1ec:	c11d                	beqz	a0,212 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 1ee:	57fd                	li	a5,-1
 1f0:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 1f4:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 1f8:	0ff0000f          	fence
 1fc:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 200:	00000097          	auipc	ra,0x0
 204:	17e080e7          	jalr	382(ra) # 37e <tyield>
}
 208:	60e2                	ld	ra,24(sp)
 20a:	6442                	ld	s0,16(sp)
 20c:	64a2                	ld	s1,8(sp)
 20e:	6105                	addi	sp,sp,32
 210:	8082                	ret
        printf("releasing lock we are not holding");
 212:	00001517          	auipc	a0,0x1
 216:	ac650513          	addi	a0,a0,-1338 # cd8 <malloc+0x14e>
 21a:	00001097          	auipc	ra,0x1
 21e:	8b8080e7          	jalr	-1864(ra) # ad2 <printf>
        exit(-1);
 222:	557d                	li	a0,-1
 224:	00000097          	auipc	ra,0x0
 228:	52e080e7          	jalr	1326(ra) # 752 <exit>

000000000000022c <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 22c:	00001517          	auipc	a0,0x1
 230:	de453503          	ld	a0,-540(a0) # 1010 <current_thread>
 234:	00001717          	auipc	a4,0x1
 238:	dec70713          	addi	a4,a4,-532 # 1020 <threads>
    for (int i = 0; i < 16; i++) {
 23c:	4781                	li	a5,0
 23e:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 240:	6314                	ld	a3,0(a4)
 242:	00a68763          	beq	a3,a0,250 <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 246:	2785                	addiw	a5,a5,1
 248:	0721                	addi	a4,a4,8
 24a:	fec79be3          	bne	a5,a2,240 <tsched+0x14>
    int current_index = 0;
 24e:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 250:	0017869b          	addiw	a3,a5,1
 254:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 258:	00001817          	auipc	a6,0x1
 25c:	dc880813          	addi	a6,a6,-568 # 1020 <threads>
 260:	488d                	li	a7,3
 262:	a021                	j	26a <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 264:	2685                	addiw	a3,a3,1
 266:	04c68363          	beq	a3,a2,2ac <tsched+0x80>
        int next_index = (current_index + i) % 16;
 26a:	41f6d71b          	sraiw	a4,a3,0x1f
 26e:	01c7571b          	srliw	a4,a4,0x1c
 272:	00d707bb          	addw	a5,a4,a3
 276:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 278:	9f99                	subw	a5,a5,a4
 27a:	078e                	slli	a5,a5,0x3
 27c:	97c2                	add	a5,a5,a6
 27e:	638c                	ld	a1,0(a5)
 280:	d1f5                	beqz	a1,264 <tsched+0x38>
 282:	5dbc                	lw	a5,120(a1)
 284:	ff1790e3          	bne	a5,a7,264 <tsched+0x38>
{
 288:	1141                	addi	sp,sp,-16
 28a:	e406                	sd	ra,8(sp)
 28c:	e022                	sd	s0,0(sp)
 28e:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 290:	00001797          	auipc	a5,0x1
 294:	d8b7b023          	sd	a1,-640(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 298:	05a1                	addi	a1,a1,8
 29a:	0521                	addi	a0,a0,8
 29c:	00000097          	auipc	ra,0x0
 2a0:	17c080e7          	jalr	380(ra) # 418 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 2a4:	60a2                	ld	ra,8(sp)
 2a6:	6402                	ld	s0,0(sp)
 2a8:	0141                	addi	sp,sp,16
 2aa:	8082                	ret
 2ac:	8082                	ret

00000000000002ae <thread_wrapper>:
{
 2ae:	1101                	addi	sp,sp,-32
 2b0:	ec06                	sd	ra,24(sp)
 2b2:	e822                	sd	s0,16(sp)
 2b4:	e426                	sd	s1,8(sp)
 2b6:	1000                	addi	s0,sp,32
    current_thread->func(current_thread->arg);
 2b8:	00001497          	auipc	s1,0x1
 2bc:	d5848493          	addi	s1,s1,-680 # 1010 <current_thread>
 2c0:	609c                	ld	a5,0(s1)
 2c2:	67d8                	ld	a4,136(a5)
 2c4:	63c8                	ld	a0,128(a5)
 2c6:	9702                	jalr	a4
    current_thread->state = EXITED;
 2c8:	609c                	ld	a5,0(s1)
 2ca:	4719                	li	a4,6
 2cc:	dfb8                	sw	a4,120(a5)
    tsched();
 2ce:	00000097          	auipc	ra,0x0
 2d2:	f5e080e7          	jalr	-162(ra) # 22c <tsched>
}
 2d6:	60e2                	ld	ra,24(sp)
 2d8:	6442                	ld	s0,16(sp)
 2da:	64a2                	ld	s1,8(sp)
 2dc:	6105                	addi	sp,sp,32
 2de:	8082                	ret

00000000000002e0 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 2e0:	7179                	addi	sp,sp,-48
 2e2:	f406                	sd	ra,40(sp)
 2e4:	f022                	sd	s0,32(sp)
 2e6:	ec26                	sd	s1,24(sp)
 2e8:	e84a                	sd	s2,16(sp)
 2ea:	e44e                	sd	s3,8(sp)
 2ec:	1800                	addi	s0,sp,48
 2ee:	84aa                	mv	s1,a0
 2f0:	89b2                	mv	s3,a2
 2f2:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 2f4:	09800513          	li	a0,152
 2f8:	00001097          	auipc	ra,0x1
 2fc:	892080e7          	jalr	-1902(ra) # b8a <malloc>
 300:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 302:	478d                	li	a5,3
 304:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 306:	609c                	ld	a5,0(s1)
 308:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 30c:	609c                	ld	a5,0(s1)
 30e:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid;
 312:	6098                	ld	a4,0(s1)
 314:	00001797          	auipc	a5,0x1
 318:	cec78793          	addi	a5,a5,-788 # 1000 <next_tid>
 31c:	4394                	lw	a3,0(a5)
 31e:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 322:	4398                	lw	a4,0(a5)
 324:	2705                	addiw	a4,a4,1
 326:	c398                	sw	a4,0(a5)

    (*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
 328:	6505                	lui	a0,0x1
 32a:	00001097          	auipc	ra,0x1
 32e:	860080e7          	jalr	-1952(ra) # b8a <malloc>
 332:	609c                	ld	a5,0(s1)
 334:	6705                	lui	a4,0x1
 336:	953a                	add	a0,a0,a4
 338:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 33a:	609c                	ld	a5,0(s1)
 33c:	00000717          	auipc	a4,0x0
 340:	f7270713          	addi	a4,a4,-142 # 2ae <thread_wrapper>
 344:	e798                	sd	a4,8(a5)

   // int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 346:	00001717          	auipc	a4,0x1
 34a:	cda70713          	addi	a4,a4,-806 # 1020 <threads>
 34e:	4781                	li	a5,0
 350:	4641                	li	a2,16
        if (threads[i] == NULL) {
 352:	6314                	ld	a3,0(a4)
 354:	ce81                	beqz	a3,36c <tcreate+0x8c>
    for (int i = 0; i < 16; i++) {
 356:	2785                	addiw	a5,a5,1
 358:	0721                	addi	a4,a4,8
 35a:	fec79ce3          	bne	a5,a2,352 <tcreate+0x72>
    if (!thread_added) {
        free(*thread);
        *thread = NULL;
        return;
    } */
}
 35e:	70a2                	ld	ra,40(sp)
 360:	7402                	ld	s0,32(sp)
 362:	64e2                	ld	s1,24(sp)
 364:	6942                	ld	s2,16(sp)
 366:	69a2                	ld	s3,8(sp)
 368:	6145                	addi	sp,sp,48
 36a:	8082                	ret
            threads[i] = *thread;
 36c:	6094                	ld	a3,0(s1)
 36e:	078e                	slli	a5,a5,0x3
 370:	00001717          	auipc	a4,0x1
 374:	cb070713          	addi	a4,a4,-848 # 1020 <threads>
 378:	97ba                	add	a5,a5,a4
 37a:	e394                	sd	a3,0(a5)
            break;
 37c:	b7cd                	j	35e <tcreate+0x7e>

000000000000037e <tyield>:
    return 0;
}


void tyield()
{
 37e:	1141                	addi	sp,sp,-16
 380:	e406                	sd	ra,8(sp)
 382:	e022                	sd	s0,0(sp)
 384:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 386:	00001797          	auipc	a5,0x1
 38a:	c8a7b783          	ld	a5,-886(a5) # 1010 <current_thread>
 38e:	470d                	li	a4,3
 390:	dfb8                	sw	a4,120(a5)
    tsched();
 392:	00000097          	auipc	ra,0x0
 396:	e9a080e7          	jalr	-358(ra) # 22c <tsched>
}
 39a:	60a2                	ld	ra,8(sp)
 39c:	6402                	ld	s0,0(sp)
 39e:	0141                	addi	sp,sp,16
 3a0:	8082                	ret

00000000000003a2 <tjoin>:
{
 3a2:	1101                	addi	sp,sp,-32
 3a4:	ec06                	sd	ra,24(sp)
 3a6:	e822                	sd	s0,16(sp)
 3a8:	e426                	sd	s1,8(sp)
 3aa:	e04a                	sd	s2,0(sp)
 3ac:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 3ae:	00001797          	auipc	a5,0x1
 3b2:	c7278793          	addi	a5,a5,-910 # 1020 <threads>
 3b6:	00001697          	auipc	a3,0x1
 3ba:	cea68693          	addi	a3,a3,-790 # 10a0 <base>
 3be:	a021                	j	3c6 <tjoin+0x24>
 3c0:	07a1                	addi	a5,a5,8
 3c2:	02d78b63          	beq	a5,a3,3f8 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 3c6:	6384                	ld	s1,0(a5)
 3c8:	dce5                	beqz	s1,3c0 <tjoin+0x1e>
 3ca:	0004c703          	lbu	a4,0(s1)
 3ce:	fea719e3          	bne	a4,a0,3c0 <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 3d2:	5cb8                	lw	a4,120(s1)
 3d4:	4799                	li	a5,6
 3d6:	4919                	li	s2,6
 3d8:	02f70263          	beq	a4,a5,3fc <tjoin+0x5a>
        tyield();
 3dc:	00000097          	auipc	ra,0x0
 3e0:	fa2080e7          	jalr	-94(ra) # 37e <tyield>
    while (target_thread->state != EXITED) {
 3e4:	5cbc                	lw	a5,120(s1)
 3e6:	ff279be3          	bne	a5,s2,3dc <tjoin+0x3a>
    return 0;
 3ea:	4501                	li	a0,0
}
 3ec:	60e2                	ld	ra,24(sp)
 3ee:	6442                	ld	s0,16(sp)
 3f0:	64a2                	ld	s1,8(sp)
 3f2:	6902                	ld	s2,0(sp)
 3f4:	6105                	addi	sp,sp,32
 3f6:	8082                	ret
        return -1;
 3f8:	557d                	li	a0,-1
 3fa:	bfcd                	j	3ec <tjoin+0x4a>
    return 0;
 3fc:	4501                	li	a0,0
 3fe:	b7fd                	j	3ec <tjoin+0x4a>

0000000000000400 <twhoami>:

uint8 twhoami()
{
 400:	1141                	addi	sp,sp,-16
 402:	e422                	sd	s0,8(sp)
 404:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 406:	00001797          	auipc	a5,0x1
 40a:	c0a7b783          	ld	a5,-1014(a5) # 1010 <current_thread>
 40e:	0007c503          	lbu	a0,0(a5)
 412:	6422                	ld	s0,8(sp)
 414:	0141                	addi	sp,sp,16
 416:	8082                	ret

0000000000000418 <tswtch>:
 418:	00153023          	sd	ra,0(a0) # 1000 <next_tid>
 41c:	00253423          	sd	sp,8(a0)
 420:	e900                	sd	s0,16(a0)
 422:	ed04                	sd	s1,24(a0)
 424:	03253023          	sd	s2,32(a0)
 428:	03353423          	sd	s3,40(a0)
 42c:	03453823          	sd	s4,48(a0)
 430:	03553c23          	sd	s5,56(a0)
 434:	05653023          	sd	s6,64(a0)
 438:	05753423          	sd	s7,72(a0)
 43c:	05853823          	sd	s8,80(a0)
 440:	05953c23          	sd	s9,88(a0)
 444:	07a53023          	sd	s10,96(a0)
 448:	07b53423          	sd	s11,104(a0)
 44c:	0005b083          	ld	ra,0(a1)
 450:	0085b103          	ld	sp,8(a1)
 454:	6980                	ld	s0,16(a1)
 456:	6d84                	ld	s1,24(a1)
 458:	0205b903          	ld	s2,32(a1)
 45c:	0285b983          	ld	s3,40(a1)
 460:	0305ba03          	ld	s4,48(a1)
 464:	0385ba83          	ld	s5,56(a1)
 468:	0405bb03          	ld	s6,64(a1)
 46c:	0485bb83          	ld	s7,72(a1)
 470:	0505bc03          	ld	s8,80(a1)
 474:	0585bc83          	ld	s9,88(a1)
 478:	0605bd03          	ld	s10,96(a1)
 47c:	0685bd83          	ld	s11,104(a1)
 480:	8082                	ret

0000000000000482 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 482:	1101                	addi	sp,sp,-32
 484:	ec06                	sd	ra,24(sp)
 486:	e822                	sd	s0,16(sp)
 488:	e426                	sd	s1,8(sp)
 48a:	e04a                	sd	s2,0(sp)
 48c:	1000                	addi	s0,sp,32
 48e:	84aa                	mv	s1,a0
 490:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 492:	09800513          	li	a0,152
 496:	00000097          	auipc	ra,0x0
 49a:	6f4080e7          	jalr	1780(ra) # b8a <malloc>

    main_thread->tid = 1;
 49e:	4785                	li	a5,1
 4a0:	00f50023          	sb	a5,0(a0)
    //next_tid += 1;
    main_thread->state = RUNNING;
 4a4:	4791                	li	a5,4
 4a6:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 4a8:	00001797          	auipc	a5,0x1
 4ac:	b6a7b423          	sd	a0,-1176(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 4b0:	00001797          	auipc	a5,0x1
 4b4:	b7078793          	addi	a5,a5,-1168 # 1020 <threads>
 4b8:	00001717          	auipc	a4,0x1
 4bc:	be870713          	addi	a4,a4,-1048 # 10a0 <base>
        threads[i] = NULL;
 4c0:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 4c4:	07a1                	addi	a5,a5,8
 4c6:	fee79de3          	bne	a5,a4,4c0 <_main+0x3e>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 4ca:	00001797          	auipc	a5,0x1
 4ce:	b4a7bb23          	sd	a0,-1194(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 4d2:	85ca                	mv	a1,s2
 4d4:	8526                	mv	a0,s1
 4d6:	00000097          	auipc	ra,0x0
 4da:	b2a080e7          	jalr	-1238(ra) # 0 <main>
    //tsched();

    exit(res);
 4de:	00000097          	auipc	ra,0x0
 4e2:	274080e7          	jalr	628(ra) # 752 <exit>

00000000000004e6 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 4e6:	1141                	addi	sp,sp,-16
 4e8:	e422                	sd	s0,8(sp)
 4ea:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 4ec:	87aa                	mv	a5,a0
 4ee:	0585                	addi	a1,a1,1
 4f0:	0785                	addi	a5,a5,1
 4f2:	fff5c703          	lbu	a4,-1(a1)
 4f6:	fee78fa3          	sb	a4,-1(a5)
 4fa:	fb75                	bnez	a4,4ee <strcpy+0x8>
        ;
    return os;
}
 4fc:	6422                	ld	s0,8(sp)
 4fe:	0141                	addi	sp,sp,16
 500:	8082                	ret

0000000000000502 <strcmp>:

int strcmp(const char *p, const char *q)
{
 502:	1141                	addi	sp,sp,-16
 504:	e422                	sd	s0,8(sp)
 506:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 508:	00054783          	lbu	a5,0(a0)
 50c:	cb91                	beqz	a5,520 <strcmp+0x1e>
 50e:	0005c703          	lbu	a4,0(a1)
 512:	00f71763          	bne	a4,a5,520 <strcmp+0x1e>
        p++, q++;
 516:	0505                	addi	a0,a0,1
 518:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 51a:	00054783          	lbu	a5,0(a0)
 51e:	fbe5                	bnez	a5,50e <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 520:	0005c503          	lbu	a0,0(a1)
}
 524:	40a7853b          	subw	a0,a5,a0
 528:	6422                	ld	s0,8(sp)
 52a:	0141                	addi	sp,sp,16
 52c:	8082                	ret

000000000000052e <strlen>:

uint strlen(const char *s)
{
 52e:	1141                	addi	sp,sp,-16
 530:	e422                	sd	s0,8(sp)
 532:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 534:	00054783          	lbu	a5,0(a0)
 538:	cf91                	beqz	a5,554 <strlen+0x26>
 53a:	0505                	addi	a0,a0,1
 53c:	87aa                	mv	a5,a0
 53e:	86be                	mv	a3,a5
 540:	0785                	addi	a5,a5,1
 542:	fff7c703          	lbu	a4,-1(a5)
 546:	ff65                	bnez	a4,53e <strlen+0x10>
 548:	40a6853b          	subw	a0,a3,a0
 54c:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 54e:	6422                	ld	s0,8(sp)
 550:	0141                	addi	sp,sp,16
 552:	8082                	ret
    for (n = 0; s[n]; n++)
 554:	4501                	li	a0,0
 556:	bfe5                	j	54e <strlen+0x20>

0000000000000558 <memset>:

void *
memset(void *dst, int c, uint n)
{
 558:	1141                	addi	sp,sp,-16
 55a:	e422                	sd	s0,8(sp)
 55c:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 55e:	ca19                	beqz	a2,574 <memset+0x1c>
 560:	87aa                	mv	a5,a0
 562:	1602                	slli	a2,a2,0x20
 564:	9201                	srli	a2,a2,0x20
 566:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 56a:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 56e:	0785                	addi	a5,a5,1
 570:	fee79de3          	bne	a5,a4,56a <memset+0x12>
    }
    return dst;
}
 574:	6422                	ld	s0,8(sp)
 576:	0141                	addi	sp,sp,16
 578:	8082                	ret

000000000000057a <strchr>:

char *
strchr(const char *s, char c)
{
 57a:	1141                	addi	sp,sp,-16
 57c:	e422                	sd	s0,8(sp)
 57e:	0800                	addi	s0,sp,16
    for (; *s; s++)
 580:	00054783          	lbu	a5,0(a0)
 584:	cb99                	beqz	a5,59a <strchr+0x20>
        if (*s == c)
 586:	00f58763          	beq	a1,a5,594 <strchr+0x1a>
    for (; *s; s++)
 58a:	0505                	addi	a0,a0,1
 58c:	00054783          	lbu	a5,0(a0)
 590:	fbfd                	bnez	a5,586 <strchr+0xc>
            return (char *)s;
    return 0;
 592:	4501                	li	a0,0
}
 594:	6422                	ld	s0,8(sp)
 596:	0141                	addi	sp,sp,16
 598:	8082                	ret
    return 0;
 59a:	4501                	li	a0,0
 59c:	bfe5                	j	594 <strchr+0x1a>

000000000000059e <gets>:

char *
gets(char *buf, int max)
{
 59e:	711d                	addi	sp,sp,-96
 5a0:	ec86                	sd	ra,88(sp)
 5a2:	e8a2                	sd	s0,80(sp)
 5a4:	e4a6                	sd	s1,72(sp)
 5a6:	e0ca                	sd	s2,64(sp)
 5a8:	fc4e                	sd	s3,56(sp)
 5aa:	f852                	sd	s4,48(sp)
 5ac:	f456                	sd	s5,40(sp)
 5ae:	f05a                	sd	s6,32(sp)
 5b0:	ec5e                	sd	s7,24(sp)
 5b2:	1080                	addi	s0,sp,96
 5b4:	8baa                	mv	s7,a0
 5b6:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 5b8:	892a                	mv	s2,a0
 5ba:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 5bc:	4aa9                	li	s5,10
 5be:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 5c0:	89a6                	mv	s3,s1
 5c2:	2485                	addiw	s1,s1,1
 5c4:	0344d863          	bge	s1,s4,5f4 <gets+0x56>
        cc = read(0, &c, 1);
 5c8:	4605                	li	a2,1
 5ca:	faf40593          	addi	a1,s0,-81
 5ce:	4501                	li	a0,0
 5d0:	00000097          	auipc	ra,0x0
 5d4:	19a080e7          	jalr	410(ra) # 76a <read>
        if (cc < 1)
 5d8:	00a05e63          	blez	a0,5f4 <gets+0x56>
        buf[i++] = c;
 5dc:	faf44783          	lbu	a5,-81(s0)
 5e0:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 5e4:	01578763          	beq	a5,s5,5f2 <gets+0x54>
 5e8:	0905                	addi	s2,s2,1
 5ea:	fd679be3          	bne	a5,s6,5c0 <gets+0x22>
    for (i = 0; i + 1 < max;)
 5ee:	89a6                	mv	s3,s1
 5f0:	a011                	j	5f4 <gets+0x56>
 5f2:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 5f4:	99de                	add	s3,s3,s7
 5f6:	00098023          	sb	zero,0(s3)
    return buf;
}
 5fa:	855e                	mv	a0,s7
 5fc:	60e6                	ld	ra,88(sp)
 5fe:	6446                	ld	s0,80(sp)
 600:	64a6                	ld	s1,72(sp)
 602:	6906                	ld	s2,64(sp)
 604:	79e2                	ld	s3,56(sp)
 606:	7a42                	ld	s4,48(sp)
 608:	7aa2                	ld	s5,40(sp)
 60a:	7b02                	ld	s6,32(sp)
 60c:	6be2                	ld	s7,24(sp)
 60e:	6125                	addi	sp,sp,96
 610:	8082                	ret

0000000000000612 <stat>:

int stat(const char *n, struct stat *st)
{
 612:	1101                	addi	sp,sp,-32
 614:	ec06                	sd	ra,24(sp)
 616:	e822                	sd	s0,16(sp)
 618:	e426                	sd	s1,8(sp)
 61a:	e04a                	sd	s2,0(sp)
 61c:	1000                	addi	s0,sp,32
 61e:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 620:	4581                	li	a1,0
 622:	00000097          	auipc	ra,0x0
 626:	170080e7          	jalr	368(ra) # 792 <open>
    if (fd < 0)
 62a:	02054563          	bltz	a0,654 <stat+0x42>
 62e:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 630:	85ca                	mv	a1,s2
 632:	00000097          	auipc	ra,0x0
 636:	178080e7          	jalr	376(ra) # 7aa <fstat>
 63a:	892a                	mv	s2,a0
    close(fd);
 63c:	8526                	mv	a0,s1
 63e:	00000097          	auipc	ra,0x0
 642:	13c080e7          	jalr	316(ra) # 77a <close>
    return r;
}
 646:	854a                	mv	a0,s2
 648:	60e2                	ld	ra,24(sp)
 64a:	6442                	ld	s0,16(sp)
 64c:	64a2                	ld	s1,8(sp)
 64e:	6902                	ld	s2,0(sp)
 650:	6105                	addi	sp,sp,32
 652:	8082                	ret
        return -1;
 654:	597d                	li	s2,-1
 656:	bfc5                	j	646 <stat+0x34>

0000000000000658 <atoi>:

int atoi(const char *s)
{
 658:	1141                	addi	sp,sp,-16
 65a:	e422                	sd	s0,8(sp)
 65c:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 65e:	00054683          	lbu	a3,0(a0)
 662:	fd06879b          	addiw	a5,a3,-48
 666:	0ff7f793          	zext.b	a5,a5
 66a:	4625                	li	a2,9
 66c:	02f66863          	bltu	a2,a5,69c <atoi+0x44>
 670:	872a                	mv	a4,a0
    n = 0;
 672:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 674:	0705                	addi	a4,a4,1
 676:	0025179b          	slliw	a5,a0,0x2
 67a:	9fa9                	addw	a5,a5,a0
 67c:	0017979b          	slliw	a5,a5,0x1
 680:	9fb5                	addw	a5,a5,a3
 682:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 686:	00074683          	lbu	a3,0(a4)
 68a:	fd06879b          	addiw	a5,a3,-48
 68e:	0ff7f793          	zext.b	a5,a5
 692:	fef671e3          	bgeu	a2,a5,674 <atoi+0x1c>
    return n;
}
 696:	6422                	ld	s0,8(sp)
 698:	0141                	addi	sp,sp,16
 69a:	8082                	ret
    n = 0;
 69c:	4501                	li	a0,0
 69e:	bfe5                	j	696 <atoi+0x3e>

00000000000006a0 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 6a0:	1141                	addi	sp,sp,-16
 6a2:	e422                	sd	s0,8(sp)
 6a4:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 6a6:	02b57463          	bgeu	a0,a1,6ce <memmove+0x2e>
    {
        while (n-- > 0)
 6aa:	00c05f63          	blez	a2,6c8 <memmove+0x28>
 6ae:	1602                	slli	a2,a2,0x20
 6b0:	9201                	srli	a2,a2,0x20
 6b2:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 6b6:	872a                	mv	a4,a0
            *dst++ = *src++;
 6b8:	0585                	addi	a1,a1,1
 6ba:	0705                	addi	a4,a4,1
 6bc:	fff5c683          	lbu	a3,-1(a1)
 6c0:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 6c4:	fee79ae3          	bne	a5,a4,6b8 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 6c8:	6422                	ld	s0,8(sp)
 6ca:	0141                	addi	sp,sp,16
 6cc:	8082                	ret
        dst += n;
 6ce:	00c50733          	add	a4,a0,a2
        src += n;
 6d2:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 6d4:	fec05ae3          	blez	a2,6c8 <memmove+0x28>
 6d8:	fff6079b          	addiw	a5,a2,-1
 6dc:	1782                	slli	a5,a5,0x20
 6de:	9381                	srli	a5,a5,0x20
 6e0:	fff7c793          	not	a5,a5
 6e4:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 6e6:	15fd                	addi	a1,a1,-1
 6e8:	177d                	addi	a4,a4,-1
 6ea:	0005c683          	lbu	a3,0(a1)
 6ee:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 6f2:	fee79ae3          	bne	a5,a4,6e6 <memmove+0x46>
 6f6:	bfc9                	j	6c8 <memmove+0x28>

00000000000006f8 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 6f8:	1141                	addi	sp,sp,-16
 6fa:	e422                	sd	s0,8(sp)
 6fc:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 6fe:	ca05                	beqz	a2,72e <memcmp+0x36>
 700:	fff6069b          	addiw	a3,a2,-1
 704:	1682                	slli	a3,a3,0x20
 706:	9281                	srli	a3,a3,0x20
 708:	0685                	addi	a3,a3,1
 70a:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 70c:	00054783          	lbu	a5,0(a0)
 710:	0005c703          	lbu	a4,0(a1)
 714:	00e79863          	bne	a5,a4,724 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 718:	0505                	addi	a0,a0,1
        p2++;
 71a:	0585                	addi	a1,a1,1
    while (n-- > 0)
 71c:	fed518e3          	bne	a0,a3,70c <memcmp+0x14>
    }
    return 0;
 720:	4501                	li	a0,0
 722:	a019                	j	728 <memcmp+0x30>
            return *p1 - *p2;
 724:	40e7853b          	subw	a0,a5,a4
}
 728:	6422                	ld	s0,8(sp)
 72a:	0141                	addi	sp,sp,16
 72c:	8082                	ret
    return 0;
 72e:	4501                	li	a0,0
 730:	bfe5                	j	728 <memcmp+0x30>

0000000000000732 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 732:	1141                	addi	sp,sp,-16
 734:	e406                	sd	ra,8(sp)
 736:	e022                	sd	s0,0(sp)
 738:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 73a:	00000097          	auipc	ra,0x0
 73e:	f66080e7          	jalr	-154(ra) # 6a0 <memmove>
}
 742:	60a2                	ld	ra,8(sp)
 744:	6402                	ld	s0,0(sp)
 746:	0141                	addi	sp,sp,16
 748:	8082                	ret

000000000000074a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 74a:	4885                	li	a7,1
 ecall
 74c:	00000073          	ecall
 ret
 750:	8082                	ret

0000000000000752 <exit>:
.global exit
exit:
 li a7, SYS_exit
 752:	4889                	li	a7,2
 ecall
 754:	00000073          	ecall
 ret
 758:	8082                	ret

000000000000075a <wait>:
.global wait
wait:
 li a7, SYS_wait
 75a:	488d                	li	a7,3
 ecall
 75c:	00000073          	ecall
 ret
 760:	8082                	ret

0000000000000762 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 762:	4891                	li	a7,4
 ecall
 764:	00000073          	ecall
 ret
 768:	8082                	ret

000000000000076a <read>:
.global read
read:
 li a7, SYS_read
 76a:	4895                	li	a7,5
 ecall
 76c:	00000073          	ecall
 ret
 770:	8082                	ret

0000000000000772 <write>:
.global write
write:
 li a7, SYS_write
 772:	48c1                	li	a7,16
 ecall
 774:	00000073          	ecall
 ret
 778:	8082                	ret

000000000000077a <close>:
.global close
close:
 li a7, SYS_close
 77a:	48d5                	li	a7,21
 ecall
 77c:	00000073          	ecall
 ret
 780:	8082                	ret

0000000000000782 <kill>:
.global kill
kill:
 li a7, SYS_kill
 782:	4899                	li	a7,6
 ecall
 784:	00000073          	ecall
 ret
 788:	8082                	ret

000000000000078a <exec>:
.global exec
exec:
 li a7, SYS_exec
 78a:	489d                	li	a7,7
 ecall
 78c:	00000073          	ecall
 ret
 790:	8082                	ret

0000000000000792 <open>:
.global open
open:
 li a7, SYS_open
 792:	48bd                	li	a7,15
 ecall
 794:	00000073          	ecall
 ret
 798:	8082                	ret

000000000000079a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 79a:	48c5                	li	a7,17
 ecall
 79c:	00000073          	ecall
 ret
 7a0:	8082                	ret

00000000000007a2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7a2:	48c9                	li	a7,18
 ecall
 7a4:	00000073          	ecall
 ret
 7a8:	8082                	ret

00000000000007aa <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7aa:	48a1                	li	a7,8
 ecall
 7ac:	00000073          	ecall
 ret
 7b0:	8082                	ret

00000000000007b2 <link>:
.global link
link:
 li a7, SYS_link
 7b2:	48cd                	li	a7,19
 ecall
 7b4:	00000073          	ecall
 ret
 7b8:	8082                	ret

00000000000007ba <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7ba:	48d1                	li	a7,20
 ecall
 7bc:	00000073          	ecall
 ret
 7c0:	8082                	ret

00000000000007c2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7c2:	48a5                	li	a7,9
 ecall
 7c4:	00000073          	ecall
 ret
 7c8:	8082                	ret

00000000000007ca <dup>:
.global dup
dup:
 li a7, SYS_dup
 7ca:	48a9                	li	a7,10
 ecall
 7cc:	00000073          	ecall
 ret
 7d0:	8082                	ret

00000000000007d2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7d2:	48ad                	li	a7,11
 ecall
 7d4:	00000073          	ecall
 ret
 7d8:	8082                	ret

00000000000007da <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7da:	48b1                	li	a7,12
 ecall
 7dc:	00000073          	ecall
 ret
 7e0:	8082                	ret

00000000000007e2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7e2:	48b5                	li	a7,13
 ecall
 7e4:	00000073          	ecall
 ret
 7e8:	8082                	ret

00000000000007ea <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7ea:	48b9                	li	a7,14
 ecall
 7ec:	00000073          	ecall
 ret
 7f0:	8082                	ret

00000000000007f2 <ps>:
.global ps
ps:
 li a7, SYS_ps
 7f2:	48d9                	li	a7,22
 ecall
 7f4:	00000073          	ecall
 ret
 7f8:	8082                	ret

00000000000007fa <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 7fa:	48dd                	li	a7,23
 ecall
 7fc:	00000073          	ecall
 ret
 800:	8082                	ret

0000000000000802 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 802:	48e1                	li	a7,24
 ecall
 804:	00000073          	ecall
 ret
 808:	8082                	ret

000000000000080a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 80a:	1101                	addi	sp,sp,-32
 80c:	ec06                	sd	ra,24(sp)
 80e:	e822                	sd	s0,16(sp)
 810:	1000                	addi	s0,sp,32
 812:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 816:	4605                	li	a2,1
 818:	fef40593          	addi	a1,s0,-17
 81c:	00000097          	auipc	ra,0x0
 820:	f56080e7          	jalr	-170(ra) # 772 <write>
}
 824:	60e2                	ld	ra,24(sp)
 826:	6442                	ld	s0,16(sp)
 828:	6105                	addi	sp,sp,32
 82a:	8082                	ret

000000000000082c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 82c:	7139                	addi	sp,sp,-64
 82e:	fc06                	sd	ra,56(sp)
 830:	f822                	sd	s0,48(sp)
 832:	f426                	sd	s1,40(sp)
 834:	f04a                	sd	s2,32(sp)
 836:	ec4e                	sd	s3,24(sp)
 838:	0080                	addi	s0,sp,64
 83a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 83c:	c299                	beqz	a3,842 <printint+0x16>
 83e:	0805c963          	bltz	a1,8d0 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 842:	2581                	sext.w	a1,a1
  neg = 0;
 844:	4881                	li	a7,0
 846:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 84a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 84c:	2601                	sext.w	a2,a2
 84e:	00000517          	auipc	a0,0x0
 852:	51250513          	addi	a0,a0,1298 # d60 <digits>
 856:	883a                	mv	a6,a4
 858:	2705                	addiw	a4,a4,1
 85a:	02c5f7bb          	remuw	a5,a1,a2
 85e:	1782                	slli	a5,a5,0x20
 860:	9381                	srli	a5,a5,0x20
 862:	97aa                	add	a5,a5,a0
 864:	0007c783          	lbu	a5,0(a5)
 868:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 86c:	0005879b          	sext.w	a5,a1
 870:	02c5d5bb          	divuw	a1,a1,a2
 874:	0685                	addi	a3,a3,1
 876:	fec7f0e3          	bgeu	a5,a2,856 <printint+0x2a>
  if(neg)
 87a:	00088c63          	beqz	a7,892 <printint+0x66>
    buf[i++] = '-';
 87e:	fd070793          	addi	a5,a4,-48
 882:	00878733          	add	a4,a5,s0
 886:	02d00793          	li	a5,45
 88a:	fef70823          	sb	a5,-16(a4)
 88e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 892:	02e05863          	blez	a4,8c2 <printint+0x96>
 896:	fc040793          	addi	a5,s0,-64
 89a:	00e78933          	add	s2,a5,a4
 89e:	fff78993          	addi	s3,a5,-1
 8a2:	99ba                	add	s3,s3,a4
 8a4:	377d                	addiw	a4,a4,-1
 8a6:	1702                	slli	a4,a4,0x20
 8a8:	9301                	srli	a4,a4,0x20
 8aa:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8ae:	fff94583          	lbu	a1,-1(s2)
 8b2:	8526                	mv	a0,s1
 8b4:	00000097          	auipc	ra,0x0
 8b8:	f56080e7          	jalr	-170(ra) # 80a <putc>
  while(--i >= 0)
 8bc:	197d                	addi	s2,s2,-1
 8be:	ff3918e3          	bne	s2,s3,8ae <printint+0x82>
}
 8c2:	70e2                	ld	ra,56(sp)
 8c4:	7442                	ld	s0,48(sp)
 8c6:	74a2                	ld	s1,40(sp)
 8c8:	7902                	ld	s2,32(sp)
 8ca:	69e2                	ld	s3,24(sp)
 8cc:	6121                	addi	sp,sp,64
 8ce:	8082                	ret
    x = -xx;
 8d0:	40b005bb          	negw	a1,a1
    neg = 1;
 8d4:	4885                	li	a7,1
    x = -xx;
 8d6:	bf85                	j	846 <printint+0x1a>

00000000000008d8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8d8:	715d                	addi	sp,sp,-80
 8da:	e486                	sd	ra,72(sp)
 8dc:	e0a2                	sd	s0,64(sp)
 8de:	fc26                	sd	s1,56(sp)
 8e0:	f84a                	sd	s2,48(sp)
 8e2:	f44e                	sd	s3,40(sp)
 8e4:	f052                	sd	s4,32(sp)
 8e6:	ec56                	sd	s5,24(sp)
 8e8:	e85a                	sd	s6,16(sp)
 8ea:	e45e                	sd	s7,8(sp)
 8ec:	e062                	sd	s8,0(sp)
 8ee:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8f0:	0005c903          	lbu	s2,0(a1)
 8f4:	18090c63          	beqz	s2,a8c <vprintf+0x1b4>
 8f8:	8aaa                	mv	s5,a0
 8fa:	8bb2                	mv	s7,a2
 8fc:	00158493          	addi	s1,a1,1
  state = 0;
 900:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 902:	02500a13          	li	s4,37
 906:	4b55                	li	s6,21
 908:	a839                	j	926 <vprintf+0x4e>
        putc(fd, c);
 90a:	85ca                	mv	a1,s2
 90c:	8556                	mv	a0,s5
 90e:	00000097          	auipc	ra,0x0
 912:	efc080e7          	jalr	-260(ra) # 80a <putc>
 916:	a019                	j	91c <vprintf+0x44>
    } else if(state == '%'){
 918:	01498d63          	beq	s3,s4,932 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 91c:	0485                	addi	s1,s1,1
 91e:	fff4c903          	lbu	s2,-1(s1)
 922:	16090563          	beqz	s2,a8c <vprintf+0x1b4>
    if(state == 0){
 926:	fe0999e3          	bnez	s3,918 <vprintf+0x40>
      if(c == '%'){
 92a:	ff4910e3          	bne	s2,s4,90a <vprintf+0x32>
        state = '%';
 92e:	89d2                	mv	s3,s4
 930:	b7f5                	j	91c <vprintf+0x44>
      if(c == 'd'){
 932:	13490263          	beq	s2,s4,a56 <vprintf+0x17e>
 936:	f9d9079b          	addiw	a5,s2,-99
 93a:	0ff7f793          	zext.b	a5,a5
 93e:	12fb6563          	bltu	s6,a5,a68 <vprintf+0x190>
 942:	f9d9079b          	addiw	a5,s2,-99
 946:	0ff7f713          	zext.b	a4,a5
 94a:	10eb6f63          	bltu	s6,a4,a68 <vprintf+0x190>
 94e:	00271793          	slli	a5,a4,0x2
 952:	00000717          	auipc	a4,0x0
 956:	3b670713          	addi	a4,a4,950 # d08 <malloc+0x17e>
 95a:	97ba                	add	a5,a5,a4
 95c:	439c                	lw	a5,0(a5)
 95e:	97ba                	add	a5,a5,a4
 960:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 962:	008b8913          	addi	s2,s7,8
 966:	4685                	li	a3,1
 968:	4629                	li	a2,10
 96a:	000ba583          	lw	a1,0(s7)
 96e:	8556                	mv	a0,s5
 970:	00000097          	auipc	ra,0x0
 974:	ebc080e7          	jalr	-324(ra) # 82c <printint>
 978:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 97a:	4981                	li	s3,0
 97c:	b745                	j	91c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 97e:	008b8913          	addi	s2,s7,8
 982:	4681                	li	a3,0
 984:	4629                	li	a2,10
 986:	000ba583          	lw	a1,0(s7)
 98a:	8556                	mv	a0,s5
 98c:	00000097          	auipc	ra,0x0
 990:	ea0080e7          	jalr	-352(ra) # 82c <printint>
 994:	8bca                	mv	s7,s2
      state = 0;
 996:	4981                	li	s3,0
 998:	b751                	j	91c <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 99a:	008b8913          	addi	s2,s7,8
 99e:	4681                	li	a3,0
 9a0:	4641                	li	a2,16
 9a2:	000ba583          	lw	a1,0(s7)
 9a6:	8556                	mv	a0,s5
 9a8:	00000097          	auipc	ra,0x0
 9ac:	e84080e7          	jalr	-380(ra) # 82c <printint>
 9b0:	8bca                	mv	s7,s2
      state = 0;
 9b2:	4981                	li	s3,0
 9b4:	b7a5                	j	91c <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 9b6:	008b8c13          	addi	s8,s7,8
 9ba:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9be:	03000593          	li	a1,48
 9c2:	8556                	mv	a0,s5
 9c4:	00000097          	auipc	ra,0x0
 9c8:	e46080e7          	jalr	-442(ra) # 80a <putc>
  putc(fd, 'x');
 9cc:	07800593          	li	a1,120
 9d0:	8556                	mv	a0,s5
 9d2:	00000097          	auipc	ra,0x0
 9d6:	e38080e7          	jalr	-456(ra) # 80a <putc>
 9da:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9dc:	00000b97          	auipc	s7,0x0
 9e0:	384b8b93          	addi	s7,s7,900 # d60 <digits>
 9e4:	03c9d793          	srli	a5,s3,0x3c
 9e8:	97de                	add	a5,a5,s7
 9ea:	0007c583          	lbu	a1,0(a5)
 9ee:	8556                	mv	a0,s5
 9f0:	00000097          	auipc	ra,0x0
 9f4:	e1a080e7          	jalr	-486(ra) # 80a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9f8:	0992                	slli	s3,s3,0x4
 9fa:	397d                	addiw	s2,s2,-1
 9fc:	fe0914e3          	bnez	s2,9e4 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 a00:	8be2                	mv	s7,s8
      state = 0;
 a02:	4981                	li	s3,0
 a04:	bf21                	j	91c <vprintf+0x44>
        s = va_arg(ap, char*);
 a06:	008b8993          	addi	s3,s7,8
 a0a:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a0e:	02090163          	beqz	s2,a30 <vprintf+0x158>
        while(*s != 0){
 a12:	00094583          	lbu	a1,0(s2)
 a16:	c9a5                	beqz	a1,a86 <vprintf+0x1ae>
          putc(fd, *s);
 a18:	8556                	mv	a0,s5
 a1a:	00000097          	auipc	ra,0x0
 a1e:	df0080e7          	jalr	-528(ra) # 80a <putc>
          s++;
 a22:	0905                	addi	s2,s2,1
        while(*s != 0){
 a24:	00094583          	lbu	a1,0(s2)
 a28:	f9e5                	bnez	a1,a18 <vprintf+0x140>
        s = va_arg(ap, char*);
 a2a:	8bce                	mv	s7,s3
      state = 0;
 a2c:	4981                	li	s3,0
 a2e:	b5fd                	j	91c <vprintf+0x44>
          s = "(null)";
 a30:	00000917          	auipc	s2,0x0
 a34:	2d090913          	addi	s2,s2,720 # d00 <malloc+0x176>
        while(*s != 0){
 a38:	02800593          	li	a1,40
 a3c:	bff1                	j	a18 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a3e:	008b8913          	addi	s2,s7,8
 a42:	000bc583          	lbu	a1,0(s7)
 a46:	8556                	mv	a0,s5
 a48:	00000097          	auipc	ra,0x0
 a4c:	dc2080e7          	jalr	-574(ra) # 80a <putc>
 a50:	8bca                	mv	s7,s2
      state = 0;
 a52:	4981                	li	s3,0
 a54:	b5e1                	j	91c <vprintf+0x44>
        putc(fd, c);
 a56:	02500593          	li	a1,37
 a5a:	8556                	mv	a0,s5
 a5c:	00000097          	auipc	ra,0x0
 a60:	dae080e7          	jalr	-594(ra) # 80a <putc>
      state = 0;
 a64:	4981                	li	s3,0
 a66:	bd5d                	j	91c <vprintf+0x44>
        putc(fd, '%');
 a68:	02500593          	li	a1,37
 a6c:	8556                	mv	a0,s5
 a6e:	00000097          	auipc	ra,0x0
 a72:	d9c080e7          	jalr	-612(ra) # 80a <putc>
        putc(fd, c);
 a76:	85ca                	mv	a1,s2
 a78:	8556                	mv	a0,s5
 a7a:	00000097          	auipc	ra,0x0
 a7e:	d90080e7          	jalr	-624(ra) # 80a <putc>
      state = 0;
 a82:	4981                	li	s3,0
 a84:	bd61                	j	91c <vprintf+0x44>
        s = va_arg(ap, char*);
 a86:	8bce                	mv	s7,s3
      state = 0;
 a88:	4981                	li	s3,0
 a8a:	bd49                	j	91c <vprintf+0x44>
    }
  }
}
 a8c:	60a6                	ld	ra,72(sp)
 a8e:	6406                	ld	s0,64(sp)
 a90:	74e2                	ld	s1,56(sp)
 a92:	7942                	ld	s2,48(sp)
 a94:	79a2                	ld	s3,40(sp)
 a96:	7a02                	ld	s4,32(sp)
 a98:	6ae2                	ld	s5,24(sp)
 a9a:	6b42                	ld	s6,16(sp)
 a9c:	6ba2                	ld	s7,8(sp)
 a9e:	6c02                	ld	s8,0(sp)
 aa0:	6161                	addi	sp,sp,80
 aa2:	8082                	ret

0000000000000aa4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 aa4:	715d                	addi	sp,sp,-80
 aa6:	ec06                	sd	ra,24(sp)
 aa8:	e822                	sd	s0,16(sp)
 aaa:	1000                	addi	s0,sp,32
 aac:	e010                	sd	a2,0(s0)
 aae:	e414                	sd	a3,8(s0)
 ab0:	e818                	sd	a4,16(s0)
 ab2:	ec1c                	sd	a5,24(s0)
 ab4:	03043023          	sd	a6,32(s0)
 ab8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 abc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 ac0:	8622                	mv	a2,s0
 ac2:	00000097          	auipc	ra,0x0
 ac6:	e16080e7          	jalr	-490(ra) # 8d8 <vprintf>
}
 aca:	60e2                	ld	ra,24(sp)
 acc:	6442                	ld	s0,16(sp)
 ace:	6161                	addi	sp,sp,80
 ad0:	8082                	ret

0000000000000ad2 <printf>:

void
printf(const char *fmt, ...)
{
 ad2:	711d                	addi	sp,sp,-96
 ad4:	ec06                	sd	ra,24(sp)
 ad6:	e822                	sd	s0,16(sp)
 ad8:	1000                	addi	s0,sp,32
 ada:	e40c                	sd	a1,8(s0)
 adc:	e810                	sd	a2,16(s0)
 ade:	ec14                	sd	a3,24(s0)
 ae0:	f018                	sd	a4,32(s0)
 ae2:	f41c                	sd	a5,40(s0)
 ae4:	03043823          	sd	a6,48(s0)
 ae8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 aec:	00840613          	addi	a2,s0,8
 af0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 af4:	85aa                	mv	a1,a0
 af6:	4505                	li	a0,1
 af8:	00000097          	auipc	ra,0x0
 afc:	de0080e7          	jalr	-544(ra) # 8d8 <vprintf>
}
 b00:	60e2                	ld	ra,24(sp)
 b02:	6442                	ld	s0,16(sp)
 b04:	6125                	addi	sp,sp,96
 b06:	8082                	ret

0000000000000b08 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 b08:	1141                	addi	sp,sp,-16
 b0a:	e422                	sd	s0,8(sp)
 b0c:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 b0e:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b12:	00000797          	auipc	a5,0x0
 b16:	5067b783          	ld	a5,1286(a5) # 1018 <freep>
 b1a:	a02d                	j	b44 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 b1c:	4618                	lw	a4,8(a2)
 b1e:	9f2d                	addw	a4,a4,a1
 b20:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 b24:	6398                	ld	a4,0(a5)
 b26:	6310                	ld	a2,0(a4)
 b28:	a83d                	j	b66 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 b2a:	ff852703          	lw	a4,-8(a0)
 b2e:	9f31                	addw	a4,a4,a2
 b30:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 b32:	ff053683          	ld	a3,-16(a0)
 b36:	a091                	j	b7a <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b38:	6398                	ld	a4,0(a5)
 b3a:	00e7e463          	bltu	a5,a4,b42 <free+0x3a>
 b3e:	00e6ea63          	bltu	a3,a4,b52 <free+0x4a>
{
 b42:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b44:	fed7fae3          	bgeu	a5,a3,b38 <free+0x30>
 b48:	6398                	ld	a4,0(a5)
 b4a:	00e6e463          	bltu	a3,a4,b52 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b4e:	fee7eae3          	bltu	a5,a4,b42 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b52:	ff852583          	lw	a1,-8(a0)
 b56:	6390                	ld	a2,0(a5)
 b58:	02059813          	slli	a6,a1,0x20
 b5c:	01c85713          	srli	a4,a6,0x1c
 b60:	9736                	add	a4,a4,a3
 b62:	fae60de3          	beq	a2,a4,b1c <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b66:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b6a:	4790                	lw	a2,8(a5)
 b6c:	02061593          	slli	a1,a2,0x20
 b70:	01c5d713          	srli	a4,a1,0x1c
 b74:	973e                	add	a4,a4,a5
 b76:	fae68ae3          	beq	a3,a4,b2a <free+0x22>
        p->s.ptr = bp->s.ptr;
 b7a:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b7c:	00000717          	auipc	a4,0x0
 b80:	48f73e23          	sd	a5,1180(a4) # 1018 <freep>
}
 b84:	6422                	ld	s0,8(sp)
 b86:	0141                	addi	sp,sp,16
 b88:	8082                	ret

0000000000000b8a <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b8a:	7139                	addi	sp,sp,-64
 b8c:	fc06                	sd	ra,56(sp)
 b8e:	f822                	sd	s0,48(sp)
 b90:	f426                	sd	s1,40(sp)
 b92:	f04a                	sd	s2,32(sp)
 b94:	ec4e                	sd	s3,24(sp)
 b96:	e852                	sd	s4,16(sp)
 b98:	e456                	sd	s5,8(sp)
 b9a:	e05a                	sd	s6,0(sp)
 b9c:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b9e:	02051493          	slli	s1,a0,0x20
 ba2:	9081                	srli	s1,s1,0x20
 ba4:	04bd                	addi	s1,s1,15
 ba6:	8091                	srli	s1,s1,0x4
 ba8:	0014899b          	addiw	s3,s1,1
 bac:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 bae:	00000517          	auipc	a0,0x0
 bb2:	46a53503          	ld	a0,1130(a0) # 1018 <freep>
 bb6:	c515                	beqz	a0,be2 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 bb8:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 bba:	4798                	lw	a4,8(a5)
 bbc:	02977f63          	bgeu	a4,s1,bfa <malloc+0x70>
    if (nu < 4096)
 bc0:	8a4e                	mv	s4,s3
 bc2:	0009871b          	sext.w	a4,s3
 bc6:	6685                	lui	a3,0x1
 bc8:	00d77363          	bgeu	a4,a3,bce <malloc+0x44>
 bcc:	6a05                	lui	s4,0x1
 bce:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 bd2:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 bd6:	00000917          	auipc	s2,0x0
 bda:	44290913          	addi	s2,s2,1090 # 1018 <freep>
    if (p == (char *)-1)
 bde:	5afd                	li	s5,-1
 be0:	a895                	j	c54 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 be2:	00000797          	auipc	a5,0x0
 be6:	4be78793          	addi	a5,a5,1214 # 10a0 <base>
 bea:	00000717          	auipc	a4,0x0
 bee:	42f73723          	sd	a5,1070(a4) # 1018 <freep>
 bf2:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 bf4:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 bf8:	b7e1                	j	bc0 <malloc+0x36>
            if (p->s.size == nunits)
 bfa:	02e48c63          	beq	s1,a4,c32 <malloc+0xa8>
                p->s.size -= nunits;
 bfe:	4137073b          	subw	a4,a4,s3
 c02:	c798                	sw	a4,8(a5)
                p += p->s.size;
 c04:	02071693          	slli	a3,a4,0x20
 c08:	01c6d713          	srli	a4,a3,0x1c
 c0c:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 c0e:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 c12:	00000717          	auipc	a4,0x0
 c16:	40a73323          	sd	a0,1030(a4) # 1018 <freep>
            return (void *)(p + 1);
 c1a:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 c1e:	70e2                	ld	ra,56(sp)
 c20:	7442                	ld	s0,48(sp)
 c22:	74a2                	ld	s1,40(sp)
 c24:	7902                	ld	s2,32(sp)
 c26:	69e2                	ld	s3,24(sp)
 c28:	6a42                	ld	s4,16(sp)
 c2a:	6aa2                	ld	s5,8(sp)
 c2c:	6b02                	ld	s6,0(sp)
 c2e:	6121                	addi	sp,sp,64
 c30:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 c32:	6398                	ld	a4,0(a5)
 c34:	e118                	sd	a4,0(a0)
 c36:	bff1                	j	c12 <malloc+0x88>
    hp->s.size = nu;
 c38:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c3c:	0541                	addi	a0,a0,16
 c3e:	00000097          	auipc	ra,0x0
 c42:	eca080e7          	jalr	-310(ra) # b08 <free>
    return freep;
 c46:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c4a:	d971                	beqz	a0,c1e <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c4c:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c4e:	4798                	lw	a4,8(a5)
 c50:	fa9775e3          	bgeu	a4,s1,bfa <malloc+0x70>
        if (p == freep)
 c54:	00093703          	ld	a4,0(s2)
 c58:	853e                	mv	a0,a5
 c5a:	fef719e3          	bne	a4,a5,c4c <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c5e:	8552                	mv	a0,s4
 c60:	00000097          	auipc	ra,0x0
 c64:	b7a080e7          	jalr	-1158(ra) # 7da <sbrk>
    if (p == (char *)-1)
 c68:	fd5518e3          	bne	a0,s5,c38 <malloc+0xae>
                return 0;
 c6c:	4501                	li	a0,0
 c6e:	bf45                	j	c1e <malloc+0x94>
