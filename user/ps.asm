
user/_ps:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

int main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
    struct user_proc *procs = ps(0, 64);
   e:	04000593          	li	a1,64
  12:	4501                	li	a0,0
  14:	00000097          	auipc	ra,0x0
  18:	7a2080e7          	jalr	1954(ra) # 7b6 <ps>

    for (int i = 0; i < 64; i++)
  1c:	01450493          	addi	s1,a0,20
  20:	6785                	lui	a5,0x1
  22:	91478793          	addi	a5,a5,-1772 # 914 <vprintf+0x78>
  26:	00f50933          	add	s2,a0,a5
    {
        if (procs[i].state == UNUSED)
            break;
        printf("%s (%d): %d\n", procs[i].name, procs[i].pid, procs[i].state);
  2a:	00001997          	auipc	s3,0x1
  2e:	c1698993          	addi	s3,s3,-1002 # c40 <malloc+0xf2>
        if (procs[i].state == UNUSED)
  32:	fec4a683          	lw	a3,-20(s1)
  36:	ce89                	beqz	a3,50 <main+0x50>
        printf("%s (%d): %d\n", procs[i].name, procs[i].pid, procs[i].state);
  38:	ff84a603          	lw	a2,-8(s1)
  3c:	85a6                	mv	a1,s1
  3e:	854e                	mv	a0,s3
  40:	00001097          	auipc	ra,0x1
  44:	a56080e7          	jalr	-1450(ra) # a96 <printf>
    for (int i = 0; i < 64; i++)
  48:	02448493          	addi	s1,s1,36
  4c:	ff2493e3          	bne	s1,s2,32 <main+0x32>
    }
    exit(0);
  50:	4501                	li	a0,0
  52:	00000097          	auipc	ra,0x0
  56:	6c4080e7          	jalr	1732(ra) # 716 <exit>

000000000000005a <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  5a:	1141                	addi	sp,sp,-16
  5c:	e422                	sd	s0,8(sp)
  5e:	0800                	addi	s0,sp,16
    lk->name = name;
  60:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  62:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  66:	57fd                	li	a5,-1
  68:	00f50823          	sb	a5,16(a0)
}
  6c:	6422                	ld	s0,8(sp)
  6e:	0141                	addi	sp,sp,16
  70:	8082                	ret

0000000000000072 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  72:	00054783          	lbu	a5,0(a0)
  76:	e399                	bnez	a5,7c <holding+0xa>
  78:	4501                	li	a0,0
}
  7a:	8082                	ret
{
  7c:	1101                	addi	sp,sp,-32
  7e:	ec06                	sd	ra,24(sp)
  80:	e822                	sd	s0,16(sp)
  82:	e426                	sd	s1,8(sp)
  84:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  86:	01054483          	lbu	s1,16(a0)
  8a:	00000097          	auipc	ra,0x0
  8e:	2dc080e7          	jalr	732(ra) # 366 <twhoami>
  92:	2501                	sext.w	a0,a0
  94:	40a48533          	sub	a0,s1,a0
  98:	00153513          	seqz	a0,a0
}
  9c:	60e2                	ld	ra,24(sp)
  9e:	6442                	ld	s0,16(sp)
  a0:	64a2                	ld	s1,8(sp)
  a2:	6105                	addi	sp,sp,32
  a4:	8082                	ret

00000000000000a6 <acquire>:

void acquire(struct lock *lk)
{
  a6:	7179                	addi	sp,sp,-48
  a8:	f406                	sd	ra,40(sp)
  aa:	f022                	sd	s0,32(sp)
  ac:	ec26                	sd	s1,24(sp)
  ae:	e84a                	sd	s2,16(sp)
  b0:	e44e                	sd	s3,8(sp)
  b2:	e052                	sd	s4,0(sp)
  b4:	1800                	addi	s0,sp,48
  b6:	8a2a                	mv	s4,a0
    if (holding(lk))
  b8:	00000097          	auipc	ra,0x0
  bc:	fba080e7          	jalr	-70(ra) # 72 <holding>
  c0:	e919                	bnez	a0,d6 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  c2:	ffca7493          	andi	s1,s4,-4
  c6:	003a7913          	andi	s2,s4,3
  ca:	0039191b          	slliw	s2,s2,0x3
  ce:	4985                	li	s3,1
  d0:	012999bb          	sllw	s3,s3,s2
  d4:	a015                	j	f8 <acquire+0x52>
        printf("re-acquiring lock we already hold");
  d6:	00001517          	auipc	a0,0x1
  da:	b7a50513          	addi	a0,a0,-1158 # c50 <malloc+0x102>
  de:	00001097          	auipc	ra,0x1
  e2:	9b8080e7          	jalr	-1608(ra) # a96 <printf>
        exit(-1);
  e6:	557d                	li	a0,-1
  e8:	00000097          	auipc	ra,0x0
  ec:	62e080e7          	jalr	1582(ra) # 716 <exit>
    {
        // give up the cpu for other threads
        tyield();
  f0:	00000097          	auipc	ra,0x0
  f4:	252080e7          	jalr	594(ra) # 342 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  f8:	4534a7af          	amoor.w.aq	a5,s3,(s1)
  fc:	0127d7bb          	srlw	a5,a5,s2
 100:	0ff7f793          	zext.b	a5,a5
 104:	f7f5                	bnez	a5,f0 <acquire+0x4a>
    }

    __sync_synchronize();
 106:	0ff0000f          	fence

    lk->tid = twhoami();
 10a:	00000097          	auipc	ra,0x0
 10e:	25c080e7          	jalr	604(ra) # 366 <twhoami>
 112:	00aa0823          	sb	a0,16(s4)
}
 116:	70a2                	ld	ra,40(sp)
 118:	7402                	ld	s0,32(sp)
 11a:	64e2                	ld	s1,24(sp)
 11c:	6942                	ld	s2,16(sp)
 11e:	69a2                	ld	s3,8(sp)
 120:	6a02                	ld	s4,0(sp)
 122:	6145                	addi	sp,sp,48
 124:	8082                	ret

0000000000000126 <release>:

void release(struct lock *lk)
{
 126:	1101                	addi	sp,sp,-32
 128:	ec06                	sd	ra,24(sp)
 12a:	e822                	sd	s0,16(sp)
 12c:	e426                	sd	s1,8(sp)
 12e:	1000                	addi	s0,sp,32
 130:	84aa                	mv	s1,a0
    if (!holding(lk))
 132:	00000097          	auipc	ra,0x0
 136:	f40080e7          	jalr	-192(ra) # 72 <holding>
 13a:	c11d                	beqz	a0,160 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 13c:	57fd                	li	a5,-1
 13e:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 142:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 146:	0ff0000f          	fence
 14a:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 14e:	00000097          	auipc	ra,0x0
 152:	1f4080e7          	jalr	500(ra) # 342 <tyield>
}
 156:	60e2                	ld	ra,24(sp)
 158:	6442                	ld	s0,16(sp)
 15a:	64a2                	ld	s1,8(sp)
 15c:	6105                	addi	sp,sp,32
 15e:	8082                	ret
        printf("releasing lock we are not holding");
 160:	00001517          	auipc	a0,0x1
 164:	b1850513          	addi	a0,a0,-1256 # c78 <malloc+0x12a>
 168:	00001097          	auipc	ra,0x1
 16c:	92e080e7          	jalr	-1746(ra) # a96 <printf>
        exit(-1);
 170:	557d                	li	a0,-1
 172:	00000097          	auipc	ra,0x0
 176:	5a4080e7          	jalr	1444(ra) # 716 <exit>

000000000000017a <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 17a:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 17c:	00001617          	auipc	a2,0x1
 180:	ea460613          	addi	a2,a2,-348 # 1020 <threads>
 184:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 186:	45c1                	li	a1,16
 188:	a021                	j	190 <tsched+0x16>
 18a:	2685                	addiw	a3,a3,1
 18c:	08b68c63          	beq	a3,a1,224 <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 190:	41f6d71b          	sraiw	a4,a3,0x1f
 194:	01c7571b          	srliw	a4,a4,0x1c
 198:	00d707bb          	addw	a5,a4,a3
 19c:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 19e:	9f99                	subw	a5,a5,a4
 1a0:	078e                	slli	a5,a5,0x3
 1a2:	97b2                	add	a5,a5,a2
 1a4:	639c                	ld	a5,0(a5)
 1a6:	d3f5                	beqz	a5,18a <tsched+0x10>
 1a8:	5fb8                	lw	a4,120(a5)
 1aa:	fea710e3          	bne	a4,a0,18a <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 1ae:	00001717          	auipc	a4,0x1
 1b2:	e7273703          	ld	a4,-398(a4) # 1020 <threads>
 1b6:	5f30                	lw	a2,120(a4)
 1b8:	468d                	li	a3,3
 1ba:	06d60363          	beq	a2,a3,220 <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 1be:	c3a5                	beqz	a5,21e <tsched+0xa4>
{
 1c0:	1101                	addi	sp,sp,-32
 1c2:	ec06                	sd	ra,24(sp)
 1c4:	e822                	sd	s0,16(sp)
 1c6:	e426                	sd	s1,8(sp)
 1c8:	e04a                	sd	s2,0(sp)
 1ca:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 1cc:	00001497          	auipc	s1,0x1
 1d0:	e4448493          	addi	s1,s1,-444 # 1010 <current_thread>
 1d4:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 1d8:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 1da:	0007c603          	lbu	a2,0(a5)
 1de:	00094583          	lbu	a1,0(s2)
 1e2:	00001517          	auipc	a0,0x1
 1e6:	abe50513          	addi	a0,a0,-1346 # ca0 <malloc+0x152>
 1ea:	00001097          	auipc	ra,0x1
 1ee:	8ac080e7          	jalr	-1876(ra) # a96 <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 1f2:	608c                	ld	a1,0(s1)
 1f4:	05a1                	addi	a1,a1,8
 1f6:	00890513          	addi	a0,s2,8
 1fa:	00000097          	auipc	ra,0x0
 1fe:	184080e7          	jalr	388(ra) # 37e <tswtch>
        printf("Thread switch complete\n");
 202:	00001517          	auipc	a0,0x1
 206:	ac650513          	addi	a0,a0,-1338 # cc8 <malloc+0x17a>
 20a:	00001097          	auipc	ra,0x1
 20e:	88c080e7          	jalr	-1908(ra) # a96 <printf>
    }
}
 212:	60e2                	ld	ra,24(sp)
 214:	6442                	ld	s0,16(sp)
 216:	64a2                	ld	s1,8(sp)
 218:	6902                	ld	s2,0(sp)
 21a:	6105                	addi	sp,sp,32
 21c:	8082                	ret
 21e:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 220:	87ba                	mv	a5,a4
 222:	bf79                	j	1c0 <tsched+0x46>
 224:	00001797          	auipc	a5,0x1
 228:	dfc7b783          	ld	a5,-516(a5) # 1020 <threads>
 22c:	5fb4                	lw	a3,120(a5)
 22e:	470d                	li	a4,3
 230:	f8e688e3          	beq	a3,a4,1c0 <tsched+0x46>
 234:	8082                	ret

0000000000000236 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 236:	7179                	addi	sp,sp,-48
 238:	f406                	sd	ra,40(sp)
 23a:	f022                	sd	s0,32(sp)
 23c:	ec26                	sd	s1,24(sp)
 23e:	e84a                	sd	s2,16(sp)
 240:	e44e                	sd	s3,8(sp)
 242:	1800                	addi	s0,sp,48
 244:	84aa                	mv	s1,a0
 246:	89b2                	mv	s3,a2
 248:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 24a:	09000513          	li	a0,144
 24e:	00001097          	auipc	ra,0x1
 252:	900080e7          	jalr	-1792(ra) # b4e <malloc>
 256:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 258:	478d                	li	a5,3
 25a:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 25c:	609c                	ld	a5,0(s1)
 25e:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 262:	609c                	ld	a5,0(s1)
 264:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 268:	00001717          	auipc	a4,0x1
 26c:	d9870713          	addi	a4,a4,-616 # 1000 <next_tid>
 270:	431c                	lw	a5,0(a4)
 272:	0017869b          	addiw	a3,a5,1
 276:	c314                	sw	a3,0(a4)
 278:	6098                	ld	a4,0(s1)
 27a:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 27e:	00001717          	auipc	a4,0x1
 282:	da270713          	addi	a4,a4,-606 # 1020 <threads>
 286:	4781                	li	a5,0
 288:	4641                	li	a2,16
    if (threads[i] == NULL) {
 28a:	6314                	ld	a3,0(a4)
 28c:	ce81                	beqz	a3,2a4 <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 28e:	2785                	addiw	a5,a5,1
 290:	0721                	addi	a4,a4,8
 292:	fec79ce3          	bne	a5,a2,28a <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 296:	70a2                	ld	ra,40(sp)
 298:	7402                	ld	s0,32(sp)
 29a:	64e2                	ld	s1,24(sp)
 29c:	6942                	ld	s2,16(sp)
 29e:	69a2                	ld	s3,8(sp)
 2a0:	6145                	addi	sp,sp,48
 2a2:	8082                	ret
        threads[i] = *thread;
 2a4:	6094                	ld	a3,0(s1)
 2a6:	078e                	slli	a5,a5,0x3
 2a8:	00001717          	auipc	a4,0x1
 2ac:	d7870713          	addi	a4,a4,-648 # 1020 <threads>
 2b0:	97ba                	add	a5,a5,a4
 2b2:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 2b4:	0006c583          	lbu	a1,0(a3)
 2b8:	00001517          	auipc	a0,0x1
 2bc:	a2850513          	addi	a0,a0,-1496 # ce0 <malloc+0x192>
 2c0:	00000097          	auipc	ra,0x0
 2c4:	7d6080e7          	jalr	2006(ra) # a96 <printf>
        break;
 2c8:	b7f9                	j	296 <tcreate+0x60>

00000000000002ca <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 2ca:	7179                	addi	sp,sp,-48
 2cc:	f406                	sd	ra,40(sp)
 2ce:	f022                	sd	s0,32(sp)
 2d0:	ec26                	sd	s1,24(sp)
 2d2:	e84a                	sd	s2,16(sp)
 2d4:	e44e                	sd	s3,8(sp)
 2d6:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 2d8:	00001797          	auipc	a5,0x1
 2dc:	d4878793          	addi	a5,a5,-696 # 1020 <threads>
 2e0:	00001697          	auipc	a3,0x1
 2e4:	dc068693          	addi	a3,a3,-576 # 10a0 <base>
 2e8:	a021                	j	2f0 <tjoin+0x26>
 2ea:	07a1                	addi	a5,a5,8
 2ec:	04d78763          	beq	a5,a3,33a <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 2f0:	6384                	ld	s1,0(a5)
 2f2:	dce5                	beqz	s1,2ea <tjoin+0x20>
 2f4:	0004c703          	lbu	a4,0(s1)
 2f8:	fea719e3          	bne	a4,a0,2ea <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 2fc:	5cb8                	lw	a4,120(s1)
 2fe:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 300:	00001997          	auipc	s3,0x1
 304:	a1098993          	addi	s3,s3,-1520 # d10 <malloc+0x1c2>
    while (target_thread->state != EXITED) {
 308:	4919                	li	s2,6
 30a:	02f70a63          	beq	a4,a5,33e <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 30e:	0004c583          	lbu	a1,0(s1)
 312:	854e                	mv	a0,s3
 314:	00000097          	auipc	ra,0x0
 318:	782080e7          	jalr	1922(ra) # a96 <printf>
        tsched();
 31c:	00000097          	auipc	ra,0x0
 320:	e5e080e7          	jalr	-418(ra) # 17a <tsched>
    while (target_thread->state != EXITED) {
 324:	5cbc                	lw	a5,120(s1)
 326:	ff2794e3          	bne	a5,s2,30e <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 32a:	4501                	li	a0,0
}
 32c:	70a2                	ld	ra,40(sp)
 32e:	7402                	ld	s0,32(sp)
 330:	64e2                	ld	s1,24(sp)
 332:	6942                	ld	s2,16(sp)
 334:	69a2                	ld	s3,8(sp)
 336:	6145                	addi	sp,sp,48
 338:	8082                	ret
        return -1;
 33a:	557d                	li	a0,-1
 33c:	bfc5                	j	32c <tjoin+0x62>
    return 0;
 33e:	4501                	li	a0,0
 340:	b7f5                	j	32c <tjoin+0x62>

0000000000000342 <tyield>:


void tyield()
{
 342:	1141                	addi	sp,sp,-16
 344:	e406                	sd	ra,8(sp)
 346:	e022                	sd	s0,0(sp)
 348:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 34a:	00001797          	auipc	a5,0x1
 34e:	cc67b783          	ld	a5,-826(a5) # 1010 <current_thread>
 352:	470d                	li	a4,3
 354:	dfb8                	sw	a4,120(a5)
    tsched();
 356:	00000097          	auipc	ra,0x0
 35a:	e24080e7          	jalr	-476(ra) # 17a <tsched>
}
 35e:	60a2                	ld	ra,8(sp)
 360:	6402                	ld	s0,0(sp)
 362:	0141                	addi	sp,sp,16
 364:	8082                	ret

0000000000000366 <twhoami>:

uint8 twhoami()
{
 366:	1141                	addi	sp,sp,-16
 368:	e422                	sd	s0,8(sp)
 36a:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
 36c:	00001797          	auipc	a5,0x1
 370:	ca47b783          	ld	a5,-860(a5) # 1010 <current_thread>
 374:	0007c503          	lbu	a0,0(a5)
 378:	6422                	ld	s0,8(sp)
 37a:	0141                	addi	sp,sp,16
 37c:	8082                	ret

000000000000037e <tswtch>:
 37e:	00153023          	sd	ra,0(a0)
 382:	00253423          	sd	sp,8(a0)
 386:	e900                	sd	s0,16(a0)
 388:	ed04                	sd	s1,24(a0)
 38a:	03253023          	sd	s2,32(a0)
 38e:	03353423          	sd	s3,40(a0)
 392:	03453823          	sd	s4,48(a0)
 396:	03553c23          	sd	s5,56(a0)
 39a:	05653023          	sd	s6,64(a0)
 39e:	05753423          	sd	s7,72(a0)
 3a2:	05853823          	sd	s8,80(a0)
 3a6:	05953c23          	sd	s9,88(a0)
 3aa:	07a53023          	sd	s10,96(a0)
 3ae:	07b53423          	sd	s11,104(a0)
 3b2:	0005b083          	ld	ra,0(a1)
 3b6:	0085b103          	ld	sp,8(a1)
 3ba:	6980                	ld	s0,16(a1)
 3bc:	6d84                	ld	s1,24(a1)
 3be:	0205b903          	ld	s2,32(a1)
 3c2:	0285b983          	ld	s3,40(a1)
 3c6:	0305ba03          	ld	s4,48(a1)
 3ca:	0385ba83          	ld	s5,56(a1)
 3ce:	0405bb03          	ld	s6,64(a1)
 3d2:	0485bb83          	ld	s7,72(a1)
 3d6:	0505bc03          	ld	s8,80(a1)
 3da:	0585bc83          	ld	s9,88(a1)
 3de:	0605bd03          	ld	s10,96(a1)
 3e2:	0685bd83          	ld	s11,104(a1)
 3e6:	8082                	ret

00000000000003e8 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 3e8:	715d                	addi	sp,sp,-80
 3ea:	e486                	sd	ra,72(sp)
 3ec:	e0a2                	sd	s0,64(sp)
 3ee:	fc26                	sd	s1,56(sp)
 3f0:	f84a                	sd	s2,48(sp)
 3f2:	f44e                	sd	s3,40(sp)
 3f4:	f052                	sd	s4,32(sp)
 3f6:	ec56                	sd	s5,24(sp)
 3f8:	e85a                	sd	s6,16(sp)
 3fa:	e45e                	sd	s7,8(sp)
 3fc:	0880                	addi	s0,sp,80
 3fe:	892a                	mv	s2,a0
 400:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 402:	00001517          	auipc	a0,0x1
 406:	92e50513          	addi	a0,a0,-1746 # d30 <malloc+0x1e2>
 40a:	00000097          	auipc	ra,0x0
 40e:	68c080e7          	jalr	1676(ra) # a96 <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 412:	09000513          	li	a0,144
 416:	00000097          	auipc	ra,0x0
 41a:	738080e7          	jalr	1848(ra) # b4e <malloc>

    main_thread->tid = 0;
 41e:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 422:	4791                	li	a5,4
 424:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 426:	00001797          	auipc	a5,0x1
 42a:	bea7b523          	sd	a0,-1046(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 42e:	00001a17          	auipc	s4,0x1
 432:	bf2a0a13          	addi	s4,s4,-1038 # 1020 <threads>
 436:	00001497          	auipc	s1,0x1
 43a:	c6a48493          	addi	s1,s1,-918 # 10a0 <base>
    current_thread = main_thread;
 43e:	87d2                	mv	a5,s4
        threads[i] = NULL;
 440:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 444:	07a1                	addi	a5,a5,8
 446:	fe979de3          	bne	a5,s1,440 <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 44a:	00001797          	auipc	a5,0x1
 44e:	bca7bb23          	sd	a0,-1066(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 452:	85ce                	mv	a1,s3
 454:	854a                	mv	a0,s2
 456:	00000097          	auipc	ra,0x0
 45a:	baa080e7          	jalr	-1110(ra) # 0 <main>
 45e:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 460:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 462:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 464:	00001a97          	auipc	s5,0x1
 468:	8eca8a93          	addi	s5,s5,-1812 # d50 <malloc+0x202>
 46c:	a03d                	j	49a <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 46e:	07a1                	addi	a5,a5,8
 470:	00978963          	beq	a5,s1,482 <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 474:	6398                	ld	a4,0(a5)
 476:	df65                	beqz	a4,46e <_main+0x86>
 478:	5f38                	lw	a4,120(a4)
 47a:	ff370ae3          	beq	a4,s3,46e <_main+0x86>
                running_threads++;
 47e:	2905                	addiw	s2,s2,1
 480:	b7fd                	j	46e <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 482:	85ca                	mv	a1,s2
 484:	8556                	mv	a0,s5
 486:	00000097          	auipc	ra,0x0
 48a:	610080e7          	jalr	1552(ra) # a96 <printf>
        if (running_threads > 0) {
 48e:	01205963          	blez	s2,4a0 <_main+0xb8>
            tsched(); // Schedule another thread to run
 492:	00000097          	auipc	ra,0x0
 496:	ce8080e7          	jalr	-792(ra) # 17a <tsched>
    current_thread = main_thread;
 49a:	87d2                	mv	a5,s4
        running_threads = 0;
 49c:	895a                	mv	s2,s6
 49e:	bfd9                	j	474 <_main+0x8c>
        }
    }

    exit(res);
 4a0:	855e                	mv	a0,s7
 4a2:	00000097          	auipc	ra,0x0
 4a6:	274080e7          	jalr	628(ra) # 716 <exit>

00000000000004aa <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 4aa:	1141                	addi	sp,sp,-16
 4ac:	e422                	sd	s0,8(sp)
 4ae:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 4b0:	87aa                	mv	a5,a0
 4b2:	0585                	addi	a1,a1,1
 4b4:	0785                	addi	a5,a5,1
 4b6:	fff5c703          	lbu	a4,-1(a1)
 4ba:	fee78fa3          	sb	a4,-1(a5)
 4be:	fb75                	bnez	a4,4b2 <strcpy+0x8>
        ;
    return os;
}
 4c0:	6422                	ld	s0,8(sp)
 4c2:	0141                	addi	sp,sp,16
 4c4:	8082                	ret

00000000000004c6 <strcmp>:

int strcmp(const char *p, const char *q)
{
 4c6:	1141                	addi	sp,sp,-16
 4c8:	e422                	sd	s0,8(sp)
 4ca:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 4cc:	00054783          	lbu	a5,0(a0)
 4d0:	cb91                	beqz	a5,4e4 <strcmp+0x1e>
 4d2:	0005c703          	lbu	a4,0(a1)
 4d6:	00f71763          	bne	a4,a5,4e4 <strcmp+0x1e>
        p++, q++;
 4da:	0505                	addi	a0,a0,1
 4dc:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 4de:	00054783          	lbu	a5,0(a0)
 4e2:	fbe5                	bnez	a5,4d2 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 4e4:	0005c503          	lbu	a0,0(a1)
}
 4e8:	40a7853b          	subw	a0,a5,a0
 4ec:	6422                	ld	s0,8(sp)
 4ee:	0141                	addi	sp,sp,16
 4f0:	8082                	ret

00000000000004f2 <strlen>:

uint strlen(const char *s)
{
 4f2:	1141                	addi	sp,sp,-16
 4f4:	e422                	sd	s0,8(sp)
 4f6:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 4f8:	00054783          	lbu	a5,0(a0)
 4fc:	cf91                	beqz	a5,518 <strlen+0x26>
 4fe:	0505                	addi	a0,a0,1
 500:	87aa                	mv	a5,a0
 502:	86be                	mv	a3,a5
 504:	0785                	addi	a5,a5,1
 506:	fff7c703          	lbu	a4,-1(a5)
 50a:	ff65                	bnez	a4,502 <strlen+0x10>
 50c:	40a6853b          	subw	a0,a3,a0
 510:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 512:	6422                	ld	s0,8(sp)
 514:	0141                	addi	sp,sp,16
 516:	8082                	ret
    for (n = 0; s[n]; n++)
 518:	4501                	li	a0,0
 51a:	bfe5                	j	512 <strlen+0x20>

000000000000051c <memset>:

void *
memset(void *dst, int c, uint n)
{
 51c:	1141                	addi	sp,sp,-16
 51e:	e422                	sd	s0,8(sp)
 520:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 522:	ca19                	beqz	a2,538 <memset+0x1c>
 524:	87aa                	mv	a5,a0
 526:	1602                	slli	a2,a2,0x20
 528:	9201                	srli	a2,a2,0x20
 52a:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 52e:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 532:	0785                	addi	a5,a5,1
 534:	fee79de3          	bne	a5,a4,52e <memset+0x12>
    }
    return dst;
}
 538:	6422                	ld	s0,8(sp)
 53a:	0141                	addi	sp,sp,16
 53c:	8082                	ret

000000000000053e <strchr>:

char *
strchr(const char *s, char c)
{
 53e:	1141                	addi	sp,sp,-16
 540:	e422                	sd	s0,8(sp)
 542:	0800                	addi	s0,sp,16
    for (; *s; s++)
 544:	00054783          	lbu	a5,0(a0)
 548:	cb99                	beqz	a5,55e <strchr+0x20>
        if (*s == c)
 54a:	00f58763          	beq	a1,a5,558 <strchr+0x1a>
    for (; *s; s++)
 54e:	0505                	addi	a0,a0,1
 550:	00054783          	lbu	a5,0(a0)
 554:	fbfd                	bnez	a5,54a <strchr+0xc>
            return (char *)s;
    return 0;
 556:	4501                	li	a0,0
}
 558:	6422                	ld	s0,8(sp)
 55a:	0141                	addi	sp,sp,16
 55c:	8082                	ret
    return 0;
 55e:	4501                	li	a0,0
 560:	bfe5                	j	558 <strchr+0x1a>

0000000000000562 <gets>:

char *
gets(char *buf, int max)
{
 562:	711d                	addi	sp,sp,-96
 564:	ec86                	sd	ra,88(sp)
 566:	e8a2                	sd	s0,80(sp)
 568:	e4a6                	sd	s1,72(sp)
 56a:	e0ca                	sd	s2,64(sp)
 56c:	fc4e                	sd	s3,56(sp)
 56e:	f852                	sd	s4,48(sp)
 570:	f456                	sd	s5,40(sp)
 572:	f05a                	sd	s6,32(sp)
 574:	ec5e                	sd	s7,24(sp)
 576:	1080                	addi	s0,sp,96
 578:	8baa                	mv	s7,a0
 57a:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 57c:	892a                	mv	s2,a0
 57e:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 580:	4aa9                	li	s5,10
 582:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 584:	89a6                	mv	s3,s1
 586:	2485                	addiw	s1,s1,1
 588:	0344d863          	bge	s1,s4,5b8 <gets+0x56>
        cc = read(0, &c, 1);
 58c:	4605                	li	a2,1
 58e:	faf40593          	addi	a1,s0,-81
 592:	4501                	li	a0,0
 594:	00000097          	auipc	ra,0x0
 598:	19a080e7          	jalr	410(ra) # 72e <read>
        if (cc < 1)
 59c:	00a05e63          	blez	a0,5b8 <gets+0x56>
        buf[i++] = c;
 5a0:	faf44783          	lbu	a5,-81(s0)
 5a4:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 5a8:	01578763          	beq	a5,s5,5b6 <gets+0x54>
 5ac:	0905                	addi	s2,s2,1
 5ae:	fd679be3          	bne	a5,s6,584 <gets+0x22>
    for (i = 0; i + 1 < max;)
 5b2:	89a6                	mv	s3,s1
 5b4:	a011                	j	5b8 <gets+0x56>
 5b6:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 5b8:	99de                	add	s3,s3,s7
 5ba:	00098023          	sb	zero,0(s3)
    return buf;
}
 5be:	855e                	mv	a0,s7
 5c0:	60e6                	ld	ra,88(sp)
 5c2:	6446                	ld	s0,80(sp)
 5c4:	64a6                	ld	s1,72(sp)
 5c6:	6906                	ld	s2,64(sp)
 5c8:	79e2                	ld	s3,56(sp)
 5ca:	7a42                	ld	s4,48(sp)
 5cc:	7aa2                	ld	s5,40(sp)
 5ce:	7b02                	ld	s6,32(sp)
 5d0:	6be2                	ld	s7,24(sp)
 5d2:	6125                	addi	sp,sp,96
 5d4:	8082                	ret

00000000000005d6 <stat>:

int stat(const char *n, struct stat *st)
{
 5d6:	1101                	addi	sp,sp,-32
 5d8:	ec06                	sd	ra,24(sp)
 5da:	e822                	sd	s0,16(sp)
 5dc:	e426                	sd	s1,8(sp)
 5de:	e04a                	sd	s2,0(sp)
 5e0:	1000                	addi	s0,sp,32
 5e2:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 5e4:	4581                	li	a1,0
 5e6:	00000097          	auipc	ra,0x0
 5ea:	170080e7          	jalr	368(ra) # 756 <open>
    if (fd < 0)
 5ee:	02054563          	bltz	a0,618 <stat+0x42>
 5f2:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 5f4:	85ca                	mv	a1,s2
 5f6:	00000097          	auipc	ra,0x0
 5fa:	178080e7          	jalr	376(ra) # 76e <fstat>
 5fe:	892a                	mv	s2,a0
    close(fd);
 600:	8526                	mv	a0,s1
 602:	00000097          	auipc	ra,0x0
 606:	13c080e7          	jalr	316(ra) # 73e <close>
    return r;
}
 60a:	854a                	mv	a0,s2
 60c:	60e2                	ld	ra,24(sp)
 60e:	6442                	ld	s0,16(sp)
 610:	64a2                	ld	s1,8(sp)
 612:	6902                	ld	s2,0(sp)
 614:	6105                	addi	sp,sp,32
 616:	8082                	ret
        return -1;
 618:	597d                	li	s2,-1
 61a:	bfc5                	j	60a <stat+0x34>

000000000000061c <atoi>:

int atoi(const char *s)
{
 61c:	1141                	addi	sp,sp,-16
 61e:	e422                	sd	s0,8(sp)
 620:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 622:	00054683          	lbu	a3,0(a0)
 626:	fd06879b          	addiw	a5,a3,-48
 62a:	0ff7f793          	zext.b	a5,a5
 62e:	4625                	li	a2,9
 630:	02f66863          	bltu	a2,a5,660 <atoi+0x44>
 634:	872a                	mv	a4,a0
    n = 0;
 636:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 638:	0705                	addi	a4,a4,1
 63a:	0025179b          	slliw	a5,a0,0x2
 63e:	9fa9                	addw	a5,a5,a0
 640:	0017979b          	slliw	a5,a5,0x1
 644:	9fb5                	addw	a5,a5,a3
 646:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 64a:	00074683          	lbu	a3,0(a4)
 64e:	fd06879b          	addiw	a5,a3,-48
 652:	0ff7f793          	zext.b	a5,a5
 656:	fef671e3          	bgeu	a2,a5,638 <atoi+0x1c>
    return n;
}
 65a:	6422                	ld	s0,8(sp)
 65c:	0141                	addi	sp,sp,16
 65e:	8082                	ret
    n = 0;
 660:	4501                	li	a0,0
 662:	bfe5                	j	65a <atoi+0x3e>

0000000000000664 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 664:	1141                	addi	sp,sp,-16
 666:	e422                	sd	s0,8(sp)
 668:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 66a:	02b57463          	bgeu	a0,a1,692 <memmove+0x2e>
    {
        while (n-- > 0)
 66e:	00c05f63          	blez	a2,68c <memmove+0x28>
 672:	1602                	slli	a2,a2,0x20
 674:	9201                	srli	a2,a2,0x20
 676:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 67a:	872a                	mv	a4,a0
            *dst++ = *src++;
 67c:	0585                	addi	a1,a1,1
 67e:	0705                	addi	a4,a4,1
 680:	fff5c683          	lbu	a3,-1(a1)
 684:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 688:	fee79ae3          	bne	a5,a4,67c <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 68c:	6422                	ld	s0,8(sp)
 68e:	0141                	addi	sp,sp,16
 690:	8082                	ret
        dst += n;
 692:	00c50733          	add	a4,a0,a2
        src += n;
 696:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 698:	fec05ae3          	blez	a2,68c <memmove+0x28>
 69c:	fff6079b          	addiw	a5,a2,-1
 6a0:	1782                	slli	a5,a5,0x20
 6a2:	9381                	srli	a5,a5,0x20
 6a4:	fff7c793          	not	a5,a5
 6a8:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 6aa:	15fd                	addi	a1,a1,-1
 6ac:	177d                	addi	a4,a4,-1
 6ae:	0005c683          	lbu	a3,0(a1)
 6b2:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 6b6:	fee79ae3          	bne	a5,a4,6aa <memmove+0x46>
 6ba:	bfc9                	j	68c <memmove+0x28>

00000000000006bc <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 6bc:	1141                	addi	sp,sp,-16
 6be:	e422                	sd	s0,8(sp)
 6c0:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 6c2:	ca05                	beqz	a2,6f2 <memcmp+0x36>
 6c4:	fff6069b          	addiw	a3,a2,-1
 6c8:	1682                	slli	a3,a3,0x20
 6ca:	9281                	srli	a3,a3,0x20
 6cc:	0685                	addi	a3,a3,1
 6ce:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 6d0:	00054783          	lbu	a5,0(a0)
 6d4:	0005c703          	lbu	a4,0(a1)
 6d8:	00e79863          	bne	a5,a4,6e8 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 6dc:	0505                	addi	a0,a0,1
        p2++;
 6de:	0585                	addi	a1,a1,1
    while (n-- > 0)
 6e0:	fed518e3          	bne	a0,a3,6d0 <memcmp+0x14>
    }
    return 0;
 6e4:	4501                	li	a0,0
 6e6:	a019                	j	6ec <memcmp+0x30>
            return *p1 - *p2;
 6e8:	40e7853b          	subw	a0,a5,a4
}
 6ec:	6422                	ld	s0,8(sp)
 6ee:	0141                	addi	sp,sp,16
 6f0:	8082                	ret
    return 0;
 6f2:	4501                	li	a0,0
 6f4:	bfe5                	j	6ec <memcmp+0x30>

00000000000006f6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6f6:	1141                	addi	sp,sp,-16
 6f8:	e406                	sd	ra,8(sp)
 6fa:	e022                	sd	s0,0(sp)
 6fc:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 6fe:	00000097          	auipc	ra,0x0
 702:	f66080e7          	jalr	-154(ra) # 664 <memmove>
}
 706:	60a2                	ld	ra,8(sp)
 708:	6402                	ld	s0,0(sp)
 70a:	0141                	addi	sp,sp,16
 70c:	8082                	ret

000000000000070e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 70e:	4885                	li	a7,1
 ecall
 710:	00000073          	ecall
 ret
 714:	8082                	ret

0000000000000716 <exit>:
.global exit
exit:
 li a7, SYS_exit
 716:	4889                	li	a7,2
 ecall
 718:	00000073          	ecall
 ret
 71c:	8082                	ret

000000000000071e <wait>:
.global wait
wait:
 li a7, SYS_wait
 71e:	488d                	li	a7,3
 ecall
 720:	00000073          	ecall
 ret
 724:	8082                	ret

0000000000000726 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 726:	4891                	li	a7,4
 ecall
 728:	00000073          	ecall
 ret
 72c:	8082                	ret

000000000000072e <read>:
.global read
read:
 li a7, SYS_read
 72e:	4895                	li	a7,5
 ecall
 730:	00000073          	ecall
 ret
 734:	8082                	ret

0000000000000736 <write>:
.global write
write:
 li a7, SYS_write
 736:	48c1                	li	a7,16
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <close>:
.global close
close:
 li a7, SYS_close
 73e:	48d5                	li	a7,21
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <kill>:
.global kill
kill:
 li a7, SYS_kill
 746:	4899                	li	a7,6
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <exec>:
.global exec
exec:
 li a7, SYS_exec
 74e:	489d                	li	a7,7
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <open>:
.global open
open:
 li a7, SYS_open
 756:	48bd                	li	a7,15
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 75e:	48c5                	li	a7,17
 ecall
 760:	00000073          	ecall
 ret
 764:	8082                	ret

0000000000000766 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 766:	48c9                	li	a7,18
 ecall
 768:	00000073          	ecall
 ret
 76c:	8082                	ret

000000000000076e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 76e:	48a1                	li	a7,8
 ecall
 770:	00000073          	ecall
 ret
 774:	8082                	ret

0000000000000776 <link>:
.global link
link:
 li a7, SYS_link
 776:	48cd                	li	a7,19
 ecall
 778:	00000073          	ecall
 ret
 77c:	8082                	ret

000000000000077e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 77e:	48d1                	li	a7,20
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 786:	48a5                	li	a7,9
 ecall
 788:	00000073          	ecall
 ret
 78c:	8082                	ret

000000000000078e <dup>:
.global dup
dup:
 li a7, SYS_dup
 78e:	48a9                	li	a7,10
 ecall
 790:	00000073          	ecall
 ret
 794:	8082                	ret

0000000000000796 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 796:	48ad                	li	a7,11
 ecall
 798:	00000073          	ecall
 ret
 79c:	8082                	ret

000000000000079e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 79e:	48b1                	li	a7,12
 ecall
 7a0:	00000073          	ecall
 ret
 7a4:	8082                	ret

00000000000007a6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7a6:	48b5                	li	a7,13
 ecall
 7a8:	00000073          	ecall
 ret
 7ac:	8082                	ret

00000000000007ae <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7ae:	48b9                	li	a7,14
 ecall
 7b0:	00000073          	ecall
 ret
 7b4:	8082                	ret

00000000000007b6 <ps>:
.global ps
ps:
 li a7, SYS_ps
 7b6:	48d9                	li	a7,22
 ecall
 7b8:	00000073          	ecall
 ret
 7bc:	8082                	ret

00000000000007be <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 7be:	48dd                	li	a7,23
 ecall
 7c0:	00000073          	ecall
 ret
 7c4:	8082                	ret

00000000000007c6 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 7c6:	48e1                	li	a7,24
 ecall
 7c8:	00000073          	ecall
 ret
 7cc:	8082                	ret

00000000000007ce <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7ce:	1101                	addi	sp,sp,-32
 7d0:	ec06                	sd	ra,24(sp)
 7d2:	e822                	sd	s0,16(sp)
 7d4:	1000                	addi	s0,sp,32
 7d6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7da:	4605                	li	a2,1
 7dc:	fef40593          	addi	a1,s0,-17
 7e0:	00000097          	auipc	ra,0x0
 7e4:	f56080e7          	jalr	-170(ra) # 736 <write>
}
 7e8:	60e2                	ld	ra,24(sp)
 7ea:	6442                	ld	s0,16(sp)
 7ec:	6105                	addi	sp,sp,32
 7ee:	8082                	ret

00000000000007f0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7f0:	7139                	addi	sp,sp,-64
 7f2:	fc06                	sd	ra,56(sp)
 7f4:	f822                	sd	s0,48(sp)
 7f6:	f426                	sd	s1,40(sp)
 7f8:	f04a                	sd	s2,32(sp)
 7fa:	ec4e                	sd	s3,24(sp)
 7fc:	0080                	addi	s0,sp,64
 7fe:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 800:	c299                	beqz	a3,806 <printint+0x16>
 802:	0805c963          	bltz	a1,894 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 806:	2581                	sext.w	a1,a1
  neg = 0;
 808:	4881                	li	a7,0
 80a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 80e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 810:	2601                	sext.w	a2,a2
 812:	00000517          	auipc	a0,0x0
 816:	5be50513          	addi	a0,a0,1470 # dd0 <digits>
 81a:	883a                	mv	a6,a4
 81c:	2705                	addiw	a4,a4,1
 81e:	02c5f7bb          	remuw	a5,a1,a2
 822:	1782                	slli	a5,a5,0x20
 824:	9381                	srli	a5,a5,0x20
 826:	97aa                	add	a5,a5,a0
 828:	0007c783          	lbu	a5,0(a5)
 82c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 830:	0005879b          	sext.w	a5,a1
 834:	02c5d5bb          	divuw	a1,a1,a2
 838:	0685                	addi	a3,a3,1
 83a:	fec7f0e3          	bgeu	a5,a2,81a <printint+0x2a>
  if(neg)
 83e:	00088c63          	beqz	a7,856 <printint+0x66>
    buf[i++] = '-';
 842:	fd070793          	addi	a5,a4,-48
 846:	00878733          	add	a4,a5,s0
 84a:	02d00793          	li	a5,45
 84e:	fef70823          	sb	a5,-16(a4)
 852:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 856:	02e05863          	blez	a4,886 <printint+0x96>
 85a:	fc040793          	addi	a5,s0,-64
 85e:	00e78933          	add	s2,a5,a4
 862:	fff78993          	addi	s3,a5,-1
 866:	99ba                	add	s3,s3,a4
 868:	377d                	addiw	a4,a4,-1
 86a:	1702                	slli	a4,a4,0x20
 86c:	9301                	srli	a4,a4,0x20
 86e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 872:	fff94583          	lbu	a1,-1(s2)
 876:	8526                	mv	a0,s1
 878:	00000097          	auipc	ra,0x0
 87c:	f56080e7          	jalr	-170(ra) # 7ce <putc>
  while(--i >= 0)
 880:	197d                	addi	s2,s2,-1
 882:	ff3918e3          	bne	s2,s3,872 <printint+0x82>
}
 886:	70e2                	ld	ra,56(sp)
 888:	7442                	ld	s0,48(sp)
 88a:	74a2                	ld	s1,40(sp)
 88c:	7902                	ld	s2,32(sp)
 88e:	69e2                	ld	s3,24(sp)
 890:	6121                	addi	sp,sp,64
 892:	8082                	ret
    x = -xx;
 894:	40b005bb          	negw	a1,a1
    neg = 1;
 898:	4885                	li	a7,1
    x = -xx;
 89a:	bf85                	j	80a <printint+0x1a>

000000000000089c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 89c:	715d                	addi	sp,sp,-80
 89e:	e486                	sd	ra,72(sp)
 8a0:	e0a2                	sd	s0,64(sp)
 8a2:	fc26                	sd	s1,56(sp)
 8a4:	f84a                	sd	s2,48(sp)
 8a6:	f44e                	sd	s3,40(sp)
 8a8:	f052                	sd	s4,32(sp)
 8aa:	ec56                	sd	s5,24(sp)
 8ac:	e85a                	sd	s6,16(sp)
 8ae:	e45e                	sd	s7,8(sp)
 8b0:	e062                	sd	s8,0(sp)
 8b2:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8b4:	0005c903          	lbu	s2,0(a1)
 8b8:	18090c63          	beqz	s2,a50 <vprintf+0x1b4>
 8bc:	8aaa                	mv	s5,a0
 8be:	8bb2                	mv	s7,a2
 8c0:	00158493          	addi	s1,a1,1
  state = 0;
 8c4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8c6:	02500a13          	li	s4,37
 8ca:	4b55                	li	s6,21
 8cc:	a839                	j	8ea <vprintf+0x4e>
        putc(fd, c);
 8ce:	85ca                	mv	a1,s2
 8d0:	8556                	mv	a0,s5
 8d2:	00000097          	auipc	ra,0x0
 8d6:	efc080e7          	jalr	-260(ra) # 7ce <putc>
 8da:	a019                	j	8e0 <vprintf+0x44>
    } else if(state == '%'){
 8dc:	01498d63          	beq	s3,s4,8f6 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 8e0:	0485                	addi	s1,s1,1
 8e2:	fff4c903          	lbu	s2,-1(s1)
 8e6:	16090563          	beqz	s2,a50 <vprintf+0x1b4>
    if(state == 0){
 8ea:	fe0999e3          	bnez	s3,8dc <vprintf+0x40>
      if(c == '%'){
 8ee:	ff4910e3          	bne	s2,s4,8ce <vprintf+0x32>
        state = '%';
 8f2:	89d2                	mv	s3,s4
 8f4:	b7f5                	j	8e0 <vprintf+0x44>
      if(c == 'd'){
 8f6:	13490263          	beq	s2,s4,a1a <vprintf+0x17e>
 8fa:	f9d9079b          	addiw	a5,s2,-99
 8fe:	0ff7f793          	zext.b	a5,a5
 902:	12fb6563          	bltu	s6,a5,a2c <vprintf+0x190>
 906:	f9d9079b          	addiw	a5,s2,-99
 90a:	0ff7f713          	zext.b	a4,a5
 90e:	10eb6f63          	bltu	s6,a4,a2c <vprintf+0x190>
 912:	00271793          	slli	a5,a4,0x2
 916:	00000717          	auipc	a4,0x0
 91a:	46270713          	addi	a4,a4,1122 # d78 <malloc+0x22a>
 91e:	97ba                	add	a5,a5,a4
 920:	439c                	lw	a5,0(a5)
 922:	97ba                	add	a5,a5,a4
 924:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 926:	008b8913          	addi	s2,s7,8
 92a:	4685                	li	a3,1
 92c:	4629                	li	a2,10
 92e:	000ba583          	lw	a1,0(s7)
 932:	8556                	mv	a0,s5
 934:	00000097          	auipc	ra,0x0
 938:	ebc080e7          	jalr	-324(ra) # 7f0 <printint>
 93c:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 93e:	4981                	li	s3,0
 940:	b745                	j	8e0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 942:	008b8913          	addi	s2,s7,8
 946:	4681                	li	a3,0
 948:	4629                	li	a2,10
 94a:	000ba583          	lw	a1,0(s7)
 94e:	8556                	mv	a0,s5
 950:	00000097          	auipc	ra,0x0
 954:	ea0080e7          	jalr	-352(ra) # 7f0 <printint>
 958:	8bca                	mv	s7,s2
      state = 0;
 95a:	4981                	li	s3,0
 95c:	b751                	j	8e0 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 95e:	008b8913          	addi	s2,s7,8
 962:	4681                	li	a3,0
 964:	4641                	li	a2,16
 966:	000ba583          	lw	a1,0(s7)
 96a:	8556                	mv	a0,s5
 96c:	00000097          	auipc	ra,0x0
 970:	e84080e7          	jalr	-380(ra) # 7f0 <printint>
 974:	8bca                	mv	s7,s2
      state = 0;
 976:	4981                	li	s3,0
 978:	b7a5                	j	8e0 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 97a:	008b8c13          	addi	s8,s7,8
 97e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 982:	03000593          	li	a1,48
 986:	8556                	mv	a0,s5
 988:	00000097          	auipc	ra,0x0
 98c:	e46080e7          	jalr	-442(ra) # 7ce <putc>
  putc(fd, 'x');
 990:	07800593          	li	a1,120
 994:	8556                	mv	a0,s5
 996:	00000097          	auipc	ra,0x0
 99a:	e38080e7          	jalr	-456(ra) # 7ce <putc>
 99e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9a0:	00000b97          	auipc	s7,0x0
 9a4:	430b8b93          	addi	s7,s7,1072 # dd0 <digits>
 9a8:	03c9d793          	srli	a5,s3,0x3c
 9ac:	97de                	add	a5,a5,s7
 9ae:	0007c583          	lbu	a1,0(a5)
 9b2:	8556                	mv	a0,s5
 9b4:	00000097          	auipc	ra,0x0
 9b8:	e1a080e7          	jalr	-486(ra) # 7ce <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9bc:	0992                	slli	s3,s3,0x4
 9be:	397d                	addiw	s2,s2,-1
 9c0:	fe0914e3          	bnez	s2,9a8 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 9c4:	8be2                	mv	s7,s8
      state = 0;
 9c6:	4981                	li	s3,0
 9c8:	bf21                	j	8e0 <vprintf+0x44>
        s = va_arg(ap, char*);
 9ca:	008b8993          	addi	s3,s7,8
 9ce:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 9d2:	02090163          	beqz	s2,9f4 <vprintf+0x158>
        while(*s != 0){
 9d6:	00094583          	lbu	a1,0(s2)
 9da:	c9a5                	beqz	a1,a4a <vprintf+0x1ae>
          putc(fd, *s);
 9dc:	8556                	mv	a0,s5
 9de:	00000097          	auipc	ra,0x0
 9e2:	df0080e7          	jalr	-528(ra) # 7ce <putc>
          s++;
 9e6:	0905                	addi	s2,s2,1
        while(*s != 0){
 9e8:	00094583          	lbu	a1,0(s2)
 9ec:	f9e5                	bnez	a1,9dc <vprintf+0x140>
        s = va_arg(ap, char*);
 9ee:	8bce                	mv	s7,s3
      state = 0;
 9f0:	4981                	li	s3,0
 9f2:	b5fd                	j	8e0 <vprintf+0x44>
          s = "(null)";
 9f4:	00000917          	auipc	s2,0x0
 9f8:	37c90913          	addi	s2,s2,892 # d70 <malloc+0x222>
        while(*s != 0){
 9fc:	02800593          	li	a1,40
 a00:	bff1                	j	9dc <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a02:	008b8913          	addi	s2,s7,8
 a06:	000bc583          	lbu	a1,0(s7)
 a0a:	8556                	mv	a0,s5
 a0c:	00000097          	auipc	ra,0x0
 a10:	dc2080e7          	jalr	-574(ra) # 7ce <putc>
 a14:	8bca                	mv	s7,s2
      state = 0;
 a16:	4981                	li	s3,0
 a18:	b5e1                	j	8e0 <vprintf+0x44>
        putc(fd, c);
 a1a:	02500593          	li	a1,37
 a1e:	8556                	mv	a0,s5
 a20:	00000097          	auipc	ra,0x0
 a24:	dae080e7          	jalr	-594(ra) # 7ce <putc>
      state = 0;
 a28:	4981                	li	s3,0
 a2a:	bd5d                	j	8e0 <vprintf+0x44>
        putc(fd, '%');
 a2c:	02500593          	li	a1,37
 a30:	8556                	mv	a0,s5
 a32:	00000097          	auipc	ra,0x0
 a36:	d9c080e7          	jalr	-612(ra) # 7ce <putc>
        putc(fd, c);
 a3a:	85ca                	mv	a1,s2
 a3c:	8556                	mv	a0,s5
 a3e:	00000097          	auipc	ra,0x0
 a42:	d90080e7          	jalr	-624(ra) # 7ce <putc>
      state = 0;
 a46:	4981                	li	s3,0
 a48:	bd61                	j	8e0 <vprintf+0x44>
        s = va_arg(ap, char*);
 a4a:	8bce                	mv	s7,s3
      state = 0;
 a4c:	4981                	li	s3,0
 a4e:	bd49                	j	8e0 <vprintf+0x44>
    }
  }
}
 a50:	60a6                	ld	ra,72(sp)
 a52:	6406                	ld	s0,64(sp)
 a54:	74e2                	ld	s1,56(sp)
 a56:	7942                	ld	s2,48(sp)
 a58:	79a2                	ld	s3,40(sp)
 a5a:	7a02                	ld	s4,32(sp)
 a5c:	6ae2                	ld	s5,24(sp)
 a5e:	6b42                	ld	s6,16(sp)
 a60:	6ba2                	ld	s7,8(sp)
 a62:	6c02                	ld	s8,0(sp)
 a64:	6161                	addi	sp,sp,80
 a66:	8082                	ret

0000000000000a68 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a68:	715d                	addi	sp,sp,-80
 a6a:	ec06                	sd	ra,24(sp)
 a6c:	e822                	sd	s0,16(sp)
 a6e:	1000                	addi	s0,sp,32
 a70:	e010                	sd	a2,0(s0)
 a72:	e414                	sd	a3,8(s0)
 a74:	e818                	sd	a4,16(s0)
 a76:	ec1c                	sd	a5,24(s0)
 a78:	03043023          	sd	a6,32(s0)
 a7c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a80:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a84:	8622                	mv	a2,s0
 a86:	00000097          	auipc	ra,0x0
 a8a:	e16080e7          	jalr	-490(ra) # 89c <vprintf>
}
 a8e:	60e2                	ld	ra,24(sp)
 a90:	6442                	ld	s0,16(sp)
 a92:	6161                	addi	sp,sp,80
 a94:	8082                	ret

0000000000000a96 <printf>:

void
printf(const char *fmt, ...)
{
 a96:	711d                	addi	sp,sp,-96
 a98:	ec06                	sd	ra,24(sp)
 a9a:	e822                	sd	s0,16(sp)
 a9c:	1000                	addi	s0,sp,32
 a9e:	e40c                	sd	a1,8(s0)
 aa0:	e810                	sd	a2,16(s0)
 aa2:	ec14                	sd	a3,24(s0)
 aa4:	f018                	sd	a4,32(s0)
 aa6:	f41c                	sd	a5,40(s0)
 aa8:	03043823          	sd	a6,48(s0)
 aac:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ab0:	00840613          	addi	a2,s0,8
 ab4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 ab8:	85aa                	mv	a1,a0
 aba:	4505                	li	a0,1
 abc:	00000097          	auipc	ra,0x0
 ac0:	de0080e7          	jalr	-544(ra) # 89c <vprintf>
}
 ac4:	60e2                	ld	ra,24(sp)
 ac6:	6442                	ld	s0,16(sp)
 ac8:	6125                	addi	sp,sp,96
 aca:	8082                	ret

0000000000000acc <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 acc:	1141                	addi	sp,sp,-16
 ace:	e422                	sd	s0,8(sp)
 ad0:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 ad2:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ad6:	00000797          	auipc	a5,0x0
 ada:	5427b783          	ld	a5,1346(a5) # 1018 <freep>
 ade:	a02d                	j	b08 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 ae0:	4618                	lw	a4,8(a2)
 ae2:	9f2d                	addw	a4,a4,a1
 ae4:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 ae8:	6398                	ld	a4,0(a5)
 aea:	6310                	ld	a2,0(a4)
 aec:	a83d                	j	b2a <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 aee:	ff852703          	lw	a4,-8(a0)
 af2:	9f31                	addw	a4,a4,a2
 af4:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 af6:	ff053683          	ld	a3,-16(a0)
 afa:	a091                	j	b3e <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 afc:	6398                	ld	a4,0(a5)
 afe:	00e7e463          	bltu	a5,a4,b06 <free+0x3a>
 b02:	00e6ea63          	bltu	a3,a4,b16 <free+0x4a>
{
 b06:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b08:	fed7fae3          	bgeu	a5,a3,afc <free+0x30>
 b0c:	6398                	ld	a4,0(a5)
 b0e:	00e6e463          	bltu	a3,a4,b16 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b12:	fee7eae3          	bltu	a5,a4,b06 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 b16:	ff852583          	lw	a1,-8(a0)
 b1a:	6390                	ld	a2,0(a5)
 b1c:	02059813          	slli	a6,a1,0x20
 b20:	01c85713          	srli	a4,a6,0x1c
 b24:	9736                	add	a4,a4,a3
 b26:	fae60de3          	beq	a2,a4,ae0 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 b2a:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 b2e:	4790                	lw	a2,8(a5)
 b30:	02061593          	slli	a1,a2,0x20
 b34:	01c5d713          	srli	a4,a1,0x1c
 b38:	973e                	add	a4,a4,a5
 b3a:	fae68ae3          	beq	a3,a4,aee <free+0x22>
        p->s.ptr = bp->s.ptr;
 b3e:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b40:	00000717          	auipc	a4,0x0
 b44:	4cf73c23          	sd	a5,1240(a4) # 1018 <freep>
}
 b48:	6422                	ld	s0,8(sp)
 b4a:	0141                	addi	sp,sp,16
 b4c:	8082                	ret

0000000000000b4e <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b4e:	7139                	addi	sp,sp,-64
 b50:	fc06                	sd	ra,56(sp)
 b52:	f822                	sd	s0,48(sp)
 b54:	f426                	sd	s1,40(sp)
 b56:	f04a                	sd	s2,32(sp)
 b58:	ec4e                	sd	s3,24(sp)
 b5a:	e852                	sd	s4,16(sp)
 b5c:	e456                	sd	s5,8(sp)
 b5e:	e05a                	sd	s6,0(sp)
 b60:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b62:	02051493          	slli	s1,a0,0x20
 b66:	9081                	srli	s1,s1,0x20
 b68:	04bd                	addi	s1,s1,15
 b6a:	8091                	srli	s1,s1,0x4
 b6c:	0014899b          	addiw	s3,s1,1
 b70:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b72:	00000517          	auipc	a0,0x0
 b76:	4a653503          	ld	a0,1190(a0) # 1018 <freep>
 b7a:	c515                	beqz	a0,ba6 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b7c:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b7e:	4798                	lw	a4,8(a5)
 b80:	02977f63          	bgeu	a4,s1,bbe <malloc+0x70>
    if (nu < 4096)
 b84:	8a4e                	mv	s4,s3
 b86:	0009871b          	sext.w	a4,s3
 b8a:	6685                	lui	a3,0x1
 b8c:	00d77363          	bgeu	a4,a3,b92 <malloc+0x44>
 b90:	6a05                	lui	s4,0x1
 b92:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b96:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b9a:	00000917          	auipc	s2,0x0
 b9e:	47e90913          	addi	s2,s2,1150 # 1018 <freep>
    if (p == (char *)-1)
 ba2:	5afd                	li	s5,-1
 ba4:	a895                	j	c18 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 ba6:	00000797          	auipc	a5,0x0
 baa:	4fa78793          	addi	a5,a5,1274 # 10a0 <base>
 bae:	00000717          	auipc	a4,0x0
 bb2:	46f73523          	sd	a5,1130(a4) # 1018 <freep>
 bb6:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 bb8:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 bbc:	b7e1                	j	b84 <malloc+0x36>
            if (p->s.size == nunits)
 bbe:	02e48c63          	beq	s1,a4,bf6 <malloc+0xa8>
                p->s.size -= nunits;
 bc2:	4137073b          	subw	a4,a4,s3
 bc6:	c798                	sw	a4,8(a5)
                p += p->s.size;
 bc8:	02071693          	slli	a3,a4,0x20
 bcc:	01c6d713          	srli	a4,a3,0x1c
 bd0:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 bd2:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 bd6:	00000717          	auipc	a4,0x0
 bda:	44a73123          	sd	a0,1090(a4) # 1018 <freep>
            return (void *)(p + 1);
 bde:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 be2:	70e2                	ld	ra,56(sp)
 be4:	7442                	ld	s0,48(sp)
 be6:	74a2                	ld	s1,40(sp)
 be8:	7902                	ld	s2,32(sp)
 bea:	69e2                	ld	s3,24(sp)
 bec:	6a42                	ld	s4,16(sp)
 bee:	6aa2                	ld	s5,8(sp)
 bf0:	6b02                	ld	s6,0(sp)
 bf2:	6121                	addi	sp,sp,64
 bf4:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 bf6:	6398                	ld	a4,0(a5)
 bf8:	e118                	sd	a4,0(a0)
 bfa:	bff1                	j	bd6 <malloc+0x88>
    hp->s.size = nu;
 bfc:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c00:	0541                	addi	a0,a0,16
 c02:	00000097          	auipc	ra,0x0
 c06:	eca080e7          	jalr	-310(ra) # acc <free>
    return freep;
 c0a:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c0e:	d971                	beqz	a0,be2 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c10:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c12:	4798                	lw	a4,8(a5)
 c14:	fa9775e3          	bgeu	a4,s1,bbe <malloc+0x70>
        if (p == freep)
 c18:	00093703          	ld	a4,0(s2)
 c1c:	853e                	mv	a0,a5
 c1e:	fef719e3          	bne	a4,a5,c10 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 c22:	8552                	mv	a0,s4
 c24:	00000097          	auipc	ra,0x0
 c28:	b7a080e7          	jalr	-1158(ra) # 79e <sbrk>
    if (p == (char *)-1)
 c2c:	fd5518e3          	bne	a0,s5,bfc <malloc+0xae>
                return 0;
 c30:	4501                	li	a0,0
 c32:	bf45                	j	be2 <malloc+0x94>
