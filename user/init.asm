
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fcntl.h"

char *argv[] = {"sh", 0};

int main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
    int pid, wpid;

    if (open("console", O_RDWR) < 0)
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	cd250513          	addi	a0,a0,-814 # ce0 <malloc+0xf4>
  16:	00000097          	auipc	ra,0x0
  1a:	7de080e7          	jalr	2014(ra) # 7f4 <open>
  1e:	06054363          	bltz	a0,84 <main+0x84>
    {
        mknod("console", CONSOLE, 0);
        open("console", O_RDWR);
    }
    dup(0); // stdout
  22:	4501                	li	a0,0
  24:	00001097          	auipc	ra,0x1
  28:	808080e7          	jalr	-2040(ra) # 82c <dup>
    dup(0); // stderr
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	7fe080e7          	jalr	2046(ra) # 82c <dup>

    for (;;)
    {
        printf("init: starting sh\n");
  36:	00001917          	auipc	s2,0x1
  3a:	cb290913          	addi	s2,s2,-846 # ce8 <malloc+0xfc>
  3e:	854a                	mv	a0,s2
  40:	00001097          	auipc	ra,0x1
  44:	af4080e7          	jalr	-1292(ra) # b34 <printf>
        pid = fork();
  48:	00000097          	auipc	ra,0x0
  4c:	764080e7          	jalr	1892(ra) # 7ac <fork>
  50:	84aa                	mv	s1,a0
        if (pid < 0)
  52:	04054d63          	bltz	a0,ac <main+0xac>
        {
            printf("init: fork failed\n");
            exit(1);
        }
        if (pid == 0)
  56:	c925                	beqz	a0,c6 <main+0xc6>

        for (;;)
        {
            // this call to wait() returns if the shell exits,
            // or if a parentless process exits.
            wpid = wait((int *)0);
  58:	4501                	li	a0,0
  5a:	00000097          	auipc	ra,0x0
  5e:	762080e7          	jalr	1890(ra) # 7bc <wait>
            if (wpid == pid)
  62:	fca48ee3          	beq	s1,a0,3e <main+0x3e>
            {
                // the shell exited; restart it.
                break;
            }
            else if (wpid < 0)
  66:	fe0559e3          	bgez	a0,58 <main+0x58>
            {
                printf("init: wait returned an error\n");
  6a:	00001517          	auipc	a0,0x1
  6e:	cce50513          	addi	a0,a0,-818 # d38 <malloc+0x14c>
  72:	00001097          	auipc	ra,0x1
  76:	ac2080e7          	jalr	-1342(ra) # b34 <printf>
                exit(1);
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	738080e7          	jalr	1848(ra) # 7b4 <exit>
        mknod("console", CONSOLE, 0);
  84:	4601                	li	a2,0
  86:	4585                	li	a1,1
  88:	00001517          	auipc	a0,0x1
  8c:	c5850513          	addi	a0,a0,-936 # ce0 <malloc+0xf4>
  90:	00000097          	auipc	ra,0x0
  94:	76c080e7          	jalr	1900(ra) # 7fc <mknod>
        open("console", O_RDWR);
  98:	4589                	li	a1,2
  9a:	00001517          	auipc	a0,0x1
  9e:	c4650513          	addi	a0,a0,-954 # ce0 <malloc+0xf4>
  a2:	00000097          	auipc	ra,0x0
  a6:	752080e7          	jalr	1874(ra) # 7f4 <open>
  aa:	bfa5                	j	22 <main+0x22>
            printf("init: fork failed\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	c5450513          	addi	a0,a0,-940 # d00 <malloc+0x114>
  b4:	00001097          	auipc	ra,0x1
  b8:	a80080e7          	jalr	-1408(ra) # b34 <printf>
            exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	6f6080e7          	jalr	1782(ra) # 7b4 <exit>
            exec("sh", argv);
  c6:	00001597          	auipc	a1,0x1
  ca:	f4a58593          	addi	a1,a1,-182 # 1010 <argv>
  ce:	00001517          	auipc	a0,0x1
  d2:	c4a50513          	addi	a0,a0,-950 # d18 <malloc+0x12c>
  d6:	00000097          	auipc	ra,0x0
  da:	716080e7          	jalr	1814(ra) # 7ec <exec>
            printf("init: exec sh failed\n");
  de:	00001517          	auipc	a0,0x1
  e2:	c4250513          	addi	a0,a0,-958 # d20 <malloc+0x134>
  e6:	00001097          	auipc	ra,0x1
  ea:	a4e080e7          	jalr	-1458(ra) # b34 <printf>
            exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	6c4080e7          	jalr	1732(ra) # 7b4 <exit>

00000000000000f8 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  f8:	1141                	addi	sp,sp,-16
  fa:	e422                	sd	s0,8(sp)
  fc:	0800                	addi	s0,sp,16
    lk->name = name;
  fe:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
 100:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
 104:	57fd                	li	a5,-1
 106:	00f50823          	sb	a5,16(a0)
}
 10a:	6422                	ld	s0,8(sp)
 10c:	0141                	addi	sp,sp,16
 10e:	8082                	ret

0000000000000110 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
 110:	00054783          	lbu	a5,0(a0)
 114:	e399                	bnez	a5,11a <holding+0xa>
 116:	4501                	li	a0,0
}
 118:	8082                	ret
{
 11a:	1101                	addi	sp,sp,-32
 11c:	ec06                	sd	ra,24(sp)
 11e:	e822                	sd	s0,16(sp)
 120:	e426                	sd	s1,8(sp)
 122:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
 124:	01054483          	lbu	s1,16(a0)
 128:	00000097          	auipc	ra,0x0
 12c:	2dc080e7          	jalr	732(ra) # 404 <twhoami>
 130:	2501                	sext.w	a0,a0
 132:	40a48533          	sub	a0,s1,a0
 136:	00153513          	seqz	a0,a0
}
 13a:	60e2                	ld	ra,24(sp)
 13c:	6442                	ld	s0,16(sp)
 13e:	64a2                	ld	s1,8(sp)
 140:	6105                	addi	sp,sp,32
 142:	8082                	ret

0000000000000144 <acquire>:

void acquire(struct lock *lk)
{
 144:	7179                	addi	sp,sp,-48
 146:	f406                	sd	ra,40(sp)
 148:	f022                	sd	s0,32(sp)
 14a:	ec26                	sd	s1,24(sp)
 14c:	e84a                	sd	s2,16(sp)
 14e:	e44e                	sd	s3,8(sp)
 150:	e052                	sd	s4,0(sp)
 152:	1800                	addi	s0,sp,48
 154:	8a2a                	mv	s4,a0
    if (holding(lk))
 156:	00000097          	auipc	ra,0x0
 15a:	fba080e7          	jalr	-70(ra) # 110 <holding>
 15e:	e919                	bnez	a0,174 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 160:	ffca7493          	andi	s1,s4,-4
 164:	003a7913          	andi	s2,s4,3
 168:	0039191b          	slliw	s2,s2,0x3
 16c:	4985                	li	s3,1
 16e:	012999bb          	sllw	s3,s3,s2
 172:	a015                	j	196 <acquire+0x52>
        printf("re-acquiring lock we already hold");
 174:	00001517          	auipc	a0,0x1
 178:	be450513          	addi	a0,a0,-1052 # d58 <malloc+0x16c>
 17c:	00001097          	auipc	ra,0x1
 180:	9b8080e7          	jalr	-1608(ra) # b34 <printf>
        exit(-1);
 184:	557d                	li	a0,-1
 186:	00000097          	auipc	ra,0x0
 18a:	62e080e7          	jalr	1582(ra) # 7b4 <exit>
    {
        // give up the cpu for other threads
        tyield();
 18e:	00000097          	auipc	ra,0x0
 192:	252080e7          	jalr	594(ra) # 3e0 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 196:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 19a:	0127d7bb          	srlw	a5,a5,s2
 19e:	0ff7f793          	zext.b	a5,a5
 1a2:	f7f5                	bnez	a5,18e <acquire+0x4a>
    }

    __sync_synchronize();
 1a4:	0ff0000f          	fence

    lk->tid = twhoami();
 1a8:	00000097          	auipc	ra,0x0
 1ac:	25c080e7          	jalr	604(ra) # 404 <twhoami>
 1b0:	00aa0823          	sb	a0,16(s4)
}
 1b4:	70a2                	ld	ra,40(sp)
 1b6:	7402                	ld	s0,32(sp)
 1b8:	64e2                	ld	s1,24(sp)
 1ba:	6942                	ld	s2,16(sp)
 1bc:	69a2                	ld	s3,8(sp)
 1be:	6a02                	ld	s4,0(sp)
 1c0:	6145                	addi	sp,sp,48
 1c2:	8082                	ret

00000000000001c4 <release>:

void release(struct lock *lk)
{
 1c4:	1101                	addi	sp,sp,-32
 1c6:	ec06                	sd	ra,24(sp)
 1c8:	e822                	sd	s0,16(sp)
 1ca:	e426                	sd	s1,8(sp)
 1cc:	1000                	addi	s0,sp,32
 1ce:	84aa                	mv	s1,a0
    if (!holding(lk))
 1d0:	00000097          	auipc	ra,0x0
 1d4:	f40080e7          	jalr	-192(ra) # 110 <holding>
 1d8:	c11d                	beqz	a0,1fe <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 1da:	57fd                	li	a5,-1
 1dc:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 1e0:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 1e4:	0ff0000f          	fence
 1e8:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 1ec:	00000097          	auipc	ra,0x0
 1f0:	1f4080e7          	jalr	500(ra) # 3e0 <tyield>
}
 1f4:	60e2                	ld	ra,24(sp)
 1f6:	6442                	ld	s0,16(sp)
 1f8:	64a2                	ld	s1,8(sp)
 1fa:	6105                	addi	sp,sp,32
 1fc:	8082                	ret
        printf("releasing lock we are not holding");
 1fe:	00001517          	auipc	a0,0x1
 202:	b8250513          	addi	a0,a0,-1150 # d80 <malloc+0x194>
 206:	00001097          	auipc	ra,0x1
 20a:	92e080e7          	jalr	-1746(ra) # b34 <printf>
        exit(-1);
 20e:	557d                	li	a0,-1
 210:	00000097          	auipc	ra,0x0
 214:	5a4080e7          	jalr	1444(ra) # 7b4 <exit>

0000000000000218 <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 218:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 21a:	00001617          	auipc	a2,0x1
 21e:	e1660613          	addi	a2,a2,-490 # 1030 <threads>
 222:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 224:	45c1                	li	a1,16
 226:	a021                	j	22e <tsched+0x16>
 228:	2685                	addiw	a3,a3,1
 22a:	08b68c63          	beq	a3,a1,2c2 <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 22e:	41f6d71b          	sraiw	a4,a3,0x1f
 232:	01c7571b          	srliw	a4,a4,0x1c
 236:	00d707bb          	addw	a5,a4,a3
 23a:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 23c:	9f99                	subw	a5,a5,a4
 23e:	078e                	slli	a5,a5,0x3
 240:	97b2                	add	a5,a5,a2
 242:	639c                	ld	a5,0(a5)
 244:	d3f5                	beqz	a5,228 <tsched+0x10>
 246:	5fb8                	lw	a4,120(a5)
 248:	fea710e3          	bne	a4,a0,228 <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 24c:	00001717          	auipc	a4,0x1
 250:	de473703          	ld	a4,-540(a4) # 1030 <threads>
 254:	5f30                	lw	a2,120(a4)
 256:	468d                	li	a3,3
 258:	06d60363          	beq	a2,a3,2be <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 25c:	c3a5                	beqz	a5,2bc <tsched+0xa4>
{
 25e:	1101                	addi	sp,sp,-32
 260:	ec06                	sd	ra,24(sp)
 262:	e822                	sd	s0,16(sp)
 264:	e426                	sd	s1,8(sp)
 266:	e04a                	sd	s2,0(sp)
 268:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 26a:	00001497          	auipc	s1,0x1
 26e:	db648493          	addi	s1,s1,-586 # 1020 <current_thread>
 272:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 276:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 278:	0007c603          	lbu	a2,0(a5)
 27c:	00094583          	lbu	a1,0(s2)
 280:	00001517          	auipc	a0,0x1
 284:	b2850513          	addi	a0,a0,-1240 # da8 <malloc+0x1bc>
 288:	00001097          	auipc	ra,0x1
 28c:	8ac080e7          	jalr	-1876(ra) # b34 <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 290:	608c                	ld	a1,0(s1)
 292:	05a1                	addi	a1,a1,8
 294:	00890513          	addi	a0,s2,8
 298:	00000097          	auipc	ra,0x0
 29c:	184080e7          	jalr	388(ra) # 41c <tswtch>
        printf("Thread switch complete\n");
 2a0:	00001517          	auipc	a0,0x1
 2a4:	b3050513          	addi	a0,a0,-1232 # dd0 <malloc+0x1e4>
 2a8:	00001097          	auipc	ra,0x1
 2ac:	88c080e7          	jalr	-1908(ra) # b34 <printf>
    }
}
 2b0:	60e2                	ld	ra,24(sp)
 2b2:	6442                	ld	s0,16(sp)
 2b4:	64a2                	ld	s1,8(sp)
 2b6:	6902                	ld	s2,0(sp)
 2b8:	6105                	addi	sp,sp,32
 2ba:	8082                	ret
 2bc:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 2be:	87ba                	mv	a5,a4
 2c0:	bf79                	j	25e <tsched+0x46>
 2c2:	00001797          	auipc	a5,0x1
 2c6:	d6e7b783          	ld	a5,-658(a5) # 1030 <threads>
 2ca:	5fb4                	lw	a3,120(a5)
 2cc:	470d                	li	a4,3
 2ce:	f8e688e3          	beq	a3,a4,25e <tsched+0x46>
 2d2:	8082                	ret

00000000000002d4 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 2d4:	7179                	addi	sp,sp,-48
 2d6:	f406                	sd	ra,40(sp)
 2d8:	f022                	sd	s0,32(sp)
 2da:	ec26                	sd	s1,24(sp)
 2dc:	e84a                	sd	s2,16(sp)
 2de:	e44e                	sd	s3,8(sp)
 2e0:	1800                	addi	s0,sp,48
 2e2:	84aa                	mv	s1,a0
 2e4:	89b2                	mv	s3,a2
 2e6:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 2e8:	09000513          	li	a0,144
 2ec:	00001097          	auipc	ra,0x1
 2f0:	900080e7          	jalr	-1792(ra) # bec <malloc>
 2f4:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 2f6:	478d                	li	a5,3
 2f8:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 2fa:	609c                	ld	a5,0(s1)
 2fc:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 300:	609c                	ld	a5,0(s1)
 302:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 306:	00001717          	auipc	a4,0x1
 30a:	cfa70713          	addi	a4,a4,-774 # 1000 <next_tid>
 30e:	431c                	lw	a5,0(a4)
 310:	0017869b          	addiw	a3,a5,1
 314:	c314                	sw	a3,0(a4)
 316:	6098                	ld	a4,0(s1)
 318:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 31c:	00001717          	auipc	a4,0x1
 320:	d1470713          	addi	a4,a4,-748 # 1030 <threads>
 324:	4781                	li	a5,0
 326:	4641                	li	a2,16
    if (threads[i] == NULL) {
 328:	6314                	ld	a3,0(a4)
 32a:	ce81                	beqz	a3,342 <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 32c:	2785                	addiw	a5,a5,1
 32e:	0721                	addi	a4,a4,8
 330:	fec79ce3          	bne	a5,a2,328 <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 334:	70a2                	ld	ra,40(sp)
 336:	7402                	ld	s0,32(sp)
 338:	64e2                	ld	s1,24(sp)
 33a:	6942                	ld	s2,16(sp)
 33c:	69a2                	ld	s3,8(sp)
 33e:	6145                	addi	sp,sp,48
 340:	8082                	ret
        threads[i] = *thread;
 342:	6094                	ld	a3,0(s1)
 344:	078e                	slli	a5,a5,0x3
 346:	00001717          	auipc	a4,0x1
 34a:	cea70713          	addi	a4,a4,-790 # 1030 <threads>
 34e:	97ba                	add	a5,a5,a4
 350:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 352:	0006c583          	lbu	a1,0(a3)
 356:	00001517          	auipc	a0,0x1
 35a:	a9250513          	addi	a0,a0,-1390 # de8 <malloc+0x1fc>
 35e:	00000097          	auipc	ra,0x0
 362:	7d6080e7          	jalr	2006(ra) # b34 <printf>
        break;
 366:	b7f9                	j	334 <tcreate+0x60>

0000000000000368 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 368:	7179                	addi	sp,sp,-48
 36a:	f406                	sd	ra,40(sp)
 36c:	f022                	sd	s0,32(sp)
 36e:	ec26                	sd	s1,24(sp)
 370:	e84a                	sd	s2,16(sp)
 372:	e44e                	sd	s3,8(sp)
 374:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 376:	00001797          	auipc	a5,0x1
 37a:	cba78793          	addi	a5,a5,-838 # 1030 <threads>
 37e:	00001697          	auipc	a3,0x1
 382:	d3268693          	addi	a3,a3,-718 # 10b0 <base>
 386:	a021                	j	38e <tjoin+0x26>
 388:	07a1                	addi	a5,a5,8
 38a:	04d78763          	beq	a5,a3,3d8 <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 38e:	6384                	ld	s1,0(a5)
 390:	dce5                	beqz	s1,388 <tjoin+0x20>
 392:	0004c703          	lbu	a4,0(s1)
 396:	fea719e3          	bne	a4,a0,388 <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 39a:	5cb8                	lw	a4,120(s1)
 39c:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 39e:	00001997          	auipc	s3,0x1
 3a2:	a7a98993          	addi	s3,s3,-1414 # e18 <malloc+0x22c>
    while (target_thread->state != EXITED) {
 3a6:	4919                	li	s2,6
 3a8:	02f70a63          	beq	a4,a5,3dc <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 3ac:	0004c583          	lbu	a1,0(s1)
 3b0:	854e                	mv	a0,s3
 3b2:	00000097          	auipc	ra,0x0
 3b6:	782080e7          	jalr	1922(ra) # b34 <printf>
        tsched();
 3ba:	00000097          	auipc	ra,0x0
 3be:	e5e080e7          	jalr	-418(ra) # 218 <tsched>
    while (target_thread->state != EXITED) {
 3c2:	5cbc                	lw	a5,120(s1)
 3c4:	ff2794e3          	bne	a5,s2,3ac <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 3c8:	4501                	li	a0,0
}
 3ca:	70a2                	ld	ra,40(sp)
 3cc:	7402                	ld	s0,32(sp)
 3ce:	64e2                	ld	s1,24(sp)
 3d0:	6942                	ld	s2,16(sp)
 3d2:	69a2                	ld	s3,8(sp)
 3d4:	6145                	addi	sp,sp,48
 3d6:	8082                	ret
        return -1;
 3d8:	557d                	li	a0,-1
 3da:	bfc5                	j	3ca <tjoin+0x62>
    return 0;
 3dc:	4501                	li	a0,0
 3de:	b7f5                	j	3ca <tjoin+0x62>

00000000000003e0 <tyield>:


void tyield()
{
 3e0:	1141                	addi	sp,sp,-16
 3e2:	e406                	sd	ra,8(sp)
 3e4:	e022                	sd	s0,0(sp)
 3e6:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 3e8:	00001797          	auipc	a5,0x1
 3ec:	c387b783          	ld	a5,-968(a5) # 1020 <current_thread>
 3f0:	470d                	li	a4,3
 3f2:	dfb8                	sw	a4,120(a5)
    tsched();
 3f4:	00000097          	auipc	ra,0x0
 3f8:	e24080e7          	jalr	-476(ra) # 218 <tsched>
}
 3fc:	60a2                	ld	ra,8(sp)
 3fe:	6402                	ld	s0,0(sp)
 400:	0141                	addi	sp,sp,16
 402:	8082                	ret

0000000000000404 <twhoami>:

uint8 twhoami()
{
 404:	1141                	addi	sp,sp,-16
 406:	e422                	sd	s0,8(sp)
 408:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
 40a:	00001797          	auipc	a5,0x1
 40e:	c167b783          	ld	a5,-1002(a5) # 1020 <current_thread>
 412:	0007c503          	lbu	a0,0(a5)
 416:	6422                	ld	s0,8(sp)
 418:	0141                	addi	sp,sp,16
 41a:	8082                	ret

000000000000041c <tswtch>:
 41c:	00153023          	sd	ra,0(a0)
 420:	00253423          	sd	sp,8(a0)
 424:	e900                	sd	s0,16(a0)
 426:	ed04                	sd	s1,24(a0)
 428:	03253023          	sd	s2,32(a0)
 42c:	03353423          	sd	s3,40(a0)
 430:	03453823          	sd	s4,48(a0)
 434:	03553c23          	sd	s5,56(a0)
 438:	05653023          	sd	s6,64(a0)
 43c:	05753423          	sd	s7,72(a0)
 440:	05853823          	sd	s8,80(a0)
 444:	05953c23          	sd	s9,88(a0)
 448:	07a53023          	sd	s10,96(a0)
 44c:	07b53423          	sd	s11,104(a0)
 450:	0005b083          	ld	ra,0(a1)
 454:	0085b103          	ld	sp,8(a1)
 458:	6980                	ld	s0,16(a1)
 45a:	6d84                	ld	s1,24(a1)
 45c:	0205b903          	ld	s2,32(a1)
 460:	0285b983          	ld	s3,40(a1)
 464:	0305ba03          	ld	s4,48(a1)
 468:	0385ba83          	ld	s5,56(a1)
 46c:	0405bb03          	ld	s6,64(a1)
 470:	0485bb83          	ld	s7,72(a1)
 474:	0505bc03          	ld	s8,80(a1)
 478:	0585bc83          	ld	s9,88(a1)
 47c:	0605bd03          	ld	s10,96(a1)
 480:	0685bd83          	ld	s11,104(a1)
 484:	8082                	ret

0000000000000486 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 486:	715d                	addi	sp,sp,-80
 488:	e486                	sd	ra,72(sp)
 48a:	e0a2                	sd	s0,64(sp)
 48c:	fc26                	sd	s1,56(sp)
 48e:	f84a                	sd	s2,48(sp)
 490:	f44e                	sd	s3,40(sp)
 492:	f052                	sd	s4,32(sp)
 494:	ec56                	sd	s5,24(sp)
 496:	e85a                	sd	s6,16(sp)
 498:	e45e                	sd	s7,8(sp)
 49a:	0880                	addi	s0,sp,80
 49c:	892a                	mv	s2,a0
 49e:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 4a0:	00001517          	auipc	a0,0x1
 4a4:	99850513          	addi	a0,a0,-1640 # e38 <malloc+0x24c>
 4a8:	00000097          	auipc	ra,0x0
 4ac:	68c080e7          	jalr	1676(ra) # b34 <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 4b0:	09000513          	li	a0,144
 4b4:	00000097          	auipc	ra,0x0
 4b8:	738080e7          	jalr	1848(ra) # bec <malloc>

    main_thread->tid = 0;
 4bc:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 4c0:	4791                	li	a5,4
 4c2:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 4c4:	00001797          	auipc	a5,0x1
 4c8:	b4a7be23          	sd	a0,-1188(a5) # 1020 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 4cc:	00001a17          	auipc	s4,0x1
 4d0:	b64a0a13          	addi	s4,s4,-1180 # 1030 <threads>
 4d4:	00001497          	auipc	s1,0x1
 4d8:	bdc48493          	addi	s1,s1,-1060 # 10b0 <base>
    current_thread = main_thread;
 4dc:	87d2                	mv	a5,s4
        threads[i] = NULL;
 4de:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 4e2:	07a1                	addi	a5,a5,8
 4e4:	fe979de3          	bne	a5,s1,4de <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 4e8:	00001797          	auipc	a5,0x1
 4ec:	b4a7b423          	sd	a0,-1208(a5) # 1030 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 4f0:	85ce                	mv	a1,s3
 4f2:	854a                	mv	a0,s2
 4f4:	00000097          	auipc	ra,0x0
 4f8:	b0c080e7          	jalr	-1268(ra) # 0 <main>
 4fc:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 4fe:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 500:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 502:	00001a97          	auipc	s5,0x1
 506:	956a8a93          	addi	s5,s5,-1706 # e58 <malloc+0x26c>
 50a:	a03d                	j	538 <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 50c:	07a1                	addi	a5,a5,8
 50e:	00978963          	beq	a5,s1,520 <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 512:	6398                	ld	a4,0(a5)
 514:	df65                	beqz	a4,50c <_main+0x86>
 516:	5f38                	lw	a4,120(a4)
 518:	ff370ae3          	beq	a4,s3,50c <_main+0x86>
                running_threads++;
 51c:	2905                	addiw	s2,s2,1
 51e:	b7fd                	j	50c <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 520:	85ca                	mv	a1,s2
 522:	8556                	mv	a0,s5
 524:	00000097          	auipc	ra,0x0
 528:	610080e7          	jalr	1552(ra) # b34 <printf>
        if (running_threads > 0) {
 52c:	01205963          	blez	s2,53e <_main+0xb8>
            tsched(); // Schedule another thread to run
 530:	00000097          	auipc	ra,0x0
 534:	ce8080e7          	jalr	-792(ra) # 218 <tsched>
    current_thread = main_thread;
 538:	87d2                	mv	a5,s4
        running_threads = 0;
 53a:	895a                	mv	s2,s6
 53c:	bfd9                	j	512 <_main+0x8c>
        }
    }

    exit(res);
 53e:	855e                	mv	a0,s7
 540:	00000097          	auipc	ra,0x0
 544:	274080e7          	jalr	628(ra) # 7b4 <exit>

0000000000000548 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 548:	1141                	addi	sp,sp,-16
 54a:	e422                	sd	s0,8(sp)
 54c:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 54e:	87aa                	mv	a5,a0
 550:	0585                	addi	a1,a1,1
 552:	0785                	addi	a5,a5,1
 554:	fff5c703          	lbu	a4,-1(a1)
 558:	fee78fa3          	sb	a4,-1(a5)
 55c:	fb75                	bnez	a4,550 <strcpy+0x8>
        ;
    return os;
}
 55e:	6422                	ld	s0,8(sp)
 560:	0141                	addi	sp,sp,16
 562:	8082                	ret

0000000000000564 <strcmp>:

int strcmp(const char *p, const char *q)
{
 564:	1141                	addi	sp,sp,-16
 566:	e422                	sd	s0,8(sp)
 568:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 56a:	00054783          	lbu	a5,0(a0)
 56e:	cb91                	beqz	a5,582 <strcmp+0x1e>
 570:	0005c703          	lbu	a4,0(a1)
 574:	00f71763          	bne	a4,a5,582 <strcmp+0x1e>
        p++, q++;
 578:	0505                	addi	a0,a0,1
 57a:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 57c:	00054783          	lbu	a5,0(a0)
 580:	fbe5                	bnez	a5,570 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 582:	0005c503          	lbu	a0,0(a1)
}
 586:	40a7853b          	subw	a0,a5,a0
 58a:	6422                	ld	s0,8(sp)
 58c:	0141                	addi	sp,sp,16
 58e:	8082                	ret

0000000000000590 <strlen>:

uint strlen(const char *s)
{
 590:	1141                	addi	sp,sp,-16
 592:	e422                	sd	s0,8(sp)
 594:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 596:	00054783          	lbu	a5,0(a0)
 59a:	cf91                	beqz	a5,5b6 <strlen+0x26>
 59c:	0505                	addi	a0,a0,1
 59e:	87aa                	mv	a5,a0
 5a0:	86be                	mv	a3,a5
 5a2:	0785                	addi	a5,a5,1
 5a4:	fff7c703          	lbu	a4,-1(a5)
 5a8:	ff65                	bnez	a4,5a0 <strlen+0x10>
 5aa:	40a6853b          	subw	a0,a3,a0
 5ae:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 5b0:	6422                	ld	s0,8(sp)
 5b2:	0141                	addi	sp,sp,16
 5b4:	8082                	ret
    for (n = 0; s[n]; n++)
 5b6:	4501                	li	a0,0
 5b8:	bfe5                	j	5b0 <strlen+0x20>

00000000000005ba <memset>:

void *
memset(void *dst, int c, uint n)
{
 5ba:	1141                	addi	sp,sp,-16
 5bc:	e422                	sd	s0,8(sp)
 5be:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 5c0:	ca19                	beqz	a2,5d6 <memset+0x1c>
 5c2:	87aa                	mv	a5,a0
 5c4:	1602                	slli	a2,a2,0x20
 5c6:	9201                	srli	a2,a2,0x20
 5c8:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 5cc:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 5d0:	0785                	addi	a5,a5,1
 5d2:	fee79de3          	bne	a5,a4,5cc <memset+0x12>
    }
    return dst;
}
 5d6:	6422                	ld	s0,8(sp)
 5d8:	0141                	addi	sp,sp,16
 5da:	8082                	ret

00000000000005dc <strchr>:

char *
strchr(const char *s, char c)
{
 5dc:	1141                	addi	sp,sp,-16
 5de:	e422                	sd	s0,8(sp)
 5e0:	0800                	addi	s0,sp,16
    for (; *s; s++)
 5e2:	00054783          	lbu	a5,0(a0)
 5e6:	cb99                	beqz	a5,5fc <strchr+0x20>
        if (*s == c)
 5e8:	00f58763          	beq	a1,a5,5f6 <strchr+0x1a>
    for (; *s; s++)
 5ec:	0505                	addi	a0,a0,1
 5ee:	00054783          	lbu	a5,0(a0)
 5f2:	fbfd                	bnez	a5,5e8 <strchr+0xc>
            return (char *)s;
    return 0;
 5f4:	4501                	li	a0,0
}
 5f6:	6422                	ld	s0,8(sp)
 5f8:	0141                	addi	sp,sp,16
 5fa:	8082                	ret
    return 0;
 5fc:	4501                	li	a0,0
 5fe:	bfe5                	j	5f6 <strchr+0x1a>

0000000000000600 <gets>:

char *
gets(char *buf, int max)
{
 600:	711d                	addi	sp,sp,-96
 602:	ec86                	sd	ra,88(sp)
 604:	e8a2                	sd	s0,80(sp)
 606:	e4a6                	sd	s1,72(sp)
 608:	e0ca                	sd	s2,64(sp)
 60a:	fc4e                	sd	s3,56(sp)
 60c:	f852                	sd	s4,48(sp)
 60e:	f456                	sd	s5,40(sp)
 610:	f05a                	sd	s6,32(sp)
 612:	ec5e                	sd	s7,24(sp)
 614:	1080                	addi	s0,sp,96
 616:	8baa                	mv	s7,a0
 618:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 61a:	892a                	mv	s2,a0
 61c:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 61e:	4aa9                	li	s5,10
 620:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 622:	89a6                	mv	s3,s1
 624:	2485                	addiw	s1,s1,1
 626:	0344d863          	bge	s1,s4,656 <gets+0x56>
        cc = read(0, &c, 1);
 62a:	4605                	li	a2,1
 62c:	faf40593          	addi	a1,s0,-81
 630:	4501                	li	a0,0
 632:	00000097          	auipc	ra,0x0
 636:	19a080e7          	jalr	410(ra) # 7cc <read>
        if (cc < 1)
 63a:	00a05e63          	blez	a0,656 <gets+0x56>
        buf[i++] = c;
 63e:	faf44783          	lbu	a5,-81(s0)
 642:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 646:	01578763          	beq	a5,s5,654 <gets+0x54>
 64a:	0905                	addi	s2,s2,1
 64c:	fd679be3          	bne	a5,s6,622 <gets+0x22>
    for (i = 0; i + 1 < max;)
 650:	89a6                	mv	s3,s1
 652:	a011                	j	656 <gets+0x56>
 654:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 656:	99de                	add	s3,s3,s7
 658:	00098023          	sb	zero,0(s3)
    return buf;
}
 65c:	855e                	mv	a0,s7
 65e:	60e6                	ld	ra,88(sp)
 660:	6446                	ld	s0,80(sp)
 662:	64a6                	ld	s1,72(sp)
 664:	6906                	ld	s2,64(sp)
 666:	79e2                	ld	s3,56(sp)
 668:	7a42                	ld	s4,48(sp)
 66a:	7aa2                	ld	s5,40(sp)
 66c:	7b02                	ld	s6,32(sp)
 66e:	6be2                	ld	s7,24(sp)
 670:	6125                	addi	sp,sp,96
 672:	8082                	ret

0000000000000674 <stat>:

int stat(const char *n, struct stat *st)
{
 674:	1101                	addi	sp,sp,-32
 676:	ec06                	sd	ra,24(sp)
 678:	e822                	sd	s0,16(sp)
 67a:	e426                	sd	s1,8(sp)
 67c:	e04a                	sd	s2,0(sp)
 67e:	1000                	addi	s0,sp,32
 680:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 682:	4581                	li	a1,0
 684:	00000097          	auipc	ra,0x0
 688:	170080e7          	jalr	368(ra) # 7f4 <open>
    if (fd < 0)
 68c:	02054563          	bltz	a0,6b6 <stat+0x42>
 690:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 692:	85ca                	mv	a1,s2
 694:	00000097          	auipc	ra,0x0
 698:	178080e7          	jalr	376(ra) # 80c <fstat>
 69c:	892a                	mv	s2,a0
    close(fd);
 69e:	8526                	mv	a0,s1
 6a0:	00000097          	auipc	ra,0x0
 6a4:	13c080e7          	jalr	316(ra) # 7dc <close>
    return r;
}
 6a8:	854a                	mv	a0,s2
 6aa:	60e2                	ld	ra,24(sp)
 6ac:	6442                	ld	s0,16(sp)
 6ae:	64a2                	ld	s1,8(sp)
 6b0:	6902                	ld	s2,0(sp)
 6b2:	6105                	addi	sp,sp,32
 6b4:	8082                	ret
        return -1;
 6b6:	597d                	li	s2,-1
 6b8:	bfc5                	j	6a8 <stat+0x34>

00000000000006ba <atoi>:

int atoi(const char *s)
{
 6ba:	1141                	addi	sp,sp,-16
 6bc:	e422                	sd	s0,8(sp)
 6be:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 6c0:	00054683          	lbu	a3,0(a0)
 6c4:	fd06879b          	addiw	a5,a3,-48
 6c8:	0ff7f793          	zext.b	a5,a5
 6cc:	4625                	li	a2,9
 6ce:	02f66863          	bltu	a2,a5,6fe <atoi+0x44>
 6d2:	872a                	mv	a4,a0
    n = 0;
 6d4:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 6d6:	0705                	addi	a4,a4,1
 6d8:	0025179b          	slliw	a5,a0,0x2
 6dc:	9fa9                	addw	a5,a5,a0
 6de:	0017979b          	slliw	a5,a5,0x1
 6e2:	9fb5                	addw	a5,a5,a3
 6e4:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 6e8:	00074683          	lbu	a3,0(a4)
 6ec:	fd06879b          	addiw	a5,a3,-48
 6f0:	0ff7f793          	zext.b	a5,a5
 6f4:	fef671e3          	bgeu	a2,a5,6d6 <atoi+0x1c>
    return n;
}
 6f8:	6422                	ld	s0,8(sp)
 6fa:	0141                	addi	sp,sp,16
 6fc:	8082                	ret
    n = 0;
 6fe:	4501                	li	a0,0
 700:	bfe5                	j	6f8 <atoi+0x3e>

0000000000000702 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 702:	1141                	addi	sp,sp,-16
 704:	e422                	sd	s0,8(sp)
 706:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 708:	02b57463          	bgeu	a0,a1,730 <memmove+0x2e>
    {
        while (n-- > 0)
 70c:	00c05f63          	blez	a2,72a <memmove+0x28>
 710:	1602                	slli	a2,a2,0x20
 712:	9201                	srli	a2,a2,0x20
 714:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 718:	872a                	mv	a4,a0
            *dst++ = *src++;
 71a:	0585                	addi	a1,a1,1
 71c:	0705                	addi	a4,a4,1
 71e:	fff5c683          	lbu	a3,-1(a1)
 722:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 726:	fee79ae3          	bne	a5,a4,71a <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 72a:	6422                	ld	s0,8(sp)
 72c:	0141                	addi	sp,sp,16
 72e:	8082                	ret
        dst += n;
 730:	00c50733          	add	a4,a0,a2
        src += n;
 734:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 736:	fec05ae3          	blez	a2,72a <memmove+0x28>
 73a:	fff6079b          	addiw	a5,a2,-1
 73e:	1782                	slli	a5,a5,0x20
 740:	9381                	srli	a5,a5,0x20
 742:	fff7c793          	not	a5,a5
 746:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 748:	15fd                	addi	a1,a1,-1
 74a:	177d                	addi	a4,a4,-1
 74c:	0005c683          	lbu	a3,0(a1)
 750:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 754:	fee79ae3          	bne	a5,a4,748 <memmove+0x46>
 758:	bfc9                	j	72a <memmove+0x28>

000000000000075a <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 75a:	1141                	addi	sp,sp,-16
 75c:	e422                	sd	s0,8(sp)
 75e:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 760:	ca05                	beqz	a2,790 <memcmp+0x36>
 762:	fff6069b          	addiw	a3,a2,-1
 766:	1682                	slli	a3,a3,0x20
 768:	9281                	srli	a3,a3,0x20
 76a:	0685                	addi	a3,a3,1
 76c:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 76e:	00054783          	lbu	a5,0(a0)
 772:	0005c703          	lbu	a4,0(a1)
 776:	00e79863          	bne	a5,a4,786 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 77a:	0505                	addi	a0,a0,1
        p2++;
 77c:	0585                	addi	a1,a1,1
    while (n-- > 0)
 77e:	fed518e3          	bne	a0,a3,76e <memcmp+0x14>
    }
    return 0;
 782:	4501                	li	a0,0
 784:	a019                	j	78a <memcmp+0x30>
            return *p1 - *p2;
 786:	40e7853b          	subw	a0,a5,a4
}
 78a:	6422                	ld	s0,8(sp)
 78c:	0141                	addi	sp,sp,16
 78e:	8082                	ret
    return 0;
 790:	4501                	li	a0,0
 792:	bfe5                	j	78a <memcmp+0x30>

0000000000000794 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 794:	1141                	addi	sp,sp,-16
 796:	e406                	sd	ra,8(sp)
 798:	e022                	sd	s0,0(sp)
 79a:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 79c:	00000097          	auipc	ra,0x0
 7a0:	f66080e7          	jalr	-154(ra) # 702 <memmove>
}
 7a4:	60a2                	ld	ra,8(sp)
 7a6:	6402                	ld	s0,0(sp)
 7a8:	0141                	addi	sp,sp,16
 7aa:	8082                	ret

00000000000007ac <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 7ac:	4885                	li	a7,1
 ecall
 7ae:	00000073          	ecall
 ret
 7b2:	8082                	ret

00000000000007b4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 7b4:	4889                	li	a7,2
 ecall
 7b6:	00000073          	ecall
 ret
 7ba:	8082                	ret

00000000000007bc <wait>:
.global wait
wait:
 li a7, SYS_wait
 7bc:	488d                	li	a7,3
 ecall
 7be:	00000073          	ecall
 ret
 7c2:	8082                	ret

00000000000007c4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 7c4:	4891                	li	a7,4
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <read>:
.global read
read:
 li a7, SYS_read
 7cc:	4895                	li	a7,5
 ecall
 7ce:	00000073          	ecall
 ret
 7d2:	8082                	ret

00000000000007d4 <write>:
.global write
write:
 li a7, SYS_write
 7d4:	48c1                	li	a7,16
 ecall
 7d6:	00000073          	ecall
 ret
 7da:	8082                	ret

00000000000007dc <close>:
.global close
close:
 li a7, SYS_close
 7dc:	48d5                	li	a7,21
 ecall
 7de:	00000073          	ecall
 ret
 7e2:	8082                	ret

00000000000007e4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 7e4:	4899                	li	a7,6
 ecall
 7e6:	00000073          	ecall
 ret
 7ea:	8082                	ret

00000000000007ec <exec>:
.global exec
exec:
 li a7, SYS_exec
 7ec:	489d                	li	a7,7
 ecall
 7ee:	00000073          	ecall
 ret
 7f2:	8082                	ret

00000000000007f4 <open>:
.global open
open:
 li a7, SYS_open
 7f4:	48bd                	li	a7,15
 ecall
 7f6:	00000073          	ecall
 ret
 7fa:	8082                	ret

00000000000007fc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7fc:	48c5                	li	a7,17
 ecall
 7fe:	00000073          	ecall
 ret
 802:	8082                	ret

0000000000000804 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 804:	48c9                	li	a7,18
 ecall
 806:	00000073          	ecall
 ret
 80a:	8082                	ret

000000000000080c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 80c:	48a1                	li	a7,8
 ecall
 80e:	00000073          	ecall
 ret
 812:	8082                	ret

0000000000000814 <link>:
.global link
link:
 li a7, SYS_link
 814:	48cd                	li	a7,19
 ecall
 816:	00000073          	ecall
 ret
 81a:	8082                	ret

000000000000081c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 81c:	48d1                	li	a7,20
 ecall
 81e:	00000073          	ecall
 ret
 822:	8082                	ret

0000000000000824 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 824:	48a5                	li	a7,9
 ecall
 826:	00000073          	ecall
 ret
 82a:	8082                	ret

000000000000082c <dup>:
.global dup
dup:
 li a7, SYS_dup
 82c:	48a9                	li	a7,10
 ecall
 82e:	00000073          	ecall
 ret
 832:	8082                	ret

0000000000000834 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 834:	48ad                	li	a7,11
 ecall
 836:	00000073          	ecall
 ret
 83a:	8082                	ret

000000000000083c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 83c:	48b1                	li	a7,12
 ecall
 83e:	00000073          	ecall
 ret
 842:	8082                	ret

0000000000000844 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 844:	48b5                	li	a7,13
 ecall
 846:	00000073          	ecall
 ret
 84a:	8082                	ret

000000000000084c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 84c:	48b9                	li	a7,14
 ecall
 84e:	00000073          	ecall
 ret
 852:	8082                	ret

0000000000000854 <ps>:
.global ps
ps:
 li a7, SYS_ps
 854:	48d9                	li	a7,22
 ecall
 856:	00000073          	ecall
 ret
 85a:	8082                	ret

000000000000085c <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 85c:	48dd                	li	a7,23
 ecall
 85e:	00000073          	ecall
 ret
 862:	8082                	ret

0000000000000864 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 864:	48e1                	li	a7,24
 ecall
 866:	00000073          	ecall
 ret
 86a:	8082                	ret

000000000000086c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 86c:	1101                	addi	sp,sp,-32
 86e:	ec06                	sd	ra,24(sp)
 870:	e822                	sd	s0,16(sp)
 872:	1000                	addi	s0,sp,32
 874:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 878:	4605                	li	a2,1
 87a:	fef40593          	addi	a1,s0,-17
 87e:	00000097          	auipc	ra,0x0
 882:	f56080e7          	jalr	-170(ra) # 7d4 <write>
}
 886:	60e2                	ld	ra,24(sp)
 888:	6442                	ld	s0,16(sp)
 88a:	6105                	addi	sp,sp,32
 88c:	8082                	ret

000000000000088e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 88e:	7139                	addi	sp,sp,-64
 890:	fc06                	sd	ra,56(sp)
 892:	f822                	sd	s0,48(sp)
 894:	f426                	sd	s1,40(sp)
 896:	f04a                	sd	s2,32(sp)
 898:	ec4e                	sd	s3,24(sp)
 89a:	0080                	addi	s0,sp,64
 89c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 89e:	c299                	beqz	a3,8a4 <printint+0x16>
 8a0:	0805c963          	bltz	a1,932 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 8a4:	2581                	sext.w	a1,a1
  neg = 0;
 8a6:	4881                	li	a7,0
 8a8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 8ac:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 8ae:	2601                	sext.w	a2,a2
 8b0:	00000517          	auipc	a0,0x0
 8b4:	62850513          	addi	a0,a0,1576 # ed8 <digits>
 8b8:	883a                	mv	a6,a4
 8ba:	2705                	addiw	a4,a4,1
 8bc:	02c5f7bb          	remuw	a5,a1,a2
 8c0:	1782                	slli	a5,a5,0x20
 8c2:	9381                	srli	a5,a5,0x20
 8c4:	97aa                	add	a5,a5,a0
 8c6:	0007c783          	lbu	a5,0(a5)
 8ca:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 8ce:	0005879b          	sext.w	a5,a1
 8d2:	02c5d5bb          	divuw	a1,a1,a2
 8d6:	0685                	addi	a3,a3,1
 8d8:	fec7f0e3          	bgeu	a5,a2,8b8 <printint+0x2a>
  if(neg)
 8dc:	00088c63          	beqz	a7,8f4 <printint+0x66>
    buf[i++] = '-';
 8e0:	fd070793          	addi	a5,a4,-48
 8e4:	00878733          	add	a4,a5,s0
 8e8:	02d00793          	li	a5,45
 8ec:	fef70823          	sb	a5,-16(a4)
 8f0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 8f4:	02e05863          	blez	a4,924 <printint+0x96>
 8f8:	fc040793          	addi	a5,s0,-64
 8fc:	00e78933          	add	s2,a5,a4
 900:	fff78993          	addi	s3,a5,-1
 904:	99ba                	add	s3,s3,a4
 906:	377d                	addiw	a4,a4,-1
 908:	1702                	slli	a4,a4,0x20
 90a:	9301                	srli	a4,a4,0x20
 90c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 910:	fff94583          	lbu	a1,-1(s2)
 914:	8526                	mv	a0,s1
 916:	00000097          	auipc	ra,0x0
 91a:	f56080e7          	jalr	-170(ra) # 86c <putc>
  while(--i >= 0)
 91e:	197d                	addi	s2,s2,-1
 920:	ff3918e3          	bne	s2,s3,910 <printint+0x82>
}
 924:	70e2                	ld	ra,56(sp)
 926:	7442                	ld	s0,48(sp)
 928:	74a2                	ld	s1,40(sp)
 92a:	7902                	ld	s2,32(sp)
 92c:	69e2                	ld	s3,24(sp)
 92e:	6121                	addi	sp,sp,64
 930:	8082                	ret
    x = -xx;
 932:	40b005bb          	negw	a1,a1
    neg = 1;
 936:	4885                	li	a7,1
    x = -xx;
 938:	bf85                	j	8a8 <printint+0x1a>

000000000000093a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 93a:	715d                	addi	sp,sp,-80
 93c:	e486                	sd	ra,72(sp)
 93e:	e0a2                	sd	s0,64(sp)
 940:	fc26                	sd	s1,56(sp)
 942:	f84a                	sd	s2,48(sp)
 944:	f44e                	sd	s3,40(sp)
 946:	f052                	sd	s4,32(sp)
 948:	ec56                	sd	s5,24(sp)
 94a:	e85a                	sd	s6,16(sp)
 94c:	e45e                	sd	s7,8(sp)
 94e:	e062                	sd	s8,0(sp)
 950:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 952:	0005c903          	lbu	s2,0(a1)
 956:	18090c63          	beqz	s2,aee <vprintf+0x1b4>
 95a:	8aaa                	mv	s5,a0
 95c:	8bb2                	mv	s7,a2
 95e:	00158493          	addi	s1,a1,1
  state = 0;
 962:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 964:	02500a13          	li	s4,37
 968:	4b55                	li	s6,21
 96a:	a839                	j	988 <vprintf+0x4e>
        putc(fd, c);
 96c:	85ca                	mv	a1,s2
 96e:	8556                	mv	a0,s5
 970:	00000097          	auipc	ra,0x0
 974:	efc080e7          	jalr	-260(ra) # 86c <putc>
 978:	a019                	j	97e <vprintf+0x44>
    } else if(state == '%'){
 97a:	01498d63          	beq	s3,s4,994 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 97e:	0485                	addi	s1,s1,1
 980:	fff4c903          	lbu	s2,-1(s1)
 984:	16090563          	beqz	s2,aee <vprintf+0x1b4>
    if(state == 0){
 988:	fe0999e3          	bnez	s3,97a <vprintf+0x40>
      if(c == '%'){
 98c:	ff4910e3          	bne	s2,s4,96c <vprintf+0x32>
        state = '%';
 990:	89d2                	mv	s3,s4
 992:	b7f5                	j	97e <vprintf+0x44>
      if(c == 'd'){
 994:	13490263          	beq	s2,s4,ab8 <vprintf+0x17e>
 998:	f9d9079b          	addiw	a5,s2,-99
 99c:	0ff7f793          	zext.b	a5,a5
 9a0:	12fb6563          	bltu	s6,a5,aca <vprintf+0x190>
 9a4:	f9d9079b          	addiw	a5,s2,-99
 9a8:	0ff7f713          	zext.b	a4,a5
 9ac:	10eb6f63          	bltu	s6,a4,aca <vprintf+0x190>
 9b0:	00271793          	slli	a5,a4,0x2
 9b4:	00000717          	auipc	a4,0x0
 9b8:	4cc70713          	addi	a4,a4,1228 # e80 <malloc+0x294>
 9bc:	97ba                	add	a5,a5,a4
 9be:	439c                	lw	a5,0(a5)
 9c0:	97ba                	add	a5,a5,a4
 9c2:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 9c4:	008b8913          	addi	s2,s7,8
 9c8:	4685                	li	a3,1
 9ca:	4629                	li	a2,10
 9cc:	000ba583          	lw	a1,0(s7)
 9d0:	8556                	mv	a0,s5
 9d2:	00000097          	auipc	ra,0x0
 9d6:	ebc080e7          	jalr	-324(ra) # 88e <printint>
 9da:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9dc:	4981                	li	s3,0
 9de:	b745                	j	97e <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9e0:	008b8913          	addi	s2,s7,8
 9e4:	4681                	li	a3,0
 9e6:	4629                	li	a2,10
 9e8:	000ba583          	lw	a1,0(s7)
 9ec:	8556                	mv	a0,s5
 9ee:	00000097          	auipc	ra,0x0
 9f2:	ea0080e7          	jalr	-352(ra) # 88e <printint>
 9f6:	8bca                	mv	s7,s2
      state = 0;
 9f8:	4981                	li	s3,0
 9fa:	b751                	j	97e <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 9fc:	008b8913          	addi	s2,s7,8
 a00:	4681                	li	a3,0
 a02:	4641                	li	a2,16
 a04:	000ba583          	lw	a1,0(s7)
 a08:	8556                	mv	a0,s5
 a0a:	00000097          	auipc	ra,0x0
 a0e:	e84080e7          	jalr	-380(ra) # 88e <printint>
 a12:	8bca                	mv	s7,s2
      state = 0;
 a14:	4981                	li	s3,0
 a16:	b7a5                	j	97e <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 a18:	008b8c13          	addi	s8,s7,8
 a1c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a20:	03000593          	li	a1,48
 a24:	8556                	mv	a0,s5
 a26:	00000097          	auipc	ra,0x0
 a2a:	e46080e7          	jalr	-442(ra) # 86c <putc>
  putc(fd, 'x');
 a2e:	07800593          	li	a1,120
 a32:	8556                	mv	a0,s5
 a34:	00000097          	auipc	ra,0x0
 a38:	e38080e7          	jalr	-456(ra) # 86c <putc>
 a3c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a3e:	00000b97          	auipc	s7,0x0
 a42:	49ab8b93          	addi	s7,s7,1178 # ed8 <digits>
 a46:	03c9d793          	srli	a5,s3,0x3c
 a4a:	97de                	add	a5,a5,s7
 a4c:	0007c583          	lbu	a1,0(a5)
 a50:	8556                	mv	a0,s5
 a52:	00000097          	auipc	ra,0x0
 a56:	e1a080e7          	jalr	-486(ra) # 86c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a5a:	0992                	slli	s3,s3,0x4
 a5c:	397d                	addiw	s2,s2,-1
 a5e:	fe0914e3          	bnez	s2,a46 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 a62:	8be2                	mv	s7,s8
      state = 0;
 a64:	4981                	li	s3,0
 a66:	bf21                	j	97e <vprintf+0x44>
        s = va_arg(ap, char*);
 a68:	008b8993          	addi	s3,s7,8
 a6c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a70:	02090163          	beqz	s2,a92 <vprintf+0x158>
        while(*s != 0){
 a74:	00094583          	lbu	a1,0(s2)
 a78:	c9a5                	beqz	a1,ae8 <vprintf+0x1ae>
          putc(fd, *s);
 a7a:	8556                	mv	a0,s5
 a7c:	00000097          	auipc	ra,0x0
 a80:	df0080e7          	jalr	-528(ra) # 86c <putc>
          s++;
 a84:	0905                	addi	s2,s2,1
        while(*s != 0){
 a86:	00094583          	lbu	a1,0(s2)
 a8a:	f9e5                	bnez	a1,a7a <vprintf+0x140>
        s = va_arg(ap, char*);
 a8c:	8bce                	mv	s7,s3
      state = 0;
 a8e:	4981                	li	s3,0
 a90:	b5fd                	j	97e <vprintf+0x44>
          s = "(null)";
 a92:	00000917          	auipc	s2,0x0
 a96:	3e690913          	addi	s2,s2,998 # e78 <malloc+0x28c>
        while(*s != 0){
 a9a:	02800593          	li	a1,40
 a9e:	bff1                	j	a7a <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 aa0:	008b8913          	addi	s2,s7,8
 aa4:	000bc583          	lbu	a1,0(s7)
 aa8:	8556                	mv	a0,s5
 aaa:	00000097          	auipc	ra,0x0
 aae:	dc2080e7          	jalr	-574(ra) # 86c <putc>
 ab2:	8bca                	mv	s7,s2
      state = 0;
 ab4:	4981                	li	s3,0
 ab6:	b5e1                	j	97e <vprintf+0x44>
        putc(fd, c);
 ab8:	02500593          	li	a1,37
 abc:	8556                	mv	a0,s5
 abe:	00000097          	auipc	ra,0x0
 ac2:	dae080e7          	jalr	-594(ra) # 86c <putc>
      state = 0;
 ac6:	4981                	li	s3,0
 ac8:	bd5d                	j	97e <vprintf+0x44>
        putc(fd, '%');
 aca:	02500593          	li	a1,37
 ace:	8556                	mv	a0,s5
 ad0:	00000097          	auipc	ra,0x0
 ad4:	d9c080e7          	jalr	-612(ra) # 86c <putc>
        putc(fd, c);
 ad8:	85ca                	mv	a1,s2
 ada:	8556                	mv	a0,s5
 adc:	00000097          	auipc	ra,0x0
 ae0:	d90080e7          	jalr	-624(ra) # 86c <putc>
      state = 0;
 ae4:	4981                	li	s3,0
 ae6:	bd61                	j	97e <vprintf+0x44>
        s = va_arg(ap, char*);
 ae8:	8bce                	mv	s7,s3
      state = 0;
 aea:	4981                	li	s3,0
 aec:	bd49                	j	97e <vprintf+0x44>
    }
  }
}
 aee:	60a6                	ld	ra,72(sp)
 af0:	6406                	ld	s0,64(sp)
 af2:	74e2                	ld	s1,56(sp)
 af4:	7942                	ld	s2,48(sp)
 af6:	79a2                	ld	s3,40(sp)
 af8:	7a02                	ld	s4,32(sp)
 afa:	6ae2                	ld	s5,24(sp)
 afc:	6b42                	ld	s6,16(sp)
 afe:	6ba2                	ld	s7,8(sp)
 b00:	6c02                	ld	s8,0(sp)
 b02:	6161                	addi	sp,sp,80
 b04:	8082                	ret

0000000000000b06 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b06:	715d                	addi	sp,sp,-80
 b08:	ec06                	sd	ra,24(sp)
 b0a:	e822                	sd	s0,16(sp)
 b0c:	1000                	addi	s0,sp,32
 b0e:	e010                	sd	a2,0(s0)
 b10:	e414                	sd	a3,8(s0)
 b12:	e818                	sd	a4,16(s0)
 b14:	ec1c                	sd	a5,24(s0)
 b16:	03043023          	sd	a6,32(s0)
 b1a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b1e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b22:	8622                	mv	a2,s0
 b24:	00000097          	auipc	ra,0x0
 b28:	e16080e7          	jalr	-490(ra) # 93a <vprintf>
}
 b2c:	60e2                	ld	ra,24(sp)
 b2e:	6442                	ld	s0,16(sp)
 b30:	6161                	addi	sp,sp,80
 b32:	8082                	ret

0000000000000b34 <printf>:

void
printf(const char *fmt, ...)
{
 b34:	711d                	addi	sp,sp,-96
 b36:	ec06                	sd	ra,24(sp)
 b38:	e822                	sd	s0,16(sp)
 b3a:	1000                	addi	s0,sp,32
 b3c:	e40c                	sd	a1,8(s0)
 b3e:	e810                	sd	a2,16(s0)
 b40:	ec14                	sd	a3,24(s0)
 b42:	f018                	sd	a4,32(s0)
 b44:	f41c                	sd	a5,40(s0)
 b46:	03043823          	sd	a6,48(s0)
 b4a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b4e:	00840613          	addi	a2,s0,8
 b52:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b56:	85aa                	mv	a1,a0
 b58:	4505                	li	a0,1
 b5a:	00000097          	auipc	ra,0x0
 b5e:	de0080e7          	jalr	-544(ra) # 93a <vprintf>
}
 b62:	60e2                	ld	ra,24(sp)
 b64:	6442                	ld	s0,16(sp)
 b66:	6125                	addi	sp,sp,96
 b68:	8082                	ret

0000000000000b6a <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 b6a:	1141                	addi	sp,sp,-16
 b6c:	e422                	sd	s0,8(sp)
 b6e:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 b70:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b74:	00000797          	auipc	a5,0x0
 b78:	4b47b783          	ld	a5,1204(a5) # 1028 <freep>
 b7c:	a02d                	j	ba6 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 b7e:	4618                	lw	a4,8(a2)
 b80:	9f2d                	addw	a4,a4,a1
 b82:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 b86:	6398                	ld	a4,0(a5)
 b88:	6310                	ld	a2,0(a4)
 b8a:	a83d                	j	bc8 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 b8c:	ff852703          	lw	a4,-8(a0)
 b90:	9f31                	addw	a4,a4,a2
 b92:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 b94:	ff053683          	ld	a3,-16(a0)
 b98:	a091                	j	bdc <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b9a:	6398                	ld	a4,0(a5)
 b9c:	00e7e463          	bltu	a5,a4,ba4 <free+0x3a>
 ba0:	00e6ea63          	bltu	a3,a4,bb4 <free+0x4a>
{
 ba4:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ba6:	fed7fae3          	bgeu	a5,a3,b9a <free+0x30>
 baa:	6398                	ld	a4,0(a5)
 bac:	00e6e463          	bltu	a3,a4,bb4 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bb0:	fee7eae3          	bltu	a5,a4,ba4 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 bb4:	ff852583          	lw	a1,-8(a0)
 bb8:	6390                	ld	a2,0(a5)
 bba:	02059813          	slli	a6,a1,0x20
 bbe:	01c85713          	srli	a4,a6,0x1c
 bc2:	9736                	add	a4,a4,a3
 bc4:	fae60de3          	beq	a2,a4,b7e <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 bc8:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 bcc:	4790                	lw	a2,8(a5)
 bce:	02061593          	slli	a1,a2,0x20
 bd2:	01c5d713          	srli	a4,a1,0x1c
 bd6:	973e                	add	a4,a4,a5
 bd8:	fae68ae3          	beq	a3,a4,b8c <free+0x22>
        p->s.ptr = bp->s.ptr;
 bdc:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 bde:	00000717          	auipc	a4,0x0
 be2:	44f73523          	sd	a5,1098(a4) # 1028 <freep>
}
 be6:	6422                	ld	s0,8(sp)
 be8:	0141                	addi	sp,sp,16
 bea:	8082                	ret

0000000000000bec <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 bec:	7139                	addi	sp,sp,-64
 bee:	fc06                	sd	ra,56(sp)
 bf0:	f822                	sd	s0,48(sp)
 bf2:	f426                	sd	s1,40(sp)
 bf4:	f04a                	sd	s2,32(sp)
 bf6:	ec4e                	sd	s3,24(sp)
 bf8:	e852                	sd	s4,16(sp)
 bfa:	e456                	sd	s5,8(sp)
 bfc:	e05a                	sd	s6,0(sp)
 bfe:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 c00:	02051493          	slli	s1,a0,0x20
 c04:	9081                	srli	s1,s1,0x20
 c06:	04bd                	addi	s1,s1,15
 c08:	8091                	srli	s1,s1,0x4
 c0a:	0014899b          	addiw	s3,s1,1
 c0e:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 c10:	00000517          	auipc	a0,0x0
 c14:	41853503          	ld	a0,1048(a0) # 1028 <freep>
 c18:	c515                	beqz	a0,c44 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c1a:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 c1c:	4798                	lw	a4,8(a5)
 c1e:	02977f63          	bgeu	a4,s1,c5c <malloc+0x70>
    if (nu < 4096)
 c22:	8a4e                	mv	s4,s3
 c24:	0009871b          	sext.w	a4,s3
 c28:	6685                	lui	a3,0x1
 c2a:	00d77363          	bgeu	a4,a3,c30 <malloc+0x44>
 c2e:	6a05                	lui	s4,0x1
 c30:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 c34:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 c38:	00000917          	auipc	s2,0x0
 c3c:	3f090913          	addi	s2,s2,1008 # 1028 <freep>
    if (p == (char *)-1)
 c40:	5afd                	li	s5,-1
 c42:	a895                	j	cb6 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 c44:	00000797          	auipc	a5,0x0
 c48:	46c78793          	addi	a5,a5,1132 # 10b0 <base>
 c4c:	00000717          	auipc	a4,0x0
 c50:	3cf73e23          	sd	a5,988(a4) # 1028 <freep>
 c54:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 c56:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 c5a:	b7e1                	j	c22 <malloc+0x36>
            if (p->s.size == nunits)
 c5c:	02e48c63          	beq	s1,a4,c94 <malloc+0xa8>
                p->s.size -= nunits;
 c60:	4137073b          	subw	a4,a4,s3
 c64:	c798                	sw	a4,8(a5)
                p += p->s.size;
 c66:	02071693          	slli	a3,a4,0x20
 c6a:	01c6d713          	srli	a4,a3,0x1c
 c6e:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 c70:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 c74:	00000717          	auipc	a4,0x0
 c78:	3aa73a23          	sd	a0,948(a4) # 1028 <freep>
            return (void *)(p + 1);
 c7c:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 c80:	70e2                	ld	ra,56(sp)
 c82:	7442                	ld	s0,48(sp)
 c84:	74a2                	ld	s1,40(sp)
 c86:	7902                	ld	s2,32(sp)
 c88:	69e2                	ld	s3,24(sp)
 c8a:	6a42                	ld	s4,16(sp)
 c8c:	6aa2                	ld	s5,8(sp)
 c8e:	6b02                	ld	s6,0(sp)
 c90:	6121                	addi	sp,sp,64
 c92:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 c94:	6398                	ld	a4,0(a5)
 c96:	e118                	sd	a4,0(a0)
 c98:	bff1                	j	c74 <malloc+0x88>
    hp->s.size = nu;
 c9a:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c9e:	0541                	addi	a0,a0,16
 ca0:	00000097          	auipc	ra,0x0
 ca4:	eca080e7          	jalr	-310(ra) # b6a <free>
    return freep;
 ca8:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 cac:	d971                	beqz	a0,c80 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 cae:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 cb0:	4798                	lw	a4,8(a5)
 cb2:	fa9775e3          	bgeu	a4,s1,c5c <malloc+0x70>
        if (p == freep)
 cb6:	00093703          	ld	a4,0(s2)
 cba:	853e                	mv	a0,a5
 cbc:	fef719e3          	bne	a4,a5,cae <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 cc0:	8552                	mv	a0,s4
 cc2:	00000097          	auipc	ra,0x0
 cc6:	b7a080e7          	jalr	-1158(ra) # 83c <sbrk>
    if (p == (char *)-1)
 cca:	fd5518e3          	bne	a0,s5,c9a <malloc+0xae>
                return 0;
 cce:	4501                	li	a0,0
 cd0:	bf45                	j	c80 <malloc+0x94>
