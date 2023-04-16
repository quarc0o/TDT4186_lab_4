
user/_schedls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    schedls();
   8:	00000097          	auipc	ra,0x0
   c:	776080e7          	jalr	1910(ra) # 77e <schedls>
    exit(0);
  10:	4501                	li	a0,0
  12:	00000097          	auipc	ra,0x0
  16:	6c4080e7          	jalr	1732(ra) # 6d6 <exit>

000000000000001a <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  1a:	1141                	addi	sp,sp,-16
  1c:	e422                	sd	s0,8(sp)
  1e:	0800                	addi	s0,sp,16
    lk->name = name;
  20:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  22:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  26:	57fd                	li	a5,-1
  28:	00f50823          	sb	a5,16(a0)
}
  2c:	6422                	ld	s0,8(sp)
  2e:	0141                	addi	sp,sp,16
  30:	8082                	ret

0000000000000032 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  32:	00054783          	lbu	a5,0(a0)
  36:	e399                	bnez	a5,3c <holding+0xa>
  38:	4501                	li	a0,0
}
  3a:	8082                	ret
{
  3c:	1101                	addi	sp,sp,-32
  3e:	ec06                	sd	ra,24(sp)
  40:	e822                	sd	s0,16(sp)
  42:	e426                	sd	s1,8(sp)
  44:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  46:	01054483          	lbu	s1,16(a0)
  4a:	00000097          	auipc	ra,0x0
  4e:	2dc080e7          	jalr	732(ra) # 326 <twhoami>
  52:	2501                	sext.w	a0,a0
  54:	40a48533          	sub	a0,s1,a0
  58:	00153513          	seqz	a0,a0
}
  5c:	60e2                	ld	ra,24(sp)
  5e:	6442                	ld	s0,16(sp)
  60:	64a2                	ld	s1,8(sp)
  62:	6105                	addi	sp,sp,32
  64:	8082                	ret

0000000000000066 <acquire>:

void acquire(struct lock *lk)
{
  66:	7179                	addi	sp,sp,-48
  68:	f406                	sd	ra,40(sp)
  6a:	f022                	sd	s0,32(sp)
  6c:	ec26                	sd	s1,24(sp)
  6e:	e84a                	sd	s2,16(sp)
  70:	e44e                	sd	s3,8(sp)
  72:	e052                	sd	s4,0(sp)
  74:	1800                	addi	s0,sp,48
  76:	8a2a                	mv	s4,a0
    if (holding(lk))
  78:	00000097          	auipc	ra,0x0
  7c:	fba080e7          	jalr	-70(ra) # 32 <holding>
  80:	e919                	bnez	a0,96 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  82:	ffca7493          	andi	s1,s4,-4
  86:	003a7913          	andi	s2,s4,3
  8a:	0039191b          	slliw	s2,s2,0x3
  8e:	4985                	li	s3,1
  90:	012999bb          	sllw	s3,s3,s2
  94:	a015                	j	b8 <acquire+0x52>
        printf("re-acquiring lock we already hold");
  96:	00001517          	auipc	a0,0x1
  9a:	b6a50513          	addi	a0,a0,-1174 # c00 <malloc+0xf2>
  9e:	00001097          	auipc	ra,0x1
  a2:	9b8080e7          	jalr	-1608(ra) # a56 <printf>
        exit(-1);
  a6:	557d                	li	a0,-1
  a8:	00000097          	auipc	ra,0x0
  ac:	62e080e7          	jalr	1582(ra) # 6d6 <exit>
    {
        // give up the cpu for other threads
        tyield();
  b0:	00000097          	auipc	ra,0x0
  b4:	252080e7          	jalr	594(ra) # 302 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  b8:	4534a7af          	amoor.w.aq	a5,s3,(s1)
  bc:	0127d7bb          	srlw	a5,a5,s2
  c0:	0ff7f793          	zext.b	a5,a5
  c4:	f7f5                	bnez	a5,b0 <acquire+0x4a>
    }

    __sync_synchronize();
  c6:	0ff0000f          	fence

    lk->tid = twhoami();
  ca:	00000097          	auipc	ra,0x0
  ce:	25c080e7          	jalr	604(ra) # 326 <twhoami>
  d2:	00aa0823          	sb	a0,16(s4)
}
  d6:	70a2                	ld	ra,40(sp)
  d8:	7402                	ld	s0,32(sp)
  da:	64e2                	ld	s1,24(sp)
  dc:	6942                	ld	s2,16(sp)
  de:	69a2                	ld	s3,8(sp)
  e0:	6a02                	ld	s4,0(sp)
  e2:	6145                	addi	sp,sp,48
  e4:	8082                	ret

00000000000000e6 <release>:

void release(struct lock *lk)
{
  e6:	1101                	addi	sp,sp,-32
  e8:	ec06                	sd	ra,24(sp)
  ea:	e822                	sd	s0,16(sp)
  ec:	e426                	sd	s1,8(sp)
  ee:	1000                	addi	s0,sp,32
  f0:	84aa                	mv	s1,a0
    if (!holding(lk))
  f2:	00000097          	auipc	ra,0x0
  f6:	f40080e7          	jalr	-192(ra) # 32 <holding>
  fa:	c11d                	beqz	a0,120 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
  fc:	57fd                	li	a5,-1
  fe:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 102:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 106:	0ff0000f          	fence
 10a:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 10e:	00000097          	auipc	ra,0x0
 112:	1f4080e7          	jalr	500(ra) # 302 <tyield>
}
 116:	60e2                	ld	ra,24(sp)
 118:	6442                	ld	s0,16(sp)
 11a:	64a2                	ld	s1,8(sp)
 11c:	6105                	addi	sp,sp,32
 11e:	8082                	ret
        printf("releasing lock we are not holding");
 120:	00001517          	auipc	a0,0x1
 124:	b0850513          	addi	a0,a0,-1272 # c28 <malloc+0x11a>
 128:	00001097          	auipc	ra,0x1
 12c:	92e080e7          	jalr	-1746(ra) # a56 <printf>
        exit(-1);
 130:	557d                	li	a0,-1
 132:	00000097          	auipc	ra,0x0
 136:	5a4080e7          	jalr	1444(ra) # 6d6 <exit>

000000000000013a <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 13a:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 13c:	00001617          	auipc	a2,0x1
 140:	ee460613          	addi	a2,a2,-284 # 1020 <threads>
 144:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 146:	45c1                	li	a1,16
 148:	a021                	j	150 <tsched+0x16>
 14a:	2685                	addiw	a3,a3,1
 14c:	08b68c63          	beq	a3,a1,1e4 <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 150:	41f6d71b          	sraiw	a4,a3,0x1f
 154:	01c7571b          	srliw	a4,a4,0x1c
 158:	00d707bb          	addw	a5,a4,a3
 15c:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 15e:	9f99                	subw	a5,a5,a4
 160:	078e                	slli	a5,a5,0x3
 162:	97b2                	add	a5,a5,a2
 164:	639c                	ld	a5,0(a5)
 166:	d3f5                	beqz	a5,14a <tsched+0x10>
 168:	5fb8                	lw	a4,120(a5)
 16a:	fea710e3          	bne	a4,a0,14a <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 16e:	00001717          	auipc	a4,0x1
 172:	eb273703          	ld	a4,-334(a4) # 1020 <threads>
 176:	5f30                	lw	a2,120(a4)
 178:	468d                	li	a3,3
 17a:	06d60363          	beq	a2,a3,1e0 <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 17e:	c3a5                	beqz	a5,1de <tsched+0xa4>
{
 180:	1101                	addi	sp,sp,-32
 182:	ec06                	sd	ra,24(sp)
 184:	e822                	sd	s0,16(sp)
 186:	e426                	sd	s1,8(sp)
 188:	e04a                	sd	s2,0(sp)
 18a:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 18c:	00001497          	auipc	s1,0x1
 190:	e8448493          	addi	s1,s1,-380 # 1010 <current_thread>
 194:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 198:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 19a:	0007c603          	lbu	a2,0(a5)
 19e:	00094583          	lbu	a1,0(s2)
 1a2:	00001517          	auipc	a0,0x1
 1a6:	aae50513          	addi	a0,a0,-1362 # c50 <malloc+0x142>
 1aa:	00001097          	auipc	ra,0x1
 1ae:	8ac080e7          	jalr	-1876(ra) # a56 <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 1b2:	608c                	ld	a1,0(s1)
 1b4:	05a1                	addi	a1,a1,8
 1b6:	00890513          	addi	a0,s2,8
 1ba:	00000097          	auipc	ra,0x0
 1be:	184080e7          	jalr	388(ra) # 33e <tswtch>
        printf("Thread switch complete\n");
 1c2:	00001517          	auipc	a0,0x1
 1c6:	ab650513          	addi	a0,a0,-1354 # c78 <malloc+0x16a>
 1ca:	00001097          	auipc	ra,0x1
 1ce:	88c080e7          	jalr	-1908(ra) # a56 <printf>
    }
}
 1d2:	60e2                	ld	ra,24(sp)
 1d4:	6442                	ld	s0,16(sp)
 1d6:	64a2                	ld	s1,8(sp)
 1d8:	6902                	ld	s2,0(sp)
 1da:	6105                	addi	sp,sp,32
 1dc:	8082                	ret
 1de:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 1e0:	87ba                	mv	a5,a4
 1e2:	bf79                	j	180 <tsched+0x46>
 1e4:	00001797          	auipc	a5,0x1
 1e8:	e3c7b783          	ld	a5,-452(a5) # 1020 <threads>
 1ec:	5fb4                	lw	a3,120(a5)
 1ee:	470d                	li	a4,3
 1f0:	f8e688e3          	beq	a3,a4,180 <tsched+0x46>
 1f4:	8082                	ret

00000000000001f6 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 1f6:	7179                	addi	sp,sp,-48
 1f8:	f406                	sd	ra,40(sp)
 1fa:	f022                	sd	s0,32(sp)
 1fc:	ec26                	sd	s1,24(sp)
 1fe:	e84a                	sd	s2,16(sp)
 200:	e44e                	sd	s3,8(sp)
 202:	1800                	addi	s0,sp,48
 204:	84aa                	mv	s1,a0
 206:	89b2                	mv	s3,a2
 208:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 20a:	09000513          	li	a0,144
 20e:	00001097          	auipc	ra,0x1
 212:	900080e7          	jalr	-1792(ra) # b0e <malloc>
 216:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 218:	478d                	li	a5,3
 21a:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 21c:	609c                	ld	a5,0(s1)
 21e:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 222:	609c                	ld	a5,0(s1)
 224:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 228:	00001717          	auipc	a4,0x1
 22c:	dd870713          	addi	a4,a4,-552 # 1000 <next_tid>
 230:	431c                	lw	a5,0(a4)
 232:	0017869b          	addiw	a3,a5,1
 236:	c314                	sw	a3,0(a4)
 238:	6098                	ld	a4,0(s1)
 23a:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 23e:	00001717          	auipc	a4,0x1
 242:	de270713          	addi	a4,a4,-542 # 1020 <threads>
 246:	4781                	li	a5,0
 248:	4641                	li	a2,16
    if (threads[i] == NULL) {
 24a:	6314                	ld	a3,0(a4)
 24c:	ce81                	beqz	a3,264 <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 24e:	2785                	addiw	a5,a5,1
 250:	0721                	addi	a4,a4,8
 252:	fec79ce3          	bne	a5,a2,24a <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 256:	70a2                	ld	ra,40(sp)
 258:	7402                	ld	s0,32(sp)
 25a:	64e2                	ld	s1,24(sp)
 25c:	6942                	ld	s2,16(sp)
 25e:	69a2                	ld	s3,8(sp)
 260:	6145                	addi	sp,sp,48
 262:	8082                	ret
        threads[i] = *thread;
 264:	6094                	ld	a3,0(s1)
 266:	078e                	slli	a5,a5,0x3
 268:	00001717          	auipc	a4,0x1
 26c:	db870713          	addi	a4,a4,-584 # 1020 <threads>
 270:	97ba                	add	a5,a5,a4
 272:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 274:	0006c583          	lbu	a1,0(a3)
 278:	00001517          	auipc	a0,0x1
 27c:	a1850513          	addi	a0,a0,-1512 # c90 <malloc+0x182>
 280:	00000097          	auipc	ra,0x0
 284:	7d6080e7          	jalr	2006(ra) # a56 <printf>
        break;
 288:	b7f9                	j	256 <tcreate+0x60>

000000000000028a <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 28a:	7179                	addi	sp,sp,-48
 28c:	f406                	sd	ra,40(sp)
 28e:	f022                	sd	s0,32(sp)
 290:	ec26                	sd	s1,24(sp)
 292:	e84a                	sd	s2,16(sp)
 294:	e44e                	sd	s3,8(sp)
 296:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 298:	00001797          	auipc	a5,0x1
 29c:	d8878793          	addi	a5,a5,-632 # 1020 <threads>
 2a0:	00001697          	auipc	a3,0x1
 2a4:	e0068693          	addi	a3,a3,-512 # 10a0 <base>
 2a8:	a021                	j	2b0 <tjoin+0x26>
 2aa:	07a1                	addi	a5,a5,8
 2ac:	04d78763          	beq	a5,a3,2fa <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 2b0:	6384                	ld	s1,0(a5)
 2b2:	dce5                	beqz	s1,2aa <tjoin+0x20>
 2b4:	0004c703          	lbu	a4,0(s1)
 2b8:	fea719e3          	bne	a4,a0,2aa <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 2bc:	5cb8                	lw	a4,120(s1)
 2be:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 2c0:	00001997          	auipc	s3,0x1
 2c4:	a0098993          	addi	s3,s3,-1536 # cc0 <malloc+0x1b2>
    while (target_thread->state != EXITED) {
 2c8:	4919                	li	s2,6
 2ca:	02f70a63          	beq	a4,a5,2fe <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 2ce:	0004c583          	lbu	a1,0(s1)
 2d2:	854e                	mv	a0,s3
 2d4:	00000097          	auipc	ra,0x0
 2d8:	782080e7          	jalr	1922(ra) # a56 <printf>
        tsched();
 2dc:	00000097          	auipc	ra,0x0
 2e0:	e5e080e7          	jalr	-418(ra) # 13a <tsched>
    while (target_thread->state != EXITED) {
 2e4:	5cbc                	lw	a5,120(s1)
 2e6:	ff2794e3          	bne	a5,s2,2ce <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 2ea:	4501                	li	a0,0
}
 2ec:	70a2                	ld	ra,40(sp)
 2ee:	7402                	ld	s0,32(sp)
 2f0:	64e2                	ld	s1,24(sp)
 2f2:	6942                	ld	s2,16(sp)
 2f4:	69a2                	ld	s3,8(sp)
 2f6:	6145                	addi	sp,sp,48
 2f8:	8082                	ret
        return -1;
 2fa:	557d                	li	a0,-1
 2fc:	bfc5                	j	2ec <tjoin+0x62>
    return 0;
 2fe:	4501                	li	a0,0
 300:	b7f5                	j	2ec <tjoin+0x62>

0000000000000302 <tyield>:


void tyield()
{
 302:	1141                	addi	sp,sp,-16
 304:	e406                	sd	ra,8(sp)
 306:	e022                	sd	s0,0(sp)
 308:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 30a:	00001797          	auipc	a5,0x1
 30e:	d067b783          	ld	a5,-762(a5) # 1010 <current_thread>
 312:	470d                	li	a4,3
 314:	dfb8                	sw	a4,120(a5)
    tsched();
 316:	00000097          	auipc	ra,0x0
 31a:	e24080e7          	jalr	-476(ra) # 13a <tsched>
}
 31e:	60a2                	ld	ra,8(sp)
 320:	6402                	ld	s0,0(sp)
 322:	0141                	addi	sp,sp,16
 324:	8082                	ret

0000000000000326 <twhoami>:

uint8 twhoami()
{
 326:	1141                	addi	sp,sp,-16
 328:	e422                	sd	s0,8(sp)
 32a:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
 32c:	00001797          	auipc	a5,0x1
 330:	ce47b783          	ld	a5,-796(a5) # 1010 <current_thread>
 334:	0007c503          	lbu	a0,0(a5)
 338:	6422                	ld	s0,8(sp)
 33a:	0141                	addi	sp,sp,16
 33c:	8082                	ret

000000000000033e <tswtch>:
 33e:	00153023          	sd	ra,0(a0)
 342:	00253423          	sd	sp,8(a0)
 346:	e900                	sd	s0,16(a0)
 348:	ed04                	sd	s1,24(a0)
 34a:	03253023          	sd	s2,32(a0)
 34e:	03353423          	sd	s3,40(a0)
 352:	03453823          	sd	s4,48(a0)
 356:	03553c23          	sd	s5,56(a0)
 35a:	05653023          	sd	s6,64(a0)
 35e:	05753423          	sd	s7,72(a0)
 362:	05853823          	sd	s8,80(a0)
 366:	05953c23          	sd	s9,88(a0)
 36a:	07a53023          	sd	s10,96(a0)
 36e:	07b53423          	sd	s11,104(a0)
 372:	0005b083          	ld	ra,0(a1)
 376:	0085b103          	ld	sp,8(a1)
 37a:	6980                	ld	s0,16(a1)
 37c:	6d84                	ld	s1,24(a1)
 37e:	0205b903          	ld	s2,32(a1)
 382:	0285b983          	ld	s3,40(a1)
 386:	0305ba03          	ld	s4,48(a1)
 38a:	0385ba83          	ld	s5,56(a1)
 38e:	0405bb03          	ld	s6,64(a1)
 392:	0485bb83          	ld	s7,72(a1)
 396:	0505bc03          	ld	s8,80(a1)
 39a:	0585bc83          	ld	s9,88(a1)
 39e:	0605bd03          	ld	s10,96(a1)
 3a2:	0685bd83          	ld	s11,104(a1)
 3a6:	8082                	ret

00000000000003a8 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 3a8:	715d                	addi	sp,sp,-80
 3aa:	e486                	sd	ra,72(sp)
 3ac:	e0a2                	sd	s0,64(sp)
 3ae:	fc26                	sd	s1,56(sp)
 3b0:	f84a                	sd	s2,48(sp)
 3b2:	f44e                	sd	s3,40(sp)
 3b4:	f052                	sd	s4,32(sp)
 3b6:	ec56                	sd	s5,24(sp)
 3b8:	e85a                	sd	s6,16(sp)
 3ba:	e45e                	sd	s7,8(sp)
 3bc:	0880                	addi	s0,sp,80
 3be:	892a                	mv	s2,a0
 3c0:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 3c2:	00001517          	auipc	a0,0x1
 3c6:	91e50513          	addi	a0,a0,-1762 # ce0 <malloc+0x1d2>
 3ca:	00000097          	auipc	ra,0x0
 3ce:	68c080e7          	jalr	1676(ra) # a56 <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 3d2:	09000513          	li	a0,144
 3d6:	00000097          	auipc	ra,0x0
 3da:	738080e7          	jalr	1848(ra) # b0e <malloc>

    main_thread->tid = 0;
 3de:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 3e2:	4791                	li	a5,4
 3e4:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 3e6:	00001797          	auipc	a5,0x1
 3ea:	c2a7b523          	sd	a0,-982(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 3ee:	00001a17          	auipc	s4,0x1
 3f2:	c32a0a13          	addi	s4,s4,-974 # 1020 <threads>
 3f6:	00001497          	auipc	s1,0x1
 3fa:	caa48493          	addi	s1,s1,-854 # 10a0 <base>
    current_thread = main_thread;
 3fe:	87d2                	mv	a5,s4
        threads[i] = NULL;
 400:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 404:	07a1                	addi	a5,a5,8
 406:	fe979de3          	bne	a5,s1,400 <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 40a:	00001797          	auipc	a5,0x1
 40e:	c0a7bb23          	sd	a0,-1002(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 412:	85ce                	mv	a1,s3
 414:	854a                	mv	a0,s2
 416:	00000097          	auipc	ra,0x0
 41a:	bea080e7          	jalr	-1046(ra) # 0 <main>
 41e:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 420:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 422:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 424:	00001a97          	auipc	s5,0x1
 428:	8dca8a93          	addi	s5,s5,-1828 # d00 <malloc+0x1f2>
 42c:	a03d                	j	45a <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 42e:	07a1                	addi	a5,a5,8
 430:	00978963          	beq	a5,s1,442 <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 434:	6398                	ld	a4,0(a5)
 436:	df65                	beqz	a4,42e <_main+0x86>
 438:	5f38                	lw	a4,120(a4)
 43a:	ff370ae3          	beq	a4,s3,42e <_main+0x86>
                running_threads++;
 43e:	2905                	addiw	s2,s2,1
 440:	b7fd                	j	42e <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 442:	85ca                	mv	a1,s2
 444:	8556                	mv	a0,s5
 446:	00000097          	auipc	ra,0x0
 44a:	610080e7          	jalr	1552(ra) # a56 <printf>
        if (running_threads > 0) {
 44e:	01205963          	blez	s2,460 <_main+0xb8>
            tsched(); // Schedule another thread to run
 452:	00000097          	auipc	ra,0x0
 456:	ce8080e7          	jalr	-792(ra) # 13a <tsched>
    current_thread = main_thread;
 45a:	87d2                	mv	a5,s4
        running_threads = 0;
 45c:	895a                	mv	s2,s6
 45e:	bfd9                	j	434 <_main+0x8c>
        }
    }

    exit(res);
 460:	855e                	mv	a0,s7
 462:	00000097          	auipc	ra,0x0
 466:	274080e7          	jalr	628(ra) # 6d6 <exit>

000000000000046a <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 46a:	1141                	addi	sp,sp,-16
 46c:	e422                	sd	s0,8(sp)
 46e:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 470:	87aa                	mv	a5,a0
 472:	0585                	addi	a1,a1,1
 474:	0785                	addi	a5,a5,1
 476:	fff5c703          	lbu	a4,-1(a1)
 47a:	fee78fa3          	sb	a4,-1(a5)
 47e:	fb75                	bnez	a4,472 <strcpy+0x8>
        ;
    return os;
}
 480:	6422                	ld	s0,8(sp)
 482:	0141                	addi	sp,sp,16
 484:	8082                	ret

0000000000000486 <strcmp>:

int strcmp(const char *p, const char *q)
{
 486:	1141                	addi	sp,sp,-16
 488:	e422                	sd	s0,8(sp)
 48a:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 48c:	00054783          	lbu	a5,0(a0)
 490:	cb91                	beqz	a5,4a4 <strcmp+0x1e>
 492:	0005c703          	lbu	a4,0(a1)
 496:	00f71763          	bne	a4,a5,4a4 <strcmp+0x1e>
        p++, q++;
 49a:	0505                	addi	a0,a0,1
 49c:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 49e:	00054783          	lbu	a5,0(a0)
 4a2:	fbe5                	bnez	a5,492 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 4a4:	0005c503          	lbu	a0,0(a1)
}
 4a8:	40a7853b          	subw	a0,a5,a0
 4ac:	6422                	ld	s0,8(sp)
 4ae:	0141                	addi	sp,sp,16
 4b0:	8082                	ret

00000000000004b2 <strlen>:

uint strlen(const char *s)
{
 4b2:	1141                	addi	sp,sp,-16
 4b4:	e422                	sd	s0,8(sp)
 4b6:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 4b8:	00054783          	lbu	a5,0(a0)
 4bc:	cf91                	beqz	a5,4d8 <strlen+0x26>
 4be:	0505                	addi	a0,a0,1
 4c0:	87aa                	mv	a5,a0
 4c2:	86be                	mv	a3,a5
 4c4:	0785                	addi	a5,a5,1
 4c6:	fff7c703          	lbu	a4,-1(a5)
 4ca:	ff65                	bnez	a4,4c2 <strlen+0x10>
 4cc:	40a6853b          	subw	a0,a3,a0
 4d0:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 4d2:	6422                	ld	s0,8(sp)
 4d4:	0141                	addi	sp,sp,16
 4d6:	8082                	ret
    for (n = 0; s[n]; n++)
 4d8:	4501                	li	a0,0
 4da:	bfe5                	j	4d2 <strlen+0x20>

00000000000004dc <memset>:

void *
memset(void *dst, int c, uint n)
{
 4dc:	1141                	addi	sp,sp,-16
 4de:	e422                	sd	s0,8(sp)
 4e0:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 4e2:	ca19                	beqz	a2,4f8 <memset+0x1c>
 4e4:	87aa                	mv	a5,a0
 4e6:	1602                	slli	a2,a2,0x20
 4e8:	9201                	srli	a2,a2,0x20
 4ea:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 4ee:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 4f2:	0785                	addi	a5,a5,1
 4f4:	fee79de3          	bne	a5,a4,4ee <memset+0x12>
    }
    return dst;
}
 4f8:	6422                	ld	s0,8(sp)
 4fa:	0141                	addi	sp,sp,16
 4fc:	8082                	ret

00000000000004fe <strchr>:

char *
strchr(const char *s, char c)
{
 4fe:	1141                	addi	sp,sp,-16
 500:	e422                	sd	s0,8(sp)
 502:	0800                	addi	s0,sp,16
    for (; *s; s++)
 504:	00054783          	lbu	a5,0(a0)
 508:	cb99                	beqz	a5,51e <strchr+0x20>
        if (*s == c)
 50a:	00f58763          	beq	a1,a5,518 <strchr+0x1a>
    for (; *s; s++)
 50e:	0505                	addi	a0,a0,1
 510:	00054783          	lbu	a5,0(a0)
 514:	fbfd                	bnez	a5,50a <strchr+0xc>
            return (char *)s;
    return 0;
 516:	4501                	li	a0,0
}
 518:	6422                	ld	s0,8(sp)
 51a:	0141                	addi	sp,sp,16
 51c:	8082                	ret
    return 0;
 51e:	4501                	li	a0,0
 520:	bfe5                	j	518 <strchr+0x1a>

0000000000000522 <gets>:

char *
gets(char *buf, int max)
{
 522:	711d                	addi	sp,sp,-96
 524:	ec86                	sd	ra,88(sp)
 526:	e8a2                	sd	s0,80(sp)
 528:	e4a6                	sd	s1,72(sp)
 52a:	e0ca                	sd	s2,64(sp)
 52c:	fc4e                	sd	s3,56(sp)
 52e:	f852                	sd	s4,48(sp)
 530:	f456                	sd	s5,40(sp)
 532:	f05a                	sd	s6,32(sp)
 534:	ec5e                	sd	s7,24(sp)
 536:	1080                	addi	s0,sp,96
 538:	8baa                	mv	s7,a0
 53a:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 53c:	892a                	mv	s2,a0
 53e:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 540:	4aa9                	li	s5,10
 542:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 544:	89a6                	mv	s3,s1
 546:	2485                	addiw	s1,s1,1
 548:	0344d863          	bge	s1,s4,578 <gets+0x56>
        cc = read(0, &c, 1);
 54c:	4605                	li	a2,1
 54e:	faf40593          	addi	a1,s0,-81
 552:	4501                	li	a0,0
 554:	00000097          	auipc	ra,0x0
 558:	19a080e7          	jalr	410(ra) # 6ee <read>
        if (cc < 1)
 55c:	00a05e63          	blez	a0,578 <gets+0x56>
        buf[i++] = c;
 560:	faf44783          	lbu	a5,-81(s0)
 564:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 568:	01578763          	beq	a5,s5,576 <gets+0x54>
 56c:	0905                	addi	s2,s2,1
 56e:	fd679be3          	bne	a5,s6,544 <gets+0x22>
    for (i = 0; i + 1 < max;)
 572:	89a6                	mv	s3,s1
 574:	a011                	j	578 <gets+0x56>
 576:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 578:	99de                	add	s3,s3,s7
 57a:	00098023          	sb	zero,0(s3)
    return buf;
}
 57e:	855e                	mv	a0,s7
 580:	60e6                	ld	ra,88(sp)
 582:	6446                	ld	s0,80(sp)
 584:	64a6                	ld	s1,72(sp)
 586:	6906                	ld	s2,64(sp)
 588:	79e2                	ld	s3,56(sp)
 58a:	7a42                	ld	s4,48(sp)
 58c:	7aa2                	ld	s5,40(sp)
 58e:	7b02                	ld	s6,32(sp)
 590:	6be2                	ld	s7,24(sp)
 592:	6125                	addi	sp,sp,96
 594:	8082                	ret

0000000000000596 <stat>:

int stat(const char *n, struct stat *st)
{
 596:	1101                	addi	sp,sp,-32
 598:	ec06                	sd	ra,24(sp)
 59a:	e822                	sd	s0,16(sp)
 59c:	e426                	sd	s1,8(sp)
 59e:	e04a                	sd	s2,0(sp)
 5a0:	1000                	addi	s0,sp,32
 5a2:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 5a4:	4581                	li	a1,0
 5a6:	00000097          	auipc	ra,0x0
 5aa:	170080e7          	jalr	368(ra) # 716 <open>
    if (fd < 0)
 5ae:	02054563          	bltz	a0,5d8 <stat+0x42>
 5b2:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 5b4:	85ca                	mv	a1,s2
 5b6:	00000097          	auipc	ra,0x0
 5ba:	178080e7          	jalr	376(ra) # 72e <fstat>
 5be:	892a                	mv	s2,a0
    close(fd);
 5c0:	8526                	mv	a0,s1
 5c2:	00000097          	auipc	ra,0x0
 5c6:	13c080e7          	jalr	316(ra) # 6fe <close>
    return r;
}
 5ca:	854a                	mv	a0,s2
 5cc:	60e2                	ld	ra,24(sp)
 5ce:	6442                	ld	s0,16(sp)
 5d0:	64a2                	ld	s1,8(sp)
 5d2:	6902                	ld	s2,0(sp)
 5d4:	6105                	addi	sp,sp,32
 5d6:	8082                	ret
        return -1;
 5d8:	597d                	li	s2,-1
 5da:	bfc5                	j	5ca <stat+0x34>

00000000000005dc <atoi>:

int atoi(const char *s)
{
 5dc:	1141                	addi	sp,sp,-16
 5de:	e422                	sd	s0,8(sp)
 5e0:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 5e2:	00054683          	lbu	a3,0(a0)
 5e6:	fd06879b          	addiw	a5,a3,-48
 5ea:	0ff7f793          	zext.b	a5,a5
 5ee:	4625                	li	a2,9
 5f0:	02f66863          	bltu	a2,a5,620 <atoi+0x44>
 5f4:	872a                	mv	a4,a0
    n = 0;
 5f6:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 5f8:	0705                	addi	a4,a4,1
 5fa:	0025179b          	slliw	a5,a0,0x2
 5fe:	9fa9                	addw	a5,a5,a0
 600:	0017979b          	slliw	a5,a5,0x1
 604:	9fb5                	addw	a5,a5,a3
 606:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 60a:	00074683          	lbu	a3,0(a4)
 60e:	fd06879b          	addiw	a5,a3,-48
 612:	0ff7f793          	zext.b	a5,a5
 616:	fef671e3          	bgeu	a2,a5,5f8 <atoi+0x1c>
    return n;
}
 61a:	6422                	ld	s0,8(sp)
 61c:	0141                	addi	sp,sp,16
 61e:	8082                	ret
    n = 0;
 620:	4501                	li	a0,0
 622:	bfe5                	j	61a <atoi+0x3e>

0000000000000624 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 624:	1141                	addi	sp,sp,-16
 626:	e422                	sd	s0,8(sp)
 628:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 62a:	02b57463          	bgeu	a0,a1,652 <memmove+0x2e>
    {
        while (n-- > 0)
 62e:	00c05f63          	blez	a2,64c <memmove+0x28>
 632:	1602                	slli	a2,a2,0x20
 634:	9201                	srli	a2,a2,0x20
 636:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 63a:	872a                	mv	a4,a0
            *dst++ = *src++;
 63c:	0585                	addi	a1,a1,1
 63e:	0705                	addi	a4,a4,1
 640:	fff5c683          	lbu	a3,-1(a1)
 644:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 648:	fee79ae3          	bne	a5,a4,63c <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 64c:	6422                	ld	s0,8(sp)
 64e:	0141                	addi	sp,sp,16
 650:	8082                	ret
        dst += n;
 652:	00c50733          	add	a4,a0,a2
        src += n;
 656:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 658:	fec05ae3          	blez	a2,64c <memmove+0x28>
 65c:	fff6079b          	addiw	a5,a2,-1
 660:	1782                	slli	a5,a5,0x20
 662:	9381                	srli	a5,a5,0x20
 664:	fff7c793          	not	a5,a5
 668:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 66a:	15fd                	addi	a1,a1,-1
 66c:	177d                	addi	a4,a4,-1
 66e:	0005c683          	lbu	a3,0(a1)
 672:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 676:	fee79ae3          	bne	a5,a4,66a <memmove+0x46>
 67a:	bfc9                	j	64c <memmove+0x28>

000000000000067c <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 67c:	1141                	addi	sp,sp,-16
 67e:	e422                	sd	s0,8(sp)
 680:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 682:	ca05                	beqz	a2,6b2 <memcmp+0x36>
 684:	fff6069b          	addiw	a3,a2,-1
 688:	1682                	slli	a3,a3,0x20
 68a:	9281                	srli	a3,a3,0x20
 68c:	0685                	addi	a3,a3,1
 68e:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 690:	00054783          	lbu	a5,0(a0)
 694:	0005c703          	lbu	a4,0(a1)
 698:	00e79863          	bne	a5,a4,6a8 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 69c:	0505                	addi	a0,a0,1
        p2++;
 69e:	0585                	addi	a1,a1,1
    while (n-- > 0)
 6a0:	fed518e3          	bne	a0,a3,690 <memcmp+0x14>
    }
    return 0;
 6a4:	4501                	li	a0,0
 6a6:	a019                	j	6ac <memcmp+0x30>
            return *p1 - *p2;
 6a8:	40e7853b          	subw	a0,a5,a4
}
 6ac:	6422                	ld	s0,8(sp)
 6ae:	0141                	addi	sp,sp,16
 6b0:	8082                	ret
    return 0;
 6b2:	4501                	li	a0,0
 6b4:	bfe5                	j	6ac <memcmp+0x30>

00000000000006b6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6b6:	1141                	addi	sp,sp,-16
 6b8:	e406                	sd	ra,8(sp)
 6ba:	e022                	sd	s0,0(sp)
 6bc:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 6be:	00000097          	auipc	ra,0x0
 6c2:	f66080e7          	jalr	-154(ra) # 624 <memmove>
}
 6c6:	60a2                	ld	ra,8(sp)
 6c8:	6402                	ld	s0,0(sp)
 6ca:	0141                	addi	sp,sp,16
 6cc:	8082                	ret

00000000000006ce <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6ce:	4885                	li	a7,1
 ecall
 6d0:	00000073          	ecall
 ret
 6d4:	8082                	ret

00000000000006d6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 6d6:	4889                	li	a7,2
 ecall
 6d8:	00000073          	ecall
 ret
 6dc:	8082                	ret

00000000000006de <wait>:
.global wait
wait:
 li a7, SYS_wait
 6de:	488d                	li	a7,3
 ecall
 6e0:	00000073          	ecall
 ret
 6e4:	8082                	ret

00000000000006e6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6e6:	4891                	li	a7,4
 ecall
 6e8:	00000073          	ecall
 ret
 6ec:	8082                	ret

00000000000006ee <read>:
.global read
read:
 li a7, SYS_read
 6ee:	4895                	li	a7,5
 ecall
 6f0:	00000073          	ecall
 ret
 6f4:	8082                	ret

00000000000006f6 <write>:
.global write
write:
 li a7, SYS_write
 6f6:	48c1                	li	a7,16
 ecall
 6f8:	00000073          	ecall
 ret
 6fc:	8082                	ret

00000000000006fe <close>:
.global close
close:
 li a7, SYS_close
 6fe:	48d5                	li	a7,21
 ecall
 700:	00000073          	ecall
 ret
 704:	8082                	ret

0000000000000706 <kill>:
.global kill
kill:
 li a7, SYS_kill
 706:	4899                	li	a7,6
 ecall
 708:	00000073          	ecall
 ret
 70c:	8082                	ret

000000000000070e <exec>:
.global exec
exec:
 li a7, SYS_exec
 70e:	489d                	li	a7,7
 ecall
 710:	00000073          	ecall
 ret
 714:	8082                	ret

0000000000000716 <open>:
.global open
open:
 li a7, SYS_open
 716:	48bd                	li	a7,15
 ecall
 718:	00000073          	ecall
 ret
 71c:	8082                	ret

000000000000071e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 71e:	48c5                	li	a7,17
 ecall
 720:	00000073          	ecall
 ret
 724:	8082                	ret

0000000000000726 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 726:	48c9                	li	a7,18
 ecall
 728:	00000073          	ecall
 ret
 72c:	8082                	ret

000000000000072e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 72e:	48a1                	li	a7,8
 ecall
 730:	00000073          	ecall
 ret
 734:	8082                	ret

0000000000000736 <link>:
.global link
link:
 li a7, SYS_link
 736:	48cd                	li	a7,19
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 73e:	48d1                	li	a7,20
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 746:	48a5                	li	a7,9
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <dup>:
.global dup
dup:
 li a7, SYS_dup
 74e:	48a9                	li	a7,10
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 756:	48ad                	li	a7,11
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 75e:	48b1                	li	a7,12
 ecall
 760:	00000073          	ecall
 ret
 764:	8082                	ret

0000000000000766 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 766:	48b5                	li	a7,13
 ecall
 768:	00000073          	ecall
 ret
 76c:	8082                	ret

000000000000076e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 76e:	48b9                	li	a7,14
 ecall
 770:	00000073          	ecall
 ret
 774:	8082                	ret

0000000000000776 <ps>:
.global ps
ps:
 li a7, SYS_ps
 776:	48d9                	li	a7,22
 ecall
 778:	00000073          	ecall
 ret
 77c:	8082                	ret

000000000000077e <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 77e:	48dd                	li	a7,23
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 786:	48e1                	li	a7,24
 ecall
 788:	00000073          	ecall
 ret
 78c:	8082                	ret

000000000000078e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 78e:	1101                	addi	sp,sp,-32
 790:	ec06                	sd	ra,24(sp)
 792:	e822                	sd	s0,16(sp)
 794:	1000                	addi	s0,sp,32
 796:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 79a:	4605                	li	a2,1
 79c:	fef40593          	addi	a1,s0,-17
 7a0:	00000097          	auipc	ra,0x0
 7a4:	f56080e7          	jalr	-170(ra) # 6f6 <write>
}
 7a8:	60e2                	ld	ra,24(sp)
 7aa:	6442                	ld	s0,16(sp)
 7ac:	6105                	addi	sp,sp,32
 7ae:	8082                	ret

00000000000007b0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7b0:	7139                	addi	sp,sp,-64
 7b2:	fc06                	sd	ra,56(sp)
 7b4:	f822                	sd	s0,48(sp)
 7b6:	f426                	sd	s1,40(sp)
 7b8:	f04a                	sd	s2,32(sp)
 7ba:	ec4e                	sd	s3,24(sp)
 7bc:	0080                	addi	s0,sp,64
 7be:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7c0:	c299                	beqz	a3,7c6 <printint+0x16>
 7c2:	0805c963          	bltz	a1,854 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7c6:	2581                	sext.w	a1,a1
  neg = 0;
 7c8:	4881                	li	a7,0
 7ca:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 7ce:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7d0:	2601                	sext.w	a2,a2
 7d2:	00000517          	auipc	a0,0x0
 7d6:	5ae50513          	addi	a0,a0,1454 # d80 <digits>
 7da:	883a                	mv	a6,a4
 7dc:	2705                	addiw	a4,a4,1
 7de:	02c5f7bb          	remuw	a5,a1,a2
 7e2:	1782                	slli	a5,a5,0x20
 7e4:	9381                	srli	a5,a5,0x20
 7e6:	97aa                	add	a5,a5,a0
 7e8:	0007c783          	lbu	a5,0(a5)
 7ec:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7f0:	0005879b          	sext.w	a5,a1
 7f4:	02c5d5bb          	divuw	a1,a1,a2
 7f8:	0685                	addi	a3,a3,1
 7fa:	fec7f0e3          	bgeu	a5,a2,7da <printint+0x2a>
  if(neg)
 7fe:	00088c63          	beqz	a7,816 <printint+0x66>
    buf[i++] = '-';
 802:	fd070793          	addi	a5,a4,-48
 806:	00878733          	add	a4,a5,s0
 80a:	02d00793          	li	a5,45
 80e:	fef70823          	sb	a5,-16(a4)
 812:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 816:	02e05863          	blez	a4,846 <printint+0x96>
 81a:	fc040793          	addi	a5,s0,-64
 81e:	00e78933          	add	s2,a5,a4
 822:	fff78993          	addi	s3,a5,-1
 826:	99ba                	add	s3,s3,a4
 828:	377d                	addiw	a4,a4,-1
 82a:	1702                	slli	a4,a4,0x20
 82c:	9301                	srli	a4,a4,0x20
 82e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 832:	fff94583          	lbu	a1,-1(s2)
 836:	8526                	mv	a0,s1
 838:	00000097          	auipc	ra,0x0
 83c:	f56080e7          	jalr	-170(ra) # 78e <putc>
  while(--i >= 0)
 840:	197d                	addi	s2,s2,-1
 842:	ff3918e3          	bne	s2,s3,832 <printint+0x82>
}
 846:	70e2                	ld	ra,56(sp)
 848:	7442                	ld	s0,48(sp)
 84a:	74a2                	ld	s1,40(sp)
 84c:	7902                	ld	s2,32(sp)
 84e:	69e2                	ld	s3,24(sp)
 850:	6121                	addi	sp,sp,64
 852:	8082                	ret
    x = -xx;
 854:	40b005bb          	negw	a1,a1
    neg = 1;
 858:	4885                	li	a7,1
    x = -xx;
 85a:	bf85                	j	7ca <printint+0x1a>

000000000000085c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 85c:	715d                	addi	sp,sp,-80
 85e:	e486                	sd	ra,72(sp)
 860:	e0a2                	sd	s0,64(sp)
 862:	fc26                	sd	s1,56(sp)
 864:	f84a                	sd	s2,48(sp)
 866:	f44e                	sd	s3,40(sp)
 868:	f052                	sd	s4,32(sp)
 86a:	ec56                	sd	s5,24(sp)
 86c:	e85a                	sd	s6,16(sp)
 86e:	e45e                	sd	s7,8(sp)
 870:	e062                	sd	s8,0(sp)
 872:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 874:	0005c903          	lbu	s2,0(a1)
 878:	18090c63          	beqz	s2,a10 <vprintf+0x1b4>
 87c:	8aaa                	mv	s5,a0
 87e:	8bb2                	mv	s7,a2
 880:	00158493          	addi	s1,a1,1
  state = 0;
 884:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 886:	02500a13          	li	s4,37
 88a:	4b55                	li	s6,21
 88c:	a839                	j	8aa <vprintf+0x4e>
        putc(fd, c);
 88e:	85ca                	mv	a1,s2
 890:	8556                	mv	a0,s5
 892:	00000097          	auipc	ra,0x0
 896:	efc080e7          	jalr	-260(ra) # 78e <putc>
 89a:	a019                	j	8a0 <vprintf+0x44>
    } else if(state == '%'){
 89c:	01498d63          	beq	s3,s4,8b6 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 8a0:	0485                	addi	s1,s1,1
 8a2:	fff4c903          	lbu	s2,-1(s1)
 8a6:	16090563          	beqz	s2,a10 <vprintf+0x1b4>
    if(state == 0){
 8aa:	fe0999e3          	bnez	s3,89c <vprintf+0x40>
      if(c == '%'){
 8ae:	ff4910e3          	bne	s2,s4,88e <vprintf+0x32>
        state = '%';
 8b2:	89d2                	mv	s3,s4
 8b4:	b7f5                	j	8a0 <vprintf+0x44>
      if(c == 'd'){
 8b6:	13490263          	beq	s2,s4,9da <vprintf+0x17e>
 8ba:	f9d9079b          	addiw	a5,s2,-99
 8be:	0ff7f793          	zext.b	a5,a5
 8c2:	12fb6563          	bltu	s6,a5,9ec <vprintf+0x190>
 8c6:	f9d9079b          	addiw	a5,s2,-99
 8ca:	0ff7f713          	zext.b	a4,a5
 8ce:	10eb6f63          	bltu	s6,a4,9ec <vprintf+0x190>
 8d2:	00271793          	slli	a5,a4,0x2
 8d6:	00000717          	auipc	a4,0x0
 8da:	45270713          	addi	a4,a4,1106 # d28 <malloc+0x21a>
 8de:	97ba                	add	a5,a5,a4
 8e0:	439c                	lw	a5,0(a5)
 8e2:	97ba                	add	a5,a5,a4
 8e4:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8e6:	008b8913          	addi	s2,s7,8
 8ea:	4685                	li	a3,1
 8ec:	4629                	li	a2,10
 8ee:	000ba583          	lw	a1,0(s7)
 8f2:	8556                	mv	a0,s5
 8f4:	00000097          	auipc	ra,0x0
 8f8:	ebc080e7          	jalr	-324(ra) # 7b0 <printint>
 8fc:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8fe:	4981                	li	s3,0
 900:	b745                	j	8a0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 902:	008b8913          	addi	s2,s7,8
 906:	4681                	li	a3,0
 908:	4629                	li	a2,10
 90a:	000ba583          	lw	a1,0(s7)
 90e:	8556                	mv	a0,s5
 910:	00000097          	auipc	ra,0x0
 914:	ea0080e7          	jalr	-352(ra) # 7b0 <printint>
 918:	8bca                	mv	s7,s2
      state = 0;
 91a:	4981                	li	s3,0
 91c:	b751                	j	8a0 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 91e:	008b8913          	addi	s2,s7,8
 922:	4681                	li	a3,0
 924:	4641                	li	a2,16
 926:	000ba583          	lw	a1,0(s7)
 92a:	8556                	mv	a0,s5
 92c:	00000097          	auipc	ra,0x0
 930:	e84080e7          	jalr	-380(ra) # 7b0 <printint>
 934:	8bca                	mv	s7,s2
      state = 0;
 936:	4981                	li	s3,0
 938:	b7a5                	j	8a0 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 93a:	008b8c13          	addi	s8,s7,8
 93e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 942:	03000593          	li	a1,48
 946:	8556                	mv	a0,s5
 948:	00000097          	auipc	ra,0x0
 94c:	e46080e7          	jalr	-442(ra) # 78e <putc>
  putc(fd, 'x');
 950:	07800593          	li	a1,120
 954:	8556                	mv	a0,s5
 956:	00000097          	auipc	ra,0x0
 95a:	e38080e7          	jalr	-456(ra) # 78e <putc>
 95e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 960:	00000b97          	auipc	s7,0x0
 964:	420b8b93          	addi	s7,s7,1056 # d80 <digits>
 968:	03c9d793          	srli	a5,s3,0x3c
 96c:	97de                	add	a5,a5,s7
 96e:	0007c583          	lbu	a1,0(a5)
 972:	8556                	mv	a0,s5
 974:	00000097          	auipc	ra,0x0
 978:	e1a080e7          	jalr	-486(ra) # 78e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 97c:	0992                	slli	s3,s3,0x4
 97e:	397d                	addiw	s2,s2,-1
 980:	fe0914e3          	bnez	s2,968 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 984:	8be2                	mv	s7,s8
      state = 0;
 986:	4981                	li	s3,0
 988:	bf21                	j	8a0 <vprintf+0x44>
        s = va_arg(ap, char*);
 98a:	008b8993          	addi	s3,s7,8
 98e:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 992:	02090163          	beqz	s2,9b4 <vprintf+0x158>
        while(*s != 0){
 996:	00094583          	lbu	a1,0(s2)
 99a:	c9a5                	beqz	a1,a0a <vprintf+0x1ae>
          putc(fd, *s);
 99c:	8556                	mv	a0,s5
 99e:	00000097          	auipc	ra,0x0
 9a2:	df0080e7          	jalr	-528(ra) # 78e <putc>
          s++;
 9a6:	0905                	addi	s2,s2,1
        while(*s != 0){
 9a8:	00094583          	lbu	a1,0(s2)
 9ac:	f9e5                	bnez	a1,99c <vprintf+0x140>
        s = va_arg(ap, char*);
 9ae:	8bce                	mv	s7,s3
      state = 0;
 9b0:	4981                	li	s3,0
 9b2:	b5fd                	j	8a0 <vprintf+0x44>
          s = "(null)";
 9b4:	00000917          	auipc	s2,0x0
 9b8:	36c90913          	addi	s2,s2,876 # d20 <malloc+0x212>
        while(*s != 0){
 9bc:	02800593          	li	a1,40
 9c0:	bff1                	j	99c <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 9c2:	008b8913          	addi	s2,s7,8
 9c6:	000bc583          	lbu	a1,0(s7)
 9ca:	8556                	mv	a0,s5
 9cc:	00000097          	auipc	ra,0x0
 9d0:	dc2080e7          	jalr	-574(ra) # 78e <putc>
 9d4:	8bca                	mv	s7,s2
      state = 0;
 9d6:	4981                	li	s3,0
 9d8:	b5e1                	j	8a0 <vprintf+0x44>
        putc(fd, c);
 9da:	02500593          	li	a1,37
 9de:	8556                	mv	a0,s5
 9e0:	00000097          	auipc	ra,0x0
 9e4:	dae080e7          	jalr	-594(ra) # 78e <putc>
      state = 0;
 9e8:	4981                	li	s3,0
 9ea:	bd5d                	j	8a0 <vprintf+0x44>
        putc(fd, '%');
 9ec:	02500593          	li	a1,37
 9f0:	8556                	mv	a0,s5
 9f2:	00000097          	auipc	ra,0x0
 9f6:	d9c080e7          	jalr	-612(ra) # 78e <putc>
        putc(fd, c);
 9fa:	85ca                	mv	a1,s2
 9fc:	8556                	mv	a0,s5
 9fe:	00000097          	auipc	ra,0x0
 a02:	d90080e7          	jalr	-624(ra) # 78e <putc>
      state = 0;
 a06:	4981                	li	s3,0
 a08:	bd61                	j	8a0 <vprintf+0x44>
        s = va_arg(ap, char*);
 a0a:	8bce                	mv	s7,s3
      state = 0;
 a0c:	4981                	li	s3,0
 a0e:	bd49                	j	8a0 <vprintf+0x44>
    }
  }
}
 a10:	60a6                	ld	ra,72(sp)
 a12:	6406                	ld	s0,64(sp)
 a14:	74e2                	ld	s1,56(sp)
 a16:	7942                	ld	s2,48(sp)
 a18:	79a2                	ld	s3,40(sp)
 a1a:	7a02                	ld	s4,32(sp)
 a1c:	6ae2                	ld	s5,24(sp)
 a1e:	6b42                	ld	s6,16(sp)
 a20:	6ba2                	ld	s7,8(sp)
 a22:	6c02                	ld	s8,0(sp)
 a24:	6161                	addi	sp,sp,80
 a26:	8082                	ret

0000000000000a28 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a28:	715d                	addi	sp,sp,-80
 a2a:	ec06                	sd	ra,24(sp)
 a2c:	e822                	sd	s0,16(sp)
 a2e:	1000                	addi	s0,sp,32
 a30:	e010                	sd	a2,0(s0)
 a32:	e414                	sd	a3,8(s0)
 a34:	e818                	sd	a4,16(s0)
 a36:	ec1c                	sd	a5,24(s0)
 a38:	03043023          	sd	a6,32(s0)
 a3c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a40:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a44:	8622                	mv	a2,s0
 a46:	00000097          	auipc	ra,0x0
 a4a:	e16080e7          	jalr	-490(ra) # 85c <vprintf>
}
 a4e:	60e2                	ld	ra,24(sp)
 a50:	6442                	ld	s0,16(sp)
 a52:	6161                	addi	sp,sp,80
 a54:	8082                	ret

0000000000000a56 <printf>:

void
printf(const char *fmt, ...)
{
 a56:	711d                	addi	sp,sp,-96
 a58:	ec06                	sd	ra,24(sp)
 a5a:	e822                	sd	s0,16(sp)
 a5c:	1000                	addi	s0,sp,32
 a5e:	e40c                	sd	a1,8(s0)
 a60:	e810                	sd	a2,16(s0)
 a62:	ec14                	sd	a3,24(s0)
 a64:	f018                	sd	a4,32(s0)
 a66:	f41c                	sd	a5,40(s0)
 a68:	03043823          	sd	a6,48(s0)
 a6c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a70:	00840613          	addi	a2,s0,8
 a74:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a78:	85aa                	mv	a1,a0
 a7a:	4505                	li	a0,1
 a7c:	00000097          	auipc	ra,0x0
 a80:	de0080e7          	jalr	-544(ra) # 85c <vprintf>
}
 a84:	60e2                	ld	ra,24(sp)
 a86:	6442                	ld	s0,16(sp)
 a88:	6125                	addi	sp,sp,96
 a8a:	8082                	ret

0000000000000a8c <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 a8c:	1141                	addi	sp,sp,-16
 a8e:	e422                	sd	s0,8(sp)
 a90:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 a92:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a96:	00000797          	auipc	a5,0x0
 a9a:	5827b783          	ld	a5,1410(a5) # 1018 <freep>
 a9e:	a02d                	j	ac8 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 aa0:	4618                	lw	a4,8(a2)
 aa2:	9f2d                	addw	a4,a4,a1
 aa4:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 aa8:	6398                	ld	a4,0(a5)
 aaa:	6310                	ld	a2,0(a4)
 aac:	a83d                	j	aea <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 aae:	ff852703          	lw	a4,-8(a0)
 ab2:	9f31                	addw	a4,a4,a2
 ab4:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 ab6:	ff053683          	ld	a3,-16(a0)
 aba:	a091                	j	afe <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 abc:	6398                	ld	a4,0(a5)
 abe:	00e7e463          	bltu	a5,a4,ac6 <free+0x3a>
 ac2:	00e6ea63          	bltu	a3,a4,ad6 <free+0x4a>
{
 ac6:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ac8:	fed7fae3          	bgeu	a5,a3,abc <free+0x30>
 acc:	6398                	ld	a4,0(a5)
 ace:	00e6e463          	bltu	a3,a4,ad6 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ad2:	fee7eae3          	bltu	a5,a4,ac6 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 ad6:	ff852583          	lw	a1,-8(a0)
 ada:	6390                	ld	a2,0(a5)
 adc:	02059813          	slli	a6,a1,0x20
 ae0:	01c85713          	srli	a4,a6,0x1c
 ae4:	9736                	add	a4,a4,a3
 ae6:	fae60de3          	beq	a2,a4,aa0 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 aea:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 aee:	4790                	lw	a2,8(a5)
 af0:	02061593          	slli	a1,a2,0x20
 af4:	01c5d713          	srli	a4,a1,0x1c
 af8:	973e                	add	a4,a4,a5
 afa:	fae68ae3          	beq	a3,a4,aae <free+0x22>
        p->s.ptr = bp->s.ptr;
 afe:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 b00:	00000717          	auipc	a4,0x0
 b04:	50f73c23          	sd	a5,1304(a4) # 1018 <freep>
}
 b08:	6422                	ld	s0,8(sp)
 b0a:	0141                	addi	sp,sp,16
 b0c:	8082                	ret

0000000000000b0e <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 b0e:	7139                	addi	sp,sp,-64
 b10:	fc06                	sd	ra,56(sp)
 b12:	f822                	sd	s0,48(sp)
 b14:	f426                	sd	s1,40(sp)
 b16:	f04a                	sd	s2,32(sp)
 b18:	ec4e                	sd	s3,24(sp)
 b1a:	e852                	sd	s4,16(sp)
 b1c:	e456                	sd	s5,8(sp)
 b1e:	e05a                	sd	s6,0(sp)
 b20:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 b22:	02051493          	slli	s1,a0,0x20
 b26:	9081                	srli	s1,s1,0x20
 b28:	04bd                	addi	s1,s1,15
 b2a:	8091                	srli	s1,s1,0x4
 b2c:	0014899b          	addiw	s3,s1,1
 b30:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 b32:	00000517          	auipc	a0,0x0
 b36:	4e653503          	ld	a0,1254(a0) # 1018 <freep>
 b3a:	c515                	beqz	a0,b66 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 b3c:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 b3e:	4798                	lw	a4,8(a5)
 b40:	02977f63          	bgeu	a4,s1,b7e <malloc+0x70>
    if (nu < 4096)
 b44:	8a4e                	mv	s4,s3
 b46:	0009871b          	sext.w	a4,s3
 b4a:	6685                	lui	a3,0x1
 b4c:	00d77363          	bgeu	a4,a3,b52 <malloc+0x44>
 b50:	6a05                	lui	s4,0x1
 b52:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 b56:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 b5a:	00000917          	auipc	s2,0x0
 b5e:	4be90913          	addi	s2,s2,1214 # 1018 <freep>
    if (p == (char *)-1)
 b62:	5afd                	li	s5,-1
 b64:	a895                	j	bd8 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 b66:	00000797          	auipc	a5,0x0
 b6a:	53a78793          	addi	a5,a5,1338 # 10a0 <base>
 b6e:	00000717          	auipc	a4,0x0
 b72:	4af73523          	sd	a5,1194(a4) # 1018 <freep>
 b76:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 b78:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 b7c:	b7e1                	j	b44 <malloc+0x36>
            if (p->s.size == nunits)
 b7e:	02e48c63          	beq	s1,a4,bb6 <malloc+0xa8>
                p->s.size -= nunits;
 b82:	4137073b          	subw	a4,a4,s3
 b86:	c798                	sw	a4,8(a5)
                p += p->s.size;
 b88:	02071693          	slli	a3,a4,0x20
 b8c:	01c6d713          	srli	a4,a3,0x1c
 b90:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 b92:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 b96:	00000717          	auipc	a4,0x0
 b9a:	48a73123          	sd	a0,1154(a4) # 1018 <freep>
            return (void *)(p + 1);
 b9e:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 ba2:	70e2                	ld	ra,56(sp)
 ba4:	7442                	ld	s0,48(sp)
 ba6:	74a2                	ld	s1,40(sp)
 ba8:	7902                	ld	s2,32(sp)
 baa:	69e2                	ld	s3,24(sp)
 bac:	6a42                	ld	s4,16(sp)
 bae:	6aa2                	ld	s5,8(sp)
 bb0:	6b02                	ld	s6,0(sp)
 bb2:	6121                	addi	sp,sp,64
 bb4:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 bb6:	6398                	ld	a4,0(a5)
 bb8:	e118                	sd	a4,0(a0)
 bba:	bff1                	j	b96 <malloc+0x88>
    hp->s.size = nu;
 bbc:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 bc0:	0541                	addi	a0,a0,16
 bc2:	00000097          	auipc	ra,0x0
 bc6:	eca080e7          	jalr	-310(ra) # a8c <free>
    return freep;
 bca:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 bce:	d971                	beqz	a0,ba2 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 bd0:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 bd2:	4798                	lw	a4,8(a5)
 bd4:	fa9775e3          	bgeu	a4,s1,b7e <malloc+0x70>
        if (p == freep)
 bd8:	00093703          	ld	a4,0(s2)
 bdc:	853e                	mv	a0,a5
 bde:	fef719e3          	bne	a4,a5,bd0 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 be2:	8552                	mv	a0,s4
 be4:	00000097          	auipc	ra,0x0
 be8:	b7a080e7          	jalr	-1158(ra) # 75e <sbrk>
    if (p == (char *)-1)
 bec:	fd5518e3          	bne	a0,s5,bbc <malloc+0xae>
                return 0;
 bf0:	4501                	li	a0,0
 bf2:	bf45                	j	ba2 <malloc+0x94>
