
user/_time:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
    if (argc < 2)
   c:	4785                	li	a5,1
   e:	02a7db63          	bge	a5,a0,44 <main+0x44>
  12:	84ae                	mv	s1,a1
        printf("Time took 0 ticks\n");
        printf("Usage: time [exec] [arg1 arg2 ...]\n");
        exit(1);
    }

    int startticks = uptime();
  14:	00000097          	auipc	ra,0x0
  18:	7f4080e7          	jalr	2036(ra) # 808 <uptime>
  1c:	892a                	mv	s2,a0

    // we now start the program in a separate process:
    int uutPid = fork();
  1e:	00000097          	auipc	ra,0x0
  22:	74a080e7          	jalr	1866(ra) # 768 <fork>

    // check if fork worked:
    if (uutPid < 0)
  26:	04054463          	bltz	a0,6e <main+0x6e>
    {
        printf("fork failed... couldn't start %s", argv[1]);
        exit(1);
    }

    if (uutPid == 0)
  2a:	e125                	bnez	a0,8a <main+0x8a>
    {
        // we are the unit under test part of the program - execute the program immediately
        exec(argv[1], argv + 1); // pass rest of the command line to the executable as args
  2c:	00848593          	addi	a1,s1,8
  30:	6488                	ld	a0,8(s1)
  32:	00000097          	auipc	ra,0x0
  36:	776080e7          	jalr	1910(ra) # 7a8 <exec>
        // wait for the uut to finish
        wait(0);
        int endticks = uptime();
        printf("Executing %s took %d ticks\n", argv[1], endticks - startticks);
    }
    exit(0);
  3a:	4501                	li	a0,0
  3c:	00000097          	auipc	ra,0x0
  40:	734080e7          	jalr	1844(ra) # 770 <exit>
        printf("Time took 0 ticks\n");
  44:	00001517          	auipc	a0,0x1
  48:	c4c50513          	addi	a0,a0,-948 # c90 <malloc+0xe8>
  4c:	00001097          	auipc	ra,0x1
  50:	aa4080e7          	jalr	-1372(ra) # af0 <printf>
        printf("Usage: time [exec] [arg1 arg2 ...]\n");
  54:	00001517          	auipc	a0,0x1
  58:	c5450513          	addi	a0,a0,-940 # ca8 <malloc+0x100>
  5c:	00001097          	auipc	ra,0x1
  60:	a94080e7          	jalr	-1388(ra) # af0 <printf>
        exit(1);
  64:	4505                	li	a0,1
  66:	00000097          	auipc	ra,0x0
  6a:	70a080e7          	jalr	1802(ra) # 770 <exit>
        printf("fork failed... couldn't start %s", argv[1]);
  6e:	648c                	ld	a1,8(s1)
  70:	00001517          	auipc	a0,0x1
  74:	c6050513          	addi	a0,a0,-928 # cd0 <malloc+0x128>
  78:	00001097          	auipc	ra,0x1
  7c:	a78080e7          	jalr	-1416(ra) # af0 <printf>
        exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	6ee080e7          	jalr	1774(ra) # 770 <exit>
        wait(0);
  8a:	4501                	li	a0,0
  8c:	00000097          	auipc	ra,0x0
  90:	6ec080e7          	jalr	1772(ra) # 778 <wait>
        int endticks = uptime();
  94:	00000097          	auipc	ra,0x0
  98:	774080e7          	jalr	1908(ra) # 808 <uptime>
        printf("Executing %s took %d ticks\n", argv[1], endticks - startticks);
  9c:	4125063b          	subw	a2,a0,s2
  a0:	648c                	ld	a1,8(s1)
  a2:	00001517          	auipc	a0,0x1
  a6:	c5650513          	addi	a0,a0,-938 # cf8 <malloc+0x150>
  aa:	00001097          	auipc	ra,0x1
  ae:	a46080e7          	jalr	-1466(ra) # af0 <printf>
  b2:	b761                	j	3a <main+0x3a>

00000000000000b4 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  b4:	1141                	addi	sp,sp,-16
  b6:	e422                	sd	s0,8(sp)
  b8:	0800                	addi	s0,sp,16
    lk->name = name;
  ba:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  bc:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  c0:	57fd                	li	a5,-1
  c2:	00f50823          	sb	a5,16(a0)
}
  c6:	6422                	ld	s0,8(sp)
  c8:	0141                	addi	sp,sp,16
  ca:	8082                	ret

00000000000000cc <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  cc:	00054783          	lbu	a5,0(a0)
  d0:	e399                	bnez	a5,d6 <holding+0xa>
  d2:	4501                	li	a0,0
}
  d4:	8082                	ret
{
  d6:	1101                	addi	sp,sp,-32
  d8:	ec06                	sd	ra,24(sp)
  da:	e822                	sd	s0,16(sp)
  dc:	e426                	sd	s1,8(sp)
  de:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  e0:	01054483          	lbu	s1,16(a0)
  e4:	00000097          	auipc	ra,0x0
  e8:	2dc080e7          	jalr	732(ra) # 3c0 <twhoami>
  ec:	2501                	sext.w	a0,a0
  ee:	40a48533          	sub	a0,s1,a0
  f2:	00153513          	seqz	a0,a0
}
  f6:	60e2                	ld	ra,24(sp)
  f8:	6442                	ld	s0,16(sp)
  fa:	64a2                	ld	s1,8(sp)
  fc:	6105                	addi	sp,sp,32
  fe:	8082                	ret

0000000000000100 <acquire>:

void acquire(struct lock *lk)
{
 100:	7179                	addi	sp,sp,-48
 102:	f406                	sd	ra,40(sp)
 104:	f022                	sd	s0,32(sp)
 106:	ec26                	sd	s1,24(sp)
 108:	e84a                	sd	s2,16(sp)
 10a:	e44e                	sd	s3,8(sp)
 10c:	e052                	sd	s4,0(sp)
 10e:	1800                	addi	s0,sp,48
 110:	8a2a                	mv	s4,a0
    if (holding(lk))
 112:	00000097          	auipc	ra,0x0
 116:	fba080e7          	jalr	-70(ra) # cc <holding>
 11a:	e919                	bnez	a0,130 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 11c:	ffca7493          	andi	s1,s4,-4
 120:	003a7913          	andi	s2,s4,3
 124:	0039191b          	slliw	s2,s2,0x3
 128:	4985                	li	s3,1
 12a:	012999bb          	sllw	s3,s3,s2
 12e:	a015                	j	152 <acquire+0x52>
        printf("re-acquiring lock we already hold");
 130:	00001517          	auipc	a0,0x1
 134:	be850513          	addi	a0,a0,-1048 # d18 <malloc+0x170>
 138:	00001097          	auipc	ra,0x1
 13c:	9b8080e7          	jalr	-1608(ra) # af0 <printf>
        exit(-1);
 140:	557d                	li	a0,-1
 142:	00000097          	auipc	ra,0x0
 146:	62e080e7          	jalr	1582(ra) # 770 <exit>
    {
        // give up the cpu for other threads
        tyield();
 14a:	00000097          	auipc	ra,0x0
 14e:	252080e7          	jalr	594(ra) # 39c <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 152:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 156:	0127d7bb          	srlw	a5,a5,s2
 15a:	0ff7f793          	zext.b	a5,a5
 15e:	f7f5                	bnez	a5,14a <acquire+0x4a>
    }

    __sync_synchronize();
 160:	0ff0000f          	fence

    lk->tid = twhoami();
 164:	00000097          	auipc	ra,0x0
 168:	25c080e7          	jalr	604(ra) # 3c0 <twhoami>
 16c:	00aa0823          	sb	a0,16(s4)
}
 170:	70a2                	ld	ra,40(sp)
 172:	7402                	ld	s0,32(sp)
 174:	64e2                	ld	s1,24(sp)
 176:	6942                	ld	s2,16(sp)
 178:	69a2                	ld	s3,8(sp)
 17a:	6a02                	ld	s4,0(sp)
 17c:	6145                	addi	sp,sp,48
 17e:	8082                	ret

0000000000000180 <release>:

void release(struct lock *lk)
{
 180:	1101                	addi	sp,sp,-32
 182:	ec06                	sd	ra,24(sp)
 184:	e822                	sd	s0,16(sp)
 186:	e426                	sd	s1,8(sp)
 188:	1000                	addi	s0,sp,32
 18a:	84aa                	mv	s1,a0
    if (!holding(lk))
 18c:	00000097          	auipc	ra,0x0
 190:	f40080e7          	jalr	-192(ra) # cc <holding>
 194:	c11d                	beqz	a0,1ba <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 196:	57fd                	li	a5,-1
 198:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 19c:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 1a0:	0ff0000f          	fence
 1a4:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 1a8:	00000097          	auipc	ra,0x0
 1ac:	1f4080e7          	jalr	500(ra) # 39c <tyield>
}
 1b0:	60e2                	ld	ra,24(sp)
 1b2:	6442                	ld	s0,16(sp)
 1b4:	64a2                	ld	s1,8(sp)
 1b6:	6105                	addi	sp,sp,32
 1b8:	8082                	ret
        printf("releasing lock we are not holding");
 1ba:	00001517          	auipc	a0,0x1
 1be:	b8650513          	addi	a0,a0,-1146 # d40 <malloc+0x198>
 1c2:	00001097          	auipc	ra,0x1
 1c6:	92e080e7          	jalr	-1746(ra) # af0 <printf>
        exit(-1);
 1ca:	557d                	li	a0,-1
 1cc:	00000097          	auipc	ra,0x0
 1d0:	5a4080e7          	jalr	1444(ra) # 770 <exit>

00000000000001d4 <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 1d4:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1d6:	00001617          	auipc	a2,0x1
 1da:	e4a60613          	addi	a2,a2,-438 # 1020 <threads>
 1de:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 1e0:	45c1                	li	a1,16
 1e2:	a021                	j	1ea <tsched+0x16>
 1e4:	2685                	addiw	a3,a3,1
 1e6:	08b68c63          	beq	a3,a1,27e <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 1ea:	41f6d71b          	sraiw	a4,a3,0x1f
 1ee:	01c7571b          	srliw	a4,a4,0x1c
 1f2:	00d707bb          	addw	a5,a4,a3
 1f6:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 1f8:	9f99                	subw	a5,a5,a4
 1fa:	078e                	slli	a5,a5,0x3
 1fc:	97b2                	add	a5,a5,a2
 1fe:	639c                	ld	a5,0(a5)
 200:	d3f5                	beqz	a5,1e4 <tsched+0x10>
 202:	5fb8                	lw	a4,120(a5)
 204:	fea710e3          	bne	a4,a0,1e4 <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 208:	00001717          	auipc	a4,0x1
 20c:	e1873703          	ld	a4,-488(a4) # 1020 <threads>
 210:	5f30                	lw	a2,120(a4)
 212:	468d                	li	a3,3
 214:	06d60363          	beq	a2,a3,27a <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 218:	c3a5                	beqz	a5,278 <tsched+0xa4>
{
 21a:	1101                	addi	sp,sp,-32
 21c:	ec06                	sd	ra,24(sp)
 21e:	e822                	sd	s0,16(sp)
 220:	e426                	sd	s1,8(sp)
 222:	e04a                	sd	s2,0(sp)
 224:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 226:	00001497          	auipc	s1,0x1
 22a:	dea48493          	addi	s1,s1,-534 # 1010 <current_thread>
 22e:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 232:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 234:	0007c603          	lbu	a2,0(a5)
 238:	00094583          	lbu	a1,0(s2)
 23c:	00001517          	auipc	a0,0x1
 240:	b2c50513          	addi	a0,a0,-1236 # d68 <malloc+0x1c0>
 244:	00001097          	auipc	ra,0x1
 248:	8ac080e7          	jalr	-1876(ra) # af0 <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 24c:	608c                	ld	a1,0(s1)
 24e:	05a1                	addi	a1,a1,8
 250:	00890513          	addi	a0,s2,8
 254:	00000097          	auipc	ra,0x0
 258:	184080e7          	jalr	388(ra) # 3d8 <tswtch>
        printf("Thread switch complete\n");
 25c:	00001517          	auipc	a0,0x1
 260:	b3450513          	addi	a0,a0,-1228 # d90 <malloc+0x1e8>
 264:	00001097          	auipc	ra,0x1
 268:	88c080e7          	jalr	-1908(ra) # af0 <printf>
    }
}
 26c:	60e2                	ld	ra,24(sp)
 26e:	6442                	ld	s0,16(sp)
 270:	64a2                	ld	s1,8(sp)
 272:	6902                	ld	s2,0(sp)
 274:	6105                	addi	sp,sp,32
 276:	8082                	ret
 278:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 27a:	87ba                	mv	a5,a4
 27c:	bf79                	j	21a <tsched+0x46>
 27e:	00001797          	auipc	a5,0x1
 282:	da27b783          	ld	a5,-606(a5) # 1020 <threads>
 286:	5fb4                	lw	a3,120(a5)
 288:	470d                	li	a4,3
 28a:	f8e688e3          	beq	a3,a4,21a <tsched+0x46>
 28e:	8082                	ret

0000000000000290 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 290:	7179                	addi	sp,sp,-48
 292:	f406                	sd	ra,40(sp)
 294:	f022                	sd	s0,32(sp)
 296:	ec26                	sd	s1,24(sp)
 298:	e84a                	sd	s2,16(sp)
 29a:	e44e                	sd	s3,8(sp)
 29c:	1800                	addi	s0,sp,48
 29e:	84aa                	mv	s1,a0
 2a0:	89b2                	mv	s3,a2
 2a2:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 2a4:	09000513          	li	a0,144
 2a8:	00001097          	auipc	ra,0x1
 2ac:	900080e7          	jalr	-1792(ra) # ba8 <malloc>
 2b0:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 2b2:	478d                	li	a5,3
 2b4:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 2b6:	609c                	ld	a5,0(s1)
 2b8:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 2bc:	609c                	ld	a5,0(s1)
 2be:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 2c2:	00001717          	auipc	a4,0x1
 2c6:	d3e70713          	addi	a4,a4,-706 # 1000 <next_tid>
 2ca:	431c                	lw	a5,0(a4)
 2cc:	0017869b          	addiw	a3,a5,1
 2d0:	c314                	sw	a3,0(a4)
 2d2:	6098                	ld	a4,0(s1)
 2d4:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 2d8:	00001717          	auipc	a4,0x1
 2dc:	d4870713          	addi	a4,a4,-696 # 1020 <threads>
 2e0:	4781                	li	a5,0
 2e2:	4641                	li	a2,16
    if (threads[i] == NULL) {
 2e4:	6314                	ld	a3,0(a4)
 2e6:	ce81                	beqz	a3,2fe <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 2e8:	2785                	addiw	a5,a5,1
 2ea:	0721                	addi	a4,a4,8
 2ec:	fec79ce3          	bne	a5,a2,2e4 <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 2f0:	70a2                	ld	ra,40(sp)
 2f2:	7402                	ld	s0,32(sp)
 2f4:	64e2                	ld	s1,24(sp)
 2f6:	6942                	ld	s2,16(sp)
 2f8:	69a2                	ld	s3,8(sp)
 2fa:	6145                	addi	sp,sp,48
 2fc:	8082                	ret
        threads[i] = *thread;
 2fe:	6094                	ld	a3,0(s1)
 300:	078e                	slli	a5,a5,0x3
 302:	00001717          	auipc	a4,0x1
 306:	d1e70713          	addi	a4,a4,-738 # 1020 <threads>
 30a:	97ba                	add	a5,a5,a4
 30c:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 30e:	0006c583          	lbu	a1,0(a3)
 312:	00001517          	auipc	a0,0x1
 316:	a9650513          	addi	a0,a0,-1386 # da8 <malloc+0x200>
 31a:	00000097          	auipc	ra,0x0
 31e:	7d6080e7          	jalr	2006(ra) # af0 <printf>
        break;
 322:	b7f9                	j	2f0 <tcreate+0x60>

0000000000000324 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 324:	7179                	addi	sp,sp,-48
 326:	f406                	sd	ra,40(sp)
 328:	f022                	sd	s0,32(sp)
 32a:	ec26                	sd	s1,24(sp)
 32c:	e84a                	sd	s2,16(sp)
 32e:	e44e                	sd	s3,8(sp)
 330:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 332:	00001797          	auipc	a5,0x1
 336:	cee78793          	addi	a5,a5,-786 # 1020 <threads>
 33a:	00001697          	auipc	a3,0x1
 33e:	d6668693          	addi	a3,a3,-666 # 10a0 <base>
 342:	a021                	j	34a <tjoin+0x26>
 344:	07a1                	addi	a5,a5,8
 346:	04d78763          	beq	a5,a3,394 <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 34a:	6384                	ld	s1,0(a5)
 34c:	dce5                	beqz	s1,344 <tjoin+0x20>
 34e:	0004c703          	lbu	a4,0(s1)
 352:	fea719e3          	bne	a4,a0,344 <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 356:	5cb8                	lw	a4,120(s1)
 358:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 35a:	00001997          	auipc	s3,0x1
 35e:	a7e98993          	addi	s3,s3,-1410 # dd8 <malloc+0x230>
    while (target_thread->state != EXITED) {
 362:	4919                	li	s2,6
 364:	02f70a63          	beq	a4,a5,398 <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 368:	0004c583          	lbu	a1,0(s1)
 36c:	854e                	mv	a0,s3
 36e:	00000097          	auipc	ra,0x0
 372:	782080e7          	jalr	1922(ra) # af0 <printf>
        tsched();
 376:	00000097          	auipc	ra,0x0
 37a:	e5e080e7          	jalr	-418(ra) # 1d4 <tsched>
    while (target_thread->state != EXITED) {
 37e:	5cbc                	lw	a5,120(s1)
 380:	ff2794e3          	bne	a5,s2,368 <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 384:	4501                	li	a0,0
}
 386:	70a2                	ld	ra,40(sp)
 388:	7402                	ld	s0,32(sp)
 38a:	64e2                	ld	s1,24(sp)
 38c:	6942                	ld	s2,16(sp)
 38e:	69a2                	ld	s3,8(sp)
 390:	6145                	addi	sp,sp,48
 392:	8082                	ret
        return -1;
 394:	557d                	li	a0,-1
 396:	bfc5                	j	386 <tjoin+0x62>
    return 0;
 398:	4501                	li	a0,0
 39a:	b7f5                	j	386 <tjoin+0x62>

000000000000039c <tyield>:


void tyield()
{
 39c:	1141                	addi	sp,sp,-16
 39e:	e406                	sd	ra,8(sp)
 3a0:	e022                	sd	s0,0(sp)
 3a2:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 3a4:	00001797          	auipc	a5,0x1
 3a8:	c6c7b783          	ld	a5,-916(a5) # 1010 <current_thread>
 3ac:	470d                	li	a4,3
 3ae:	dfb8                	sw	a4,120(a5)
    tsched();
 3b0:	00000097          	auipc	ra,0x0
 3b4:	e24080e7          	jalr	-476(ra) # 1d4 <tsched>
}
 3b8:	60a2                	ld	ra,8(sp)
 3ba:	6402                	ld	s0,0(sp)
 3bc:	0141                	addi	sp,sp,16
 3be:	8082                	ret

00000000000003c0 <twhoami>:

uint8 twhoami()
{
 3c0:	1141                	addi	sp,sp,-16
 3c2:	e422                	sd	s0,8(sp)
 3c4:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
 3c6:	00001797          	auipc	a5,0x1
 3ca:	c4a7b783          	ld	a5,-950(a5) # 1010 <current_thread>
 3ce:	0007c503          	lbu	a0,0(a5)
 3d2:	6422                	ld	s0,8(sp)
 3d4:	0141                	addi	sp,sp,16
 3d6:	8082                	ret

00000000000003d8 <tswtch>:
 3d8:	00153023          	sd	ra,0(a0)
 3dc:	00253423          	sd	sp,8(a0)
 3e0:	e900                	sd	s0,16(a0)
 3e2:	ed04                	sd	s1,24(a0)
 3e4:	03253023          	sd	s2,32(a0)
 3e8:	03353423          	sd	s3,40(a0)
 3ec:	03453823          	sd	s4,48(a0)
 3f0:	03553c23          	sd	s5,56(a0)
 3f4:	05653023          	sd	s6,64(a0)
 3f8:	05753423          	sd	s7,72(a0)
 3fc:	05853823          	sd	s8,80(a0)
 400:	05953c23          	sd	s9,88(a0)
 404:	07a53023          	sd	s10,96(a0)
 408:	07b53423          	sd	s11,104(a0)
 40c:	0005b083          	ld	ra,0(a1)
 410:	0085b103          	ld	sp,8(a1)
 414:	6980                	ld	s0,16(a1)
 416:	6d84                	ld	s1,24(a1)
 418:	0205b903          	ld	s2,32(a1)
 41c:	0285b983          	ld	s3,40(a1)
 420:	0305ba03          	ld	s4,48(a1)
 424:	0385ba83          	ld	s5,56(a1)
 428:	0405bb03          	ld	s6,64(a1)
 42c:	0485bb83          	ld	s7,72(a1)
 430:	0505bc03          	ld	s8,80(a1)
 434:	0585bc83          	ld	s9,88(a1)
 438:	0605bd03          	ld	s10,96(a1)
 43c:	0685bd83          	ld	s11,104(a1)
 440:	8082                	ret

0000000000000442 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 442:	715d                	addi	sp,sp,-80
 444:	e486                	sd	ra,72(sp)
 446:	e0a2                	sd	s0,64(sp)
 448:	fc26                	sd	s1,56(sp)
 44a:	f84a                	sd	s2,48(sp)
 44c:	f44e                	sd	s3,40(sp)
 44e:	f052                	sd	s4,32(sp)
 450:	ec56                	sd	s5,24(sp)
 452:	e85a                	sd	s6,16(sp)
 454:	e45e                	sd	s7,8(sp)
 456:	0880                	addi	s0,sp,80
 458:	892a                	mv	s2,a0
 45a:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 45c:	00001517          	auipc	a0,0x1
 460:	99c50513          	addi	a0,a0,-1636 # df8 <malloc+0x250>
 464:	00000097          	auipc	ra,0x0
 468:	68c080e7          	jalr	1676(ra) # af0 <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 46c:	09000513          	li	a0,144
 470:	00000097          	auipc	ra,0x0
 474:	738080e7          	jalr	1848(ra) # ba8 <malloc>

    main_thread->tid = 0;
 478:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 47c:	4791                	li	a5,4
 47e:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 480:	00001797          	auipc	a5,0x1
 484:	b8a7b823          	sd	a0,-1136(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 488:	00001a17          	auipc	s4,0x1
 48c:	b98a0a13          	addi	s4,s4,-1128 # 1020 <threads>
 490:	00001497          	auipc	s1,0x1
 494:	c1048493          	addi	s1,s1,-1008 # 10a0 <base>
    current_thread = main_thread;
 498:	87d2                	mv	a5,s4
        threads[i] = NULL;
 49a:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 49e:	07a1                	addi	a5,a5,8
 4a0:	fe979de3          	bne	a5,s1,49a <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 4a4:	00001797          	auipc	a5,0x1
 4a8:	b6a7be23          	sd	a0,-1156(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 4ac:	85ce                	mv	a1,s3
 4ae:	854a                	mv	a0,s2
 4b0:	00000097          	auipc	ra,0x0
 4b4:	b50080e7          	jalr	-1200(ra) # 0 <main>
 4b8:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 4ba:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 4bc:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 4be:	00001a97          	auipc	s5,0x1
 4c2:	95aa8a93          	addi	s5,s5,-1702 # e18 <malloc+0x270>
 4c6:	a03d                	j	4f4 <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 4c8:	07a1                	addi	a5,a5,8
 4ca:	00978963          	beq	a5,s1,4dc <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 4ce:	6398                	ld	a4,0(a5)
 4d0:	df65                	beqz	a4,4c8 <_main+0x86>
 4d2:	5f38                	lw	a4,120(a4)
 4d4:	ff370ae3          	beq	a4,s3,4c8 <_main+0x86>
                running_threads++;
 4d8:	2905                	addiw	s2,s2,1
 4da:	b7fd                	j	4c8 <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 4dc:	85ca                	mv	a1,s2
 4de:	8556                	mv	a0,s5
 4e0:	00000097          	auipc	ra,0x0
 4e4:	610080e7          	jalr	1552(ra) # af0 <printf>
        if (running_threads > 0) {
 4e8:	01205963          	blez	s2,4fa <_main+0xb8>
            tsched(); // Schedule another thread to run
 4ec:	00000097          	auipc	ra,0x0
 4f0:	ce8080e7          	jalr	-792(ra) # 1d4 <tsched>
    current_thread = main_thread;
 4f4:	87d2                	mv	a5,s4
        running_threads = 0;
 4f6:	895a                	mv	s2,s6
 4f8:	bfd9                	j	4ce <_main+0x8c>
        }
    }

    exit(res);
 4fa:	855e                	mv	a0,s7
 4fc:	00000097          	auipc	ra,0x0
 500:	274080e7          	jalr	628(ra) # 770 <exit>

0000000000000504 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 504:	1141                	addi	sp,sp,-16
 506:	e422                	sd	s0,8(sp)
 508:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 50a:	87aa                	mv	a5,a0
 50c:	0585                	addi	a1,a1,1
 50e:	0785                	addi	a5,a5,1
 510:	fff5c703          	lbu	a4,-1(a1)
 514:	fee78fa3          	sb	a4,-1(a5)
 518:	fb75                	bnez	a4,50c <strcpy+0x8>
        ;
    return os;
}
 51a:	6422                	ld	s0,8(sp)
 51c:	0141                	addi	sp,sp,16
 51e:	8082                	ret

0000000000000520 <strcmp>:

int strcmp(const char *p, const char *q)
{
 520:	1141                	addi	sp,sp,-16
 522:	e422                	sd	s0,8(sp)
 524:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 526:	00054783          	lbu	a5,0(a0)
 52a:	cb91                	beqz	a5,53e <strcmp+0x1e>
 52c:	0005c703          	lbu	a4,0(a1)
 530:	00f71763          	bne	a4,a5,53e <strcmp+0x1e>
        p++, q++;
 534:	0505                	addi	a0,a0,1
 536:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 538:	00054783          	lbu	a5,0(a0)
 53c:	fbe5                	bnez	a5,52c <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 53e:	0005c503          	lbu	a0,0(a1)
}
 542:	40a7853b          	subw	a0,a5,a0
 546:	6422                	ld	s0,8(sp)
 548:	0141                	addi	sp,sp,16
 54a:	8082                	ret

000000000000054c <strlen>:

uint strlen(const char *s)
{
 54c:	1141                	addi	sp,sp,-16
 54e:	e422                	sd	s0,8(sp)
 550:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 552:	00054783          	lbu	a5,0(a0)
 556:	cf91                	beqz	a5,572 <strlen+0x26>
 558:	0505                	addi	a0,a0,1
 55a:	87aa                	mv	a5,a0
 55c:	86be                	mv	a3,a5
 55e:	0785                	addi	a5,a5,1
 560:	fff7c703          	lbu	a4,-1(a5)
 564:	ff65                	bnez	a4,55c <strlen+0x10>
 566:	40a6853b          	subw	a0,a3,a0
 56a:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 56c:	6422                	ld	s0,8(sp)
 56e:	0141                	addi	sp,sp,16
 570:	8082                	ret
    for (n = 0; s[n]; n++)
 572:	4501                	li	a0,0
 574:	bfe5                	j	56c <strlen+0x20>

0000000000000576 <memset>:

void *
memset(void *dst, int c, uint n)
{
 576:	1141                	addi	sp,sp,-16
 578:	e422                	sd	s0,8(sp)
 57a:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 57c:	ca19                	beqz	a2,592 <memset+0x1c>
 57e:	87aa                	mv	a5,a0
 580:	1602                	slli	a2,a2,0x20
 582:	9201                	srli	a2,a2,0x20
 584:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 588:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 58c:	0785                	addi	a5,a5,1
 58e:	fee79de3          	bne	a5,a4,588 <memset+0x12>
    }
    return dst;
}
 592:	6422                	ld	s0,8(sp)
 594:	0141                	addi	sp,sp,16
 596:	8082                	ret

0000000000000598 <strchr>:

char *
strchr(const char *s, char c)
{
 598:	1141                	addi	sp,sp,-16
 59a:	e422                	sd	s0,8(sp)
 59c:	0800                	addi	s0,sp,16
    for (; *s; s++)
 59e:	00054783          	lbu	a5,0(a0)
 5a2:	cb99                	beqz	a5,5b8 <strchr+0x20>
        if (*s == c)
 5a4:	00f58763          	beq	a1,a5,5b2 <strchr+0x1a>
    for (; *s; s++)
 5a8:	0505                	addi	a0,a0,1
 5aa:	00054783          	lbu	a5,0(a0)
 5ae:	fbfd                	bnez	a5,5a4 <strchr+0xc>
            return (char *)s;
    return 0;
 5b0:	4501                	li	a0,0
}
 5b2:	6422                	ld	s0,8(sp)
 5b4:	0141                	addi	sp,sp,16
 5b6:	8082                	ret
    return 0;
 5b8:	4501                	li	a0,0
 5ba:	bfe5                	j	5b2 <strchr+0x1a>

00000000000005bc <gets>:

char *
gets(char *buf, int max)
{
 5bc:	711d                	addi	sp,sp,-96
 5be:	ec86                	sd	ra,88(sp)
 5c0:	e8a2                	sd	s0,80(sp)
 5c2:	e4a6                	sd	s1,72(sp)
 5c4:	e0ca                	sd	s2,64(sp)
 5c6:	fc4e                	sd	s3,56(sp)
 5c8:	f852                	sd	s4,48(sp)
 5ca:	f456                	sd	s5,40(sp)
 5cc:	f05a                	sd	s6,32(sp)
 5ce:	ec5e                	sd	s7,24(sp)
 5d0:	1080                	addi	s0,sp,96
 5d2:	8baa                	mv	s7,a0
 5d4:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 5d6:	892a                	mv	s2,a0
 5d8:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 5da:	4aa9                	li	s5,10
 5dc:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 5de:	89a6                	mv	s3,s1
 5e0:	2485                	addiw	s1,s1,1
 5e2:	0344d863          	bge	s1,s4,612 <gets+0x56>
        cc = read(0, &c, 1);
 5e6:	4605                	li	a2,1
 5e8:	faf40593          	addi	a1,s0,-81
 5ec:	4501                	li	a0,0
 5ee:	00000097          	auipc	ra,0x0
 5f2:	19a080e7          	jalr	410(ra) # 788 <read>
        if (cc < 1)
 5f6:	00a05e63          	blez	a0,612 <gets+0x56>
        buf[i++] = c;
 5fa:	faf44783          	lbu	a5,-81(s0)
 5fe:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 602:	01578763          	beq	a5,s5,610 <gets+0x54>
 606:	0905                	addi	s2,s2,1
 608:	fd679be3          	bne	a5,s6,5de <gets+0x22>
    for (i = 0; i + 1 < max;)
 60c:	89a6                	mv	s3,s1
 60e:	a011                	j	612 <gets+0x56>
 610:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 612:	99de                	add	s3,s3,s7
 614:	00098023          	sb	zero,0(s3)
    return buf;
}
 618:	855e                	mv	a0,s7
 61a:	60e6                	ld	ra,88(sp)
 61c:	6446                	ld	s0,80(sp)
 61e:	64a6                	ld	s1,72(sp)
 620:	6906                	ld	s2,64(sp)
 622:	79e2                	ld	s3,56(sp)
 624:	7a42                	ld	s4,48(sp)
 626:	7aa2                	ld	s5,40(sp)
 628:	7b02                	ld	s6,32(sp)
 62a:	6be2                	ld	s7,24(sp)
 62c:	6125                	addi	sp,sp,96
 62e:	8082                	ret

0000000000000630 <stat>:

int stat(const char *n, struct stat *st)
{
 630:	1101                	addi	sp,sp,-32
 632:	ec06                	sd	ra,24(sp)
 634:	e822                	sd	s0,16(sp)
 636:	e426                	sd	s1,8(sp)
 638:	e04a                	sd	s2,0(sp)
 63a:	1000                	addi	s0,sp,32
 63c:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 63e:	4581                	li	a1,0
 640:	00000097          	auipc	ra,0x0
 644:	170080e7          	jalr	368(ra) # 7b0 <open>
    if (fd < 0)
 648:	02054563          	bltz	a0,672 <stat+0x42>
 64c:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 64e:	85ca                	mv	a1,s2
 650:	00000097          	auipc	ra,0x0
 654:	178080e7          	jalr	376(ra) # 7c8 <fstat>
 658:	892a                	mv	s2,a0
    close(fd);
 65a:	8526                	mv	a0,s1
 65c:	00000097          	auipc	ra,0x0
 660:	13c080e7          	jalr	316(ra) # 798 <close>
    return r;
}
 664:	854a                	mv	a0,s2
 666:	60e2                	ld	ra,24(sp)
 668:	6442                	ld	s0,16(sp)
 66a:	64a2                	ld	s1,8(sp)
 66c:	6902                	ld	s2,0(sp)
 66e:	6105                	addi	sp,sp,32
 670:	8082                	ret
        return -1;
 672:	597d                	li	s2,-1
 674:	bfc5                	j	664 <stat+0x34>

0000000000000676 <atoi>:

int atoi(const char *s)
{
 676:	1141                	addi	sp,sp,-16
 678:	e422                	sd	s0,8(sp)
 67a:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 67c:	00054683          	lbu	a3,0(a0)
 680:	fd06879b          	addiw	a5,a3,-48
 684:	0ff7f793          	zext.b	a5,a5
 688:	4625                	li	a2,9
 68a:	02f66863          	bltu	a2,a5,6ba <atoi+0x44>
 68e:	872a                	mv	a4,a0
    n = 0;
 690:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 692:	0705                	addi	a4,a4,1
 694:	0025179b          	slliw	a5,a0,0x2
 698:	9fa9                	addw	a5,a5,a0
 69a:	0017979b          	slliw	a5,a5,0x1
 69e:	9fb5                	addw	a5,a5,a3
 6a0:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 6a4:	00074683          	lbu	a3,0(a4)
 6a8:	fd06879b          	addiw	a5,a3,-48
 6ac:	0ff7f793          	zext.b	a5,a5
 6b0:	fef671e3          	bgeu	a2,a5,692 <atoi+0x1c>
    return n;
}
 6b4:	6422                	ld	s0,8(sp)
 6b6:	0141                	addi	sp,sp,16
 6b8:	8082                	ret
    n = 0;
 6ba:	4501                	li	a0,0
 6bc:	bfe5                	j	6b4 <atoi+0x3e>

00000000000006be <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 6be:	1141                	addi	sp,sp,-16
 6c0:	e422                	sd	s0,8(sp)
 6c2:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 6c4:	02b57463          	bgeu	a0,a1,6ec <memmove+0x2e>
    {
        while (n-- > 0)
 6c8:	00c05f63          	blez	a2,6e6 <memmove+0x28>
 6cc:	1602                	slli	a2,a2,0x20
 6ce:	9201                	srli	a2,a2,0x20
 6d0:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 6d4:	872a                	mv	a4,a0
            *dst++ = *src++;
 6d6:	0585                	addi	a1,a1,1
 6d8:	0705                	addi	a4,a4,1
 6da:	fff5c683          	lbu	a3,-1(a1)
 6de:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 6e2:	fee79ae3          	bne	a5,a4,6d6 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 6e6:	6422                	ld	s0,8(sp)
 6e8:	0141                	addi	sp,sp,16
 6ea:	8082                	ret
        dst += n;
 6ec:	00c50733          	add	a4,a0,a2
        src += n;
 6f0:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 6f2:	fec05ae3          	blez	a2,6e6 <memmove+0x28>
 6f6:	fff6079b          	addiw	a5,a2,-1
 6fa:	1782                	slli	a5,a5,0x20
 6fc:	9381                	srli	a5,a5,0x20
 6fe:	fff7c793          	not	a5,a5
 702:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 704:	15fd                	addi	a1,a1,-1
 706:	177d                	addi	a4,a4,-1
 708:	0005c683          	lbu	a3,0(a1)
 70c:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 710:	fee79ae3          	bne	a5,a4,704 <memmove+0x46>
 714:	bfc9                	j	6e6 <memmove+0x28>

0000000000000716 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 716:	1141                	addi	sp,sp,-16
 718:	e422                	sd	s0,8(sp)
 71a:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 71c:	ca05                	beqz	a2,74c <memcmp+0x36>
 71e:	fff6069b          	addiw	a3,a2,-1
 722:	1682                	slli	a3,a3,0x20
 724:	9281                	srli	a3,a3,0x20
 726:	0685                	addi	a3,a3,1
 728:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 72a:	00054783          	lbu	a5,0(a0)
 72e:	0005c703          	lbu	a4,0(a1)
 732:	00e79863          	bne	a5,a4,742 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 736:	0505                	addi	a0,a0,1
        p2++;
 738:	0585                	addi	a1,a1,1
    while (n-- > 0)
 73a:	fed518e3          	bne	a0,a3,72a <memcmp+0x14>
    }
    return 0;
 73e:	4501                	li	a0,0
 740:	a019                	j	746 <memcmp+0x30>
            return *p1 - *p2;
 742:	40e7853b          	subw	a0,a5,a4
}
 746:	6422                	ld	s0,8(sp)
 748:	0141                	addi	sp,sp,16
 74a:	8082                	ret
    return 0;
 74c:	4501                	li	a0,0
 74e:	bfe5                	j	746 <memcmp+0x30>

0000000000000750 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 750:	1141                	addi	sp,sp,-16
 752:	e406                	sd	ra,8(sp)
 754:	e022                	sd	s0,0(sp)
 756:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 758:	00000097          	auipc	ra,0x0
 75c:	f66080e7          	jalr	-154(ra) # 6be <memmove>
}
 760:	60a2                	ld	ra,8(sp)
 762:	6402                	ld	s0,0(sp)
 764:	0141                	addi	sp,sp,16
 766:	8082                	ret

0000000000000768 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 768:	4885                	li	a7,1
 ecall
 76a:	00000073          	ecall
 ret
 76e:	8082                	ret

0000000000000770 <exit>:
.global exit
exit:
 li a7, SYS_exit
 770:	4889                	li	a7,2
 ecall
 772:	00000073          	ecall
 ret
 776:	8082                	ret

0000000000000778 <wait>:
.global wait
wait:
 li a7, SYS_wait
 778:	488d                	li	a7,3
 ecall
 77a:	00000073          	ecall
 ret
 77e:	8082                	ret

0000000000000780 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 780:	4891                	li	a7,4
 ecall
 782:	00000073          	ecall
 ret
 786:	8082                	ret

0000000000000788 <read>:
.global read
read:
 li a7, SYS_read
 788:	4895                	li	a7,5
 ecall
 78a:	00000073          	ecall
 ret
 78e:	8082                	ret

0000000000000790 <write>:
.global write
write:
 li a7, SYS_write
 790:	48c1                	li	a7,16
 ecall
 792:	00000073          	ecall
 ret
 796:	8082                	ret

0000000000000798 <close>:
.global close
close:
 li a7, SYS_close
 798:	48d5                	li	a7,21
 ecall
 79a:	00000073          	ecall
 ret
 79e:	8082                	ret

00000000000007a0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 7a0:	4899                	li	a7,6
 ecall
 7a2:	00000073          	ecall
 ret
 7a6:	8082                	ret

00000000000007a8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 7a8:	489d                	li	a7,7
 ecall
 7aa:	00000073          	ecall
 ret
 7ae:	8082                	ret

00000000000007b0 <open>:
.global open
open:
 li a7, SYS_open
 7b0:	48bd                	li	a7,15
 ecall
 7b2:	00000073          	ecall
 ret
 7b6:	8082                	ret

00000000000007b8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7b8:	48c5                	li	a7,17
 ecall
 7ba:	00000073          	ecall
 ret
 7be:	8082                	ret

00000000000007c0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7c0:	48c9                	li	a7,18
 ecall
 7c2:	00000073          	ecall
 ret
 7c6:	8082                	ret

00000000000007c8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7c8:	48a1                	li	a7,8
 ecall
 7ca:	00000073          	ecall
 ret
 7ce:	8082                	ret

00000000000007d0 <link>:
.global link
link:
 li a7, SYS_link
 7d0:	48cd                	li	a7,19
 ecall
 7d2:	00000073          	ecall
 ret
 7d6:	8082                	ret

00000000000007d8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7d8:	48d1                	li	a7,20
 ecall
 7da:	00000073          	ecall
 ret
 7de:	8082                	ret

00000000000007e0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7e0:	48a5                	li	a7,9
 ecall
 7e2:	00000073          	ecall
 ret
 7e6:	8082                	ret

00000000000007e8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 7e8:	48a9                	li	a7,10
 ecall
 7ea:	00000073          	ecall
 ret
 7ee:	8082                	ret

00000000000007f0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7f0:	48ad                	li	a7,11
 ecall
 7f2:	00000073          	ecall
 ret
 7f6:	8082                	ret

00000000000007f8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7f8:	48b1                	li	a7,12
 ecall
 7fa:	00000073          	ecall
 ret
 7fe:	8082                	ret

0000000000000800 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 800:	48b5                	li	a7,13
 ecall
 802:	00000073          	ecall
 ret
 806:	8082                	ret

0000000000000808 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 808:	48b9                	li	a7,14
 ecall
 80a:	00000073          	ecall
 ret
 80e:	8082                	ret

0000000000000810 <ps>:
.global ps
ps:
 li a7, SYS_ps
 810:	48d9                	li	a7,22
 ecall
 812:	00000073          	ecall
 ret
 816:	8082                	ret

0000000000000818 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 818:	48dd                	li	a7,23
 ecall
 81a:	00000073          	ecall
 ret
 81e:	8082                	ret

0000000000000820 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 820:	48e1                	li	a7,24
 ecall
 822:	00000073          	ecall
 ret
 826:	8082                	ret

0000000000000828 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 828:	1101                	addi	sp,sp,-32
 82a:	ec06                	sd	ra,24(sp)
 82c:	e822                	sd	s0,16(sp)
 82e:	1000                	addi	s0,sp,32
 830:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 834:	4605                	li	a2,1
 836:	fef40593          	addi	a1,s0,-17
 83a:	00000097          	auipc	ra,0x0
 83e:	f56080e7          	jalr	-170(ra) # 790 <write>
}
 842:	60e2                	ld	ra,24(sp)
 844:	6442                	ld	s0,16(sp)
 846:	6105                	addi	sp,sp,32
 848:	8082                	ret

000000000000084a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 84a:	7139                	addi	sp,sp,-64
 84c:	fc06                	sd	ra,56(sp)
 84e:	f822                	sd	s0,48(sp)
 850:	f426                	sd	s1,40(sp)
 852:	f04a                	sd	s2,32(sp)
 854:	ec4e                	sd	s3,24(sp)
 856:	0080                	addi	s0,sp,64
 858:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 85a:	c299                	beqz	a3,860 <printint+0x16>
 85c:	0805c963          	bltz	a1,8ee <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 860:	2581                	sext.w	a1,a1
  neg = 0;
 862:	4881                	li	a7,0
 864:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 868:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 86a:	2601                	sext.w	a2,a2
 86c:	00000517          	auipc	a0,0x0
 870:	62c50513          	addi	a0,a0,1580 # e98 <digits>
 874:	883a                	mv	a6,a4
 876:	2705                	addiw	a4,a4,1
 878:	02c5f7bb          	remuw	a5,a1,a2
 87c:	1782                	slli	a5,a5,0x20
 87e:	9381                	srli	a5,a5,0x20
 880:	97aa                	add	a5,a5,a0
 882:	0007c783          	lbu	a5,0(a5)
 886:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 88a:	0005879b          	sext.w	a5,a1
 88e:	02c5d5bb          	divuw	a1,a1,a2
 892:	0685                	addi	a3,a3,1
 894:	fec7f0e3          	bgeu	a5,a2,874 <printint+0x2a>
  if(neg)
 898:	00088c63          	beqz	a7,8b0 <printint+0x66>
    buf[i++] = '-';
 89c:	fd070793          	addi	a5,a4,-48
 8a0:	00878733          	add	a4,a5,s0
 8a4:	02d00793          	li	a5,45
 8a8:	fef70823          	sb	a5,-16(a4)
 8ac:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 8b0:	02e05863          	blez	a4,8e0 <printint+0x96>
 8b4:	fc040793          	addi	a5,s0,-64
 8b8:	00e78933          	add	s2,a5,a4
 8bc:	fff78993          	addi	s3,a5,-1
 8c0:	99ba                	add	s3,s3,a4
 8c2:	377d                	addiw	a4,a4,-1
 8c4:	1702                	slli	a4,a4,0x20
 8c6:	9301                	srli	a4,a4,0x20
 8c8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8cc:	fff94583          	lbu	a1,-1(s2)
 8d0:	8526                	mv	a0,s1
 8d2:	00000097          	auipc	ra,0x0
 8d6:	f56080e7          	jalr	-170(ra) # 828 <putc>
  while(--i >= 0)
 8da:	197d                	addi	s2,s2,-1
 8dc:	ff3918e3          	bne	s2,s3,8cc <printint+0x82>
}
 8e0:	70e2                	ld	ra,56(sp)
 8e2:	7442                	ld	s0,48(sp)
 8e4:	74a2                	ld	s1,40(sp)
 8e6:	7902                	ld	s2,32(sp)
 8e8:	69e2                	ld	s3,24(sp)
 8ea:	6121                	addi	sp,sp,64
 8ec:	8082                	ret
    x = -xx;
 8ee:	40b005bb          	negw	a1,a1
    neg = 1;
 8f2:	4885                	li	a7,1
    x = -xx;
 8f4:	bf85                	j	864 <printint+0x1a>

00000000000008f6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8f6:	715d                	addi	sp,sp,-80
 8f8:	e486                	sd	ra,72(sp)
 8fa:	e0a2                	sd	s0,64(sp)
 8fc:	fc26                	sd	s1,56(sp)
 8fe:	f84a                	sd	s2,48(sp)
 900:	f44e                	sd	s3,40(sp)
 902:	f052                	sd	s4,32(sp)
 904:	ec56                	sd	s5,24(sp)
 906:	e85a                	sd	s6,16(sp)
 908:	e45e                	sd	s7,8(sp)
 90a:	e062                	sd	s8,0(sp)
 90c:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 90e:	0005c903          	lbu	s2,0(a1)
 912:	18090c63          	beqz	s2,aaa <vprintf+0x1b4>
 916:	8aaa                	mv	s5,a0
 918:	8bb2                	mv	s7,a2
 91a:	00158493          	addi	s1,a1,1
  state = 0;
 91e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 920:	02500a13          	li	s4,37
 924:	4b55                	li	s6,21
 926:	a839                	j	944 <vprintf+0x4e>
        putc(fd, c);
 928:	85ca                	mv	a1,s2
 92a:	8556                	mv	a0,s5
 92c:	00000097          	auipc	ra,0x0
 930:	efc080e7          	jalr	-260(ra) # 828 <putc>
 934:	a019                	j	93a <vprintf+0x44>
    } else if(state == '%'){
 936:	01498d63          	beq	s3,s4,950 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 93a:	0485                	addi	s1,s1,1
 93c:	fff4c903          	lbu	s2,-1(s1)
 940:	16090563          	beqz	s2,aaa <vprintf+0x1b4>
    if(state == 0){
 944:	fe0999e3          	bnez	s3,936 <vprintf+0x40>
      if(c == '%'){
 948:	ff4910e3          	bne	s2,s4,928 <vprintf+0x32>
        state = '%';
 94c:	89d2                	mv	s3,s4
 94e:	b7f5                	j	93a <vprintf+0x44>
      if(c == 'd'){
 950:	13490263          	beq	s2,s4,a74 <vprintf+0x17e>
 954:	f9d9079b          	addiw	a5,s2,-99
 958:	0ff7f793          	zext.b	a5,a5
 95c:	12fb6563          	bltu	s6,a5,a86 <vprintf+0x190>
 960:	f9d9079b          	addiw	a5,s2,-99
 964:	0ff7f713          	zext.b	a4,a5
 968:	10eb6f63          	bltu	s6,a4,a86 <vprintf+0x190>
 96c:	00271793          	slli	a5,a4,0x2
 970:	00000717          	auipc	a4,0x0
 974:	4d070713          	addi	a4,a4,1232 # e40 <malloc+0x298>
 978:	97ba                	add	a5,a5,a4
 97a:	439c                	lw	a5,0(a5)
 97c:	97ba                	add	a5,a5,a4
 97e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 980:	008b8913          	addi	s2,s7,8
 984:	4685                	li	a3,1
 986:	4629                	li	a2,10
 988:	000ba583          	lw	a1,0(s7)
 98c:	8556                	mv	a0,s5
 98e:	00000097          	auipc	ra,0x0
 992:	ebc080e7          	jalr	-324(ra) # 84a <printint>
 996:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 998:	4981                	li	s3,0
 99a:	b745                	j	93a <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 99c:	008b8913          	addi	s2,s7,8
 9a0:	4681                	li	a3,0
 9a2:	4629                	li	a2,10
 9a4:	000ba583          	lw	a1,0(s7)
 9a8:	8556                	mv	a0,s5
 9aa:	00000097          	auipc	ra,0x0
 9ae:	ea0080e7          	jalr	-352(ra) # 84a <printint>
 9b2:	8bca                	mv	s7,s2
      state = 0;
 9b4:	4981                	li	s3,0
 9b6:	b751                	j	93a <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 9b8:	008b8913          	addi	s2,s7,8
 9bc:	4681                	li	a3,0
 9be:	4641                	li	a2,16
 9c0:	000ba583          	lw	a1,0(s7)
 9c4:	8556                	mv	a0,s5
 9c6:	00000097          	auipc	ra,0x0
 9ca:	e84080e7          	jalr	-380(ra) # 84a <printint>
 9ce:	8bca                	mv	s7,s2
      state = 0;
 9d0:	4981                	li	s3,0
 9d2:	b7a5                	j	93a <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 9d4:	008b8c13          	addi	s8,s7,8
 9d8:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9dc:	03000593          	li	a1,48
 9e0:	8556                	mv	a0,s5
 9e2:	00000097          	auipc	ra,0x0
 9e6:	e46080e7          	jalr	-442(ra) # 828 <putc>
  putc(fd, 'x');
 9ea:	07800593          	li	a1,120
 9ee:	8556                	mv	a0,s5
 9f0:	00000097          	auipc	ra,0x0
 9f4:	e38080e7          	jalr	-456(ra) # 828 <putc>
 9f8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9fa:	00000b97          	auipc	s7,0x0
 9fe:	49eb8b93          	addi	s7,s7,1182 # e98 <digits>
 a02:	03c9d793          	srli	a5,s3,0x3c
 a06:	97de                	add	a5,a5,s7
 a08:	0007c583          	lbu	a1,0(a5)
 a0c:	8556                	mv	a0,s5
 a0e:	00000097          	auipc	ra,0x0
 a12:	e1a080e7          	jalr	-486(ra) # 828 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a16:	0992                	slli	s3,s3,0x4
 a18:	397d                	addiw	s2,s2,-1
 a1a:	fe0914e3          	bnez	s2,a02 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 a1e:	8be2                	mv	s7,s8
      state = 0;
 a20:	4981                	li	s3,0
 a22:	bf21                	j	93a <vprintf+0x44>
        s = va_arg(ap, char*);
 a24:	008b8993          	addi	s3,s7,8
 a28:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a2c:	02090163          	beqz	s2,a4e <vprintf+0x158>
        while(*s != 0){
 a30:	00094583          	lbu	a1,0(s2)
 a34:	c9a5                	beqz	a1,aa4 <vprintf+0x1ae>
          putc(fd, *s);
 a36:	8556                	mv	a0,s5
 a38:	00000097          	auipc	ra,0x0
 a3c:	df0080e7          	jalr	-528(ra) # 828 <putc>
          s++;
 a40:	0905                	addi	s2,s2,1
        while(*s != 0){
 a42:	00094583          	lbu	a1,0(s2)
 a46:	f9e5                	bnez	a1,a36 <vprintf+0x140>
        s = va_arg(ap, char*);
 a48:	8bce                	mv	s7,s3
      state = 0;
 a4a:	4981                	li	s3,0
 a4c:	b5fd                	j	93a <vprintf+0x44>
          s = "(null)";
 a4e:	00000917          	auipc	s2,0x0
 a52:	3ea90913          	addi	s2,s2,1002 # e38 <malloc+0x290>
        while(*s != 0){
 a56:	02800593          	li	a1,40
 a5a:	bff1                	j	a36 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a5c:	008b8913          	addi	s2,s7,8
 a60:	000bc583          	lbu	a1,0(s7)
 a64:	8556                	mv	a0,s5
 a66:	00000097          	auipc	ra,0x0
 a6a:	dc2080e7          	jalr	-574(ra) # 828 <putc>
 a6e:	8bca                	mv	s7,s2
      state = 0;
 a70:	4981                	li	s3,0
 a72:	b5e1                	j	93a <vprintf+0x44>
        putc(fd, c);
 a74:	02500593          	li	a1,37
 a78:	8556                	mv	a0,s5
 a7a:	00000097          	auipc	ra,0x0
 a7e:	dae080e7          	jalr	-594(ra) # 828 <putc>
      state = 0;
 a82:	4981                	li	s3,0
 a84:	bd5d                	j	93a <vprintf+0x44>
        putc(fd, '%');
 a86:	02500593          	li	a1,37
 a8a:	8556                	mv	a0,s5
 a8c:	00000097          	auipc	ra,0x0
 a90:	d9c080e7          	jalr	-612(ra) # 828 <putc>
        putc(fd, c);
 a94:	85ca                	mv	a1,s2
 a96:	8556                	mv	a0,s5
 a98:	00000097          	auipc	ra,0x0
 a9c:	d90080e7          	jalr	-624(ra) # 828 <putc>
      state = 0;
 aa0:	4981                	li	s3,0
 aa2:	bd61                	j	93a <vprintf+0x44>
        s = va_arg(ap, char*);
 aa4:	8bce                	mv	s7,s3
      state = 0;
 aa6:	4981                	li	s3,0
 aa8:	bd49                	j	93a <vprintf+0x44>
    }
  }
}
 aaa:	60a6                	ld	ra,72(sp)
 aac:	6406                	ld	s0,64(sp)
 aae:	74e2                	ld	s1,56(sp)
 ab0:	7942                	ld	s2,48(sp)
 ab2:	79a2                	ld	s3,40(sp)
 ab4:	7a02                	ld	s4,32(sp)
 ab6:	6ae2                	ld	s5,24(sp)
 ab8:	6b42                	ld	s6,16(sp)
 aba:	6ba2                	ld	s7,8(sp)
 abc:	6c02                	ld	s8,0(sp)
 abe:	6161                	addi	sp,sp,80
 ac0:	8082                	ret

0000000000000ac2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ac2:	715d                	addi	sp,sp,-80
 ac4:	ec06                	sd	ra,24(sp)
 ac6:	e822                	sd	s0,16(sp)
 ac8:	1000                	addi	s0,sp,32
 aca:	e010                	sd	a2,0(s0)
 acc:	e414                	sd	a3,8(s0)
 ace:	e818                	sd	a4,16(s0)
 ad0:	ec1c                	sd	a5,24(s0)
 ad2:	03043023          	sd	a6,32(s0)
 ad6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 ada:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 ade:	8622                	mv	a2,s0
 ae0:	00000097          	auipc	ra,0x0
 ae4:	e16080e7          	jalr	-490(ra) # 8f6 <vprintf>
}
 ae8:	60e2                	ld	ra,24(sp)
 aea:	6442                	ld	s0,16(sp)
 aec:	6161                	addi	sp,sp,80
 aee:	8082                	ret

0000000000000af0 <printf>:

void
printf(const char *fmt, ...)
{
 af0:	711d                	addi	sp,sp,-96
 af2:	ec06                	sd	ra,24(sp)
 af4:	e822                	sd	s0,16(sp)
 af6:	1000                	addi	s0,sp,32
 af8:	e40c                	sd	a1,8(s0)
 afa:	e810                	sd	a2,16(s0)
 afc:	ec14                	sd	a3,24(s0)
 afe:	f018                	sd	a4,32(s0)
 b00:	f41c                	sd	a5,40(s0)
 b02:	03043823          	sd	a6,48(s0)
 b06:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b0a:	00840613          	addi	a2,s0,8
 b0e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b12:	85aa                	mv	a1,a0
 b14:	4505                	li	a0,1
 b16:	00000097          	auipc	ra,0x0
 b1a:	de0080e7          	jalr	-544(ra) # 8f6 <vprintf>
}
 b1e:	60e2                	ld	ra,24(sp)
 b20:	6442                	ld	s0,16(sp)
 b22:	6125                	addi	sp,sp,96
 b24:	8082                	ret

0000000000000b26 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 b26:	1141                	addi	sp,sp,-16
 b28:	e422                	sd	s0,8(sp)
 b2a:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 b2c:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b30:	00000797          	auipc	a5,0x0
 b34:	4e87b783          	ld	a5,1256(a5) # 1018 <freep>
 b38:	a02d                	j	b62 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 b3a:	4618                	lw	a4,8(a2)
 b3c:	9f2d                	addw	a4,a4,a1
 b3e:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 b42:	6398                	ld	a4,0(a5)
 b44:	6310                	ld	a2,0(a4)
 b46:	a83d                	j	b84 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 b48:	ff852703          	lw	a4,-8(a0)
 b4c:	9f31                	addw	a4,a4,a2
 b4e:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 b50:	ff053683          	ld	a3,-16(a0)
 b54:	a091                	j	b98 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b56:	6398                	ld	a4,0(a5)
 b58:	00e7e463          	bltu	a5,a4,b60 <free+0x3a>
 b5c:	00e6ea63          	bltu	a3,a4,b70 <free+0x4a>
{
 b60:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b62:	fed7fae3          	bgeu	a5,a3,b56 <free+0x30>
 b66:	6398                	ld	a4,0(a5)
 b68:	00e6e463          	bltu	a3,a4,b70 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b6c:	fee7eae3          	bltu	a5,a4,b60 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b70:	ff852583          	lw	a1,-8(a0)
 b74:	6390                	ld	a2,0(a5)
 b76:	02059813          	slli	a6,a1,0x20
 b7a:	01c85713          	srli	a4,a6,0x1c
 b7e:	9736                	add	a4,a4,a3
 b80:	fae60de3          	beq	a2,a4,b3a <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b84:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b88:	4790                	lw	a2,8(a5)
 b8a:	02061593          	slli	a1,a2,0x20
 b8e:	01c5d713          	srli	a4,a1,0x1c
 b92:	973e                	add	a4,a4,a5
 b94:	fae68ae3          	beq	a3,a4,b48 <free+0x22>
        p->s.ptr = bp->s.ptr;
 b98:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b9a:	00000717          	auipc	a4,0x0
 b9e:	46f73f23          	sd	a5,1150(a4) # 1018 <freep>
}
 ba2:	6422                	ld	s0,8(sp)
 ba4:	0141                	addi	sp,sp,16
 ba6:	8082                	ret

0000000000000ba8 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 ba8:	7139                	addi	sp,sp,-64
 baa:	fc06                	sd	ra,56(sp)
 bac:	f822                	sd	s0,48(sp)
 bae:	f426                	sd	s1,40(sp)
 bb0:	f04a                	sd	s2,32(sp)
 bb2:	ec4e                	sd	s3,24(sp)
 bb4:	e852                	sd	s4,16(sp)
 bb6:	e456                	sd	s5,8(sp)
 bb8:	e05a                	sd	s6,0(sp)
 bba:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 bbc:	02051493          	slli	s1,a0,0x20
 bc0:	9081                	srli	s1,s1,0x20
 bc2:	04bd                	addi	s1,s1,15
 bc4:	8091                	srli	s1,s1,0x4
 bc6:	0014899b          	addiw	s3,s1,1
 bca:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 bcc:	00000517          	auipc	a0,0x0
 bd0:	44c53503          	ld	a0,1100(a0) # 1018 <freep>
 bd4:	c515                	beqz	a0,c00 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 bd6:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 bd8:	4798                	lw	a4,8(a5)
 bda:	02977f63          	bgeu	a4,s1,c18 <malloc+0x70>
    if (nu < 4096)
 bde:	8a4e                	mv	s4,s3
 be0:	0009871b          	sext.w	a4,s3
 be4:	6685                	lui	a3,0x1
 be6:	00d77363          	bgeu	a4,a3,bec <malloc+0x44>
 bea:	6a05                	lui	s4,0x1
 bec:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 bf0:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 bf4:	00000917          	auipc	s2,0x0
 bf8:	42490913          	addi	s2,s2,1060 # 1018 <freep>
    if (p == (char *)-1)
 bfc:	5afd                	li	s5,-1
 bfe:	a895                	j	c72 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 c00:	00000797          	auipc	a5,0x0
 c04:	4a078793          	addi	a5,a5,1184 # 10a0 <base>
 c08:	00000717          	auipc	a4,0x0
 c0c:	40f73823          	sd	a5,1040(a4) # 1018 <freep>
 c10:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 c12:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 c16:	b7e1                	j	bde <malloc+0x36>
            if (p->s.size == nunits)
 c18:	02e48c63          	beq	s1,a4,c50 <malloc+0xa8>
                p->s.size -= nunits;
 c1c:	4137073b          	subw	a4,a4,s3
 c20:	c798                	sw	a4,8(a5)
                p += p->s.size;
 c22:	02071693          	slli	a3,a4,0x20
 c26:	01c6d713          	srli	a4,a3,0x1c
 c2a:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 c2c:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 c30:	00000717          	auipc	a4,0x0
 c34:	3ea73423          	sd	a0,1000(a4) # 1018 <freep>
            return (void *)(p + 1);
 c38:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 c3c:	70e2                	ld	ra,56(sp)
 c3e:	7442                	ld	s0,48(sp)
 c40:	74a2                	ld	s1,40(sp)
 c42:	7902                	ld	s2,32(sp)
 c44:	69e2                	ld	s3,24(sp)
 c46:	6a42                	ld	s4,16(sp)
 c48:	6aa2                	ld	s5,8(sp)
 c4a:	6b02                	ld	s6,0(sp)
 c4c:	6121                	addi	sp,sp,64
 c4e:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 c50:	6398                	ld	a4,0(a5)
 c52:	e118                	sd	a4,0(a0)
 c54:	bff1                	j	c30 <malloc+0x88>
    hp->s.size = nu;
 c56:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c5a:	0541                	addi	a0,a0,16
 c5c:	00000097          	auipc	ra,0x0
 c60:	eca080e7          	jalr	-310(ra) # b26 <free>
    return freep;
 c64:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c68:	d971                	beqz	a0,c3c <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c6a:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c6c:	4798                	lw	a4,8(a5)
 c6e:	fa9775e3          	bgeu	a4,s1,c18 <malloc+0x70>
        if (p == freep)
 c72:	00093703          	ld	a4,0(s2)
 c76:	853e                	mv	a0,a5
 c78:	fef719e3          	bne	a4,a5,c6a <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c7c:	8552                	mv	a0,s4
 c7e:	00000097          	auipc	ra,0x0
 c82:	b7a080e7          	jalr	-1158(ra) # 7f8 <sbrk>
    if (p == (char *)-1)
 c86:	fd5518e3          	bne	a0,s5,c56 <malloc+0xae>
                return 0;
 c8a:	4501                	li	a0,0
 c8c:	bf45                	j	c3c <malloc+0x94>
