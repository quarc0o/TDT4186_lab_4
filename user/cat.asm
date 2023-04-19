
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:
#include "user.h"

char buf[512];

void cat(int fd)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	89aa                	mv	s3,a0
    int n;

    while ((n = read(fd, buf, sizeof(buf))) > 0)
  10:	00001917          	auipc	s2,0x1
  14:	01090913          	addi	s2,s2,16 # 1020 <buf>
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	00000097          	auipc	ra,0x0
  24:	79e080e7          	jalr	1950(ra) # 7be <read>
  28:	84aa                	mv	s1,a0
  2a:	02a05963          	blez	a0,5c <cat+0x5c>
    {
        if (write(1, buf, n) != n)
  2e:	8626                	mv	a2,s1
  30:	85ca                	mv	a1,s2
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	792080e7          	jalr	1938(ra) # 7c6 <write>
  3c:	fc950ee3          	beq	a0,s1,18 <cat+0x18>
        {
            fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	c9058593          	addi	a1,a1,-880 # cd0 <malloc+0xf2>
  48:	4509                	li	a0,2
  4a:	00001097          	auipc	ra,0x1
  4e:	aae080e7          	jalr	-1362(ra) # af8 <fprintf>
            exit(1);
  52:	4505                	li	a0,1
  54:	00000097          	auipc	ra,0x0
  58:	752080e7          	jalr	1874(ra) # 7a6 <exit>
        }
    }
    if (n < 0)
  5c:	00054963          	bltz	a0,6e <cat+0x6e>
    {
        fprintf(2, "cat: read error\n");
        exit(1);
    }
}
  60:	70a2                	ld	ra,40(sp)
  62:	7402                	ld	s0,32(sp)
  64:	64e2                	ld	s1,24(sp)
  66:	6942                	ld	s2,16(sp)
  68:	69a2                	ld	s3,8(sp)
  6a:	6145                	addi	sp,sp,48
  6c:	8082                	ret
        fprintf(2, "cat: read error\n");
  6e:	00001597          	auipc	a1,0x1
  72:	c7a58593          	addi	a1,a1,-902 # ce8 <malloc+0x10a>
  76:	4509                	li	a0,2
  78:	00001097          	auipc	ra,0x1
  7c:	a80080e7          	jalr	-1408(ra) # af8 <fprintf>
        exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	724080e7          	jalr	1828(ra) # 7a6 <exit>

000000000000008a <main>:

int main(int argc, char *argv[])
{
  8a:	7179                	addi	sp,sp,-48
  8c:	f406                	sd	ra,40(sp)
  8e:	f022                	sd	s0,32(sp)
  90:	ec26                	sd	s1,24(sp)
  92:	e84a                	sd	s2,16(sp)
  94:	e44e                	sd	s3,8(sp)
  96:	1800                	addi	s0,sp,48
    int fd, i;

    if (argc <= 1)
  98:	4785                	li	a5,1
  9a:	04a7d763          	bge	a5,a0,e8 <main+0x5e>
  9e:	00858913          	addi	s2,a1,8
  a2:	ffe5099b          	addiw	s3,a0,-2
  a6:	02099793          	slli	a5,s3,0x20
  aa:	01d7d993          	srli	s3,a5,0x1d
  ae:	05c1                	addi	a1,a1,16
  b0:	99ae                	add	s3,s3,a1
        exit(0);
    }

    for (i = 1; i < argc; i++)
    {
        if ((fd = open(argv[i], 0)) < 0)
  b2:	4581                	li	a1,0
  b4:	00093503          	ld	a0,0(s2)
  b8:	00000097          	auipc	ra,0x0
  bc:	72e080e7          	jalr	1838(ra) # 7e6 <open>
  c0:	84aa                	mv	s1,a0
  c2:	02054d63          	bltz	a0,fc <main+0x72>
        {
            fprintf(2, "cat: cannot open %s\n", argv[i]);
            exit(1);
        }
        cat(fd);
  c6:	00000097          	auipc	ra,0x0
  ca:	f3a080e7          	jalr	-198(ra) # 0 <cat>
        close(fd);
  ce:	8526                	mv	a0,s1
  d0:	00000097          	auipc	ra,0x0
  d4:	6fe080e7          	jalr	1790(ra) # 7ce <close>
    for (i = 1; i < argc; i++)
  d8:	0921                	addi	s2,s2,8
  da:	fd391ce3          	bne	s2,s3,b2 <main+0x28>
    }
    exit(0);
  de:	4501                	li	a0,0
  e0:	00000097          	auipc	ra,0x0
  e4:	6c6080e7          	jalr	1734(ra) # 7a6 <exit>
        cat(0);
  e8:	4501                	li	a0,0
  ea:	00000097          	auipc	ra,0x0
  ee:	f16080e7          	jalr	-234(ra) # 0 <cat>
        exit(0);
  f2:	4501                	li	a0,0
  f4:	00000097          	auipc	ra,0x0
  f8:	6b2080e7          	jalr	1714(ra) # 7a6 <exit>
            fprintf(2, "cat: cannot open %s\n", argv[i]);
  fc:	00093603          	ld	a2,0(s2)
 100:	00001597          	auipc	a1,0x1
 104:	c0058593          	addi	a1,a1,-1024 # d00 <malloc+0x122>
 108:	4509                	li	a0,2
 10a:	00001097          	auipc	ra,0x1
 10e:	9ee080e7          	jalr	-1554(ra) # af8 <fprintf>
            exit(1);
 112:	4505                	li	a0,1
 114:	00000097          	auipc	ra,0x0
 118:	692080e7          	jalr	1682(ra) # 7a6 <exit>

000000000000011c <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
 11c:	1141                	addi	sp,sp,-16
 11e:	e422                	sd	s0,8(sp)
 120:	0800                	addi	s0,sp,16
    lk->name = name;
 122:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
 124:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
 128:	57fd                	li	a5,-1
 12a:	00f50823          	sb	a5,16(a0)
}
 12e:	6422                	ld	s0,8(sp)
 130:	0141                	addi	sp,sp,16
 132:	8082                	ret

0000000000000134 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
 134:	00054783          	lbu	a5,0(a0)
 138:	e399                	bnez	a5,13e <holding+0xa>
 13a:	4501                	li	a0,0
}
 13c:	8082                	ret
{
 13e:	1101                	addi	sp,sp,-32
 140:	ec06                	sd	ra,24(sp)
 142:	e822                	sd	s0,16(sp)
 144:	e426                	sd	s1,8(sp)
 146:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
 148:	01054483          	lbu	s1,16(a0)
 14c:	00000097          	auipc	ra,0x0
 150:	340080e7          	jalr	832(ra) # 48c <twhoami>
 154:	2501                	sext.w	a0,a0
 156:	40a48533          	sub	a0,s1,a0
 15a:	00153513          	seqz	a0,a0
}
 15e:	60e2                	ld	ra,24(sp)
 160:	6442                	ld	s0,16(sp)
 162:	64a2                	ld	s1,8(sp)
 164:	6105                	addi	sp,sp,32
 166:	8082                	ret

0000000000000168 <acquire>:

void acquire(struct lock *lk)
{
 168:	7179                	addi	sp,sp,-48
 16a:	f406                	sd	ra,40(sp)
 16c:	f022                	sd	s0,32(sp)
 16e:	ec26                	sd	s1,24(sp)
 170:	e84a                	sd	s2,16(sp)
 172:	e44e                	sd	s3,8(sp)
 174:	e052                	sd	s4,0(sp)
 176:	1800                	addi	s0,sp,48
 178:	8a2a                	mv	s4,a0
    if (holding(lk))
 17a:	00000097          	auipc	ra,0x0
 17e:	fba080e7          	jalr	-70(ra) # 134 <holding>
 182:	e919                	bnez	a0,198 <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 184:	ffca7493          	andi	s1,s4,-4
 188:	003a7913          	andi	s2,s4,3
 18c:	0039191b          	slliw	s2,s2,0x3
 190:	4985                	li	s3,1
 192:	012999bb          	sllw	s3,s3,s2
 196:	a015                	j	1ba <acquire+0x52>
        printf("re-acquiring lock we already hold");
 198:	00001517          	auipc	a0,0x1
 19c:	b8050513          	addi	a0,a0,-1152 # d18 <malloc+0x13a>
 1a0:	00001097          	auipc	ra,0x1
 1a4:	986080e7          	jalr	-1658(ra) # b26 <printf>
        exit(-1);
 1a8:	557d                	li	a0,-1
 1aa:	00000097          	auipc	ra,0x0
 1ae:	5fc080e7          	jalr	1532(ra) # 7a6 <exit>
    {
        // give up the cpu for other threads
        tyield();
 1b2:	00000097          	auipc	ra,0x0
 1b6:	258080e7          	jalr	600(ra) # 40a <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 1ba:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 1be:	0127d7bb          	srlw	a5,a5,s2
 1c2:	0ff7f793          	zext.b	a5,a5
 1c6:	f7f5                	bnez	a5,1b2 <acquire+0x4a>
    }

    __sync_synchronize();
 1c8:	0ff0000f          	fence

    lk->tid = twhoami();
 1cc:	00000097          	auipc	ra,0x0
 1d0:	2c0080e7          	jalr	704(ra) # 48c <twhoami>
 1d4:	00aa0823          	sb	a0,16(s4)
}
 1d8:	70a2                	ld	ra,40(sp)
 1da:	7402                	ld	s0,32(sp)
 1dc:	64e2                	ld	s1,24(sp)
 1de:	6942                	ld	s2,16(sp)
 1e0:	69a2                	ld	s3,8(sp)
 1e2:	6a02                	ld	s4,0(sp)
 1e4:	6145                	addi	sp,sp,48
 1e6:	8082                	ret

00000000000001e8 <release>:

void release(struct lock *lk)
{
 1e8:	1101                	addi	sp,sp,-32
 1ea:	ec06                	sd	ra,24(sp)
 1ec:	e822                	sd	s0,16(sp)
 1ee:	e426                	sd	s1,8(sp)
 1f0:	1000                	addi	s0,sp,32
 1f2:	84aa                	mv	s1,a0
    if (!holding(lk))
 1f4:	00000097          	auipc	ra,0x0
 1f8:	f40080e7          	jalr	-192(ra) # 134 <holding>
 1fc:	c11d                	beqz	a0,222 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 1fe:	57fd                	li	a5,-1
 200:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 204:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 208:	0ff0000f          	fence
 20c:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 210:	00000097          	auipc	ra,0x0
 214:	1fa080e7          	jalr	506(ra) # 40a <tyield>
}
 218:	60e2                	ld	ra,24(sp)
 21a:	6442                	ld	s0,16(sp)
 21c:	64a2                	ld	s1,8(sp)
 21e:	6105                	addi	sp,sp,32
 220:	8082                	ret
        printf("releasing lock we are not holding");
 222:	00001517          	auipc	a0,0x1
 226:	b1e50513          	addi	a0,a0,-1250 # d40 <malloc+0x162>
 22a:	00001097          	auipc	ra,0x1
 22e:	8fc080e7          	jalr	-1796(ra) # b26 <printf>
        exit(-1);
 232:	557d                	li	a0,-1
 234:	00000097          	auipc	ra,0x0
 238:	572080e7          	jalr	1394(ra) # 7a6 <exit>

000000000000023c <tinit>:
    func(arg);
    current_thread->state = EXITED;
    tsched();
}

void tinit() {
 23c:	1141                	addi	sp,sp,-16
 23e:	e406                	sd	ra,8(sp)
 240:	e022                	sd	s0,0(sp)
 242:	0800                	addi	s0,sp,16
    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 244:	09800513          	li	a0,152
 248:	00001097          	auipc	ra,0x1
 24c:	996080e7          	jalr	-1642(ra) # bde <malloc>

    main_thread->tid = next_tid;
 250:	00001797          	auipc	a5,0x1
 254:	db078793          	addi	a5,a5,-592 # 1000 <next_tid>
 258:	4398                	lw	a4,0(a5)
 25a:	00e50023          	sb	a4,0(a0)
    next_tid += 1;
 25e:	4398                	lw	a4,0(a5)
 260:	2705                	addiw	a4,a4,1
 262:	c398                	sw	a4,0(a5)
    main_thread->state = RUNNING;
 264:	4791                	li	a5,4
 266:	dd3c                	sw	a5,120(a0)
    current_thread = main_thread;
 268:	00001797          	auipc	a5,0x1
 26c:	daa7b423          	sd	a0,-600(a5) # 1010 <current_thread>

    // Clear the thread list
    for (int i = 0; i < 16; i++) {
 270:	00001797          	auipc	a5,0x1
 274:	fb078793          	addi	a5,a5,-80 # 1220 <threads>
 278:	00001717          	auipc	a4,0x1
 27c:	02870713          	addi	a4,a4,40 # 12a0 <base>
        threads[i] = NULL;
 280:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 16; i++) {
 284:	07a1                	addi	a5,a5,8
 286:	fee79de3          	bne	a5,a4,280 <tinit+0x44>
    }

    // Set the main thread as the first element in the threads array
    threads[0] = main_thread;
 28a:	00001797          	auipc	a5,0x1
 28e:	f8a7bb23          	sd	a0,-106(a5) # 1220 <threads>
}
 292:	60a2                	ld	ra,8(sp)
 294:	6402                	ld	s0,0(sp)
 296:	0141                	addi	sp,sp,16
 298:	8082                	ret

000000000000029a <tsched>:
    struct thread *next_thread = NULL;
    int current_index = 0;

    // Find the current_index of the current_thread
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 29a:	00001517          	auipc	a0,0x1
 29e:	d7653503          	ld	a0,-650(a0) # 1010 <current_thread>
 2a2:	00001717          	auipc	a4,0x1
 2a6:	f7e70713          	addi	a4,a4,-130 # 1220 <threads>
    for (int i = 0; i < 16; i++) {
 2aa:	4781                	li	a5,0
 2ac:	4641                	li	a2,16
        if (threads[i] == current_thread) {
 2ae:	6314                	ld	a3,0(a4)
 2b0:	00a68763          	beq	a3,a0,2be <tsched+0x24>
    for (int i = 0; i < 16; i++) {
 2b4:	2785                	addiw	a5,a5,1
 2b6:	0721                	addi	a4,a4,8
 2b8:	fec79be3          	bne	a5,a2,2ae <tsched+0x14>
    int current_index = 0;
 2bc:	4781                	li	a5,0
            break;
        }
    }


    for (int i = 1; i < 17; i++) {
 2be:	0017869b          	addiw	a3,a5,1
 2c2:	0117861b          	addiw	a2,a5,17
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 2c6:	00001817          	auipc	a6,0x1
 2ca:	f5a80813          	addi	a6,a6,-166 # 1220 <threads>
 2ce:	488d                	li	a7,3
 2d0:	a021                	j	2d8 <tsched+0x3e>
    for (int i = 1; i < 17; i++) {
 2d2:	2685                	addiw	a3,a3,1
 2d4:	04c68363          	beq	a3,a2,31a <tsched+0x80>
        int next_index = (current_index + i) % 16;
 2d8:	41f6d71b          	sraiw	a4,a3,0x1f
 2dc:	01c7571b          	srliw	a4,a4,0x1c
 2e0:	00d707bb          	addw	a5,a4,a3
 2e4:	8bbd                	andi	a5,a5,15
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
 2e6:	9f99                	subw	a5,a5,a4
 2e8:	078e                	slli	a5,a5,0x3
 2ea:	97c2                	add	a5,a5,a6
 2ec:	638c                	ld	a1,0(a5)
 2ee:	d1f5                	beqz	a1,2d2 <tsched+0x38>
 2f0:	5dbc                	lw	a5,120(a1)
 2f2:	ff1790e3          	bne	a5,a7,2d2 <tsched+0x38>
{
 2f6:	1141                	addi	sp,sp,-16
 2f8:	e406                	sd	ra,8(sp)
 2fa:	e022                	sd	s0,0(sp)
 2fc:	0800                	addi	s0,sp,16
        }
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
 2fe:	00001797          	auipc	a5,0x1
 302:	d0b7b923          	sd	a1,-750(a5) # 1010 <current_thread>
        //printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
 306:	05a1                	addi	a1,a1,8
 308:	0521                	addi	a0,a0,8
 30a:	00000097          	auipc	ra,0x0
 30e:	19a080e7          	jalr	410(ra) # 4a4 <tswtch>
        //printf("Thread switch complete\n");
    }
}
 312:	60a2                	ld	ra,8(sp)
 314:	6402                	ld	s0,0(sp)
 316:	0141                	addi	sp,sp,16
 318:	8082                	ret
 31a:	8082                	ret

000000000000031c <thread_wrapper>:
{
 31c:	1101                	addi	sp,sp,-32
 31e:	ec06                	sd	ra,24(sp)
 320:	e822                	sd	s0,16(sp)
 322:	e426                	sd	s1,8(sp)
 324:	1000                	addi	s0,sp,32
    uint64 *stack_ptr = (uint64 *)current_thread->tcontext.sp;
 326:	00001497          	auipc	s1,0x1
 32a:	cea48493          	addi	s1,s1,-790 # 1010 <current_thread>
 32e:	609c                	ld	a5,0(s1)
 330:	6b9c                	ld	a5,16(a5)
    func(arg);
 332:	6398                	ld	a4,0(a5)
 334:	6788                	ld	a0,8(a5)
 336:	9702                	jalr	a4
    current_thread->state = EXITED;
 338:	609c                	ld	a5,0(s1)
 33a:	4719                	li	a4,6
 33c:	dfb8                	sw	a4,120(a5)
    tsched();
 33e:	00000097          	auipc	ra,0x0
 342:	f5c080e7          	jalr	-164(ra) # 29a <tsched>
}
 346:	60e2                	ld	ra,24(sp)
 348:	6442                	ld	s0,16(sp)
 34a:	64a2                	ld	s1,8(sp)
 34c:	6105                	addi	sp,sp,32
 34e:	8082                	ret

0000000000000350 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 350:	7179                	addi	sp,sp,-48
 352:	f406                	sd	ra,40(sp)
 354:	f022                	sd	s0,32(sp)
 356:	ec26                	sd	s1,24(sp)
 358:	e84a                	sd	s2,16(sp)
 35a:	e44e                	sd	s3,8(sp)
 35c:	1800                	addi	s0,sp,48
 35e:	84aa                	mv	s1,a0
 360:	8932                	mv	s2,a2
 362:	89b6                	mv	s3,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time


    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 364:	09800513          	li	a0,152
 368:	00001097          	auipc	ra,0x1
 36c:	876080e7          	jalr	-1930(ra) # bde <malloc>
 370:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 372:	478d                	li	a5,3
 374:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 376:	609c                	ld	a5,0(s1)
 378:	0927b423          	sd	s2,136(a5)
    (*thread)->arg = arg;
 37c:	609c                	ld	a5,0(s1)
 37e:	0937b023          	sd	s3,128(a5)
    (*thread)->tid = next_tid;
 382:	6098                	ld	a4,0(s1)
 384:	00001797          	auipc	a5,0x1
 388:	c7c78793          	addi	a5,a5,-900 # 1000 <next_tid>
 38c:	4394                	lw	a3,0(a5)
 38e:	00d70023          	sb	a3,0(a4)
    next_tid += 1;
 392:	4398                	lw	a4,0(a5)
 394:	2705                	addiw	a4,a4,1
 396:	c398                	sw	a4,0(a5)
    //(*thread)->tcontext.sp = (uint64)malloc(4096) + 4096;
    //(*thread)->tcontext.ra = (uint64)thread_wrapper;

    // Allocate stack memory for the thread
    uint64 stack_top = (uint64)malloc(4096) + 4096;
 398:	6505                	lui	a0,0x1
 39a:	00001097          	auipc	ra,0x1
 39e:	844080e7          	jalr	-1980(ra) # bde <malloc>

    // Place the function pointer and its argument on the top of the stack
    stack_top -= sizeof(uint64);
    *(uint64 *)stack_top = (uint64)arg;
 3a2:	6785                	lui	a5,0x1
 3a4:	00a78733          	add	a4,a5,a0
 3a8:	ff373c23          	sd	s3,-8(a4)
    stack_top -= sizeof(uint64);
 3ac:	17c1                	addi	a5,a5,-16 # ff0 <digits+0x228>
 3ae:	953e                	add	a0,a0,a5
    *(uint64 *)stack_top = (uint64)func;
 3b0:	01253023          	sd	s2,0(a0) # 1000 <next_tid>

    (*thread)->tcontext.sp = stack_top;
 3b4:	609c                	ld	a5,0(s1)
 3b6:	eb88                	sd	a0,16(a5)
    (*thread)->tcontext.ra = (uint64)thread_wrapper;
 3b8:	609c                	ld	a5,0(s1)
 3ba:	00000717          	auipc	a4,0x0
 3be:	f6270713          	addi	a4,a4,-158 # 31c <thread_wrapper>
 3c2:	e798                	sd	a4,8(a5)

    int thread_added = 0;
    for (int i = 0; i < 16; i++) {
 3c4:	00001717          	auipc	a4,0x1
 3c8:	e5c70713          	addi	a4,a4,-420 # 1220 <threads>
 3cc:	4781                	li	a5,0
 3ce:	4641                	li	a2,16
        if (threads[i] == NULL) {
 3d0:	6314                	ld	a3,0(a4)
 3d2:	c29d                	beqz	a3,3f8 <tcreate+0xa8>
    for (int i = 0; i < 16; i++) {
 3d4:	2785                	addiw	a5,a5,1
 3d6:	0721                	addi	a4,a4,8
 3d8:	fec79ce3          	bne	a5,a2,3d0 <tcreate+0x80>
        }
    }

    // If there are already 16 threads, return without creating a new one
    if (!thread_added) {
        free(*thread);
 3dc:	6088                	ld	a0,0(s1)
 3de:	00000097          	auipc	ra,0x0
 3e2:	77e080e7          	jalr	1918(ra) # b5c <free>
        *thread = NULL;
 3e6:	0004b023          	sd	zero,0(s1)
        return;
    }
}
 3ea:	70a2                	ld	ra,40(sp)
 3ec:	7402                	ld	s0,32(sp)
 3ee:	64e2                	ld	s1,24(sp)
 3f0:	6942                	ld	s2,16(sp)
 3f2:	69a2                	ld	s3,8(sp)
 3f4:	6145                	addi	sp,sp,48
 3f6:	8082                	ret
            threads[i] = *thread;
 3f8:	6094                	ld	a3,0(s1)
 3fa:	078e                	slli	a5,a5,0x3
 3fc:	00001717          	auipc	a4,0x1
 400:	e2470713          	addi	a4,a4,-476 # 1220 <threads>
 404:	97ba                	add	a5,a5,a4
 406:	e394                	sd	a3,0(a5)
    if (!thread_added) {
 408:	b7cd                	j	3ea <tcreate+0x9a>

000000000000040a <tyield>:
    return 0;
}


void tyield()
{
 40a:	1141                	addi	sp,sp,-16
 40c:	e406                	sd	ra,8(sp)
 40e:	e022                	sd	s0,0(sp)
 410:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread

    current_thread->state = RUNNABLE;
 412:	00001797          	auipc	a5,0x1
 416:	bfe7b783          	ld	a5,-1026(a5) # 1010 <current_thread>
 41a:	470d                	li	a4,3
 41c:	dfb8                	sw	a4,120(a5)
    tsched();
 41e:	00000097          	auipc	ra,0x0
 422:	e7c080e7          	jalr	-388(ra) # 29a <tsched>
}
 426:	60a2                	ld	ra,8(sp)
 428:	6402                	ld	s0,0(sp)
 42a:	0141                	addi	sp,sp,16
 42c:	8082                	ret

000000000000042e <tjoin>:
{
 42e:	1101                	addi	sp,sp,-32
 430:	ec06                	sd	ra,24(sp)
 432:	e822                	sd	s0,16(sp)
 434:	e426                	sd	s1,8(sp)
 436:	e04a                	sd	s2,0(sp)
 438:	1000                	addi	s0,sp,32
    for (int i = 0; i < 16; i++) {
 43a:	00001797          	auipc	a5,0x1
 43e:	de678793          	addi	a5,a5,-538 # 1220 <threads>
 442:	00001697          	auipc	a3,0x1
 446:	e5e68693          	addi	a3,a3,-418 # 12a0 <base>
 44a:	a021                	j	452 <tjoin+0x24>
 44c:	07a1                	addi	a5,a5,8
 44e:	02d78b63          	beq	a5,a3,484 <tjoin+0x56>
        if (threads[i] && threads[i]->tid == tid) {
 452:	6384                	ld	s1,0(a5)
 454:	dce5                	beqz	s1,44c <tjoin+0x1e>
 456:	0004c703          	lbu	a4,0(s1)
 45a:	fea719e3          	bne	a4,a0,44c <tjoin+0x1e>
    while (target_thread->state != EXITED) {
 45e:	5cb8                	lw	a4,120(s1)
 460:	4799                	li	a5,6
 462:	4919                	li	s2,6
 464:	02f70263          	beq	a4,a5,488 <tjoin+0x5a>
        tyield();
 468:	00000097          	auipc	ra,0x0
 46c:	fa2080e7          	jalr	-94(ra) # 40a <tyield>
    while (target_thread->state != EXITED) {
 470:	5cbc                	lw	a5,120(s1)
 472:	ff279be3          	bne	a5,s2,468 <tjoin+0x3a>
    return 0;
 476:	4501                	li	a0,0
}
 478:	60e2                	ld	ra,24(sp)
 47a:	6442                	ld	s0,16(sp)
 47c:	64a2                	ld	s1,8(sp)
 47e:	6902                	ld	s2,0(sp)
 480:	6105                	addi	sp,sp,32
 482:	8082                	ret
        return -1;
 484:	557d                	li	a0,-1
 486:	bfcd                	j	478 <tjoin+0x4a>
    return 0;
 488:	4501                	li	a0,0
 48a:	b7fd                	j	478 <tjoin+0x4a>

000000000000048c <twhoami>:

uint8 twhoami()
{
 48c:	1141                	addi	sp,sp,-16
 48e:	e422                	sd	s0,8(sp)
 490:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread

    return current_thread->tid;
    return 0;
}
 492:	00001797          	auipc	a5,0x1
 496:	b7e7b783          	ld	a5,-1154(a5) # 1010 <current_thread>
 49a:	0007c503          	lbu	a0,0(a5)
 49e:	6422                	ld	s0,8(sp)
 4a0:	0141                	addi	sp,sp,16
 4a2:	8082                	ret

00000000000004a4 <tswtch>:
 4a4:	00153023          	sd	ra,0(a0)
 4a8:	00253423          	sd	sp,8(a0)
 4ac:	e900                	sd	s0,16(a0)
 4ae:	ed04                	sd	s1,24(a0)
 4b0:	03253023          	sd	s2,32(a0)
 4b4:	03353423          	sd	s3,40(a0)
 4b8:	03453823          	sd	s4,48(a0)
 4bc:	03553c23          	sd	s5,56(a0)
 4c0:	05653023          	sd	s6,64(a0)
 4c4:	05753423          	sd	s7,72(a0)
 4c8:	05853823          	sd	s8,80(a0)
 4cc:	05953c23          	sd	s9,88(a0)
 4d0:	07a53023          	sd	s10,96(a0)
 4d4:	07b53423          	sd	s11,104(a0)
 4d8:	0005b083          	ld	ra,0(a1)
 4dc:	0085b103          	ld	sp,8(a1)
 4e0:	6980                	ld	s0,16(a1)
 4e2:	6d84                	ld	s1,24(a1)
 4e4:	0205b903          	ld	s2,32(a1)
 4e8:	0285b983          	ld	s3,40(a1)
 4ec:	0305ba03          	ld	s4,48(a1)
 4f0:	0385ba83          	ld	s5,56(a1)
 4f4:	0405bb03          	ld	s6,64(a1)
 4f8:	0485bb83          	ld	s7,72(a1)
 4fc:	0505bc03          	ld	s8,80(a1)
 500:	0585bc83          	ld	s9,88(a1)
 504:	0605bd03          	ld	s10,96(a1)
 508:	0685bd83          	ld	s11,104(a1)
 50c:	8082                	ret

000000000000050e <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 50e:	1101                	addi	sp,sp,-32
 510:	ec06                	sd	ra,24(sp)
 512:	e822                	sd	s0,16(sp)
 514:	e426                	sd	s1,8(sp)
 516:	e04a                	sd	s2,0(sp)
 518:	1000                	addi	s0,sp,32
 51a:	84aa                	mv	s1,a0
 51c:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    tinit();
 51e:	00000097          	auipc	ra,0x0
 522:	d1e080e7          	jalr	-738(ra) # 23c <tinit>
    // Set the main thread as the first element in the threads array
    threads[0] = main_thread; */
    

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 526:	85ca                	mv	a1,s2
 528:	8526                	mv	a0,s1
 52a:	00000097          	auipc	ra,0x0
 52e:	b60080e7          	jalr	-1184(ra) # 8a <main>
        if (running_threads > 0) {
            tsched(); // Schedule another thread to run
        }
    } */

    exit(res);
 532:	00000097          	auipc	ra,0x0
 536:	274080e7          	jalr	628(ra) # 7a6 <exit>

000000000000053a <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 53a:	1141                	addi	sp,sp,-16
 53c:	e422                	sd	s0,8(sp)
 53e:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 540:	87aa                	mv	a5,a0
 542:	0585                	addi	a1,a1,1
 544:	0785                	addi	a5,a5,1
 546:	fff5c703          	lbu	a4,-1(a1)
 54a:	fee78fa3          	sb	a4,-1(a5)
 54e:	fb75                	bnez	a4,542 <strcpy+0x8>
        ;
    return os;
}
 550:	6422                	ld	s0,8(sp)
 552:	0141                	addi	sp,sp,16
 554:	8082                	ret

0000000000000556 <strcmp>:

int strcmp(const char *p, const char *q)
{
 556:	1141                	addi	sp,sp,-16
 558:	e422                	sd	s0,8(sp)
 55a:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 55c:	00054783          	lbu	a5,0(a0)
 560:	cb91                	beqz	a5,574 <strcmp+0x1e>
 562:	0005c703          	lbu	a4,0(a1)
 566:	00f71763          	bne	a4,a5,574 <strcmp+0x1e>
        p++, q++;
 56a:	0505                	addi	a0,a0,1
 56c:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 56e:	00054783          	lbu	a5,0(a0)
 572:	fbe5                	bnez	a5,562 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 574:	0005c503          	lbu	a0,0(a1)
}
 578:	40a7853b          	subw	a0,a5,a0
 57c:	6422                	ld	s0,8(sp)
 57e:	0141                	addi	sp,sp,16
 580:	8082                	ret

0000000000000582 <strlen>:

uint strlen(const char *s)
{
 582:	1141                	addi	sp,sp,-16
 584:	e422                	sd	s0,8(sp)
 586:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 588:	00054783          	lbu	a5,0(a0)
 58c:	cf91                	beqz	a5,5a8 <strlen+0x26>
 58e:	0505                	addi	a0,a0,1
 590:	87aa                	mv	a5,a0
 592:	86be                	mv	a3,a5
 594:	0785                	addi	a5,a5,1
 596:	fff7c703          	lbu	a4,-1(a5)
 59a:	ff65                	bnez	a4,592 <strlen+0x10>
 59c:	40a6853b          	subw	a0,a3,a0
 5a0:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 5a2:	6422                	ld	s0,8(sp)
 5a4:	0141                	addi	sp,sp,16
 5a6:	8082                	ret
    for (n = 0; s[n]; n++)
 5a8:	4501                	li	a0,0
 5aa:	bfe5                	j	5a2 <strlen+0x20>

00000000000005ac <memset>:

void *
memset(void *dst, int c, uint n)
{
 5ac:	1141                	addi	sp,sp,-16
 5ae:	e422                	sd	s0,8(sp)
 5b0:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 5b2:	ca19                	beqz	a2,5c8 <memset+0x1c>
 5b4:	87aa                	mv	a5,a0
 5b6:	1602                	slli	a2,a2,0x20
 5b8:	9201                	srli	a2,a2,0x20
 5ba:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 5be:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 5c2:	0785                	addi	a5,a5,1
 5c4:	fee79de3          	bne	a5,a4,5be <memset+0x12>
    }
    return dst;
}
 5c8:	6422                	ld	s0,8(sp)
 5ca:	0141                	addi	sp,sp,16
 5cc:	8082                	ret

00000000000005ce <strchr>:

char *
strchr(const char *s, char c)
{
 5ce:	1141                	addi	sp,sp,-16
 5d0:	e422                	sd	s0,8(sp)
 5d2:	0800                	addi	s0,sp,16
    for (; *s; s++)
 5d4:	00054783          	lbu	a5,0(a0)
 5d8:	cb99                	beqz	a5,5ee <strchr+0x20>
        if (*s == c)
 5da:	00f58763          	beq	a1,a5,5e8 <strchr+0x1a>
    for (; *s; s++)
 5de:	0505                	addi	a0,a0,1
 5e0:	00054783          	lbu	a5,0(a0)
 5e4:	fbfd                	bnez	a5,5da <strchr+0xc>
            return (char *)s;
    return 0;
 5e6:	4501                	li	a0,0
}
 5e8:	6422                	ld	s0,8(sp)
 5ea:	0141                	addi	sp,sp,16
 5ec:	8082                	ret
    return 0;
 5ee:	4501                	li	a0,0
 5f0:	bfe5                	j	5e8 <strchr+0x1a>

00000000000005f2 <gets>:

char *
gets(char *buf, int max)
{
 5f2:	711d                	addi	sp,sp,-96
 5f4:	ec86                	sd	ra,88(sp)
 5f6:	e8a2                	sd	s0,80(sp)
 5f8:	e4a6                	sd	s1,72(sp)
 5fa:	e0ca                	sd	s2,64(sp)
 5fc:	fc4e                	sd	s3,56(sp)
 5fe:	f852                	sd	s4,48(sp)
 600:	f456                	sd	s5,40(sp)
 602:	f05a                	sd	s6,32(sp)
 604:	ec5e                	sd	s7,24(sp)
 606:	1080                	addi	s0,sp,96
 608:	8baa                	mv	s7,a0
 60a:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 60c:	892a                	mv	s2,a0
 60e:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 610:	4aa9                	li	s5,10
 612:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 614:	89a6                	mv	s3,s1
 616:	2485                	addiw	s1,s1,1
 618:	0344d863          	bge	s1,s4,648 <gets+0x56>
        cc = read(0, &c, 1);
 61c:	4605                	li	a2,1
 61e:	faf40593          	addi	a1,s0,-81
 622:	4501                	li	a0,0
 624:	00000097          	auipc	ra,0x0
 628:	19a080e7          	jalr	410(ra) # 7be <read>
        if (cc < 1)
 62c:	00a05e63          	blez	a0,648 <gets+0x56>
        buf[i++] = c;
 630:	faf44783          	lbu	a5,-81(s0)
 634:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 638:	01578763          	beq	a5,s5,646 <gets+0x54>
 63c:	0905                	addi	s2,s2,1
 63e:	fd679be3          	bne	a5,s6,614 <gets+0x22>
    for (i = 0; i + 1 < max;)
 642:	89a6                	mv	s3,s1
 644:	a011                	j	648 <gets+0x56>
 646:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 648:	99de                	add	s3,s3,s7
 64a:	00098023          	sb	zero,0(s3)
    return buf;
}
 64e:	855e                	mv	a0,s7
 650:	60e6                	ld	ra,88(sp)
 652:	6446                	ld	s0,80(sp)
 654:	64a6                	ld	s1,72(sp)
 656:	6906                	ld	s2,64(sp)
 658:	79e2                	ld	s3,56(sp)
 65a:	7a42                	ld	s4,48(sp)
 65c:	7aa2                	ld	s5,40(sp)
 65e:	7b02                	ld	s6,32(sp)
 660:	6be2                	ld	s7,24(sp)
 662:	6125                	addi	sp,sp,96
 664:	8082                	ret

0000000000000666 <stat>:

int stat(const char *n, struct stat *st)
{
 666:	1101                	addi	sp,sp,-32
 668:	ec06                	sd	ra,24(sp)
 66a:	e822                	sd	s0,16(sp)
 66c:	e426                	sd	s1,8(sp)
 66e:	e04a                	sd	s2,0(sp)
 670:	1000                	addi	s0,sp,32
 672:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 674:	4581                	li	a1,0
 676:	00000097          	auipc	ra,0x0
 67a:	170080e7          	jalr	368(ra) # 7e6 <open>
    if (fd < 0)
 67e:	02054563          	bltz	a0,6a8 <stat+0x42>
 682:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 684:	85ca                	mv	a1,s2
 686:	00000097          	auipc	ra,0x0
 68a:	178080e7          	jalr	376(ra) # 7fe <fstat>
 68e:	892a                	mv	s2,a0
    close(fd);
 690:	8526                	mv	a0,s1
 692:	00000097          	auipc	ra,0x0
 696:	13c080e7          	jalr	316(ra) # 7ce <close>
    return r;
}
 69a:	854a                	mv	a0,s2
 69c:	60e2                	ld	ra,24(sp)
 69e:	6442                	ld	s0,16(sp)
 6a0:	64a2                	ld	s1,8(sp)
 6a2:	6902                	ld	s2,0(sp)
 6a4:	6105                	addi	sp,sp,32
 6a6:	8082                	ret
        return -1;
 6a8:	597d                	li	s2,-1
 6aa:	bfc5                	j	69a <stat+0x34>

00000000000006ac <atoi>:

int atoi(const char *s)
{
 6ac:	1141                	addi	sp,sp,-16
 6ae:	e422                	sd	s0,8(sp)
 6b0:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 6b2:	00054683          	lbu	a3,0(a0)
 6b6:	fd06879b          	addiw	a5,a3,-48
 6ba:	0ff7f793          	zext.b	a5,a5
 6be:	4625                	li	a2,9
 6c0:	02f66863          	bltu	a2,a5,6f0 <atoi+0x44>
 6c4:	872a                	mv	a4,a0
    n = 0;
 6c6:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 6c8:	0705                	addi	a4,a4,1
 6ca:	0025179b          	slliw	a5,a0,0x2
 6ce:	9fa9                	addw	a5,a5,a0
 6d0:	0017979b          	slliw	a5,a5,0x1
 6d4:	9fb5                	addw	a5,a5,a3
 6d6:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 6da:	00074683          	lbu	a3,0(a4)
 6de:	fd06879b          	addiw	a5,a3,-48
 6e2:	0ff7f793          	zext.b	a5,a5
 6e6:	fef671e3          	bgeu	a2,a5,6c8 <atoi+0x1c>
    return n;
}
 6ea:	6422                	ld	s0,8(sp)
 6ec:	0141                	addi	sp,sp,16
 6ee:	8082                	ret
    n = 0;
 6f0:	4501                	li	a0,0
 6f2:	bfe5                	j	6ea <atoi+0x3e>

00000000000006f4 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 6f4:	1141                	addi	sp,sp,-16
 6f6:	e422                	sd	s0,8(sp)
 6f8:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 6fa:	02b57463          	bgeu	a0,a1,722 <memmove+0x2e>
    {
        while (n-- > 0)
 6fe:	00c05f63          	blez	a2,71c <memmove+0x28>
 702:	1602                	slli	a2,a2,0x20
 704:	9201                	srli	a2,a2,0x20
 706:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 70a:	872a                	mv	a4,a0
            *dst++ = *src++;
 70c:	0585                	addi	a1,a1,1
 70e:	0705                	addi	a4,a4,1
 710:	fff5c683          	lbu	a3,-1(a1)
 714:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 718:	fee79ae3          	bne	a5,a4,70c <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 71c:	6422                	ld	s0,8(sp)
 71e:	0141                	addi	sp,sp,16
 720:	8082                	ret
        dst += n;
 722:	00c50733          	add	a4,a0,a2
        src += n;
 726:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 728:	fec05ae3          	blez	a2,71c <memmove+0x28>
 72c:	fff6079b          	addiw	a5,a2,-1
 730:	1782                	slli	a5,a5,0x20
 732:	9381                	srli	a5,a5,0x20
 734:	fff7c793          	not	a5,a5
 738:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 73a:	15fd                	addi	a1,a1,-1
 73c:	177d                	addi	a4,a4,-1
 73e:	0005c683          	lbu	a3,0(a1)
 742:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 746:	fee79ae3          	bne	a5,a4,73a <memmove+0x46>
 74a:	bfc9                	j	71c <memmove+0x28>

000000000000074c <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 74c:	1141                	addi	sp,sp,-16
 74e:	e422                	sd	s0,8(sp)
 750:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 752:	ca05                	beqz	a2,782 <memcmp+0x36>
 754:	fff6069b          	addiw	a3,a2,-1
 758:	1682                	slli	a3,a3,0x20
 75a:	9281                	srli	a3,a3,0x20
 75c:	0685                	addi	a3,a3,1
 75e:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 760:	00054783          	lbu	a5,0(a0)
 764:	0005c703          	lbu	a4,0(a1)
 768:	00e79863          	bne	a5,a4,778 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 76c:	0505                	addi	a0,a0,1
        p2++;
 76e:	0585                	addi	a1,a1,1
    while (n-- > 0)
 770:	fed518e3          	bne	a0,a3,760 <memcmp+0x14>
    }
    return 0;
 774:	4501                	li	a0,0
 776:	a019                	j	77c <memcmp+0x30>
            return *p1 - *p2;
 778:	40e7853b          	subw	a0,a5,a4
}
 77c:	6422                	ld	s0,8(sp)
 77e:	0141                	addi	sp,sp,16
 780:	8082                	ret
    return 0;
 782:	4501                	li	a0,0
 784:	bfe5                	j	77c <memcmp+0x30>

0000000000000786 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 786:	1141                	addi	sp,sp,-16
 788:	e406                	sd	ra,8(sp)
 78a:	e022                	sd	s0,0(sp)
 78c:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 78e:	00000097          	auipc	ra,0x0
 792:	f66080e7          	jalr	-154(ra) # 6f4 <memmove>
}
 796:	60a2                	ld	ra,8(sp)
 798:	6402                	ld	s0,0(sp)
 79a:	0141                	addi	sp,sp,16
 79c:	8082                	ret

000000000000079e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 79e:	4885                	li	a7,1
 ecall
 7a0:	00000073          	ecall
 ret
 7a4:	8082                	ret

00000000000007a6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 7a6:	4889                	li	a7,2
 ecall
 7a8:	00000073          	ecall
 ret
 7ac:	8082                	ret

00000000000007ae <wait>:
.global wait
wait:
 li a7, SYS_wait
 7ae:	488d                	li	a7,3
 ecall
 7b0:	00000073          	ecall
 ret
 7b4:	8082                	ret

00000000000007b6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 7b6:	4891                	li	a7,4
 ecall
 7b8:	00000073          	ecall
 ret
 7bc:	8082                	ret

00000000000007be <read>:
.global read
read:
 li a7, SYS_read
 7be:	4895                	li	a7,5
 ecall
 7c0:	00000073          	ecall
 ret
 7c4:	8082                	ret

00000000000007c6 <write>:
.global write
write:
 li a7, SYS_write
 7c6:	48c1                	li	a7,16
 ecall
 7c8:	00000073          	ecall
 ret
 7cc:	8082                	ret

00000000000007ce <close>:
.global close
close:
 li a7, SYS_close
 7ce:	48d5                	li	a7,21
 ecall
 7d0:	00000073          	ecall
 ret
 7d4:	8082                	ret

00000000000007d6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 7d6:	4899                	li	a7,6
 ecall
 7d8:	00000073          	ecall
 ret
 7dc:	8082                	ret

00000000000007de <exec>:
.global exec
exec:
 li a7, SYS_exec
 7de:	489d                	li	a7,7
 ecall
 7e0:	00000073          	ecall
 ret
 7e4:	8082                	ret

00000000000007e6 <open>:
.global open
open:
 li a7, SYS_open
 7e6:	48bd                	li	a7,15
 ecall
 7e8:	00000073          	ecall
 ret
 7ec:	8082                	ret

00000000000007ee <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7ee:	48c5                	li	a7,17
 ecall
 7f0:	00000073          	ecall
 ret
 7f4:	8082                	ret

00000000000007f6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7f6:	48c9                	li	a7,18
 ecall
 7f8:	00000073          	ecall
 ret
 7fc:	8082                	ret

00000000000007fe <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7fe:	48a1                	li	a7,8
 ecall
 800:	00000073          	ecall
 ret
 804:	8082                	ret

0000000000000806 <link>:
.global link
link:
 li a7, SYS_link
 806:	48cd                	li	a7,19
 ecall
 808:	00000073          	ecall
 ret
 80c:	8082                	ret

000000000000080e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 80e:	48d1                	li	a7,20
 ecall
 810:	00000073          	ecall
 ret
 814:	8082                	ret

0000000000000816 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 816:	48a5                	li	a7,9
 ecall
 818:	00000073          	ecall
 ret
 81c:	8082                	ret

000000000000081e <dup>:
.global dup
dup:
 li a7, SYS_dup
 81e:	48a9                	li	a7,10
 ecall
 820:	00000073          	ecall
 ret
 824:	8082                	ret

0000000000000826 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 826:	48ad                	li	a7,11
 ecall
 828:	00000073          	ecall
 ret
 82c:	8082                	ret

000000000000082e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 82e:	48b1                	li	a7,12
 ecall
 830:	00000073          	ecall
 ret
 834:	8082                	ret

0000000000000836 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 836:	48b5                	li	a7,13
 ecall
 838:	00000073          	ecall
 ret
 83c:	8082                	ret

000000000000083e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 83e:	48b9                	li	a7,14
 ecall
 840:	00000073          	ecall
 ret
 844:	8082                	ret

0000000000000846 <ps>:
.global ps
ps:
 li a7, SYS_ps
 846:	48d9                	li	a7,22
 ecall
 848:	00000073          	ecall
 ret
 84c:	8082                	ret

000000000000084e <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 84e:	48dd                	li	a7,23
 ecall
 850:	00000073          	ecall
 ret
 854:	8082                	ret

0000000000000856 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 856:	48e1                	li	a7,24
 ecall
 858:	00000073          	ecall
 ret
 85c:	8082                	ret

000000000000085e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 85e:	1101                	addi	sp,sp,-32
 860:	ec06                	sd	ra,24(sp)
 862:	e822                	sd	s0,16(sp)
 864:	1000                	addi	s0,sp,32
 866:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 86a:	4605                	li	a2,1
 86c:	fef40593          	addi	a1,s0,-17
 870:	00000097          	auipc	ra,0x0
 874:	f56080e7          	jalr	-170(ra) # 7c6 <write>
}
 878:	60e2                	ld	ra,24(sp)
 87a:	6442                	ld	s0,16(sp)
 87c:	6105                	addi	sp,sp,32
 87e:	8082                	ret

0000000000000880 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 880:	7139                	addi	sp,sp,-64
 882:	fc06                	sd	ra,56(sp)
 884:	f822                	sd	s0,48(sp)
 886:	f426                	sd	s1,40(sp)
 888:	f04a                	sd	s2,32(sp)
 88a:	ec4e                	sd	s3,24(sp)
 88c:	0080                	addi	s0,sp,64
 88e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 890:	c299                	beqz	a3,896 <printint+0x16>
 892:	0805c963          	bltz	a1,924 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 896:	2581                	sext.w	a1,a1
  neg = 0;
 898:	4881                	li	a7,0
 89a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 89e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 8a0:	2601                	sext.w	a2,a2
 8a2:	00000517          	auipc	a0,0x0
 8a6:	52650513          	addi	a0,a0,1318 # dc8 <digits>
 8aa:	883a                	mv	a6,a4
 8ac:	2705                	addiw	a4,a4,1
 8ae:	02c5f7bb          	remuw	a5,a1,a2
 8b2:	1782                	slli	a5,a5,0x20
 8b4:	9381                	srli	a5,a5,0x20
 8b6:	97aa                	add	a5,a5,a0
 8b8:	0007c783          	lbu	a5,0(a5)
 8bc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 8c0:	0005879b          	sext.w	a5,a1
 8c4:	02c5d5bb          	divuw	a1,a1,a2
 8c8:	0685                	addi	a3,a3,1
 8ca:	fec7f0e3          	bgeu	a5,a2,8aa <printint+0x2a>
  if(neg)
 8ce:	00088c63          	beqz	a7,8e6 <printint+0x66>
    buf[i++] = '-';
 8d2:	fd070793          	addi	a5,a4,-48
 8d6:	00878733          	add	a4,a5,s0
 8da:	02d00793          	li	a5,45
 8de:	fef70823          	sb	a5,-16(a4)
 8e2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 8e6:	02e05863          	blez	a4,916 <printint+0x96>
 8ea:	fc040793          	addi	a5,s0,-64
 8ee:	00e78933          	add	s2,a5,a4
 8f2:	fff78993          	addi	s3,a5,-1
 8f6:	99ba                	add	s3,s3,a4
 8f8:	377d                	addiw	a4,a4,-1
 8fa:	1702                	slli	a4,a4,0x20
 8fc:	9301                	srli	a4,a4,0x20
 8fe:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 902:	fff94583          	lbu	a1,-1(s2)
 906:	8526                	mv	a0,s1
 908:	00000097          	auipc	ra,0x0
 90c:	f56080e7          	jalr	-170(ra) # 85e <putc>
  while(--i >= 0)
 910:	197d                	addi	s2,s2,-1
 912:	ff3918e3          	bne	s2,s3,902 <printint+0x82>
}
 916:	70e2                	ld	ra,56(sp)
 918:	7442                	ld	s0,48(sp)
 91a:	74a2                	ld	s1,40(sp)
 91c:	7902                	ld	s2,32(sp)
 91e:	69e2                	ld	s3,24(sp)
 920:	6121                	addi	sp,sp,64
 922:	8082                	ret
    x = -xx;
 924:	40b005bb          	negw	a1,a1
    neg = 1;
 928:	4885                	li	a7,1
    x = -xx;
 92a:	bf85                	j	89a <printint+0x1a>

000000000000092c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 92c:	715d                	addi	sp,sp,-80
 92e:	e486                	sd	ra,72(sp)
 930:	e0a2                	sd	s0,64(sp)
 932:	fc26                	sd	s1,56(sp)
 934:	f84a                	sd	s2,48(sp)
 936:	f44e                	sd	s3,40(sp)
 938:	f052                	sd	s4,32(sp)
 93a:	ec56                	sd	s5,24(sp)
 93c:	e85a                	sd	s6,16(sp)
 93e:	e45e                	sd	s7,8(sp)
 940:	e062                	sd	s8,0(sp)
 942:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 944:	0005c903          	lbu	s2,0(a1)
 948:	18090c63          	beqz	s2,ae0 <vprintf+0x1b4>
 94c:	8aaa                	mv	s5,a0
 94e:	8bb2                	mv	s7,a2
 950:	00158493          	addi	s1,a1,1
  state = 0;
 954:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 956:	02500a13          	li	s4,37
 95a:	4b55                	li	s6,21
 95c:	a839                	j	97a <vprintf+0x4e>
        putc(fd, c);
 95e:	85ca                	mv	a1,s2
 960:	8556                	mv	a0,s5
 962:	00000097          	auipc	ra,0x0
 966:	efc080e7          	jalr	-260(ra) # 85e <putc>
 96a:	a019                	j	970 <vprintf+0x44>
    } else if(state == '%'){
 96c:	01498d63          	beq	s3,s4,986 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 970:	0485                	addi	s1,s1,1
 972:	fff4c903          	lbu	s2,-1(s1)
 976:	16090563          	beqz	s2,ae0 <vprintf+0x1b4>
    if(state == 0){
 97a:	fe0999e3          	bnez	s3,96c <vprintf+0x40>
      if(c == '%'){
 97e:	ff4910e3          	bne	s2,s4,95e <vprintf+0x32>
        state = '%';
 982:	89d2                	mv	s3,s4
 984:	b7f5                	j	970 <vprintf+0x44>
      if(c == 'd'){
 986:	13490263          	beq	s2,s4,aaa <vprintf+0x17e>
 98a:	f9d9079b          	addiw	a5,s2,-99
 98e:	0ff7f793          	zext.b	a5,a5
 992:	12fb6563          	bltu	s6,a5,abc <vprintf+0x190>
 996:	f9d9079b          	addiw	a5,s2,-99
 99a:	0ff7f713          	zext.b	a4,a5
 99e:	10eb6f63          	bltu	s6,a4,abc <vprintf+0x190>
 9a2:	00271793          	slli	a5,a4,0x2
 9a6:	00000717          	auipc	a4,0x0
 9aa:	3ca70713          	addi	a4,a4,970 # d70 <malloc+0x192>
 9ae:	97ba                	add	a5,a5,a4
 9b0:	439c                	lw	a5,0(a5)
 9b2:	97ba                	add	a5,a5,a4
 9b4:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 9b6:	008b8913          	addi	s2,s7,8
 9ba:	4685                	li	a3,1
 9bc:	4629                	li	a2,10
 9be:	000ba583          	lw	a1,0(s7)
 9c2:	8556                	mv	a0,s5
 9c4:	00000097          	auipc	ra,0x0
 9c8:	ebc080e7          	jalr	-324(ra) # 880 <printint>
 9cc:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9ce:	4981                	li	s3,0
 9d0:	b745                	j	970 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9d2:	008b8913          	addi	s2,s7,8
 9d6:	4681                	li	a3,0
 9d8:	4629                	li	a2,10
 9da:	000ba583          	lw	a1,0(s7)
 9de:	8556                	mv	a0,s5
 9e0:	00000097          	auipc	ra,0x0
 9e4:	ea0080e7          	jalr	-352(ra) # 880 <printint>
 9e8:	8bca                	mv	s7,s2
      state = 0;
 9ea:	4981                	li	s3,0
 9ec:	b751                	j	970 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 9ee:	008b8913          	addi	s2,s7,8
 9f2:	4681                	li	a3,0
 9f4:	4641                	li	a2,16
 9f6:	000ba583          	lw	a1,0(s7)
 9fa:	8556                	mv	a0,s5
 9fc:	00000097          	auipc	ra,0x0
 a00:	e84080e7          	jalr	-380(ra) # 880 <printint>
 a04:	8bca                	mv	s7,s2
      state = 0;
 a06:	4981                	li	s3,0
 a08:	b7a5                	j	970 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 a0a:	008b8c13          	addi	s8,s7,8
 a0e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a12:	03000593          	li	a1,48
 a16:	8556                	mv	a0,s5
 a18:	00000097          	auipc	ra,0x0
 a1c:	e46080e7          	jalr	-442(ra) # 85e <putc>
  putc(fd, 'x');
 a20:	07800593          	li	a1,120
 a24:	8556                	mv	a0,s5
 a26:	00000097          	auipc	ra,0x0
 a2a:	e38080e7          	jalr	-456(ra) # 85e <putc>
 a2e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a30:	00000b97          	auipc	s7,0x0
 a34:	398b8b93          	addi	s7,s7,920 # dc8 <digits>
 a38:	03c9d793          	srli	a5,s3,0x3c
 a3c:	97de                	add	a5,a5,s7
 a3e:	0007c583          	lbu	a1,0(a5)
 a42:	8556                	mv	a0,s5
 a44:	00000097          	auipc	ra,0x0
 a48:	e1a080e7          	jalr	-486(ra) # 85e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a4c:	0992                	slli	s3,s3,0x4
 a4e:	397d                	addiw	s2,s2,-1
 a50:	fe0914e3          	bnez	s2,a38 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 a54:	8be2                	mv	s7,s8
      state = 0;
 a56:	4981                	li	s3,0
 a58:	bf21                	j	970 <vprintf+0x44>
        s = va_arg(ap, char*);
 a5a:	008b8993          	addi	s3,s7,8
 a5e:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 a62:	02090163          	beqz	s2,a84 <vprintf+0x158>
        while(*s != 0){
 a66:	00094583          	lbu	a1,0(s2)
 a6a:	c9a5                	beqz	a1,ada <vprintf+0x1ae>
          putc(fd, *s);
 a6c:	8556                	mv	a0,s5
 a6e:	00000097          	auipc	ra,0x0
 a72:	df0080e7          	jalr	-528(ra) # 85e <putc>
          s++;
 a76:	0905                	addi	s2,s2,1
        while(*s != 0){
 a78:	00094583          	lbu	a1,0(s2)
 a7c:	f9e5                	bnez	a1,a6c <vprintf+0x140>
        s = va_arg(ap, char*);
 a7e:	8bce                	mv	s7,s3
      state = 0;
 a80:	4981                	li	s3,0
 a82:	b5fd                	j	970 <vprintf+0x44>
          s = "(null)";
 a84:	00000917          	auipc	s2,0x0
 a88:	2e490913          	addi	s2,s2,740 # d68 <malloc+0x18a>
        while(*s != 0){
 a8c:	02800593          	li	a1,40
 a90:	bff1                	j	a6c <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 a92:	008b8913          	addi	s2,s7,8
 a96:	000bc583          	lbu	a1,0(s7)
 a9a:	8556                	mv	a0,s5
 a9c:	00000097          	auipc	ra,0x0
 aa0:	dc2080e7          	jalr	-574(ra) # 85e <putc>
 aa4:	8bca                	mv	s7,s2
      state = 0;
 aa6:	4981                	li	s3,0
 aa8:	b5e1                	j	970 <vprintf+0x44>
        putc(fd, c);
 aaa:	02500593          	li	a1,37
 aae:	8556                	mv	a0,s5
 ab0:	00000097          	auipc	ra,0x0
 ab4:	dae080e7          	jalr	-594(ra) # 85e <putc>
      state = 0;
 ab8:	4981                	li	s3,0
 aba:	bd5d                	j	970 <vprintf+0x44>
        putc(fd, '%');
 abc:	02500593          	li	a1,37
 ac0:	8556                	mv	a0,s5
 ac2:	00000097          	auipc	ra,0x0
 ac6:	d9c080e7          	jalr	-612(ra) # 85e <putc>
        putc(fd, c);
 aca:	85ca                	mv	a1,s2
 acc:	8556                	mv	a0,s5
 ace:	00000097          	auipc	ra,0x0
 ad2:	d90080e7          	jalr	-624(ra) # 85e <putc>
      state = 0;
 ad6:	4981                	li	s3,0
 ad8:	bd61                	j	970 <vprintf+0x44>
        s = va_arg(ap, char*);
 ada:	8bce                	mv	s7,s3
      state = 0;
 adc:	4981                	li	s3,0
 ade:	bd49                	j	970 <vprintf+0x44>
    }
  }
}
 ae0:	60a6                	ld	ra,72(sp)
 ae2:	6406                	ld	s0,64(sp)
 ae4:	74e2                	ld	s1,56(sp)
 ae6:	7942                	ld	s2,48(sp)
 ae8:	79a2                	ld	s3,40(sp)
 aea:	7a02                	ld	s4,32(sp)
 aec:	6ae2                	ld	s5,24(sp)
 aee:	6b42                	ld	s6,16(sp)
 af0:	6ba2                	ld	s7,8(sp)
 af2:	6c02                	ld	s8,0(sp)
 af4:	6161                	addi	sp,sp,80
 af6:	8082                	ret

0000000000000af8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 af8:	715d                	addi	sp,sp,-80
 afa:	ec06                	sd	ra,24(sp)
 afc:	e822                	sd	s0,16(sp)
 afe:	1000                	addi	s0,sp,32
 b00:	e010                	sd	a2,0(s0)
 b02:	e414                	sd	a3,8(s0)
 b04:	e818                	sd	a4,16(s0)
 b06:	ec1c                	sd	a5,24(s0)
 b08:	03043023          	sd	a6,32(s0)
 b0c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b10:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b14:	8622                	mv	a2,s0
 b16:	00000097          	auipc	ra,0x0
 b1a:	e16080e7          	jalr	-490(ra) # 92c <vprintf>
}
 b1e:	60e2                	ld	ra,24(sp)
 b20:	6442                	ld	s0,16(sp)
 b22:	6161                	addi	sp,sp,80
 b24:	8082                	ret

0000000000000b26 <printf>:

void
printf(const char *fmt, ...)
{
 b26:	711d                	addi	sp,sp,-96
 b28:	ec06                	sd	ra,24(sp)
 b2a:	e822                	sd	s0,16(sp)
 b2c:	1000                	addi	s0,sp,32
 b2e:	e40c                	sd	a1,8(s0)
 b30:	e810                	sd	a2,16(s0)
 b32:	ec14                	sd	a3,24(s0)
 b34:	f018                	sd	a4,32(s0)
 b36:	f41c                	sd	a5,40(s0)
 b38:	03043823          	sd	a6,48(s0)
 b3c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b40:	00840613          	addi	a2,s0,8
 b44:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b48:	85aa                	mv	a1,a0
 b4a:	4505                	li	a0,1
 b4c:	00000097          	auipc	ra,0x0
 b50:	de0080e7          	jalr	-544(ra) # 92c <vprintf>
}
 b54:	60e2                	ld	ra,24(sp)
 b56:	6442                	ld	s0,16(sp)
 b58:	6125                	addi	sp,sp,96
 b5a:	8082                	ret

0000000000000b5c <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 b5c:	1141                	addi	sp,sp,-16
 b5e:	e422                	sd	s0,8(sp)
 b60:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 b62:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b66:	00000797          	auipc	a5,0x0
 b6a:	4b27b783          	ld	a5,1202(a5) # 1018 <freep>
 b6e:	a02d                	j	b98 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 b70:	4618                	lw	a4,8(a2)
 b72:	9f2d                	addw	a4,a4,a1
 b74:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 b78:	6398                	ld	a4,0(a5)
 b7a:	6310                	ld	a2,0(a4)
 b7c:	a83d                	j	bba <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 b7e:	ff852703          	lw	a4,-8(a0)
 b82:	9f31                	addw	a4,a4,a2
 b84:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 b86:	ff053683          	ld	a3,-16(a0)
 b8a:	a091                	j	bce <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b8c:	6398                	ld	a4,0(a5)
 b8e:	00e7e463          	bltu	a5,a4,b96 <free+0x3a>
 b92:	00e6ea63          	bltu	a3,a4,ba6 <free+0x4a>
{
 b96:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b98:	fed7fae3          	bgeu	a5,a3,b8c <free+0x30>
 b9c:	6398                	ld	a4,0(a5)
 b9e:	00e6e463          	bltu	a3,a4,ba6 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ba2:	fee7eae3          	bltu	a5,a4,b96 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 ba6:	ff852583          	lw	a1,-8(a0)
 baa:	6390                	ld	a2,0(a5)
 bac:	02059813          	slli	a6,a1,0x20
 bb0:	01c85713          	srli	a4,a6,0x1c
 bb4:	9736                	add	a4,a4,a3
 bb6:	fae60de3          	beq	a2,a4,b70 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 bba:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 bbe:	4790                	lw	a2,8(a5)
 bc0:	02061593          	slli	a1,a2,0x20
 bc4:	01c5d713          	srli	a4,a1,0x1c
 bc8:	973e                	add	a4,a4,a5
 bca:	fae68ae3          	beq	a3,a4,b7e <free+0x22>
        p->s.ptr = bp->s.ptr;
 bce:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 bd0:	00000717          	auipc	a4,0x0
 bd4:	44f73423          	sd	a5,1096(a4) # 1018 <freep>
}
 bd8:	6422                	ld	s0,8(sp)
 bda:	0141                	addi	sp,sp,16
 bdc:	8082                	ret

0000000000000bde <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 bde:	7139                	addi	sp,sp,-64
 be0:	fc06                	sd	ra,56(sp)
 be2:	f822                	sd	s0,48(sp)
 be4:	f426                	sd	s1,40(sp)
 be6:	f04a                	sd	s2,32(sp)
 be8:	ec4e                	sd	s3,24(sp)
 bea:	e852                	sd	s4,16(sp)
 bec:	e456                	sd	s5,8(sp)
 bee:	e05a                	sd	s6,0(sp)
 bf0:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 bf2:	02051493          	slli	s1,a0,0x20
 bf6:	9081                	srli	s1,s1,0x20
 bf8:	04bd                	addi	s1,s1,15
 bfa:	8091                	srli	s1,s1,0x4
 bfc:	0014899b          	addiw	s3,s1,1
 c00:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 c02:	00000517          	auipc	a0,0x0
 c06:	41653503          	ld	a0,1046(a0) # 1018 <freep>
 c0a:	c515                	beqz	a0,c36 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 c0c:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 c0e:	4798                	lw	a4,8(a5)
 c10:	02977f63          	bgeu	a4,s1,c4e <malloc+0x70>
    if (nu < 4096)
 c14:	8a4e                	mv	s4,s3
 c16:	0009871b          	sext.w	a4,s3
 c1a:	6685                	lui	a3,0x1
 c1c:	00d77363          	bgeu	a4,a3,c22 <malloc+0x44>
 c20:	6a05                	lui	s4,0x1
 c22:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 c26:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 c2a:	00000917          	auipc	s2,0x0
 c2e:	3ee90913          	addi	s2,s2,1006 # 1018 <freep>
    if (p == (char *)-1)
 c32:	5afd                	li	s5,-1
 c34:	a895                	j	ca8 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 c36:	00000797          	auipc	a5,0x0
 c3a:	66a78793          	addi	a5,a5,1642 # 12a0 <base>
 c3e:	00000717          	auipc	a4,0x0
 c42:	3cf73d23          	sd	a5,986(a4) # 1018 <freep>
 c46:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 c48:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 c4c:	b7e1                	j	c14 <malloc+0x36>
            if (p->s.size == nunits)
 c4e:	02e48c63          	beq	s1,a4,c86 <malloc+0xa8>
                p->s.size -= nunits;
 c52:	4137073b          	subw	a4,a4,s3
 c56:	c798                	sw	a4,8(a5)
                p += p->s.size;
 c58:	02071693          	slli	a3,a4,0x20
 c5c:	01c6d713          	srli	a4,a3,0x1c
 c60:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 c62:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 c66:	00000717          	auipc	a4,0x0
 c6a:	3aa73923          	sd	a0,946(a4) # 1018 <freep>
            return (void *)(p + 1);
 c6e:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 c72:	70e2                	ld	ra,56(sp)
 c74:	7442                	ld	s0,48(sp)
 c76:	74a2                	ld	s1,40(sp)
 c78:	7902                	ld	s2,32(sp)
 c7a:	69e2                	ld	s3,24(sp)
 c7c:	6a42                	ld	s4,16(sp)
 c7e:	6aa2                	ld	s5,8(sp)
 c80:	6b02                	ld	s6,0(sp)
 c82:	6121                	addi	sp,sp,64
 c84:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 c86:	6398                	ld	a4,0(a5)
 c88:	e118                	sd	a4,0(a0)
 c8a:	bff1                	j	c66 <malloc+0x88>
    hp->s.size = nu;
 c8c:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 c90:	0541                	addi	a0,a0,16
 c92:	00000097          	auipc	ra,0x0
 c96:	eca080e7          	jalr	-310(ra) # b5c <free>
    return freep;
 c9a:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 c9e:	d971                	beqz	a0,c72 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 ca0:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 ca2:	4798                	lw	a4,8(a5)
 ca4:	fa9775e3          	bgeu	a4,s1,c4e <malloc+0x70>
        if (p == freep)
 ca8:	00093703          	ld	a4,0(s2)
 cac:	853e                	mv	a0,a5
 cae:	fef719e3          	bne	a4,a5,ca0 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 cb2:	8552                	mv	a0,s4
 cb4:	00000097          	auipc	ra,0x0
 cb8:	b7a080e7          	jalr	-1158(ra) # 82e <sbrk>
    if (p == (char *)-1)
 cbc:	fd5518e3          	bne	a0,s5,c8c <malloc+0xae>
                return 0;
 cc0:	4501                	li	a0,0
 cc2:	bf45                	j	c72 <malloc+0x94>
