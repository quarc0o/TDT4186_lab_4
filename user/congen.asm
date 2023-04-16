
user/_congen:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:
#include "user/user.h"

#define N 5

void print(const char *s)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
    write(1, s, strlen(s));
   c:	00000097          	auipc	ra,0x0
  10:	572080e7          	jalr	1394(ra) # 57e <strlen>
  14:	0005061b          	sext.w	a2,a0
  18:	85a6                	mv	a1,s1
  1a:	4505                	li	a0,1
  1c:	00000097          	auipc	ra,0x0
  20:	7a6080e7          	jalr	1958(ra) # 7c2 <write>
}
  24:	60e2                	ld	ra,24(sp)
  26:	6442                	ld	s0,16(sp)
  28:	64a2                	ld	s1,8(sp)
  2a:	6105                	addi	sp,sp,32
  2c:	8082                	ret

000000000000002e <forktest>:

void forktest(void)
{
  2e:	7139                	addi	sp,sp,-64
  30:	fc06                	sd	ra,56(sp)
  32:	f822                	sd	s0,48(sp)
  34:	f426                	sd	s1,40(sp)
  36:	f04a                	sd	s2,32(sp)
  38:	ec4e                	sd	s3,24(sp)
  3a:	e852                	sd	s4,16(sp)
  3c:	e456                	sd	s5,8(sp)
  3e:	e05a                	sd	s6,0(sp)
  40:	0080                	addi	s0,sp,64
    int n, pid;

    print("fork test\n");
  42:	00001517          	auipc	a0,0x1
  46:	c7e50513          	addi	a0,a0,-898 # cc0 <malloc+0xe6>
  4a:	00000097          	auipc	ra,0x0
  4e:	fb6080e7          	jalr	-74(ra) # 0 <print>

    for (n = 0; n < N; n++)
  52:	4a01                	li	s4,0
  54:	4495                	li	s1,5
    {
        pid = fork();
  56:	00000097          	auipc	ra,0x0
  5a:	744080e7          	jalr	1860(ra) # 79a <fork>
  5e:	892a                	mv	s2,a0
        if (pid < 0)
            break;
        if (pid == 0)
  60:	00a05563          	blez	a0,6a <forktest+0x3c>
    for (n = 0; n < N; n++)
  64:	2a05                	addiw	s4,s4,1
  66:	fe9a18e3          	bne	s4,s1,56 <forktest+0x28>
            break;
    }

    for (unsigned long long i = 0; i < 1000; i++)
  6a:	4481                	li	s1,0
        {
            printf("CHILD %d: %d\n", n, i);
        }
        else
        {
            printf("PARENT: %d\n", i);
  6c:	00001b17          	auipc	s6,0x1
  70:	c74b0b13          	addi	s6,s6,-908 # ce0 <malloc+0x106>
            printf("CHILD %d: %d\n", n, i);
  74:	00001a97          	auipc	s5,0x1
  78:	c5ca8a93          	addi	s5,s5,-932 # cd0 <malloc+0xf6>
    for (unsigned long long i = 0; i < 1000; i++)
  7c:	3e800993          	li	s3,1000
  80:	a811                	j	94 <forktest+0x66>
            printf("PARENT: %d\n", i);
  82:	85a6                	mv	a1,s1
  84:	855a                	mv	a0,s6
  86:	00001097          	auipc	ra,0x1
  8a:	a9c080e7          	jalr	-1380(ra) # b22 <printf>
    for (unsigned long long i = 0; i < 1000; i++)
  8e:	0485                	addi	s1,s1,1
  90:	01348c63          	beq	s1,s3,a8 <forktest+0x7a>
        if (pid == 0)
  94:	fe0917e3          	bnez	s2,82 <forktest+0x54>
            printf("CHILD %d: %d\n", n, i);
  98:	8626                	mv	a2,s1
  9a:	85d2                	mv	a1,s4
  9c:	8556                	mv	a0,s5
  9e:	00001097          	auipc	ra,0x1
  a2:	a84080e7          	jalr	-1404(ra) # b22 <printf>
  a6:	b7e5                	j	8e <forktest+0x60>
        }
    }

    print("fork test OK\n");
  a8:	00001517          	auipc	a0,0x1
  ac:	c4850513          	addi	a0,a0,-952 # cf0 <malloc+0x116>
  b0:	00000097          	auipc	ra,0x0
  b4:	f50080e7          	jalr	-176(ra) # 0 <print>
}
  b8:	70e2                	ld	ra,56(sp)
  ba:	7442                	ld	s0,48(sp)
  bc:	74a2                	ld	s1,40(sp)
  be:	7902                	ld	s2,32(sp)
  c0:	69e2                	ld	s3,24(sp)
  c2:	6a42                	ld	s4,16(sp)
  c4:	6aa2                	ld	s5,8(sp)
  c6:	6b02                	ld	s6,0(sp)
  c8:	6121                	addi	sp,sp,64
  ca:	8082                	ret

00000000000000cc <main>:

int main(void)
{
  cc:	1141                	addi	sp,sp,-16
  ce:	e406                	sd	ra,8(sp)
  d0:	e022                	sd	s0,0(sp)
  d2:	0800                	addi	s0,sp,16
    forktest();
  d4:	00000097          	auipc	ra,0x0
  d8:	f5a080e7          	jalr	-166(ra) # 2e <forktest>
    exit(0);
  dc:	4501                	li	a0,0
  de:	00000097          	auipc	ra,0x0
  e2:	6c4080e7          	jalr	1732(ra) # 7a2 <exit>

00000000000000e6 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  e6:	1141                	addi	sp,sp,-16
  e8:	e422                	sd	s0,8(sp)
  ea:	0800                	addi	s0,sp,16
    lk->name = name;
  ec:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  ee:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  f2:	57fd                	li	a5,-1
  f4:	00f50823          	sb	a5,16(a0)
}
  f8:	6422                	ld	s0,8(sp)
  fa:	0141                	addi	sp,sp,16
  fc:	8082                	ret

00000000000000fe <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  fe:	00054783          	lbu	a5,0(a0)
 102:	e399                	bnez	a5,108 <holding+0xa>
 104:	4501                	li	a0,0
}
 106:	8082                	ret
{
 108:	1101                	addi	sp,sp,-32
 10a:	ec06                	sd	ra,24(sp)
 10c:	e822                	sd	s0,16(sp)
 10e:	e426                	sd	s1,8(sp)
 110:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
 112:	01054483          	lbu	s1,16(a0)
 116:	00000097          	auipc	ra,0x0
 11a:	2dc080e7          	jalr	732(ra) # 3f2 <twhoami>
 11e:	2501                	sext.w	a0,a0
 120:	40a48533          	sub	a0,s1,a0
 124:	00153513          	seqz	a0,a0
}
 128:	60e2                	ld	ra,24(sp)
 12a:	6442                	ld	s0,16(sp)
 12c:	64a2                	ld	s1,8(sp)
 12e:	6105                	addi	sp,sp,32
 130:	8082                	ret

0000000000000132 <acquire>:

void acquire(struct lock *lk)
{
 132:	7179                	addi	sp,sp,-48
 134:	f406                	sd	ra,40(sp)
 136:	f022                	sd	s0,32(sp)
 138:	ec26                	sd	s1,24(sp)
 13a:	e84a                	sd	s2,16(sp)
 13c:	e44e                	sd	s3,8(sp)
 13e:	e052                	sd	s4,0(sp)
 140:	1800                	addi	s0,sp,48
 142:	8a2a                	mv	s4,a0
    if (holding(lk))
 144:	00000097          	auipc	ra,0x0
 148:	fba080e7          	jalr	-70(ra) # fe <holding>
 14c:	e919                	bnez	a0,162 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 14e:	ffca7493          	andi	s1,s4,-4
 152:	003a7913          	andi	s2,s4,3
 156:	0039191b          	slliw	s2,s2,0x3
 15a:	4985                	li	s3,1
 15c:	012999bb          	sllw	s3,s3,s2
 160:	a015                	j	184 <acquire+0x52>
        printf("re-acquiring lock we already hold");
 162:	00001517          	auipc	a0,0x1
 166:	b9e50513          	addi	a0,a0,-1122 # d00 <malloc+0x126>
 16a:	00001097          	auipc	ra,0x1
 16e:	9b8080e7          	jalr	-1608(ra) # b22 <printf>
        exit(-1);
 172:	557d                	li	a0,-1
 174:	00000097          	auipc	ra,0x0
 178:	62e080e7          	jalr	1582(ra) # 7a2 <exit>
    {
        // give up the cpu for other threads
        tyield();
 17c:	00000097          	auipc	ra,0x0
 180:	252080e7          	jalr	594(ra) # 3ce <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 184:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 188:	0127d7bb          	srlw	a5,a5,s2
 18c:	0ff7f793          	zext.b	a5,a5
 190:	f7f5                	bnez	a5,17c <acquire+0x4a>
    }

    __sync_synchronize();
 192:	0ff0000f          	fence

    lk->tid = twhoami();
 196:	00000097          	auipc	ra,0x0
 19a:	25c080e7          	jalr	604(ra) # 3f2 <twhoami>
 19e:	00aa0823          	sb	a0,16(s4)
}
 1a2:	70a2                	ld	ra,40(sp)
 1a4:	7402                	ld	s0,32(sp)
 1a6:	64e2                	ld	s1,24(sp)
 1a8:	6942                	ld	s2,16(sp)
 1aa:	69a2                	ld	s3,8(sp)
 1ac:	6a02                	ld	s4,0(sp)
 1ae:	6145                	addi	sp,sp,48
 1b0:	8082                	ret

00000000000001b2 <release>:

void release(struct lock *lk)
{
 1b2:	1101                	addi	sp,sp,-32
 1b4:	ec06                	sd	ra,24(sp)
 1b6:	e822                	sd	s0,16(sp)
 1b8:	e426                	sd	s1,8(sp)
 1ba:	1000                	addi	s0,sp,32
 1bc:	84aa                	mv	s1,a0
    if (!holding(lk))
 1be:	00000097          	auipc	ra,0x0
 1c2:	f40080e7          	jalr	-192(ra) # fe <holding>
 1c6:	c11d                	beqz	a0,1ec <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 1c8:	57fd                	li	a5,-1
 1ca:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 1ce:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 1d2:	0ff0000f          	fence
 1d6:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 1da:	00000097          	auipc	ra,0x0
 1de:	1f4080e7          	jalr	500(ra) # 3ce <tyield>
}
 1e2:	60e2                	ld	ra,24(sp)
 1e4:	6442                	ld	s0,16(sp)
 1e6:	64a2                	ld	s1,8(sp)
 1e8:	6105                	addi	sp,sp,32
 1ea:	8082                	ret
        printf("releasing lock we are not holding");
 1ec:	00001517          	auipc	a0,0x1
 1f0:	b3c50513          	addi	a0,a0,-1220 # d28 <malloc+0x14e>
 1f4:	00001097          	auipc	ra,0x1
 1f8:	92e080e7          	jalr	-1746(ra) # b22 <printf>
        exit(-1);
 1fc:	557d                	li	a0,-1
 1fe:	00000097          	auipc	ra,0x0
 202:	5a4080e7          	jalr	1444(ra) # 7a2 <exit>

0000000000000206 <tsched>:
void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
 206:	4685                	li	a3,1
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 208:	00001617          	auipc	a2,0x1
 20c:	e1860613          	addi	a2,a2,-488 # 1020 <threads>
 210:	450d                	li	a0,3
    for (int i = 1; i < 16; i++) {
 212:	45c1                	li	a1,16
 214:	a021                	j	21c <tsched+0x16>
 216:	2685                	addiw	a3,a3,1
 218:	08b68c63          	beq	a3,a1,2b0 <tsched+0xaa>
        int next_index = (current_index + i) % 16;
 21c:	41f6d71b          	sraiw	a4,a3,0x1f
 220:	01c7571b          	srliw	a4,a4,0x1c
 224:	00d707bb          	addw	a5,a4,a3
 228:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 22a:	9f99                	subw	a5,a5,a4
 22c:	078e                	slli	a5,a5,0x3
 22e:	97b2                	add	a5,a5,a2
 230:	639c                	ld	a5,0(a5)
 232:	d3f5                	beqz	a5,216 <tsched+0x10>
 234:	5fb8                	lw	a4,120(a5)
 236:	fea710e3          	bne	a4,a0,216 <tsched+0x10>

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
 23a:	00001717          	auipc	a4,0x1
 23e:	de673703          	ld	a4,-538(a4) # 1020 <threads>
 242:	5f30                	lw	a2,120(a4)
 244:	468d                	li	a3,3
 246:	06d60363          	beq	a2,a3,2ac <tsched+0xa6>
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
 24a:	c3a5                	beqz	a5,2aa <tsched+0xa4>
{
 24c:	1101                	addi	sp,sp,-32
 24e:	ec06                	sd	ra,24(sp)
 250:	e822                	sd	s0,16(sp)
 252:	e426                	sd	s1,8(sp)
 254:	e04a                	sd	s2,0(sp)
 256:	1000                	addi	s0,sp,32
        struct thread *prev_thread = current_thread;
 258:	00001497          	auipc	s1,0x1
 25c:	db848493          	addi	s1,s1,-584 # 1010 <current_thread>
 260:	0004b903          	ld	s2,0(s1)
        current_thread = next_thread;
 264:	e09c                	sd	a5,0(s1)
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
 266:	0007c603          	lbu	a2,0(a5)
 26a:	00094583          	lbu	a1,0(s2)
 26e:	00001517          	auipc	a0,0x1
 272:	ae250513          	addi	a0,a0,-1310 # d50 <malloc+0x176>
 276:	00001097          	auipc	ra,0x1
 27a:	8ac080e7          	jalr	-1876(ra) # b22 <printf>
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 27e:	608c                	ld	a1,0(s1)
 280:	05a1                	addi	a1,a1,8
 282:	00890513          	addi	a0,s2,8
 286:	00000097          	auipc	ra,0x0
 28a:	184080e7          	jalr	388(ra) # 40a <tswtch>
        printf("Thread switch complete\n");
 28e:	00001517          	auipc	a0,0x1
 292:	aea50513          	addi	a0,a0,-1302 # d78 <malloc+0x19e>
 296:	00001097          	auipc	ra,0x1
 29a:	88c080e7          	jalr	-1908(ra) # b22 <printf>
    }
}
 29e:	60e2                	ld	ra,24(sp)
 2a0:	6442                	ld	s0,16(sp)
 2a2:	64a2                	ld	s1,8(sp)
 2a4:	6902                	ld	s2,0(sp)
 2a6:	6105                	addi	sp,sp,32
 2a8:	8082                	ret
 2aa:	8082                	ret
        if (threads[current_index + i]->state != RUNNABLE) {
 2ac:	87ba                	mv	a5,a4
 2ae:	bf79                	j	24c <tsched+0x46>
 2b0:	00001797          	auipc	a5,0x1
 2b4:	d707b783          	ld	a5,-656(a5) # 1020 <threads>
 2b8:	5fb4                	lw	a3,120(a5)
 2ba:	470d                	li	a4,3
 2bc:	f8e688e3          	beq	a3,a4,24c <tsched+0x46>
 2c0:	8082                	ret

00000000000002c2 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 2c2:	7179                	addi	sp,sp,-48
 2c4:	f406                	sd	ra,40(sp)
 2c6:	f022                	sd	s0,32(sp)
 2c8:	ec26                	sd	s1,24(sp)
 2ca:	e84a                	sd	s2,16(sp)
 2cc:	e44e                	sd	s3,8(sp)
 2ce:	1800                	addi	s0,sp,48
 2d0:	84aa                	mv	s1,a0
 2d2:	89b2                	mv	s3,a2
 2d4:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 2d6:	09000513          	li	a0,144
 2da:	00001097          	auipc	ra,0x1
 2de:	900080e7          	jalr	-1792(ra) # bda <malloc>
 2e2:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 2e4:	478d                	li	a5,3
 2e6:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 2e8:	609c                	ld	a5,0(s1)
 2ea:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 2ee:	609c                	ld	a5,0(s1)
 2f0:	0927b023          	sd	s2,128(a5)
    (*thread)->tid = next_tid++;
 2f4:	00001717          	auipc	a4,0x1
 2f8:	d0c70713          	addi	a4,a4,-756 # 1000 <next_tid>
 2fc:	431c                	lw	a5,0(a4)
 2fe:	0017869b          	addiw	a3,a5,1
 302:	c314                	sw	a3,0(a4)
 304:	6098                	ld	a4,0(s1)
 306:	00f70023          	sb	a5,0(a4)
    //(*thread)->tid = func;
    for (int i = 0; i < 16; i++) {
 30a:	00001717          	auipc	a4,0x1
 30e:	d1670713          	addi	a4,a4,-746 # 1020 <threads>
 312:	4781                	li	a5,0
 314:	4641                	li	a2,16
    if (threads[i] == NULL) {
 316:	6314                	ld	a3,0(a4)
 318:	ce81                	beqz	a3,330 <tcreate+0x6e>
    for (int i = 0; i < 16; i++) {
 31a:	2785                	addiw	a5,a5,1
 31c:	0721                	addi	a4,a4,8
 31e:	fec79ce3          	bne	a5,a2,316 <tcreate+0x54>
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}
 322:	70a2                	ld	ra,40(sp)
 324:	7402                	ld	s0,32(sp)
 326:	64e2                	ld	s1,24(sp)
 328:	6942                	ld	s2,16(sp)
 32a:	69a2                	ld	s3,8(sp)
 32c:	6145                	addi	sp,sp,48
 32e:	8082                	ret
        threads[i] = *thread;
 330:	6094                	ld	a3,0(s1)
 332:	078e                	slli	a5,a5,0x3
 334:	00001717          	auipc	a4,0x1
 338:	cec70713          	addi	a4,a4,-788 # 1020 <threads>
 33c:	97ba                	add	a5,a5,a4
 33e:	e394                	sd	a3,0(a5)
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
 340:	0006c583          	lbu	a1,0(a3)
 344:	00001517          	auipc	a0,0x1
 348:	a4c50513          	addi	a0,a0,-1460 # d90 <malloc+0x1b6>
 34c:	00000097          	auipc	ra,0x0
 350:	7d6080e7          	jalr	2006(ra) # b22 <printf>
        break;
 354:	b7f9                	j	322 <tcreate+0x60>

0000000000000356 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 356:	7179                	addi	sp,sp,-48
 358:	f406                	sd	ra,40(sp)
 35a:	f022                	sd	s0,32(sp)
 35c:	ec26                	sd	s1,24(sp)
 35e:	e84a                	sd	s2,16(sp)
 360:	e44e                	sd	s3,8(sp)
 362:	1800                	addi	s0,sp,48
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
 364:	00001797          	auipc	a5,0x1
 368:	cbc78793          	addi	a5,a5,-836 # 1020 <threads>
 36c:	00001697          	auipc	a3,0x1
 370:	d3468693          	addi	a3,a3,-716 # 10a0 <base>
 374:	a021                	j	37c <tjoin+0x26>
 376:	07a1                	addi	a5,a5,8
 378:	04d78763          	beq	a5,a3,3c6 <tjoin+0x70>
        if (threads[i] && threads[i]->tid == tid) {
 37c:	6384                	ld	s1,0(a5)
 37e:	dce5                	beqz	s1,376 <tjoin+0x20>
 380:	0004c703          	lbu	a4,0(s1)
 384:	fea719e3          	bne	a4,a0,376 <tjoin+0x20>

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
 388:	5cb8                	lw	a4,120(s1)
 38a:	4799                	li	a5,6
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 38c:	00001997          	auipc	s3,0x1
 390:	a3498993          	addi	s3,s3,-1484 # dc0 <malloc+0x1e6>
    while (target_thread->state != EXITED) {
 394:	4919                	li	s2,6
 396:	02f70a63          	beq	a4,a5,3ca <tjoin+0x74>
        printf("Waiting for thread %d to exit\n", target_thread->tid);
 39a:	0004c583          	lbu	a1,0(s1)
 39e:	854e                	mv	a0,s3
 3a0:	00000097          	auipc	ra,0x0
 3a4:	782080e7          	jalr	1922(ra) # b22 <printf>
        tsched();
 3a8:	00000097          	auipc	ra,0x0
 3ac:	e5e080e7          	jalr	-418(ra) # 206 <tsched>
    while (target_thread->state != EXITED) {
 3b0:	5cbc                	lw	a5,120(s1)
 3b2:	ff2794e3          	bne	a5,s2,39a <tjoin+0x44>

    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
 3b6:	4501                	li	a0,0
}
 3b8:	70a2                	ld	ra,40(sp)
 3ba:	7402                	ld	s0,32(sp)
 3bc:	64e2                	ld	s1,24(sp)
 3be:	6942                	ld	s2,16(sp)
 3c0:	69a2                	ld	s3,8(sp)
 3c2:	6145                	addi	sp,sp,48
 3c4:	8082                	ret
        return -1;
 3c6:	557d                	li	a0,-1
 3c8:	bfc5                	j	3b8 <tjoin+0x62>
    return 0;
 3ca:	4501                	li	a0,0
 3cc:	b7f5                	j	3b8 <tjoin+0x62>

00000000000003ce <tyield>:


void tyield()
{
 3ce:	1141                	addi	sp,sp,-16
 3d0:	e406                	sd	ra,8(sp)
 3d2:	e022                	sd	s0,0(sp)
 3d4:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 3d6:	00001797          	auipc	a5,0x1
 3da:	c3a7b783          	ld	a5,-966(a5) # 1010 <current_thread>
 3de:	470d                	li	a4,3
 3e0:	dfb8                	sw	a4,120(a5)
    tsched();
 3e2:	00000097          	auipc	ra,0x0
 3e6:	e24080e7          	jalr	-476(ra) # 206 <tsched>
}
 3ea:	60a2                	ld	ra,8(sp)
 3ec:	6402                	ld	s0,0(sp)
 3ee:	0141                	addi	sp,sp,16
 3f0:	8082                	ret

00000000000003f2 <twhoami>:

uint8 twhoami()
{
 3f2:	1141                	addi	sp,sp,-16
 3f4:	e422                	sd	s0,8(sp)
 3f6:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
 3f8:	00001797          	auipc	a5,0x1
 3fc:	c187b783          	ld	a5,-1000(a5) # 1010 <current_thread>
 400:	0007c503          	lbu	a0,0(a5)
 404:	6422                	ld	s0,8(sp)
 406:	0141                	addi	sp,sp,16
 408:	8082                	ret

000000000000040a <tswtch>:
 40a:	00153023          	sd	ra,0(a0)
 40e:	00253423          	sd	sp,8(a0)
 412:	e900                	sd	s0,16(a0)
 414:	ed04                	sd	s1,24(a0)
 416:	03253023          	sd	s2,32(a0)
 41a:	03353423          	sd	s3,40(a0)
 41e:	03453823          	sd	s4,48(a0)
 422:	03553c23          	sd	s5,56(a0)
 426:	05653023          	sd	s6,64(a0)
 42a:	05753423          	sd	s7,72(a0)
 42e:	05853823          	sd	s8,80(a0)
 432:	05953c23          	sd	s9,88(a0)
 436:	07a53023          	sd	s10,96(a0)
 43a:	07b53423          	sd	s11,104(a0)
 43e:	0005b083          	ld	ra,0(a1)
 442:	0085b103          	ld	sp,8(a1)
 446:	6980                	ld	s0,16(a1)
 448:	6d84                	ld	s1,24(a1)
 44a:	0205b903          	ld	s2,32(a1)
 44e:	0285b983          	ld	s3,40(a1)
 452:	0305ba03          	ld	s4,48(a1)
 456:	0385ba83          	ld	s5,56(a1)
 45a:	0405bb03          	ld	s6,64(a1)
 45e:	0485bb83          	ld	s7,72(a1)
 462:	0505bc03          	ld	s8,80(a1)
 466:	0585bc83          	ld	s9,88(a1)
 46a:	0605bd03          	ld	s10,96(a1)
 46e:	0685bd83          	ld	s11,104(a1)
 472:	8082                	ret

0000000000000474 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 474:	715d                	addi	sp,sp,-80
 476:	e486                	sd	ra,72(sp)
 478:	e0a2                	sd	s0,64(sp)
 47a:	fc26                	sd	s1,56(sp)
 47c:	f84a                	sd	s2,48(sp)
 47e:	f44e                	sd	s3,40(sp)
 480:	f052                	sd	s4,32(sp)
 482:	ec56                	sd	s5,24(sp)
 484:	e85a                	sd	s6,16(sp)
 486:	e45e                	sd	s7,8(sp)
 488:	0880                	addi	s0,sp,80
 48a:	892a                	mv	s2,a0
 48c:	89ae                	mv	s3,a1
    printf("Entering _main function\n");
 48e:	00001517          	auipc	a0,0x1
 492:	95250513          	addi	a0,a0,-1710 # de0 <malloc+0x206>
 496:	00000097          	auipc	ra,0x0
 49a:	68c080e7          	jalr	1676(ra) # b22 <printf>
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 49e:	09000513          	li	a0,144
 4a2:	00000097          	auipc	ra,0x0
 4a6:	738080e7          	jalr	1848(ra) # bda <malloc>

    main_thread->tid = 0;
 4aa:	00050023          	sb	zero,0(a0)
    main_thread->state = RUNNING;
 4ae:	4791                	li	a5,4
 4b0:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 4b2:	00001797          	auipc	a5,0x1
 4b6:	b4a7bf23          	sd	a0,-1186(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 4ba:	00001a17          	auipc	s4,0x1
 4be:	b66a0a13          	addi	s4,s4,-1178 # 1020 <threads>
 4c2:	00001497          	auipc	s1,0x1
 4c6:	bde48493          	addi	s1,s1,-1058 # 10a0 <base>
    current_thread = main_thread;
 4ca:	87d2                	mv	a5,s4
        threads[i] = NULL;
 4cc:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 4d0:	07a1                	addi	a5,a5,8
 4d2:	fe979de3          	bne	a5,s1,4cc <_main+0x58>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 4d6:	00001797          	auipc	a5,0x1
 4da:	b4a7b523          	sd	a0,-1206(a5) # 1020 <threads>
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 4de:	85ce                	mv	a1,s3
 4e0:	854a                	mv	a0,s2
 4e2:	00000097          	auipc	ra,0x0
 4e6:	bea080e7          	jalr	-1046(ra) # cc <main>
 4ea:	8baa                	mv	s7,a0

    // Wait for all other threads to finish
    int running_threads = 1;
    while (running_threads > 0) {
        running_threads = 0;
 4ec:	4b01                	li	s6,0
        for (int i = 0; i < 16; i++) {
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 4ee:	4999                	li	s3,6
                running_threads++;
            }
        }
        printf("Number of running threads: %d\n", running_threads);
 4f0:	00001a97          	auipc	s5,0x1
 4f4:	910a8a93          	addi	s5,s5,-1776 # e00 <malloc+0x226>
 4f8:	a03d                	j	526 <_main+0xb2>
        for (int i = 0; i < 16; i++) {
 4fa:	07a1                	addi	a5,a5,8
 4fc:	00978963          	beq	a5,s1,50e <_main+0x9a>
            if (threads[i] != NULL && threads[i]->state != EXITED) {
 500:	6398                	ld	a4,0(a5)
 502:	df65                	beqz	a4,4fa <_main+0x86>
 504:	5f38                	lw	a4,120(a4)
 506:	ff370ae3          	beq	a4,s3,4fa <_main+0x86>
                running_threads++;
 50a:	2905                	addiw	s2,s2,1
 50c:	b7fd                	j	4fa <_main+0x86>
        printf("Number of running threads: %d\n", running_threads);
 50e:	85ca                	mv	a1,s2
 510:	8556                	mv	a0,s5
 512:	00000097          	auipc	ra,0x0
 516:	610080e7          	jalr	1552(ra) # b22 <printf>
        if (running_threads > 0) {
 51a:	01205963          	blez	s2,52c <_main+0xb8>
            tsched(); // Schedule another thread to run
 51e:	00000097          	auipc	ra,0x0
 522:	ce8080e7          	jalr	-792(ra) # 206 <tsched>
    current_thread = main_thread;
 526:	87d2                	mv	a5,s4
        running_threads = 0;
 528:	895a                	mv	s2,s6
 52a:	bfd9                	j	500 <_main+0x8c>
        }
    }

    exit(res);
 52c:	855e                	mv	a0,s7
 52e:	00000097          	auipc	ra,0x0
 532:	274080e7          	jalr	628(ra) # 7a2 <exit>

0000000000000536 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 536:	1141                	addi	sp,sp,-16
 538:	e422                	sd	s0,8(sp)
 53a:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 53c:	87aa                	mv	a5,a0
 53e:	0585                	addi	a1,a1,1
 540:	0785                	addi	a5,a5,1
 542:	fff5c703          	lbu	a4,-1(a1)
 546:	fee78fa3          	sb	a4,-1(a5)
 54a:	fb75                	bnez	a4,53e <strcpy+0x8>
        ;
    return os;
}
 54c:	6422                	ld	s0,8(sp)
 54e:	0141                	addi	sp,sp,16
 550:	8082                	ret

0000000000000552 <strcmp>:

int strcmp(const char *p, const char *q)
{
 552:	1141                	addi	sp,sp,-16
 554:	e422                	sd	s0,8(sp)
 556:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 558:	00054783          	lbu	a5,0(a0)
 55c:	cb91                	beqz	a5,570 <strcmp+0x1e>
 55e:	0005c703          	lbu	a4,0(a1)
 562:	00f71763          	bne	a4,a5,570 <strcmp+0x1e>
        p++, q++;
 566:	0505                	addi	a0,a0,1
 568:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 56a:	00054783          	lbu	a5,0(a0)
 56e:	fbe5                	bnez	a5,55e <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 570:	0005c503          	lbu	a0,0(a1)
}
 574:	40a7853b          	subw	a0,a5,a0
 578:	6422                	ld	s0,8(sp)
 57a:	0141                	addi	sp,sp,16
 57c:	8082                	ret

000000000000057e <strlen>:

uint strlen(const char *s)
{
 57e:	1141                	addi	sp,sp,-16
 580:	e422                	sd	s0,8(sp)
 582:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 584:	00054783          	lbu	a5,0(a0)
 588:	cf91                	beqz	a5,5a4 <strlen+0x26>
 58a:	0505                	addi	a0,a0,1
 58c:	87aa                	mv	a5,a0
 58e:	86be                	mv	a3,a5
 590:	0785                	addi	a5,a5,1
 592:	fff7c703          	lbu	a4,-1(a5)
 596:	ff65                	bnez	a4,58e <strlen+0x10>
 598:	40a6853b          	subw	a0,a3,a0
 59c:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 59e:	6422                	ld	s0,8(sp)
 5a0:	0141                	addi	sp,sp,16
 5a2:	8082                	ret
    for (n = 0; s[n]; n++)
 5a4:	4501                	li	a0,0
 5a6:	bfe5                	j	59e <strlen+0x20>

00000000000005a8 <memset>:

void *
memset(void *dst, int c, uint n)
{
 5a8:	1141                	addi	sp,sp,-16
 5aa:	e422                	sd	s0,8(sp)
 5ac:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 5ae:	ca19                	beqz	a2,5c4 <memset+0x1c>
 5b0:	87aa                	mv	a5,a0
 5b2:	1602                	slli	a2,a2,0x20
 5b4:	9201                	srli	a2,a2,0x20
 5b6:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 5ba:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 5be:	0785                	addi	a5,a5,1
 5c0:	fee79de3          	bne	a5,a4,5ba <memset+0x12>
    }
    return dst;
}
 5c4:	6422                	ld	s0,8(sp)
 5c6:	0141                	addi	sp,sp,16
 5c8:	8082                	ret

00000000000005ca <strchr>:

char *
strchr(const char *s, char c)
{
 5ca:	1141                	addi	sp,sp,-16
 5cc:	e422                	sd	s0,8(sp)
 5ce:	0800                	addi	s0,sp,16
    for (; *s; s++)
 5d0:	00054783          	lbu	a5,0(a0)
 5d4:	cb99                	beqz	a5,5ea <strchr+0x20>
        if (*s == c)
 5d6:	00f58763          	beq	a1,a5,5e4 <strchr+0x1a>
    for (; *s; s++)
 5da:	0505                	addi	a0,a0,1
 5dc:	00054783          	lbu	a5,0(a0)
 5e0:	fbfd                	bnez	a5,5d6 <strchr+0xc>
            return (char *)s;
    return 0;
 5e2:	4501                	li	a0,0
}
 5e4:	6422                	ld	s0,8(sp)
 5e6:	0141                	addi	sp,sp,16
 5e8:	8082                	ret
    return 0;
 5ea:	4501                	li	a0,0
 5ec:	bfe5                	j	5e4 <strchr+0x1a>

00000000000005ee <gets>:

char *
gets(char *buf, int max)
{
 5ee:	711d                	addi	sp,sp,-96
 5f0:	ec86                	sd	ra,88(sp)
 5f2:	e8a2                	sd	s0,80(sp)
 5f4:	e4a6                	sd	s1,72(sp)
 5f6:	e0ca                	sd	s2,64(sp)
 5f8:	fc4e                	sd	s3,56(sp)
 5fa:	f852                	sd	s4,48(sp)
 5fc:	f456                	sd	s5,40(sp)
 5fe:	f05a                	sd	s6,32(sp)
 600:	ec5e                	sd	s7,24(sp)
 602:	1080                	addi	s0,sp,96
 604:	8baa                	mv	s7,a0
 606:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 608:	892a                	mv	s2,a0
 60a:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 60c:	4aa9                	li	s5,10
 60e:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 610:	89a6                	mv	s3,s1
 612:	2485                	addiw	s1,s1,1
 614:	0344d863          	bge	s1,s4,644 <gets+0x56>
        cc = read(0, &c, 1);
 618:	4605                	li	a2,1
 61a:	faf40593          	addi	a1,s0,-81
 61e:	4501                	li	a0,0
 620:	00000097          	auipc	ra,0x0
 624:	19a080e7          	jalr	410(ra) # 7ba <read>
        if (cc < 1)
 628:	00a05e63          	blez	a0,644 <gets+0x56>
        buf[i++] = c;
 62c:	faf44783          	lbu	a5,-81(s0)
 630:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 634:	01578763          	beq	a5,s5,642 <gets+0x54>
 638:	0905                	addi	s2,s2,1
 63a:	fd679be3          	bne	a5,s6,610 <gets+0x22>
    for (i = 0; i + 1 < max;)
 63e:	89a6                	mv	s3,s1
 640:	a011                	j	644 <gets+0x56>
 642:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 644:	99de                	add	s3,s3,s7
 646:	00098023          	sb	zero,0(s3)
    return buf;
}
 64a:	855e                	mv	a0,s7
 64c:	60e6                	ld	ra,88(sp)
 64e:	6446                	ld	s0,80(sp)
 650:	64a6                	ld	s1,72(sp)
 652:	6906                	ld	s2,64(sp)
 654:	79e2                	ld	s3,56(sp)
 656:	7a42                	ld	s4,48(sp)
 658:	7aa2                	ld	s5,40(sp)
 65a:	7b02                	ld	s6,32(sp)
 65c:	6be2                	ld	s7,24(sp)
 65e:	6125                	addi	sp,sp,96
 660:	8082                	ret

0000000000000662 <stat>:

int stat(const char *n, struct stat *st)
{
 662:	1101                	addi	sp,sp,-32
 664:	ec06                	sd	ra,24(sp)
 666:	e822                	sd	s0,16(sp)
 668:	e426                	sd	s1,8(sp)
 66a:	e04a                	sd	s2,0(sp)
 66c:	1000                	addi	s0,sp,32
 66e:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 670:	4581                	li	a1,0
 672:	00000097          	auipc	ra,0x0
 676:	170080e7          	jalr	368(ra) # 7e2 <open>
    if (fd < 0)
 67a:	02054563          	bltz	a0,6a4 <stat+0x42>
 67e:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 680:	85ca                	mv	a1,s2
 682:	00000097          	auipc	ra,0x0
 686:	178080e7          	jalr	376(ra) # 7fa <fstat>
 68a:	892a                	mv	s2,a0
    close(fd);
 68c:	8526                	mv	a0,s1
 68e:	00000097          	auipc	ra,0x0
 692:	13c080e7          	jalr	316(ra) # 7ca <close>
    return r;
}
 696:	854a                	mv	a0,s2
 698:	60e2                	ld	ra,24(sp)
 69a:	6442                	ld	s0,16(sp)
 69c:	64a2                	ld	s1,8(sp)
 69e:	6902                	ld	s2,0(sp)
 6a0:	6105                	addi	sp,sp,32
 6a2:	8082                	ret
        return -1;
 6a4:	597d                	li	s2,-1
 6a6:	bfc5                	j	696 <stat+0x34>

00000000000006a8 <atoi>:

int atoi(const char *s)
{
 6a8:	1141                	addi	sp,sp,-16
 6aa:	e422                	sd	s0,8(sp)
 6ac:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 6ae:	00054683          	lbu	a3,0(a0)
 6b2:	fd06879b          	addiw	a5,a3,-48
 6b6:	0ff7f793          	zext.b	a5,a5
 6ba:	4625                	li	a2,9
 6bc:	02f66863          	bltu	a2,a5,6ec <atoi+0x44>
 6c0:	872a                	mv	a4,a0
    n = 0;
 6c2:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 6c4:	0705                	addi	a4,a4,1
 6c6:	0025179b          	slliw	a5,a0,0x2
 6ca:	9fa9                	addw	a5,a5,a0
 6cc:	0017979b          	slliw	a5,a5,0x1
 6d0:	9fb5                	addw	a5,a5,a3
 6d2:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 6d6:	00074683          	lbu	a3,0(a4)
 6da:	fd06879b          	addiw	a5,a3,-48
 6de:	0ff7f793          	zext.b	a5,a5
 6e2:	fef671e3          	bgeu	a2,a5,6c4 <atoi+0x1c>
    return n;
}
 6e6:	6422                	ld	s0,8(sp)
 6e8:	0141                	addi	sp,sp,16
 6ea:	8082                	ret
    n = 0;
 6ec:	4501                	li	a0,0
 6ee:	bfe5                	j	6e6 <atoi+0x3e>

00000000000006f0 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 6f0:	1141                	addi	sp,sp,-16
 6f2:	e422                	sd	s0,8(sp)
 6f4:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 6f6:	02b57463          	bgeu	a0,a1,71e <memmove+0x2e>
    {
        while (n-- > 0)
 6fa:	00c05f63          	blez	a2,718 <memmove+0x28>
 6fe:	1602                	slli	a2,a2,0x20
 700:	9201                	srli	a2,a2,0x20
 702:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 706:	872a                	mv	a4,a0
            *dst++ = *src++;
 708:	0585                	addi	a1,a1,1
 70a:	0705                	addi	a4,a4,1
 70c:	fff5c683          	lbu	a3,-1(a1)
 710:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 714:	fee79ae3          	bne	a5,a4,708 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 718:	6422                	ld	s0,8(sp)
 71a:	0141                	addi	sp,sp,16
 71c:	8082                	ret
        dst += n;
 71e:	00c50733          	add	a4,a0,a2
        src += n;
 722:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 724:	fec05ae3          	blez	a2,718 <memmove+0x28>
 728:	fff6079b          	addiw	a5,a2,-1
 72c:	1782                	slli	a5,a5,0x20
 72e:	9381                	srli	a5,a5,0x20
 730:	fff7c793          	not	a5,a5
 734:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 736:	15fd                	addi	a1,a1,-1
 738:	177d                	addi	a4,a4,-1
 73a:	0005c683          	lbu	a3,0(a1)
 73e:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 742:	fee79ae3          	bne	a5,a4,736 <memmove+0x46>
 746:	bfc9                	j	718 <memmove+0x28>

0000000000000748 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 748:	1141                	addi	sp,sp,-16
 74a:	e422                	sd	s0,8(sp)
 74c:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 74e:	ca05                	beqz	a2,77e <memcmp+0x36>
 750:	fff6069b          	addiw	a3,a2,-1
 754:	1682                	slli	a3,a3,0x20
 756:	9281                	srli	a3,a3,0x20
 758:	0685                	addi	a3,a3,1
 75a:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 75c:	00054783          	lbu	a5,0(a0)
 760:	0005c703          	lbu	a4,0(a1)
 764:	00e79863          	bne	a5,a4,774 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 768:	0505                	addi	a0,a0,1
        p2++;
 76a:	0585                	addi	a1,a1,1
    while (n-- > 0)
 76c:	fed518e3          	bne	a0,a3,75c <memcmp+0x14>
    }
    return 0;
 770:	4501                	li	a0,0
 772:	a019                	j	778 <memcmp+0x30>
            return *p1 - *p2;
 774:	40e7853b          	subw	a0,a5,a4
}
 778:	6422                	ld	s0,8(sp)
 77a:	0141                	addi	sp,sp,16
 77c:	8082                	ret
    return 0;
 77e:	4501                	li	a0,0
 780:	bfe5                	j	778 <memcmp+0x30>

0000000000000782 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 782:	1141                	addi	sp,sp,-16
 784:	e406                	sd	ra,8(sp)
 786:	e022                	sd	s0,0(sp)
 788:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 78a:	00000097          	auipc	ra,0x0
 78e:	f66080e7          	jalr	-154(ra) # 6f0 <memmove>
}
 792:	60a2                	ld	ra,8(sp)
 794:	6402                	ld	s0,0(sp)
 796:	0141                	addi	sp,sp,16
 798:	8082                	ret

000000000000079a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 79a:	4885                	li	a7,1
 ecall
 79c:	00000073          	ecall
 ret
 7a0:	8082                	ret

00000000000007a2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 7a2:	4889                	li	a7,2
 ecall
 7a4:	00000073          	ecall
 ret
 7a8:	8082                	ret

00000000000007aa <wait>:
.global wait
wait:
 li a7, SYS_wait
 7aa:	488d                	li	a7,3
 ecall
 7ac:	00000073          	ecall
 ret
 7b0:	8082                	ret

00000000000007b2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 7b2:	4891                	li	a7,4
 ecall
 7b4:	00000073          	ecall
 ret
 7b8:	8082                	ret

00000000000007ba <read>:
.global read
read:
 li a7, SYS_read
 7ba:	4895                	li	a7,5
 ecall
 7bc:	00000073          	ecall
 ret
 7c0:	8082                	ret

00000000000007c2 <write>:
.global write
write:
 li a7, SYS_write
 7c2:	48c1                	li	a7,16
 ecall
 7c4:	00000073          	ecall
 ret
 7c8:	8082                	ret

00000000000007ca <close>:
.global close
close:
 li a7, SYS_close
 7ca:	48d5                	li	a7,21
 ecall
 7cc:	00000073          	ecall
 ret
 7d0:	8082                	ret

00000000000007d2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 7d2:	4899                	li	a7,6
 ecall
 7d4:	00000073          	ecall
 ret
 7d8:	8082                	ret

00000000000007da <exec>:
.global exec
exec:
 li a7, SYS_exec
 7da:	489d                	li	a7,7
 ecall
 7dc:	00000073          	ecall
 ret
 7e0:	8082                	ret

00000000000007e2 <open>:
.global open
open:
 li a7, SYS_open
 7e2:	48bd                	li	a7,15
 ecall
 7e4:	00000073          	ecall
 ret
 7e8:	8082                	ret

00000000000007ea <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7ea:	48c5                	li	a7,17
 ecall
 7ec:	00000073          	ecall
 ret
 7f0:	8082                	ret

00000000000007f2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7f2:	48c9                	li	a7,18
 ecall
 7f4:	00000073          	ecall
 ret
 7f8:	8082                	ret

00000000000007fa <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7fa:	48a1                	li	a7,8
 ecall
 7fc:	00000073          	ecall
 ret
 800:	8082                	ret

0000000000000802 <link>:
.global link
link:
 li a7, SYS_link
 802:	48cd                	li	a7,19
 ecall
 804:	00000073          	ecall
 ret
 808:	8082                	ret

000000000000080a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 80a:	48d1                	li	a7,20
 ecall
 80c:	00000073          	ecall
 ret
 810:	8082                	ret

0000000000000812 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 812:	48a5                	li	a7,9
 ecall
 814:	00000073          	ecall
 ret
 818:	8082                	ret

000000000000081a <dup>:
.global dup
dup:
 li a7, SYS_dup
 81a:	48a9                	li	a7,10
 ecall
 81c:	00000073          	ecall
 ret
 820:	8082                	ret

0000000000000822 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 822:	48ad                	li	a7,11
 ecall
 824:	00000073          	ecall
 ret
 828:	8082                	ret

000000000000082a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 82a:	48b1                	li	a7,12
 ecall
 82c:	00000073          	ecall
 ret
 830:	8082                	ret

0000000000000832 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 832:	48b5                	li	a7,13
 ecall
 834:	00000073          	ecall
 ret
 838:	8082                	ret

000000000000083a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 83a:	48b9                	li	a7,14
 ecall
 83c:	00000073          	ecall
 ret
 840:	8082                	ret

0000000000000842 <ps>:
.global ps
ps:
 li a7, SYS_ps
 842:	48d9                	li	a7,22
 ecall
 844:	00000073          	ecall
 ret
 848:	8082                	ret

000000000000084a <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 84a:	48dd                	li	a7,23
 ecall
 84c:	00000073          	ecall
 ret
 850:	8082                	ret

0000000000000852 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 852:	48e1                	li	a7,24
 ecall
 854:	00000073          	ecall
 ret
 858:	8082                	ret

000000000000085a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 85a:	1101                	addi	sp,sp,-32
 85c:	ec06                	sd	ra,24(sp)
 85e:	e822                	sd	s0,16(sp)
 860:	1000                	addi	s0,sp,32
 862:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 866:	4605                	li	a2,1
 868:	fef40593          	addi	a1,s0,-17
 86c:	00000097          	auipc	ra,0x0
 870:	f56080e7          	jalr	-170(ra) # 7c2 <write>
}
 874:	60e2                	ld	ra,24(sp)
 876:	6442                	ld	s0,16(sp)
 878:	6105                	addi	sp,sp,32
 87a:	8082                	ret

000000000000087c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 87c:	7139                	addi	sp,sp,-64
 87e:	fc06                	sd	ra,56(sp)
 880:	f822                	sd	s0,48(sp)
 882:	f426                	sd	s1,40(sp)
 884:	f04a                	sd	s2,32(sp)
 886:	ec4e                	sd	s3,24(sp)
 888:	0080                	addi	s0,sp,64
 88a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 88c:	c299                	beqz	a3,892 <printint+0x16>
 88e:	0805c963          	bltz	a1,920 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 892:	2581                	sext.w	a1,a1
  neg = 0;
 894:	4881                	li	a7,0
 896:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 89a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 89c:	2601                	sext.w	a2,a2
 89e:	00000517          	auipc	a0,0x0
 8a2:	5e250513          	addi	a0,a0,1506 # e80 <digits>
 8a6:	883a                	mv	a6,a4
 8a8:	2705                	addiw	a4,a4,1
 8aa:	02c5f7bb          	remuw	a5,a1,a2
 8ae:	1782                	slli	a5,a5,0x20
 8b0:	9381                	srli	a5,a5,0x20
 8b2:	97aa                	add	a5,a5,a0
 8b4:	0007c783          	lbu	a5,0(a5)
 8b8:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 8bc:	0005879b          	sext.w	a5,a1
 8c0:	02c5d5bb          	divuw	a1,a1,a2
 8c4:	0685                	addi	a3,a3,1
 8c6:	fec7f0e3          	bgeu	a5,a2,8a6 <printint+0x2a>
  if(neg)
 8ca:	00088c63          	beqz	a7,8e2 <printint+0x66>
    buf[i++] = '-';
 8ce:	fd070793          	addi	a5,a4,-48
 8d2:	00878733          	add	a4,a5,s0
 8d6:	02d00793          	li	a5,45
 8da:	fef70823          	sb	a5,-16(a4)
 8de:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 8e2:	02e05863          	blez	a4,912 <printint+0x96>
 8e6:	fc040793          	addi	a5,s0,-64
 8ea:	00e78933          	add	s2,a5,a4
 8ee:	fff78993          	addi	s3,a5,-1
 8f2:	99ba                	add	s3,s3,a4
 8f4:	377d                	addiw	a4,a4,-1
 8f6:	1702                	slli	a4,a4,0x20
 8f8:	9301                	srli	a4,a4,0x20
 8fa:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8fe:	fff94583          	lbu	a1,-1(s2)
 902:	8526                	mv	a0,s1
 904:	00000097          	auipc	ra,0x0
 908:	f56080e7          	jalr	-170(ra) # 85a <putc>
  while(--i >= 0)
 90c:	197d                	addi	s2,s2,-1
 90e:	ff3918e3          	bne	s2,s3,8fe <printint+0x82>
}
 912:	70e2                	ld	ra,56(sp)
 914:	7442                	ld	s0,48(sp)
 916:	74a2                	ld	s1,40(sp)
 918:	7902                	ld	s2,32(sp)
 91a:	69e2                	ld	s3,24(sp)
 91c:	6121                	addi	sp,sp,64
 91e:	8082                	ret
    x = -xx;
 920:	40b005bb          	negw	a1,a1
    neg = 1;
 924:	4885                	li	a7,1
    x = -xx;
 926:	bf85                	j	896 <printint+0x1a>

0000000000000928 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 928:	715d                	addi	sp,sp,-80
 92a:	e486                	sd	ra,72(sp)
 92c:	e0a2                	sd	s0,64(sp)
 92e:	fc26                	sd	s1,56(sp)
 930:	f84a                	sd	s2,48(sp)
 932:	f44e                	sd	s3,40(sp)
 934:	f052                	sd	s4,32(sp)
 936:	ec56                	sd	s5,24(sp)
 938:	e85a                	sd	s6,16(sp)
 93a:	e45e                	sd	s7,8(sp)
 93c:	e062                	sd	s8,0(sp)
 93e:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 940:	0005c903          	lbu	s2,0(a1)
 944:	18090c63          	beqz	s2,adc <vprintf+0x1b4>
 948:	8aaa                	mv	s5,a0
 94a:	8bb2                	mv	s7,a2
 94c:	00158493          	addi	s1,a1,1
  state = 0;
 950:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 952:	02500a13          	li	s4,37
 956:	4b55                	li	s6,21
 958:	a839                	j	976 <vprintf+0x4e>
        putc(fd, c);
 95a:	85ca                	mv	a1,s2
 95c:	8556                	mv	a0,s5
 95e:	00000097          	auipc	ra,0x0
 962:	efc080e7          	jalr	-260(ra) # 85a <putc>
 966:	a019                	j	96c <vprintf+0x44>
    } else if(state == '%'){
 968:	01498d63          	beq	s3,s4,982 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 96c:	0485                	addi	s1,s1,1
 96e:	fff4c903          	lbu	s2,-1(s1)
 972:	16090563          	beqz	s2,adc <vprintf+0x1b4>
    if(state == 0){
 976:	fe0999e3          	bnez	s3,968 <vprintf+0x40>
      if(c == '%'){
 97a:	ff4910e3          	bne	s2,s4,95a <vprintf+0x32>
        state = '%';
 97e:	89d2                	mv	s3,s4
 980:	b7f5                	j	96c <vprintf+0x44>
      if(c == 'd'){
 982:	13490263          	beq	s2,s4,aa6 <vprintf+0x17e>
 986:	f9d9079b          	addiw	a5,s2,-99
 98a:	0ff7f793          	zext.b	a5,a5
 98e:	12fb6563          	bltu	s6,a5,ab8 <vprintf+0x190>
 992:	f9d9079b          	addiw	a5,s2,-99
 996:	0ff7f713          	zext.b	a4,a5
 99a:	10eb6f63          	bltu	s6,a4,ab8 <vprintf+0x190>
 99e:	00271793          	slli	a5,a4,0x2
 9a2:	00000717          	auipc	a4,0x0
 9a6:	48670713          	addi	a4,a4,1158 # e28 <malloc+0x24e>
 9aa:	97ba                	add	a5,a5,a4
 9ac:	439c                	lw	a5,0(a5)
 9ae:	97ba                	add	a5,a5,a4
 9b0:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 9b2:	008b8913          	addi	s2,s7,8
 9b6:	4685                	li	a3,1
 9b8:	4629                	li	a2,10
 9ba:	000ba583          	lw	a1,0(s7)
 9be:	8556                	mv	a0,s5
 9c0:	00000097          	auipc	ra,0x0
 9c4:	ebc080e7          	jalr	-324(ra) # 87c <printint>
 9c8:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9ca:	4981                	li	s3,0
 9cc:	b745                	j	96c <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9ce:	008b8913          	addi	s2,s7,8
 9d2:	4681                	li	a3,0
 9d4:	4629                	li	a2,10
 9d6:	000ba583          	lw	a1,0(s7)
 9da:	8556                	mv	a0,s5
 9dc:	00000097          	auipc	ra,0x0
 9e0:	ea0080e7          	jalr	-352(ra) # 87c <printint>
 9e4:	8bca                	mv	s7,s2
      state = 0;
 9e6:	4981                	li	s3,0
 9e8:	b751                	j	96c <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 9ea:	008b8913          	addi	s2,s7,8
 9ee:	4681                	li	a3,0
 9f0:	4641                	li	a2,16
 9f2:	000ba583          	lw	a1,0(s7)
 9f6:	8556                	mv	a0,s5
 9f8:	00000097          	auipc	ra,0x0
 9fc:	e84080e7          	jalr	-380(ra) # 87c <printint>
 a00:	8bca                	mv	s7,s2
      state = 0;
 a02:	4981                	li	s3,0
 a04:	b7a5                	j	96c <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 a06:	008b8c13          	addi	s8,s7,8
 a0a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a0e:	03000593          	li	a1,48
 a12:	8556                	mv	a0,s5
 a14:	00000097          	auipc	ra,0x0
 a18:	e46080e7          	jalr	-442(ra) # 85a <putc>
  putc(fd, 'x');
 a1c:	07800593          	li	a1,120
 a20:	8556                	mv	a0,s5
 a22:	00000097          	auipc	ra,0x0
 a26:	e38080e7          	jalr	-456(ra) # 85a <putc>
 a2a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a2c:	00000b97          	auipc	s7,0x0
 a30:	454b8b93          	addi	s7,s7,1108 # e80 <digits>
 a34:	03c9d793          	srli	a5,s3,0x3c
 a38:	97de                	add	a5,a5,s7
 a3a:	0007c583          	lbu	a1,0(a5)
 a3e:	8556                	mv	a0,s5
 a40:	00000097          	auipc	ra,0x0
 a44:	e1a080e7          	jalr	-486(ra) # 85a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a48:	0992                	slli	s3,s3,0x4
 a4a:	397d                	addiw	s2,s2,-1
 a4c:	fe0914e3          	bnez	s2,a34 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 a50:	8be2                	mv	s7,s8
      state = 0;
 a52:	4981                	li	s3,0
 a54:	bf21                	j	96c <vprintf+0x44>
        s = va_arg(ap, char*);
 a56:	008b8993          	addi	s3,s7,8
 a5a:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a5e:	02090163          	beqz	s2,a80 <vprintf+0x158>
        while(*s != 0){
 a62:	00094583          	lbu	a1,0(s2)
 a66:	c9a5                	beqz	a1,ad6 <vprintf+0x1ae>
          putc(fd, *s);
 a68:	8556                	mv	a0,s5
 a6a:	00000097          	auipc	ra,0x0
 a6e:	df0080e7          	jalr	-528(ra) # 85a <putc>
          s++;
 a72:	0905                	addi	s2,s2,1
        while(*s != 0){
 a74:	00094583          	lbu	a1,0(s2)
 a78:	f9e5                	bnez	a1,a68 <vprintf+0x140>
        s = va_arg(ap, char*);
 a7a:	8bce                	mv	s7,s3
      state = 0;
 a7c:	4981                	li	s3,0
 a7e:	b5fd                	j	96c <vprintf+0x44>
          s = "(null)";
 a80:	00000917          	auipc	s2,0x0
 a84:	3a090913          	addi	s2,s2,928 # e20 <malloc+0x246>
        while(*s != 0){
 a88:	02800593          	li	a1,40
 a8c:	bff1                	j	a68 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a8e:	008b8913          	addi	s2,s7,8
 a92:	000bc583          	lbu	a1,0(s7)
 a96:	8556                	mv	a0,s5
 a98:	00000097          	auipc	ra,0x0
 a9c:	dc2080e7          	jalr	-574(ra) # 85a <putc>
 aa0:	8bca                	mv	s7,s2
      state = 0;
 aa2:	4981                	li	s3,0
 aa4:	b5e1                	j	96c <vprintf+0x44>
        putc(fd, c);
 aa6:	02500593          	li	a1,37
 aaa:	8556                	mv	a0,s5
 aac:	00000097          	auipc	ra,0x0
 ab0:	dae080e7          	jalr	-594(ra) # 85a <putc>
      state = 0;
 ab4:	4981                	li	s3,0
 ab6:	bd5d                	j	96c <vprintf+0x44>
        putc(fd, '%');
 ab8:	02500593          	li	a1,37
 abc:	8556                	mv	a0,s5
 abe:	00000097          	auipc	ra,0x0
 ac2:	d9c080e7          	jalr	-612(ra) # 85a <putc>
        putc(fd, c);
 ac6:	85ca                	mv	a1,s2
 ac8:	8556                	mv	a0,s5
 aca:	00000097          	auipc	ra,0x0
 ace:	d90080e7          	jalr	-624(ra) # 85a <putc>
      state = 0;
 ad2:	4981                	li	s3,0
 ad4:	bd61                	j	96c <vprintf+0x44>
        s = va_arg(ap, char*);
 ad6:	8bce                	mv	s7,s3
      state = 0;
 ad8:	4981                	li	s3,0
 ada:	bd49                	j	96c <vprintf+0x44>
    }
  }
}
 adc:	60a6                	ld	ra,72(sp)
 ade:	6406                	ld	s0,64(sp)
 ae0:	74e2                	ld	s1,56(sp)
 ae2:	7942                	ld	s2,48(sp)
 ae4:	79a2                	ld	s3,40(sp)
 ae6:	7a02                	ld	s4,32(sp)
 ae8:	6ae2                	ld	s5,24(sp)
 aea:	6b42                	ld	s6,16(sp)
 aec:	6ba2                	ld	s7,8(sp)
 aee:	6c02                	ld	s8,0(sp)
 af0:	6161                	addi	sp,sp,80
 af2:	8082                	ret

0000000000000af4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 af4:	715d                	addi	sp,sp,-80
 af6:	ec06                	sd	ra,24(sp)
 af8:	e822                	sd	s0,16(sp)
 afa:	1000                	addi	s0,sp,32
 afc:	e010                	sd	a2,0(s0)
 afe:	e414                	sd	a3,8(s0)
 b00:	e818                	sd	a4,16(s0)
 b02:	ec1c                	sd	a5,24(s0)
 b04:	03043023          	sd	a6,32(s0)
 b08:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b0c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b10:	8622                	mv	a2,s0
 b12:	00000097          	auipc	ra,0x0
 b16:	e16080e7          	jalr	-490(ra) # 928 <vprintf>
}
 b1a:	60e2                	ld	ra,24(sp)
 b1c:	6442                	ld	s0,16(sp)
 b1e:	6161                	addi	sp,sp,80
 b20:	8082                	ret

0000000000000b22 <printf>:

void
printf(const char *fmt, ...)
{
 b22:	711d                	addi	sp,sp,-96
 b24:	ec06                	sd	ra,24(sp)
 b26:	e822                	sd	s0,16(sp)
 b28:	1000                	addi	s0,sp,32
 b2a:	e40c                	sd	a1,8(s0)
 b2c:	e810                	sd	a2,16(s0)
 b2e:	ec14                	sd	a3,24(s0)
 b30:	f018                	sd	a4,32(s0)
 b32:	f41c                	sd	a5,40(s0)
 b34:	03043823          	sd	a6,48(s0)
 b38:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b3c:	00840613          	addi	a2,s0,8
 b40:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b44:	85aa                	mv	a1,a0
 b46:	4505                	li	a0,1
 b48:	00000097          	auipc	ra,0x0
 b4c:	de0080e7          	jalr	-544(ra) # 928 <vprintf>
}
 b50:	60e2                	ld	ra,24(sp)
 b52:	6442                	ld	s0,16(sp)
 b54:	6125                	addi	sp,sp,96
 b56:	8082                	ret

0000000000000b58 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 b58:	1141                	addi	sp,sp,-16
 b5a:	e422                	sd	s0,8(sp)
 b5c:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 b5e:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b62:	00000797          	auipc	a5,0x0
 b66:	4b67b783          	ld	a5,1206(a5) # 1018 <freep>
 b6a:	a02d                	j	b94 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 b6c:	4618                	lw	a4,8(a2)
 b6e:	9f2d                	addw	a4,a4,a1
 b70:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 b74:	6398                	ld	a4,0(a5)
 b76:	6310                	ld	a2,0(a4)
 b78:	a83d                	j	bb6 <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 b7a:	ff852703          	lw	a4,-8(a0)
 b7e:	9f31                	addw	a4,a4,a2
 b80:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 b82:	ff053683          	ld	a3,-16(a0)
 b86:	a091                	j	bca <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b88:	6398                	ld	a4,0(a5)
 b8a:	00e7e463          	bltu	a5,a4,b92 <free+0x3a>
 b8e:	00e6ea63          	bltu	a3,a4,ba2 <free+0x4a>
{
 b92:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b94:	fed7fae3          	bgeu	a5,a3,b88 <free+0x30>
 b98:	6398                	ld	a4,0(a5)
 b9a:	00e6e463          	bltu	a3,a4,ba2 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b9e:	fee7eae3          	bltu	a5,a4,b92 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 ba2:	ff852583          	lw	a1,-8(a0)
 ba6:	6390                	ld	a2,0(a5)
 ba8:	02059813          	slli	a6,a1,0x20
 bac:	01c85713          	srli	a4,a6,0x1c
 bb0:	9736                	add	a4,a4,a3
 bb2:	fae60de3          	beq	a2,a4,b6c <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 bb6:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 bba:	4790                	lw	a2,8(a5)
 bbc:	02061593          	slli	a1,a2,0x20
 bc0:	01c5d713          	srli	a4,a1,0x1c
 bc4:	973e                	add	a4,a4,a5
 bc6:	fae68ae3          	beq	a3,a4,b7a <free+0x22>
        p->s.ptr = bp->s.ptr;
 bca:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 bcc:	00000717          	auipc	a4,0x0
 bd0:	44f73623          	sd	a5,1100(a4) # 1018 <freep>
}
 bd4:	6422                	ld	s0,8(sp)
 bd6:	0141                	addi	sp,sp,16
 bd8:	8082                	ret

0000000000000bda <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 bda:	7139                	addi	sp,sp,-64
 bdc:	fc06                	sd	ra,56(sp)
 bde:	f822                	sd	s0,48(sp)
 be0:	f426                	sd	s1,40(sp)
 be2:	f04a                	sd	s2,32(sp)
 be4:	ec4e                	sd	s3,24(sp)
 be6:	e852                	sd	s4,16(sp)
 be8:	e456                	sd	s5,8(sp)
 bea:	e05a                	sd	s6,0(sp)
 bec:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 bee:	02051493          	slli	s1,a0,0x20
 bf2:	9081                	srli	s1,s1,0x20
 bf4:	04bd                	addi	s1,s1,15
 bf6:	8091                	srli	s1,s1,0x4
 bf8:	0014899b          	addiw	s3,s1,1
 bfc:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 bfe:	00000517          	auipc	a0,0x0
 c02:	41a53503          	ld	a0,1050(a0) # 1018 <freep>
 c06:	c515                	beqz	a0,c32 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c08:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 c0a:	4798                	lw	a4,8(a5)
 c0c:	02977f63          	bgeu	a4,s1,c4a <malloc+0x70>
    if (nu < 4096)
 c10:	8a4e                	mv	s4,s3
 c12:	0009871b          	sext.w	a4,s3
 c16:	6685                	lui	a3,0x1
 c18:	00d77363          	bgeu	a4,a3,c1e <malloc+0x44>
 c1c:	6a05                	lui	s4,0x1
 c1e:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 c22:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 c26:	00000917          	auipc	s2,0x0
 c2a:	3f290913          	addi	s2,s2,1010 # 1018 <freep>
    if (p == (char *)-1)
 c2e:	5afd                	li	s5,-1
 c30:	a895                	j	ca4 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 c32:	00000797          	auipc	a5,0x0
 c36:	46e78793          	addi	a5,a5,1134 # 10a0 <base>
 c3a:	00000717          	auipc	a4,0x0
 c3e:	3cf73f23          	sd	a5,990(a4) # 1018 <freep>
 c42:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 c44:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 c48:	b7e1                	j	c10 <malloc+0x36>
            if (p->s.size == nunits)
 c4a:	02e48c63          	beq	s1,a4,c82 <malloc+0xa8>
                p->s.size -= nunits;
 c4e:	4137073b          	subw	a4,a4,s3
 c52:	c798                	sw	a4,8(a5)
                p += p->s.size;
 c54:	02071693          	slli	a3,a4,0x20
 c58:	01c6d713          	srli	a4,a3,0x1c
 c5c:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 c5e:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 c62:	00000717          	auipc	a4,0x0
 c66:	3aa73b23          	sd	a0,950(a4) # 1018 <freep>
            return (void *)(p + 1);
 c6a:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 c6e:	70e2                	ld	ra,56(sp)
 c70:	7442                	ld	s0,48(sp)
 c72:	74a2                	ld	s1,40(sp)
 c74:	7902                	ld	s2,32(sp)
 c76:	69e2                	ld	s3,24(sp)
 c78:	6a42                	ld	s4,16(sp)
 c7a:	6aa2                	ld	s5,8(sp)
 c7c:	6b02                	ld	s6,0(sp)
 c7e:	6121                	addi	sp,sp,64
 c80:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 c82:	6398                	ld	a4,0(a5)
 c84:	e118                	sd	a4,0(a0)
 c86:	bff1                	j	c62 <malloc+0x88>
    hp->s.size = nu;
 c88:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c8c:	0541                	addi	a0,a0,16
 c8e:	00000097          	auipc	ra,0x0
 c92:	eca080e7          	jalr	-310(ra) # b58 <free>
    return freep;
 c96:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c9a:	d971                	beqz	a0,c6e <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c9c:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 c9e:	4798                	lw	a4,8(a5)
 ca0:	fa9775e3          	bgeu	a4,s1,c4a <malloc+0x70>
        if (p == freep)
 ca4:	00093703          	ld	a4,0(s2)
 ca8:	853e                	mv	a0,a5
 caa:	fef719e3          	bne	a4,a5,c9c <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 cae:	8552                	mv	a0,s4
 cb0:	00000097          	auipc	ra,0x0
 cb4:	b7a080e7          	jalr	-1158(ra) # 82a <sbrk>
    if (p == (char *)-1)
 cb8:	fd5518e3          	bne	a0,s5,c88 <malloc+0xae>
                return 0;
 cbc:	4501                	li	a0,0
 cbe:	bf45                	j	c6e <malloc+0x94>
