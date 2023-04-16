
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
  1a:	d0a78793          	addi	a5,a5,-758 # d20 <malloc+0x120>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	cc450513          	addi	a0,a0,-828 # cf0 <malloc+0xf0>
  34:	00001097          	auipc	ra,0x1
  38:	b14080e7          	jalr	-1260(ra) # b48 <printf>
  memset(data, 'a', sizeof(data));
  3c:	20000613          	li	a2,512
  40:	06100593          	li	a1,97
  44:	dd040513          	addi	a0,s0,-560
  48:	00000097          	auipc	ra,0x0
  4c:	586080e7          	jalr	1414(ra) # 5ce <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	00000097          	auipc	ra,0x0
  58:	76c080e7          	jalr	1900(ra) # 7c0 <fork>
  5c:	00a04563          	bgtz	a0,66 <main+0x66>
  for(i = 0; i < 4; i++)
  60:	2485                	addiw	s1,s1,1
  62:	ff2499e3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  66:	85a6                	mv	a1,s1
  68:	00001517          	auipc	a0,0x1
  6c:	ca050513          	addi	a0,a0,-864 # d08 <malloc+0x108>
  70:	00001097          	auipc	ra,0x1
  74:	ad8080e7          	jalr	-1320(ra) # b48 <printf>

  path[8] += i;
  78:	fd844783          	lbu	a5,-40(s0)
  7c:	9fa5                	addw	a5,a5,s1
  7e:	fcf40c23          	sb	a5,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  82:	20200593          	li	a1,514
  86:	fd040513          	addi	a0,s0,-48
  8a:	00000097          	auipc	ra,0x0
  8e:	77e080e7          	jalr	1918(ra) # 808 <open>
  92:	892a                	mv	s2,a0
  94:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  96:	20000613          	li	a2,512
  9a:	dd040593          	addi	a1,s0,-560
  9e:	854a                	mv	a0,s2
  a0:	00000097          	auipc	ra,0x0
  a4:	748080e7          	jalr	1864(ra) # 7e8 <write>
  for(i = 0; i < 20; i++)
  a8:	34fd                	addiw	s1,s1,-1
  aa:	f4f5                	bnez	s1,96 <main+0x96>
  close(fd);
  ac:	854a                	mv	a0,s2
  ae:	00000097          	auipc	ra,0x0
  b2:	742080e7          	jalr	1858(ra) # 7f0 <close>

  printf("read\n");
  b6:	00001517          	auipc	a0,0x1
  ba:	c6250513          	addi	a0,a0,-926 # d18 <malloc+0x118>
  be:	00001097          	auipc	ra,0x1
  c2:	a8a080e7          	jalr	-1398(ra) # b48 <printf>

  fd = open(path, O_RDONLY);
  c6:	4581                	li	a1,0
  c8:	fd040513          	addi	a0,s0,-48
  cc:	00000097          	auipc	ra,0x0
  d0:	73c080e7          	jalr	1852(ra) # 808 <open>
  d4:	892a                	mv	s2,a0
  d6:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  d8:	20000613          	li	a2,512
  dc:	dd040593          	addi	a1,s0,-560
  e0:	854a                	mv	a0,s2
  e2:	00000097          	auipc	ra,0x0
  e6:	6fe080e7          	jalr	1790(ra) # 7e0 <read>
  for (i = 0; i < 20; i++)
  ea:	34fd                	addiw	s1,s1,-1
  ec:	f4f5                	bnez	s1,d8 <main+0xd8>
  close(fd);
  ee:	854a                	mv	a0,s2
  f0:	00000097          	auipc	ra,0x0
  f4:	700080e7          	jalr	1792(ra) # 7f0 <close>

  wait(0);
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	6d6080e7          	jalr	1750(ra) # 7d0 <wait>

  exit(0);
 102:	4501                	li	a0,0
 104:	00000097          	auipc	ra,0x0
 108:	6c4080e7          	jalr	1732(ra) # 7c8 <exit>

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
 140:	2dc080e7          	jalr	732(ra) # 418 <twhoami>
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
 18c:	ba850513          	addi	a0,a0,-1112 # d30 <malloc+0x130>
 190:	00001097          	auipc	ra,0x1
 194:	9b8080e7          	jalr	-1608(ra) # b48 <printf>
        exit(-1);
 198:	557d                	li	a0,-1
 19a:	00000097          	auipc	ra,0x0
 19e:	62e080e7          	jalr	1582(ra) # 7c8 <exit>
    {
        // give up the cpu for other threads
        tyield();
 1a2:	00000097          	auipc	ra,0x0
 1a6:	252080e7          	jalr	594(ra) # 3f4 <tyield>
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
 1c0:	25c080e7          	jalr	604(ra) # 418 <twhoami>
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
 204:	1f4080e7          	jalr	500(ra) # 3f4 <tyield>
}
 208:	60e2                	ld	ra,24(sp)
 20a:	6442                	ld	s0,16(sp)
 20c:	64a2                	ld	s1,8(sp)
 20e:	6105                	addi	sp,sp,32
 210:	8082                	ret
        printf("releasing lock we are not holding");
 212:	00001517          	auipc	a0,0x1
 216:	b4650513          	addi	a0,a0,-1210 # d58 <malloc+0x158>
 21a:	00001097          	auipc	ra,0x1
 21e:	92e080e7          	jalr	-1746(ra) # b48 <printf>
        exit(-1);
 222:	557d                	li	a0,-1
 224:	00000097          	auipc	ra,0x0
 228:	5a4080e7          	jalr	1444(ra) # 7c8 <exit>

000000000000022c <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 22c:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 22e:	00001617          	auipc	a2,0x1
 232:	df260613          	addi	a2,a2,-526 # 1020 <threads>
 236:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 238:	45c1                	li	a1,16
 23a:	a021                	j	242 <tsched+0x16>
 23c:	2685                	addiw	a3,a3,1
 23e:	08b68c63          	beq	a3,a1,2d6 <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 242:	41f6d71b          	sraiw	a4,a3,0x1f
 246:	01c7571b          	srliw	a4,a4,0x1c
 24a:	00d707bb          	addw	a5,a4,a3
 24e:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 250:	9f99                	subw	a5,a5,a4
 252:	078e                	slli	a5,a5,0x3
 254:	97b2                	add	a5,a5,a2
 256:	639c                	ld	a5,0(a5)
 258:	d3f5                	beqz	a5,23c <tsched+0x10>
 25a:	5fb8                	lw	a4,120(a5)
 25c:	fea710e3          	bne	a4,a0,23c <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 260:	00001717          	auipc	a4,0x1
 264:	dc073703          	ld	a4,-576(a4) # 1020 <threads>
 268:	5f30                	lw	a2,120(a4)
 26a:	468d                	li	a3,3
 26c:	06d60363          	beq	a2,a3,2d2 <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 270:	c3a5                	beqz	a5,2d0 <tsched+0xa4>
{
 272:	1101                	addi	sp,sp,-32
 274:	ec06                	sd	ra,24(sp)
 276:	e822                	sd	s0,16(sp)
 278:	e426                	sd	s1,8(sp)
 27a:	e04a                	sd	s2,0(sp)
 27c:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 27e:	00001497          	auipc	s1,0x1
 282:	d9248493          	addi	s1,s1,-622 # 1010 <current_thread>
 286:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 28a:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 28c:	0007c603          	lbu	a2,0(a5)
 290:	00094583          	lbu	a1,0(s2)
 294:	00001517          	auipc	a0,0x1
 298:	aec50513          	addi	a0,a0,-1300 # d80 <malloc+0x180>
 29c:	00001097          	auipc	ra,0x1
 2a0:	8ac080e7          	jalr	-1876(ra) # b48 <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 2a4:	608c                	ld	a1,0(s1)
 2a6:	05a1                	addi	a1,a1,8
 2a8:	00890513          	addi	a0,s2,8
 2ac:	00000097          	auipc	ra,0x0
 2b0:	184080e7          	jalr	388(ra) # 430 <tswtch>
        printf("Thread switch complete\n");
 2b4:	00001517          	auipc	a0,0x1
 2b8:	af450513          	addi	a0,a0,-1292 # da8 <malloc+0x1a8>
 2bc:	00001097          	auipc	ra,0x1
 2c0:	88c080e7          	jalr	-1908(ra) # b48 <printf>
    }
}
 2c4:	60e2                	ld	ra,24(sp)
 2c6:	6442                	ld	s0,16(sp)
 2c8:	64a2                	ld	s1,8(sp)
 2ca:	6902                	ld	s2,0(sp)
 2cc:	6105                	addi	sp,sp,32
 2ce:	8082                	ret
 2d0:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 2d2:	87ba                	mv	a5,a4
 2d4:	bf79                	j	272 <tsched+0x46>
 2d6:	00001797          	auipc	a5,0x1
 2da:	d4a7b783          	ld	a5,-694(a5) # 1020 <threads>
 2de:	5fb4                	lw	a3,120(a5)
 2e0:	470d                	li	a4,3
 2e2:	f8e688e3          	beq	a3,a4,272 <tsched+0x46>
 2e6:	8082                	ret

00000000000002e8 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 2e8:	7179                	addi	sp,sp,-48
 2ea:	f406                	sd	ra,40(sp)
 2ec:	f022                	sd	s0,32(sp)
 2ee:	ec26                	sd	s1,24(sp)
 2f0:	e84a                	sd	s2,16(sp)
 2f2:	e44e                	sd	s3,8(sp)
 2f4:	1800                	addi	s0,sp,48
 2f6:	84aa                	mv	s1,a0
 2f8:	89b2                	mv	s3,a2
 2fa:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 2fc:	09000513          	li	a0,144
 300:	00001097          	auipc	ra,0x1
 304:	900080e7          	jalr	-1792(ra) # c00 <malloc>
 308:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 30a:	478d                	li	a5,3
 30c:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 30e:	609c                	ld	a5,0(s1)
 310:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 314:	609c                	ld	a5,0(s1)
 316:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 31a:	00001717          	auipc	a4,0x1
 31e:	ce670713          	addi	a4,a4,-794 # 1000 <next_tid>
 322:	431c                	lw	a5,0(a4)
 324:	0017869b          	addiw	a3,a5,1
 328:	c314                	sw	a3,0(a4)
 32a:	6098                	ld	a4,0(s1)
 32c:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 330:	00001717          	auipc	a4,0x1
 334:	cf070713          	addi	a4,a4,-784 # 1020 <threads>
 338:	4781                	li	a5,0
 33a:	4641                	li	a2,16
    if (threads[i] == NULL) {
 33c:	6314                	ld	a3,0(a4)
 33e:	ce81                	beqz	a3,356 <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 340:	2785                	addiw	a5,a5,1
 342:	0721                	addi	a4,a4,8
 344:	fec79ce3          	bne	a5,a2,33c <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 348:	70a2                	ld	ra,40(sp)
 34a:	7402                	ld	s0,32(sp)
 34c:	64e2                	ld	s1,24(sp)
 34e:	6942                	ld	s2,16(sp)
 350:	69a2                	ld	s3,8(sp)
 352:	6145                	addi	sp,sp,48
 354:	8082                	ret
        threads[i] = *thread;
 356:	6094                	ld	a3,0(s1)
 358:	078e                	slli	a5,a5,0x3
 35a:	00001717          	auipc	a4,0x1
 35e:	cc670713          	addi	a4,a4,-826 # 1020 <threads>
 362:	97ba                	add	a5,a5,a4
 364:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 366:	0006c583          	lbu	a1,0(a3)
 36a:	00001517          	auipc	a0,0x1
 36e:	a5650513          	addi	a0,a0,-1450 # dc0 <malloc+0x1c0>
 372:	00000097          	auipc	ra,0x0
 376:	7d6080e7          	jalr	2006(ra) # b48 <printf>
        break;
 37a:	b7f9                	j	348 <tcreate+0x60>

000000000000037c <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 37c:	7179                	addi	sp,sp,-48
 37e:	f406                	sd	ra,40(sp)
 380:	f022                	sd	s0,32(sp)
 382:	ec26                	sd	s1,24(sp)
 384:	e84a                	sd	s2,16(sp)
 386:	e44e                	sd	s3,8(sp)
 388:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 38a:	00001797          	auipc	a5,0x1
 38e:	c9678793          	addi	a5,a5,-874 # 1020 <threads>
 392:	00001697          	auipc	a3,0x1
 396:	d0e68693          	addi	a3,a3,-754 # 10a0 <base>
 39a:	a021                	j	3a2 <tjoin+0x26>
 39c:	07a1                	addi	a5,a5,8
 39e:	04d78763          	beq	a5,a3,3ec <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 3a2:	6384                	ld	s1,0(a5)
 3a4:	dce5                	beqz	s1,39c <tjoin+0x20>
 3a6:	0004c703          	lbu	a4,0(s1)
 3aa:	fea719e3          	bne	a4,a0,39c <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 3ae:	5cb8                	lw	a4,120(s1)
 3b0:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 3b2:	00001997          	auipc	s3,0x1
 3b6:	a3e98993          	addi	s3,s3,-1474 # df0 <malloc+0x1f0>
    while (target_thread->state != EXITED) {
 3ba:	4919                	li	s2,6
 3bc:	02f70a63          	beq	a4,a5,3f0 <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 3c0:	0004c583          	lbu	a1,0(s1)
 3c4:	854e                	mv	a0,s3
 3c6:	00000097          	auipc	ra,0x0
 3ca:	782080e7          	jalr	1922(ra) # b48 <printf>
        tsched();
 3ce:	00000097          	auipc	ra,0x0
 3d2:	e5e080e7          	jalr	-418(ra) # 22c <tsched>
    while (target_thread->state != EXITED) {
 3d6:	5cbc                	lw	a5,120(s1)
 3d8:	ff2794e3          	bne	a5,s2,3c0 <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 3dc:	4501                	li	a0,0
}
 3de:	70a2                	ld	ra,40(sp)
 3e0:	7402                	ld	s0,32(sp)
 3e2:	64e2                	ld	s1,24(sp)
 3e4:	6942                	ld	s2,16(sp)
 3e6:	69a2                	ld	s3,8(sp)
 3e8:	6145                	addi	sp,sp,48
 3ea:	8082                	ret
        return -1;
 3ec:	557d                	li	a0,-1
 3ee:	bfc5                	j	3de <tjoin+0x62>
    return 0;
 3f0:	4501                	li	a0,0
 3f2:	b7f5                	j	3de <tjoin+0x62>

00000000000003f4 <tyield>:


void tyield()
{
 3f4:	1141                	addi	sp,sp,-16
 3f6:	e406                	sd	ra,8(sp)
 3f8:	e022                	sd	s0,0(sp)
 3fa:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 3fc:	00001797          	auipc	a5,0x1
 400:	c147b783          	ld	a5,-1004(a5) # 1010 <current_thread>
 404:	470d                	li	a4,3
 406:	dfb8                	sw	a4,120(a5)
    tsched();
 408:	00000097          	auipc	ra,0x0
 40c:	e24080e7          	jalr	-476(ra) # 22c <tsched>
}
 410:	60a2                	ld	ra,8(sp)
 412:	6402                	ld	s0,0(sp)
 414:	0141                	addi	sp,sp,16
 416:	8082                	ret

0000000000000418 <twhoami>:

uint8 twhoami()
{
 418:	1141                	addi	sp,sp,-16
 41a:	e422                	sd	s0,8(sp)
 41c:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
 41e:	00001797          	auipc	a5,0x1
 422:	bf27b783          	ld	a5,-1038(a5) # 1010 <current_thread>
 426:	0007c503          	lbu	a0,0(a5)
 42a:	6422                	ld	s0,8(sp)
 42c:	0141                	addi	sp,sp,16
 42e:	8082                	ret

0000000000000430 <tswtch>:
 430:	00153023          	sd	ra,0(a0)
 434:	00253423          	sd	sp,8(a0)
 438:	e900                	sd	s0,16(a0)
 43a:	ed04                	sd	s1,24(a0)
 43c:	03253023          	sd	s2,32(a0)
 440:	03353423          	sd	s3,40(a0)
 444:	03453823          	sd	s4,48(a0)
 448:	03553c23          	sd	s5,56(a0)
 44c:	05653023          	sd	s6,64(a0)
 450:	05753423          	sd	s7,72(a0)
 454:	05853823          	sd	s8,80(a0)
 458:	05953c23          	sd	s9,88(a0)
 45c:	07a53023          	sd	s10,96(a0)
 460:	07b53423          	sd	s11,104(a0)
 464:	0005b083          	ld	ra,0(a1)
 468:	0085b103          	ld	sp,8(a1)
 46c:	6980                	ld	s0,16(a1)
 46e:	6d84                	ld	s1,24(a1)
 470:	0205b903          	ld	s2,32(a1)
 474:	0285b983          	ld	s3,40(a1)
 478:	0305ba03          	ld	s4,48(a1)
 47c:	0385ba83          	ld	s5,56(a1)
 480:	0405bb03          	ld	s6,64(a1)
 484:	0485bb83          	ld	s7,72(a1)
 488:	0505bc03          	ld	s8,80(a1)
 48c:	0585bc83          	ld	s9,88(a1)
 490:	0605bd03          	ld	s10,96(a1)
 494:	0685bd83          	ld	s11,104(a1)
 498:	8082                	ret

000000000000049a <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 49a:	715d                	addi	sp,sp,-80
 49c:	e486                	sd	ra,72(sp)
 49e:	e0a2                	sd	s0,64(sp)
 4a0:	fc26                	sd	s1,56(sp)
 4a2:	f84a                	sd	s2,48(sp)
 4a4:	f44e                	sd	s3,40(sp)
 4a6:	f052                	sd	s4,32(sp)
 4a8:	ec56                	sd	s5,24(sp)
 4aa:	e85a                	sd	s6,16(sp)
 4ac:	e45e                	sd	s7,8(sp)
 4ae:	0880                	addi	s0,sp,80
 4b0:	892a                	mv	s2,a0
 4b2:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 4b4:	00001517          	auipc	a0,0x1
 4b8:	95c50513          	addi	a0,a0,-1700 # e10 <malloc+0x210>
 4bc:	00000097          	auipc	ra,0x0
 4c0:	68c080e7          	jalr	1676(ra) # b48 <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 4c4:	09000513          	li	a0,144
 4c8:	00000097          	auipc	ra,0x0
 4cc:	738080e7          	jalr	1848(ra) # c00 <malloc>

    main_thread->tid = 0;
 4d0:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 4d4:	4791                	li	a5,4
 4d6:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 4d8:	00001797          	auipc	a5,0x1
 4dc:	b2a7bc23          	sd	a0,-1224(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 4e0:	00001a17          	auipc	s4,0x1
 4e4:	b40a0a13          	addi	s4,s4,-1216 # 1020 <threads>
 4e8:	00001497          	auipc	s1,0x1
 4ec:	bb848493          	addi	s1,s1,-1096 # 10a0 <base>
    current_thread = main_thread;
 4f0:	87d2                	mv	a5,s4
        threads[i] = NULL;
 4f2:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 4f6:	07a1                	addi	a5,a5,8
 4f8:	fe979de3          	bne	a5,s1,4f2 <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 4fc:	00001797          	auipc	a5,0x1
 500:	b2a7b223          	sd	a0,-1244(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 504:	85ce                	mv	a1,s3
 506:	854a                	mv	a0,s2
 508:	00000097          	auipc	ra,0x0
 50c:	af8080e7          	jalr	-1288(ra) # 0 <main>
 510:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 512:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 514:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 516:	00001a97          	auipc	s5,0x1
 51a:	91aa8a93          	addi	s5,s5,-1766 # e30 <malloc+0x230>
 51e:	a03d                	j	54c <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 520:	07a1                	addi	a5,a5,8
 522:	00978963          	beq	a5,s1,534 <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 526:	6398                	ld	a4,0(a5)
 528:	df65                	beqz	a4,520 <_main+0x86>
 52a:	5f38                	lw	a4,120(a4)
 52c:	ff370ae3          	beq	a4,s3,520 <_main+0x86>
                running_threads++;
 530:	2905                	addiw	s2,s2,1
 532:	b7fd                	j	520 <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 534:	85ca                	mv	a1,s2
 536:	8556                	mv	a0,s5
 538:	00000097          	auipc	ra,0x0
 53c:	610080e7          	jalr	1552(ra) # b48 <printf>
        if (running_threads > 0) {
 540:	01205963          	blez	s2,552 <_main+0xb8>
            tsched(); // Schedule another thread to run
 544:	00000097          	auipc	ra,0x0
 548:	ce8080e7          	jalr	-792(ra) # 22c <tsched>
    current_thread = main_thread;
 54c:	87d2                	mv	a5,s4
        running_threads = 0;
 54e:	895a                	mv	s2,s6
 550:	bfd9                	j	526 <_main+0x8c>
        }
    }

    exit(res);
 552:	855e                	mv	a0,s7
 554:	00000097          	auipc	ra,0x0
 558:	274080e7          	jalr	628(ra) # 7c8 <exit>

000000000000055c <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 55c:	1141                	addi	sp,sp,-16
 55e:	e422                	sd	s0,8(sp)
 560:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 562:	87aa                	mv	a5,a0
 564:	0585                	addi	a1,a1,1
 566:	0785                	addi	a5,a5,1
 568:	fff5c703          	lbu	a4,-1(a1)
 56c:	fee78fa3          	sb	a4,-1(a5)
 570:	fb75                	bnez	a4,564 <strcpy+0x8>
        ;
    return os;
}
 572:	6422                	ld	s0,8(sp)
 574:	0141                	addi	sp,sp,16
 576:	8082                	ret

0000000000000578 <strcmp>:

int strcmp(const char *p, const char *q)
{
 578:	1141                	addi	sp,sp,-16
 57a:	e422                	sd	s0,8(sp)
 57c:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 57e:	00054783          	lbu	a5,0(a0)
 582:	cb91                	beqz	a5,596 <strcmp+0x1e>
 584:	0005c703          	lbu	a4,0(a1)
 588:	00f71763          	bne	a4,a5,596 <strcmp+0x1e>
        p++, q++;
 58c:	0505                	addi	a0,a0,1
 58e:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 590:	00054783          	lbu	a5,0(a0)
 594:	fbe5                	bnez	a5,584 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 596:	0005c503          	lbu	a0,0(a1)
}
 59a:	40a7853b          	subw	a0,a5,a0
 59e:	6422                	ld	s0,8(sp)
 5a0:	0141                	addi	sp,sp,16
 5a2:	8082                	ret

00000000000005a4 <strlen>:

uint strlen(const char *s)
{
 5a4:	1141                	addi	sp,sp,-16
 5a6:	e422                	sd	s0,8(sp)
 5a8:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 5aa:	00054783          	lbu	a5,0(a0)
 5ae:	cf91                	beqz	a5,5ca <strlen+0x26>
 5b0:	0505                	addi	a0,a0,1
 5b2:	87aa                	mv	a5,a0
 5b4:	86be                	mv	a3,a5
 5b6:	0785                	addi	a5,a5,1
 5b8:	fff7c703          	lbu	a4,-1(a5)
 5bc:	ff65                	bnez	a4,5b4 <strlen+0x10>
 5be:	40a6853b          	subw	a0,a3,a0
 5c2:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 5c4:	6422                	ld	s0,8(sp)
 5c6:	0141                	addi	sp,sp,16
 5c8:	8082                	ret
    for (n = 0; s[n]; n++)
 5ca:	4501                	li	a0,0
 5cc:	bfe5                	j	5c4 <strlen+0x20>

00000000000005ce <memset>:

void *
memset(void *dst, int c, uint n)
{
 5ce:	1141                	addi	sp,sp,-16
 5d0:	e422                	sd	s0,8(sp)
 5d2:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 5d4:	ca19                	beqz	a2,5ea <memset+0x1c>
 5d6:	87aa                	mv	a5,a0
 5d8:	1602                	slli	a2,a2,0x20
 5da:	9201                	srli	a2,a2,0x20
 5dc:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 5e0:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 5e4:	0785                	addi	a5,a5,1
 5e6:	fee79de3          	bne	a5,a4,5e0 <memset+0x12>
    }
    return dst;
}
 5ea:	6422                	ld	s0,8(sp)
 5ec:	0141                	addi	sp,sp,16
 5ee:	8082                	ret

00000000000005f0 <strchr>:

char *
strchr(const char *s, char c)
{
 5f0:	1141                	addi	sp,sp,-16
 5f2:	e422                	sd	s0,8(sp)
 5f4:	0800                	addi	s0,sp,16
    for (; *s; s++)
 5f6:	00054783          	lbu	a5,0(a0)
 5fa:	cb99                	beqz	a5,610 <strchr+0x20>
        if (*s == c)
 5fc:	00f58763          	beq	a1,a5,60a <strchr+0x1a>
    for (; *s; s++)
 600:	0505                	addi	a0,a0,1
 602:	00054783          	lbu	a5,0(a0)
 606:	fbfd                	bnez	a5,5fc <strchr+0xc>
            return (char *)s;
    return 0;
 608:	4501                	li	a0,0
}
 60a:	6422                	ld	s0,8(sp)
 60c:	0141                	addi	sp,sp,16
 60e:	8082                	ret
    return 0;
 610:	4501                	li	a0,0
 612:	bfe5                	j	60a <strchr+0x1a>

0000000000000614 <gets>:

char *
gets(char *buf, int max)
{
 614:	711d                	addi	sp,sp,-96
 616:	ec86                	sd	ra,88(sp)
 618:	e8a2                	sd	s0,80(sp)
 61a:	e4a6                	sd	s1,72(sp)
 61c:	e0ca                	sd	s2,64(sp)
 61e:	fc4e                	sd	s3,56(sp)
 620:	f852                	sd	s4,48(sp)
 622:	f456                	sd	s5,40(sp)
 624:	f05a                	sd	s6,32(sp)
 626:	ec5e                	sd	s7,24(sp)
 628:	1080                	addi	s0,sp,96
 62a:	8baa                	mv	s7,a0
 62c:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 62e:	892a                	mv	s2,a0
 630:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 632:	4aa9                	li	s5,10
 634:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 636:	89a6                	mv	s3,s1
 638:	2485                	addiw	s1,s1,1
 63a:	0344d863          	bge	s1,s4,66a <gets+0x56>
        cc = read(0, &c, 1);
 63e:	4605                	li	a2,1
 640:	faf40593          	addi	a1,s0,-81
 644:	4501                	li	a0,0
 646:	00000097          	auipc	ra,0x0
 64a:	19a080e7          	jalr	410(ra) # 7e0 <read>
        if (cc < 1)
 64e:	00a05e63          	blez	a0,66a <gets+0x56>
        buf[i++] = c;
 652:	faf44783          	lbu	a5,-81(s0)
 656:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 65a:	01578763          	beq	a5,s5,668 <gets+0x54>
 65e:	0905                	addi	s2,s2,1
 660:	fd679be3          	bne	a5,s6,636 <gets+0x22>
    for (i = 0; i + 1 < max;)
 664:	89a6                	mv	s3,s1
 666:	a011                	j	66a <gets+0x56>
 668:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 66a:	99de                	add	s3,s3,s7
 66c:	00098023          	sb	zero,0(s3)
    return buf;
}
 670:	855e                	mv	a0,s7
 672:	60e6                	ld	ra,88(sp)
 674:	6446                	ld	s0,80(sp)
 676:	64a6                	ld	s1,72(sp)
 678:	6906                	ld	s2,64(sp)
 67a:	79e2                	ld	s3,56(sp)
 67c:	7a42                	ld	s4,48(sp)
 67e:	7aa2                	ld	s5,40(sp)
 680:	7b02                	ld	s6,32(sp)
 682:	6be2                	ld	s7,24(sp)
 684:	6125                	addi	sp,sp,96
 686:	8082                	ret

0000000000000688 <stat>:

int stat(const char *n, struct stat *st)
{
 688:	1101                	addi	sp,sp,-32
 68a:	ec06                	sd	ra,24(sp)
 68c:	e822                	sd	s0,16(sp)
 68e:	e426                	sd	s1,8(sp)
 690:	e04a                	sd	s2,0(sp)
 692:	1000                	addi	s0,sp,32
 694:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 696:	4581                	li	a1,0
 698:	00000097          	auipc	ra,0x0
 69c:	170080e7          	jalr	368(ra) # 808 <open>
    if (fd < 0)
 6a0:	02054563          	bltz	a0,6ca <stat+0x42>
 6a4:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 6a6:	85ca                	mv	a1,s2
 6a8:	00000097          	auipc	ra,0x0
 6ac:	178080e7          	jalr	376(ra) # 820 <fstat>
 6b0:	892a                	mv	s2,a0
    close(fd);
 6b2:	8526                	mv	a0,s1
 6b4:	00000097          	auipc	ra,0x0
 6b8:	13c080e7          	jalr	316(ra) # 7f0 <close>
    return r;
}
 6bc:	854a                	mv	a0,s2
 6be:	60e2                	ld	ra,24(sp)
 6c0:	6442                	ld	s0,16(sp)
 6c2:	64a2                	ld	s1,8(sp)
 6c4:	6902                	ld	s2,0(sp)
 6c6:	6105                	addi	sp,sp,32
 6c8:	8082                	ret
        return -1;
 6ca:	597d                	li	s2,-1
 6cc:	bfc5                	j	6bc <stat+0x34>

00000000000006ce <atoi>:

int atoi(const char *s)
{
 6ce:	1141                	addi	sp,sp,-16
 6d0:	e422                	sd	s0,8(sp)
 6d2:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 6d4:	00054683          	lbu	a3,0(a0)
 6d8:	fd06879b          	addiw	a5,a3,-48
 6dc:	0ff7f793          	zext.b	a5,a5
 6e0:	4625                	li	a2,9
 6e2:	02f66863          	bltu	a2,a5,712 <atoi+0x44>
 6e6:	872a                	mv	a4,a0
    n = 0;
 6e8:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 6ea:	0705                	addi	a4,a4,1
 6ec:	0025179b          	slliw	a5,a0,0x2
 6f0:	9fa9                	addw	a5,a5,a0
 6f2:	0017979b          	slliw	a5,a5,0x1
 6f6:	9fb5                	addw	a5,a5,a3
 6f8:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 6fc:	00074683          	lbu	a3,0(a4)
 700:	fd06879b          	addiw	a5,a3,-48
 704:	0ff7f793          	zext.b	a5,a5
 708:	fef671e3          	bgeu	a2,a5,6ea <atoi+0x1c>
    return n;
}
 70c:	6422                	ld	s0,8(sp)
 70e:	0141                	addi	sp,sp,16
 710:	8082                	ret
    n = 0;
 712:	4501                	li	a0,0
 714:	bfe5                	j	70c <atoi+0x3e>

0000000000000716 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 716:	1141                	addi	sp,sp,-16
 718:	e422                	sd	s0,8(sp)
 71a:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 71c:	02b57463          	bgeu	a0,a1,744 <memmove+0x2e>
    {
        while (n-- > 0)
 720:	00c05f63          	blez	a2,73e <memmove+0x28>
 724:	1602                	slli	a2,a2,0x20
 726:	9201                	srli	a2,a2,0x20
 728:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 72c:	872a                	mv	a4,a0
            *dst++ = *src++;
 72e:	0585                	addi	a1,a1,1
 730:	0705                	addi	a4,a4,1
 732:	fff5c683          	lbu	a3,-1(a1)
 736:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 73a:	fee79ae3          	bne	a5,a4,72e <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 73e:	6422                	ld	s0,8(sp)
 740:	0141                	addi	sp,sp,16
 742:	8082                	ret
        dst += n;
 744:	00c50733          	add	a4,a0,a2
        src += n;
 748:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 74a:	fec05ae3          	blez	a2,73e <memmove+0x28>
 74e:	fff6079b          	addiw	a5,a2,-1
 752:	1782                	slli	a5,a5,0x20
 754:	9381                	srli	a5,a5,0x20
 756:	fff7c793          	not	a5,a5
 75a:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 75c:	15fd                	addi	a1,a1,-1
 75e:	177d                	addi	a4,a4,-1
 760:	0005c683          	lbu	a3,0(a1)
 764:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 768:	fee79ae3          	bne	a5,a4,75c <memmove+0x46>
 76c:	bfc9                	j	73e <memmove+0x28>

000000000000076e <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 76e:	1141                	addi	sp,sp,-16
 770:	e422                	sd	s0,8(sp)
 772:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 774:	ca05                	beqz	a2,7a4 <memcmp+0x36>
 776:	fff6069b          	addiw	a3,a2,-1
 77a:	1682                	slli	a3,a3,0x20
 77c:	9281                	srli	a3,a3,0x20
 77e:	0685                	addi	a3,a3,1
 780:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 782:	00054783          	lbu	a5,0(a0)
 786:	0005c703          	lbu	a4,0(a1)
 78a:	00e79863          	bne	a5,a4,79a <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 78e:	0505                	addi	a0,a0,1
        p2++;
 790:	0585                	addi	a1,a1,1
    while (n-- > 0)
 792:	fed518e3          	bne	a0,a3,782 <memcmp+0x14>
    }
    return 0;
 796:	4501                	li	a0,0
 798:	a019                	j	79e <memcmp+0x30>
            return *p1 - *p2;
 79a:	40e7853b          	subw	a0,a5,a4
}
 79e:	6422                	ld	s0,8(sp)
 7a0:	0141                	addi	sp,sp,16
 7a2:	8082                	ret
    return 0;
 7a4:	4501                	li	a0,0
 7a6:	bfe5                	j	79e <memcmp+0x30>

00000000000007a8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 7a8:	1141                	addi	sp,sp,-16
 7aa:	e406                	sd	ra,8(sp)
 7ac:	e022                	sd	s0,0(sp)
 7ae:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 7b0:	00000097          	auipc	ra,0x0
 7b4:	f66080e7          	jalr	-154(ra) # 716 <memmove>
}
 7b8:	60a2                	ld	ra,8(sp)
 7ba:	6402                	ld	s0,0(sp)
 7bc:	0141                	addi	sp,sp,16
 7be:	8082                	ret

00000000000007c0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 7c0:	4885                	li	a7,1
 ecall
 7c2:	00000073          	ecall
 ret
 7c6:	8082                	ret

00000000000007c8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 7c8:	4889                	li	a7,2
 ecall
 7ca:	00000073          	ecall
 ret
 7ce:	8082                	ret

00000000000007d0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 7d0:	488d                	li	a7,3
 ecall
 7d2:	00000073          	ecall
 ret
 7d6:	8082                	ret

00000000000007d8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 7d8:	4891                	li	a7,4
 ecall
 7da:	00000073          	ecall
 ret
 7de:	8082                	ret

00000000000007e0 <read>:
.global read
read:
 li a7, SYS_read
 7e0:	4895                	li	a7,5
 ecall
 7e2:	00000073          	ecall
 ret
 7e6:	8082                	ret

00000000000007e8 <write>:
.global write
write:
 li a7, SYS_write
 7e8:	48c1                	li	a7,16
 ecall
 7ea:	00000073          	ecall
 ret
 7ee:	8082                	ret

00000000000007f0 <close>:
.global close
close:
 li a7, SYS_close
 7f0:	48d5                	li	a7,21
 ecall
 7f2:	00000073          	ecall
 ret
 7f6:	8082                	ret

00000000000007f8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 7f8:	4899                	li	a7,6
 ecall
 7fa:	00000073          	ecall
 ret
 7fe:	8082                	ret

0000000000000800 <exec>:
.global exec
exec:
 li a7, SYS_exec
 800:	489d                	li	a7,7
 ecall
 802:	00000073          	ecall
 ret
 806:	8082                	ret

0000000000000808 <open>:
.global open
open:
 li a7, SYS_open
 808:	48bd                	li	a7,15
 ecall
 80a:	00000073          	ecall
 ret
 80e:	8082                	ret

0000000000000810 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 810:	48c5                	li	a7,17
 ecall
 812:	00000073          	ecall
 ret
 816:	8082                	ret

0000000000000818 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 818:	48c9                	li	a7,18
 ecall
 81a:	00000073          	ecall
 ret
 81e:	8082                	ret

0000000000000820 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 820:	48a1                	li	a7,8
 ecall
 822:	00000073          	ecall
 ret
 826:	8082                	ret

0000000000000828 <link>:
.global link
link:
 li a7, SYS_link
 828:	48cd                	li	a7,19
 ecall
 82a:	00000073          	ecall
 ret
 82e:	8082                	ret

0000000000000830 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 830:	48d1                	li	a7,20
 ecall
 832:	00000073          	ecall
 ret
 836:	8082                	ret

0000000000000838 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 838:	48a5                	li	a7,9
 ecall
 83a:	00000073          	ecall
 ret
 83e:	8082                	ret

0000000000000840 <dup>:
.global dup
dup:
 li a7, SYS_dup
 840:	48a9                	li	a7,10
 ecall
 842:	00000073          	ecall
 ret
 846:	8082                	ret

0000000000000848 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 848:	48ad                	li	a7,11
 ecall
 84a:	00000073          	ecall
 ret
 84e:	8082                	ret

0000000000000850 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 850:	48b1                	li	a7,12
 ecall
 852:	00000073          	ecall
 ret
 856:	8082                	ret

0000000000000858 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 858:	48b5                	li	a7,13
 ecall
 85a:	00000073          	ecall
 ret
 85e:	8082                	ret

0000000000000860 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 860:	48b9                	li	a7,14
 ecall
 862:	00000073          	ecall
 ret
 866:	8082                	ret

0000000000000868 <ps>:
.global ps
ps:
 li a7, SYS_ps
 868:	48d9                	li	a7,22
 ecall
 86a:	00000073          	ecall
 ret
 86e:	8082                	ret

0000000000000870 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 870:	48dd                	li	a7,23
 ecall
 872:	00000073          	ecall
 ret
 876:	8082                	ret

0000000000000878 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 878:	48e1                	li	a7,24
 ecall
 87a:	00000073          	ecall
 ret
 87e:	8082                	ret

0000000000000880 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 880:	1101                	addi	sp,sp,-32
 882:	ec06                	sd	ra,24(sp)
 884:	e822                	sd	s0,16(sp)
 886:	1000                	addi	s0,sp,32
 888:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 88c:	4605                	li	a2,1
 88e:	fef40593          	addi	a1,s0,-17
 892:	00000097          	auipc	ra,0x0
 896:	f56080e7          	jalr	-170(ra) # 7e8 <write>
}
 89a:	60e2                	ld	ra,24(sp)
 89c:	6442                	ld	s0,16(sp)
 89e:	6105                	addi	sp,sp,32
 8a0:	8082                	ret

00000000000008a2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 8a2:	7139                	addi	sp,sp,-64
 8a4:	fc06                	sd	ra,56(sp)
 8a6:	f822                	sd	s0,48(sp)
 8a8:	f426                	sd	s1,40(sp)
 8aa:	f04a                	sd	s2,32(sp)
 8ac:	ec4e                	sd	s3,24(sp)
 8ae:	0080                	addi	s0,sp,64
 8b0:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 8b2:	c299                	beqz	a3,8b8 <printint+0x16>
 8b4:	0805c963          	bltz	a1,946 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 8b8:	2581                	sext.w	a1,a1
  neg = 0;
 8ba:	4881                	li	a7,0
 8bc:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 8c0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 8c2:	2601                	sext.w	a2,a2
 8c4:	00000517          	auipc	a0,0x0
 8c8:	5ec50513          	addi	a0,a0,1516 # eb0 <digits>
 8cc:	883a                	mv	a6,a4
 8ce:	2705                	addiw	a4,a4,1
 8d0:	02c5f7bb          	remuw	a5,a1,a2
 8d4:	1782                	slli	a5,a5,0x20
 8d6:	9381                	srli	a5,a5,0x20
 8d8:	97aa                	add	a5,a5,a0
 8da:	0007c783          	lbu	a5,0(a5)
 8de:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 8e2:	0005879b          	sext.w	a5,a1
 8e6:	02c5d5bb          	divuw	a1,a1,a2
 8ea:	0685                	addi	a3,a3,1
 8ec:	fec7f0e3          	bgeu	a5,a2,8cc <printint+0x2a>
  if(neg)
 8f0:	00088c63          	beqz	a7,908 <printint+0x66>
    buf[i++] = '-';
 8f4:	fd070793          	addi	a5,a4,-48
 8f8:	00878733          	add	a4,a5,s0
 8fc:	02d00793          	li	a5,45
 900:	fef70823          	sb	a5,-16(a4)
 904:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 908:	02e05863          	blez	a4,938 <printint+0x96>
 90c:	fc040793          	addi	a5,s0,-64
 910:	00e78933          	add	s2,a5,a4
 914:	fff78993          	addi	s3,a5,-1
 918:	99ba                	add	s3,s3,a4
 91a:	377d                	addiw	a4,a4,-1
 91c:	1702                	slli	a4,a4,0x20
 91e:	9301                	srli	a4,a4,0x20
 920:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 924:	fff94583          	lbu	a1,-1(s2)
 928:	8526                	mv	a0,s1
 92a:	00000097          	auipc	ra,0x0
 92e:	f56080e7          	jalr	-170(ra) # 880 <putc>
  while(--i >= 0)
 932:	197d                	addi	s2,s2,-1
 934:	ff3918e3          	bne	s2,s3,924 <printint+0x82>
}
 938:	70e2                	ld	ra,56(sp)
 93a:	7442                	ld	s0,48(sp)
 93c:	74a2                	ld	s1,40(sp)
 93e:	7902                	ld	s2,32(sp)
 940:	69e2                	ld	s3,24(sp)
 942:	6121                	addi	sp,sp,64
 944:	8082                	ret
    x = -xx;
 946:	40b005bb          	negw	a1,a1
    neg = 1;
 94a:	4885                	li	a7,1
    x = -xx;
 94c:	bf85                	j	8bc <printint+0x1a>

000000000000094e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 94e:	715d                	addi	sp,sp,-80
 950:	e486                	sd	ra,72(sp)
 952:	e0a2                	sd	s0,64(sp)
 954:	fc26                	sd	s1,56(sp)
 956:	f84a                	sd	s2,48(sp)
 958:	f44e                	sd	s3,40(sp)
 95a:	f052                	sd	s4,32(sp)
 95c:	ec56                	sd	s5,24(sp)
 95e:	e85a                	sd	s6,16(sp)
 960:	e45e                	sd	s7,8(sp)
 962:	e062                	sd	s8,0(sp)
 964:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 966:	0005c903          	lbu	s2,0(a1)
 96a:	18090c63          	beqz	s2,b02 <vprintf+0x1b4>
 96e:	8aaa                	mv	s5,a0
 970:	8bb2                	mv	s7,a2
 972:	00158493          	addi	s1,a1,1
  state = 0;
 976:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 978:	02500a13          	li	s4,37
 97c:	4b55                	li	s6,21
 97e:	a839                	j	99c <vprintf+0x4e>
        putc(fd, c);
 980:	85ca                	mv	a1,s2
 982:	8556                	mv	a0,s5
 984:	00000097          	auipc	ra,0x0
 988:	efc080e7          	jalr	-260(ra) # 880 <putc>
 98c:	a019                	j	992 <vprintf+0x44>
    } else if(state == '%'){
 98e:	01498d63          	beq	s3,s4,9a8 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 992:	0485                	addi	s1,s1,1
 994:	fff4c903          	lbu	s2,-1(s1)
 998:	16090563          	beqz	s2,b02 <vprintf+0x1b4>
    if(state == 0){
 99c:	fe0999e3          	bnez	s3,98e <vprintf+0x40>
      if(c == '%'){
 9a0:	ff4910e3          	bne	s2,s4,980 <vprintf+0x32>
        state = '%';
 9a4:	89d2                	mv	s3,s4
 9a6:	b7f5                	j	992 <vprintf+0x44>
      if(c == 'd'){
 9a8:	13490263          	beq	s2,s4,acc <vprintf+0x17e>
 9ac:	f9d9079b          	addiw	a5,s2,-99
 9b0:	0ff7f793          	zext.b	a5,a5
 9b4:	12fb6563          	bltu	s6,a5,ade <vprintf+0x190>
 9b8:	f9d9079b          	addiw	a5,s2,-99
 9bc:	0ff7f713          	zext.b	a4,a5
 9c0:	10eb6f63          	bltu	s6,a4,ade <vprintf+0x190>
 9c4:	00271793          	slli	a5,a4,0x2
 9c8:	00000717          	auipc	a4,0x0
 9cc:	49070713          	addi	a4,a4,1168 # e58 <malloc+0x258>
 9d0:	97ba                	add	a5,a5,a4
 9d2:	439c                	lw	a5,0(a5)
 9d4:	97ba                	add	a5,a5,a4
 9d6:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 9d8:	008b8913          	addi	s2,s7,8
 9dc:	4685                	li	a3,1
 9de:	4629                	li	a2,10
 9e0:	000ba583          	lw	a1,0(s7)
 9e4:	8556                	mv	a0,s5
 9e6:	00000097          	auipc	ra,0x0
 9ea:	ebc080e7          	jalr	-324(ra) # 8a2 <printint>
 9ee:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9f0:	4981                	li	s3,0
 9f2:	b745                	j	992 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9f4:	008b8913          	addi	s2,s7,8
 9f8:	4681                	li	a3,0
 9fa:	4629                	li	a2,10
 9fc:	000ba583          	lw	a1,0(s7)
 a00:	8556                	mv	a0,s5
 a02:	00000097          	auipc	ra,0x0
 a06:	ea0080e7          	jalr	-352(ra) # 8a2 <printint>
 a0a:	8bca                	mv	s7,s2
      state = 0;
 a0c:	4981                	li	s3,0
 a0e:	b751                	j	992 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 a10:	008b8913          	addi	s2,s7,8
 a14:	4681                	li	a3,0
 a16:	4641                	li	a2,16
 a18:	000ba583          	lw	a1,0(s7)
 a1c:	8556                	mv	a0,s5
 a1e:	00000097          	auipc	ra,0x0
 a22:	e84080e7          	jalr	-380(ra) # 8a2 <printint>
 a26:	8bca                	mv	s7,s2
      state = 0;
 a28:	4981                	li	s3,0
 a2a:	b7a5                	j	992 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 a2c:	008b8c13          	addi	s8,s7,8
 a30:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a34:	03000593          	li	a1,48
 a38:	8556                	mv	a0,s5
 a3a:	00000097          	auipc	ra,0x0
 a3e:	e46080e7          	jalr	-442(ra) # 880 <putc>
  putc(fd, 'x');
 a42:	07800593          	li	a1,120
 a46:	8556                	mv	a0,s5
 a48:	00000097          	auipc	ra,0x0
 a4c:	e38080e7          	jalr	-456(ra) # 880 <putc>
 a50:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a52:	00000b97          	auipc	s7,0x0
 a56:	45eb8b93          	addi	s7,s7,1118 # eb0 <digits>
 a5a:	03c9d793          	srli	a5,s3,0x3c
 a5e:	97de                	add	a5,a5,s7
 a60:	0007c583          	lbu	a1,0(a5)
 a64:	8556                	mv	a0,s5
 a66:	00000097          	auipc	ra,0x0
 a6a:	e1a080e7          	jalr	-486(ra) # 880 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a6e:	0992                	slli	s3,s3,0x4
 a70:	397d                	addiw	s2,s2,-1
 a72:	fe0914e3          	bnez	s2,a5a <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 a76:	8be2                	mv	s7,s8
      state = 0;
 a78:	4981                	li	s3,0
 a7a:	bf21                	j	992 <vprintf+0x44>
        s = va_arg(ap, char*);
 a7c:	008b8993          	addi	s3,s7,8
 a80:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a84:	02090163          	beqz	s2,aa6 <vprintf+0x158>
        while(*s != 0){
 a88:	00094583          	lbu	a1,0(s2)
 a8c:	c9a5                	beqz	a1,afc <vprintf+0x1ae>
          putc(fd, *s);
 a8e:	8556                	mv	a0,s5
 a90:	00000097          	auipc	ra,0x0
 a94:	df0080e7          	jalr	-528(ra) # 880 <putc>
          s++;
 a98:	0905                	addi	s2,s2,1
        while(*s != 0){
 a9a:	00094583          	lbu	a1,0(s2)
 a9e:	f9e5                	bnez	a1,a8e <vprintf+0x140>
        s = va_arg(ap, char*);
 aa0:	8bce                	mv	s7,s3
      state = 0;
 aa2:	4981                	li	s3,0
 aa4:	b5fd                	j	992 <vprintf+0x44>
          s = "(null)";
 aa6:	00000917          	auipc	s2,0x0
 aaa:	3aa90913          	addi	s2,s2,938 # e50 <malloc+0x250>
        while(*s != 0){
 aae:	02800593          	li	a1,40
 ab2:	bff1                	j	a8e <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 ab4:	008b8913          	addi	s2,s7,8
 ab8:	000bc583          	lbu	a1,0(s7)
 abc:	8556                	mv	a0,s5
 abe:	00000097          	auipc	ra,0x0
 ac2:	dc2080e7          	jalr	-574(ra) # 880 <putc>
 ac6:	8bca                	mv	s7,s2
      state = 0;
 ac8:	4981                	li	s3,0
 aca:	b5e1                	j	992 <vprintf+0x44>
        putc(fd, c);
 acc:	02500593          	li	a1,37
 ad0:	8556                	mv	a0,s5
 ad2:	00000097          	auipc	ra,0x0
 ad6:	dae080e7          	jalr	-594(ra) # 880 <putc>
      state = 0;
 ada:	4981                	li	s3,0
 adc:	bd5d                	j	992 <vprintf+0x44>
        putc(fd, '%');
 ade:	02500593          	li	a1,37
 ae2:	8556                	mv	a0,s5
 ae4:	00000097          	auipc	ra,0x0
 ae8:	d9c080e7          	jalr	-612(ra) # 880 <putc>
        putc(fd, c);
 aec:	85ca                	mv	a1,s2
 aee:	8556                	mv	a0,s5
 af0:	00000097          	auipc	ra,0x0
 af4:	d90080e7          	jalr	-624(ra) # 880 <putc>
      state = 0;
 af8:	4981                	li	s3,0
 afa:	bd61                	j	992 <vprintf+0x44>
        s = va_arg(ap, char*);
 afc:	8bce                	mv	s7,s3
      state = 0;
 afe:	4981                	li	s3,0
 b00:	bd49                	j	992 <vprintf+0x44>
    }
  }
}
 b02:	60a6                	ld	ra,72(sp)
 b04:	6406                	ld	s0,64(sp)
 b06:	74e2                	ld	s1,56(sp)
 b08:	7942                	ld	s2,48(sp)
 b0a:	79a2                	ld	s3,40(sp)
 b0c:	7a02                	ld	s4,32(sp)
 b0e:	6ae2                	ld	s5,24(sp)
 b10:	6b42                	ld	s6,16(sp)
 b12:	6ba2                	ld	s7,8(sp)
 b14:	6c02                	ld	s8,0(sp)
 b16:	6161                	addi	sp,sp,80
 b18:	8082                	ret

0000000000000b1a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b1a:	715d                	addi	sp,sp,-80
 b1c:	ec06                	sd	ra,24(sp)
 b1e:	e822                	sd	s0,16(sp)
 b20:	1000                	addi	s0,sp,32
 b22:	e010                	sd	a2,0(s0)
 b24:	e414                	sd	a3,8(s0)
 b26:	e818                	sd	a4,16(s0)
 b28:	ec1c                	sd	a5,24(s0)
 b2a:	03043023          	sd	a6,32(s0)
 b2e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b32:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b36:	8622                	mv	a2,s0
 b38:	00000097          	auipc	ra,0x0
 b3c:	e16080e7          	jalr	-490(ra) # 94e <vprintf>
}
 b40:	60e2                	ld	ra,24(sp)
 b42:	6442                	ld	s0,16(sp)
 b44:	6161                	addi	sp,sp,80
 b46:	8082                	ret

0000000000000b48 <printf>:

void
printf(const char *fmt, ...)
{
 b48:	711d                	addi	sp,sp,-96
 b4a:	ec06                	sd	ra,24(sp)
 b4c:	e822                	sd	s0,16(sp)
 b4e:	1000                	addi	s0,sp,32
 b50:	e40c                	sd	a1,8(s0)
 b52:	e810                	sd	a2,16(s0)
 b54:	ec14                	sd	a3,24(s0)
 b56:	f018                	sd	a4,32(s0)
 b58:	f41c                	sd	a5,40(s0)
 b5a:	03043823          	sd	a6,48(s0)
 b5e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b62:	00840613          	addi	a2,s0,8
 b66:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b6a:	85aa                	mv	a1,a0
 b6c:	4505                	li	a0,1
 b6e:	00000097          	auipc	ra,0x0
 b72:	de0080e7          	jalr	-544(ra) # 94e <vprintf>
}
 b76:	60e2                	ld	ra,24(sp)
 b78:	6442                	ld	s0,16(sp)
 b7a:	6125                	addi	sp,sp,96
 b7c:	8082                	ret

0000000000000b7e <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 b7e:	1141                	addi	sp,sp,-16
 b80:	e422                	sd	s0,8(sp)
 b82:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 b84:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b88:	00000797          	auipc	a5,0x0
 b8c:	4907b783          	ld	a5,1168(a5) # 1018 <freep>
 b90:	a02d                	j	bba <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 b92:	4618                	lw	a4,8(a2)
 b94:	9f2d                	addw	a4,a4,a1
 b96:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 b9a:	6398                	ld	a4,0(a5)
 b9c:	6310                	ld	a2,0(a4)
 b9e:	a83d                	j	bdc <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 ba0:	ff852703          	lw	a4,-8(a0)
 ba4:	9f31                	addw	a4,a4,a2
 ba6:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 ba8:	ff053683          	ld	a3,-16(a0)
 bac:	a091                	j	bf0 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bae:	6398                	ld	a4,0(a5)
 bb0:	00e7e463          	bltu	a5,a4,bb8 <free+0x3a>
 bb4:	00e6ea63          	bltu	a3,a4,bc8 <free+0x4a>
{
 bb8:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bba:	fed7fae3          	bgeu	a5,a3,bae <free+0x30>
 bbe:	6398                	ld	a4,0(a5)
 bc0:	00e6e463          	bltu	a3,a4,bc8 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bc4:	fee7eae3          	bltu	a5,a4,bb8 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 bc8:	ff852583          	lw	a1,-8(a0)
 bcc:	6390                	ld	a2,0(a5)
 bce:	02059813          	slli	a6,a1,0x20
 bd2:	01c85713          	srli	a4,a6,0x1c
 bd6:	9736                	add	a4,a4,a3
 bd8:	fae60de3          	beq	a2,a4,b92 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 bdc:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 be0:	4790                	lw	a2,8(a5)
 be2:	02061593          	slli	a1,a2,0x20
 be6:	01c5d713          	srli	a4,a1,0x1c
 bea:	973e                	add	a4,a4,a5
 bec:	fae68ae3          	beq	a3,a4,ba0 <free+0x22>
        p->s.ptr = bp->s.ptr;
 bf0:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 bf2:	00000717          	auipc	a4,0x0
 bf6:	42f73323          	sd	a5,1062(a4) # 1018 <freep>
}
 bfa:	6422                	ld	s0,8(sp)
 bfc:	0141                	addi	sp,sp,16
 bfe:	8082                	ret

0000000000000c00 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 c00:	7139                	addi	sp,sp,-64
 c02:	fc06                	sd	ra,56(sp)
 c04:	f822                	sd	s0,48(sp)
 c06:	f426                	sd	s1,40(sp)
 c08:	f04a                	sd	s2,32(sp)
 c0a:	ec4e                	sd	s3,24(sp)
 c0c:	e852                	sd	s4,16(sp)
 c0e:	e456                	sd	s5,8(sp)
 c10:	e05a                	sd	s6,0(sp)
 c12:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 c14:	02051493          	slli	s1,a0,0x20
 c18:	9081                	srli	s1,s1,0x20
 c1a:	04bd                	addi	s1,s1,15
 c1c:	8091                	srli	s1,s1,0x4
 c1e:	0014899b          	addiw	s3,s1,1
 c22:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 c24:	00000517          	auipc	a0,0x0
 c28:	3f453503          	ld	a0,1012(a0) # 1018 <freep>
 c2c:	c515                	beqz	a0,c58 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c2e:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 c30:	4798                	lw	a4,8(a5)
 c32:	02977f63          	bgeu	a4,s1,c70 <malloc+0x70>
    if (nu < 4096)
 c36:	8a4e                	mv	s4,s3
 c38:	0009871b          	sext.w	a4,s3
 c3c:	6685                	lui	a3,0x1
 c3e:	00d77363          	bgeu	a4,a3,c44 <malloc+0x44>
 c42:	6a05                	lui	s4,0x1
 c44:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 c48:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 c4c:	00000917          	auipc	s2,0x0
 c50:	3cc90913          	addi	s2,s2,972 # 1018 <freep>
    if (p == (char *)-1)
 c54:	5afd                	li	s5,-1
 c56:	a895                	j	cca <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 c58:	00000797          	auipc	a5,0x0
 c5c:	44878793          	addi	a5,a5,1096 # 10a0 <base>
 c60:	00000717          	auipc	a4,0x0
 c64:	3af73c23          	sd	a5,952(a4) # 1018 <freep>
 c68:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 c6a:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 c6e:	b7e1                	j	c36 <malloc+0x36>
            if (p->s.size == nunits)
 c70:	02e48c63          	beq	s1,a4,ca8 <malloc+0xa8>
                p->s.size -= nunits;
 c74:	4137073b          	subw	a4,a4,s3
 c78:	c798                	sw	a4,8(a5)
                p += p->s.size;
 c7a:	02071693          	slli	a3,a4,0x20
 c7e:	01c6d713          	srli	a4,a3,0x1c
 c82:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 c84:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 c88:	00000717          	auipc	a4,0x0
 c8c:	38a73823          	sd	a0,912(a4) # 1018 <freep>
            return (void *)(p + 1);
 c90:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 c94:	70e2                	ld	ra,56(sp)
 c96:	7442                	ld	s0,48(sp)
 c98:	74a2                	ld	s1,40(sp)
 c9a:	7902                	ld	s2,32(sp)
 c9c:	69e2                	ld	s3,24(sp)
 c9e:	6a42                	ld	s4,16(sp)
 ca0:	6aa2                	ld	s5,8(sp)
 ca2:	6b02                	ld	s6,0(sp)
 ca4:	6121                	addi	sp,sp,64
 ca6:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 ca8:	6398                	ld	a4,0(a5)
 caa:	e118                	sd	a4,0(a0)
 cac:	bff1                	j	c88 <malloc+0x88>
    hp->s.size = nu;
 cae:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 cb2:	0541                	addi	a0,a0,16
 cb4:	00000097          	auipc	ra,0x0
 cb8:	eca080e7          	jalr	-310(ra) # b7e <free>
    return freep;
 cbc:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 cc0:	d971                	beqz	a0,c94 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 cc2:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 cc4:	4798                	lw	a4,8(a5)
 cc6:	fa9775e3          	bgeu	a4,s1,c70 <malloc+0x70>
        if (p == freep)
 cca:	00093703          	ld	a4,0(s2)
 cce:	853e                	mv	a0,a5
 cd0:	fef719e3          	bne	a4,a5,cc2 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 cd4:	8552                	mv	a0,s4
 cd6:	00000097          	auipc	ra,0x0
 cda:	b7a080e7          	jalr	-1158(ra) # 850 <sbrk>
    if (p == (char *)-1)
 cde:	fd5518e3          	bne	a0,s5,cae <malloc+0xae>
                return 0;
 ce2:	4501                	li	a0,0
 ce4:	bf45                	j	c94 <malloc+0x94>
