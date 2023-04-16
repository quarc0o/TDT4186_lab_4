
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
  14:	00090913          	mv	s2,s2
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	00000097          	auipc	ra,0x0
  24:	5ce080e7          	jalr	1486(ra) # 5ee <read>
  28:	84aa                	mv	s1,a0
  2a:	02a05963          	blez	a0,5c <cat+0x5c>
    {
        if (write(1, buf, n) != n)
  2e:	8626                	mv	a2,s1
  30:	85ca                	mv	a1,s2
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	5c2080e7          	jalr	1474(ra) # 5f6 <write>
  3c:	fc950ee3          	beq	a0,s1,18 <cat+0x18>
        {
            fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	ac058593          	addi	a1,a1,-1344 # b00 <malloc+0xf2>
  48:	4509                	li	a0,2
  4a:	00001097          	auipc	ra,0x1
  4e:	8de080e7          	jalr	-1826(ra) # 928 <fprintf>
            exit(1);
  52:	4505                	li	a0,1
  54:	00000097          	auipc	ra,0x0
  58:	582080e7          	jalr	1410(ra) # 5d6 <exit>
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
  72:	aaa58593          	addi	a1,a1,-1366 # b18 <malloc+0x10a>
  76:	4509                	li	a0,2
  78:	00001097          	auipc	ra,0x1
  7c:	8b0080e7          	jalr	-1872(ra) # 928 <fprintf>
        exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	554080e7          	jalr	1364(ra) # 5d6 <exit>

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
  b4:	00093503          	ld	a0,0(s2) # 1010 <buf>
  b8:	00000097          	auipc	ra,0x0
  bc:	55e080e7          	jalr	1374(ra) # 616 <open>
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
  d4:	52e080e7          	jalr	1326(ra) # 5fe <close>
    for (i = 1; i < argc; i++)
  d8:	0921                	addi	s2,s2,8
  da:	fd391ce3          	bne	s2,s3,b2 <main+0x28>
    }
    exit(0);
  de:	4501                	li	a0,0
  e0:	00000097          	auipc	ra,0x0
  e4:	4f6080e7          	jalr	1270(ra) # 5d6 <exit>
        cat(0);
  e8:	4501                	li	a0,0
  ea:	00000097          	auipc	ra,0x0
  ee:	f16080e7          	jalr	-234(ra) # 0 <cat>
        exit(0);
  f2:	4501                	li	a0,0
  f4:	00000097          	auipc	ra,0x0
  f8:	4e2080e7          	jalr	1250(ra) # 5d6 <exit>
            fprintf(2, "cat: cannot open %s\n", argv[i]);
  fc:	00093603          	ld	a2,0(s2)
 100:	00001597          	auipc	a1,0x1
 104:	a3058593          	addi	a1,a1,-1488 # b30 <malloc+0x122>
 108:	4509                	li	a0,2
 10a:	00001097          	auipc	ra,0x1
 10e:	81e080e7          	jalr	-2018(ra) # 928 <fprintf>
            exit(1);
 112:	4505                	li	a0,1
 114:	00000097          	auipc	ra,0x0
 118:	4c2080e7          	jalr	1218(ra) # 5d6 <exit>

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
 150:	172080e7          	jalr	370(ra) # 2be <twhoami>
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
 19c:	9b050513          	addi	a0,a0,-1616 # b48 <malloc+0x13a>
 1a0:	00000097          	auipc	ra,0x0
 1a4:	7b6080e7          	jalr	1974(ra) # 956 <printf>
        exit(-1);
 1a8:	557d                	li	a0,-1
 1aa:	00000097          	auipc	ra,0x0
 1ae:	42c080e7          	jalr	1068(ra) # 5d6 <exit>
    {
        // give up the cpu for other threads
        tyield();
 1b2:	00000097          	auipc	ra,0x0
 1b6:	0f4080e7          	jalr	244(ra) # 2a6 <tyield>
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
 1d0:	0f2080e7          	jalr	242(ra) # 2be <twhoami>
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
 214:	096080e7          	jalr	150(ra) # 2a6 <tyield>
}
 218:	60e2                	ld	ra,24(sp)
 21a:	6442                	ld	s0,16(sp)
 21c:	64a2                	ld	s1,8(sp)
 21e:	6105                	addi	sp,sp,32
 220:	8082                	ret
        printf("releasing lock we are not holding");
 222:	00001517          	auipc	a0,0x1
 226:	94e50513          	addi	a0,a0,-1714 # b70 <malloc+0x162>
 22a:	00000097          	auipc	ra,0x0
 22e:	72c080e7          	jalr	1836(ra) # 956 <printf>
        exit(-1);
 232:	557d                	li	a0,-1
 234:	00000097          	auipc	ra,0x0
 238:	3a2080e7          	jalr	930(ra) # 5d6 <exit>

000000000000023c <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 23c:	1141                	addi	sp,sp,-16
 23e:	e422                	sd	s0,8(sp)
 240:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 242:	00001717          	auipc	a4,0x1
 246:	dbe73703          	ld	a4,-578(a4) # 1000 <current_thread>
 24a:	47c1                	li	a5,16
 24c:	c319                	beqz	a4,252 <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 24e:	37fd                	addiw	a5,a5,-1
 250:	fff5                	bnez	a5,24c <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 252:	6422                	ld	s0,8(sp)
 254:	0141                	addi	sp,sp,16
 256:	8082                	ret

0000000000000258 <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 258:	7179                	addi	sp,sp,-48
 25a:	f406                	sd	ra,40(sp)
 25c:	f022                	sd	s0,32(sp)
 25e:	ec26                	sd	s1,24(sp)
 260:	e84a                	sd	s2,16(sp)
 262:	e44e                	sd	s3,8(sp)
 264:	1800                	addi	s0,sp,48
 266:	84aa                	mv	s1,a0
 268:	89b2                	mv	s3,a2
 26a:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 26c:	09000513          	li	a0,144
 270:	00000097          	auipc	ra,0x0
 274:	79e080e7          	jalr	1950(ra) # a0e <malloc>
 278:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 27a:	478d                	li	a5,3
 27c:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 27e:	609c                	ld	a5,0(s1)
 280:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 284:	609c                	ld	a5,0(s1)
 286:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 28a:	70a2                	ld	ra,40(sp)
 28c:	7402                	ld	s0,32(sp)
 28e:	64e2                	ld	s1,24(sp)
 290:	6942                	ld	s2,16(sp)
 292:	69a2                	ld	s3,8(sp)
 294:	6145                	addi	sp,sp,48
 296:	8082                	ret

0000000000000298 <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 298:	1141                	addi	sp,sp,-16
 29a:	e422                	sd	s0,8(sp)
 29c:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 29e:	4501                	li	a0,0
 2a0:	6422                	ld	s0,8(sp)
 2a2:	0141                	addi	sp,sp,16
 2a4:	8082                	ret

00000000000002a6 <tyield>:

void tyield()
{
 2a6:	1141                	addi	sp,sp,-16
 2a8:	e422                	sd	s0,8(sp)
 2aa:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 2ac:	00001797          	auipc	a5,0x1
 2b0:	d547b783          	ld	a5,-684(a5) # 1000 <current_thread>
 2b4:	470d                	li	a4,3
 2b6:	dfb8                	sw	a4,120(a5)
    tsched();
}
 2b8:	6422                	ld	s0,8(sp)
 2ba:	0141                	addi	sp,sp,16
 2bc:	8082                	ret

00000000000002be <twhoami>:

uint8 twhoami()
{
 2be:	1141                	addi	sp,sp,-16
 2c0:	e422                	sd	s0,8(sp)
 2c2:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 2c4:	4501                	li	a0,0
 2c6:	6422                	ld	s0,8(sp)
 2c8:	0141                	addi	sp,sp,16
 2ca:	8082                	ret

00000000000002cc <tswtch>:
 2cc:	00153023          	sd	ra,0(a0)
 2d0:	00253423          	sd	sp,8(a0)
 2d4:	e900                	sd	s0,16(a0)
 2d6:	ed04                	sd	s1,24(a0)
 2d8:	03253023          	sd	s2,32(a0)
 2dc:	03353423          	sd	s3,40(a0)
 2e0:	03453823          	sd	s4,48(a0)
 2e4:	03553c23          	sd	s5,56(a0)
 2e8:	05653023          	sd	s6,64(a0)
 2ec:	05753423          	sd	s7,72(a0)
 2f0:	05853823          	sd	s8,80(a0)
 2f4:	05953c23          	sd	s9,88(a0)
 2f8:	07a53023          	sd	s10,96(a0)
 2fc:	07b53423          	sd	s11,104(a0)
 300:	0005b083          	ld	ra,0(a1)
 304:	0085b103          	ld	sp,8(a1)
 308:	6980                	ld	s0,16(a1)
 30a:	6d84                	ld	s1,24(a1)
 30c:	0205b903          	ld	s2,32(a1)
 310:	0285b983          	ld	s3,40(a1)
 314:	0305ba03          	ld	s4,48(a1)
 318:	0385ba83          	ld	s5,56(a1)
 31c:	0405bb03          	ld	s6,64(a1)
 320:	0485bb83          	ld	s7,72(a1)
 324:	0505bc03          	ld	s8,80(a1)
 328:	0585bc83          	ld	s9,88(a1)
 32c:	0605bd03          	ld	s10,96(a1)
 330:	0685bd83          	ld	s11,104(a1)
 334:	8082                	ret

0000000000000336 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 336:	1101                	addi	sp,sp,-32
 338:	ec06                	sd	ra,24(sp)
 33a:	e822                	sd	s0,16(sp)
 33c:	e426                	sd	s1,8(sp)
 33e:	e04a                	sd	s2,0(sp)
 340:	1000                	addi	s0,sp,32
 342:	84aa                	mv	s1,a0
 344:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 346:	09000513          	li	a0,144
 34a:	00000097          	auipc	ra,0x0
 34e:	6c4080e7          	jalr	1732(ra) # a0e <malloc>

    main_thread->tid = 0;
 352:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 356:	85ca                	mv	a1,s2
 358:	8526                	mv	a0,s1
 35a:	00000097          	auipc	ra,0x0
 35e:	d30080e7          	jalr	-720(ra) # 8a <main>
    exit(res);
 362:	00000097          	auipc	ra,0x0
 366:	274080e7          	jalr	628(ra) # 5d6 <exit>

000000000000036a <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 36a:	1141                	addi	sp,sp,-16
 36c:	e422                	sd	s0,8(sp)
 36e:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 370:	87aa                	mv	a5,a0
 372:	0585                	addi	a1,a1,1
 374:	0785                	addi	a5,a5,1
 376:	fff5c703          	lbu	a4,-1(a1)
 37a:	fee78fa3          	sb	a4,-1(a5)
 37e:	fb75                	bnez	a4,372 <strcpy+0x8>
        ;
    return os;
}
 380:	6422                	ld	s0,8(sp)
 382:	0141                	addi	sp,sp,16
 384:	8082                	ret

0000000000000386 <strcmp>:

int strcmp(const char *p, const char *q)
{
 386:	1141                	addi	sp,sp,-16
 388:	e422                	sd	s0,8(sp)
 38a:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 38c:	00054783          	lbu	a5,0(a0)
 390:	cb91                	beqz	a5,3a4 <strcmp+0x1e>
 392:	0005c703          	lbu	a4,0(a1)
 396:	00f71763          	bne	a4,a5,3a4 <strcmp+0x1e>
        p++, q++;
 39a:	0505                	addi	a0,a0,1
 39c:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 39e:	00054783          	lbu	a5,0(a0)
 3a2:	fbe5                	bnez	a5,392 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 3a4:	0005c503          	lbu	a0,0(a1)
}
 3a8:	40a7853b          	subw	a0,a5,a0
 3ac:	6422                	ld	s0,8(sp)
 3ae:	0141                	addi	sp,sp,16
 3b0:	8082                	ret

00000000000003b2 <strlen>:

uint strlen(const char *s)
{
 3b2:	1141                	addi	sp,sp,-16
 3b4:	e422                	sd	s0,8(sp)
 3b6:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 3b8:	00054783          	lbu	a5,0(a0)
 3bc:	cf91                	beqz	a5,3d8 <strlen+0x26>
 3be:	0505                	addi	a0,a0,1
 3c0:	87aa                	mv	a5,a0
 3c2:	86be                	mv	a3,a5
 3c4:	0785                	addi	a5,a5,1
 3c6:	fff7c703          	lbu	a4,-1(a5)
 3ca:	ff65                	bnez	a4,3c2 <strlen+0x10>
 3cc:	40a6853b          	subw	a0,a3,a0
 3d0:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 3d2:	6422                	ld	s0,8(sp)
 3d4:	0141                	addi	sp,sp,16
 3d6:	8082                	ret
    for (n = 0; s[n]; n++)
 3d8:	4501                	li	a0,0
 3da:	bfe5                	j	3d2 <strlen+0x20>

00000000000003dc <memset>:

void *
memset(void *dst, int c, uint n)
{
 3dc:	1141                	addi	sp,sp,-16
 3de:	e422                	sd	s0,8(sp)
 3e0:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 3e2:	ca19                	beqz	a2,3f8 <memset+0x1c>
 3e4:	87aa                	mv	a5,a0
 3e6:	1602                	slli	a2,a2,0x20
 3e8:	9201                	srli	a2,a2,0x20
 3ea:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 3ee:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 3f2:	0785                	addi	a5,a5,1
 3f4:	fee79de3          	bne	a5,a4,3ee <memset+0x12>
    }
    return dst;
}
 3f8:	6422                	ld	s0,8(sp)
 3fa:	0141                	addi	sp,sp,16
 3fc:	8082                	ret

00000000000003fe <strchr>:

char *
strchr(const char *s, char c)
{
 3fe:	1141                	addi	sp,sp,-16
 400:	e422                	sd	s0,8(sp)
 402:	0800                	addi	s0,sp,16
    for (; *s; s++)
 404:	00054783          	lbu	a5,0(a0)
 408:	cb99                	beqz	a5,41e <strchr+0x20>
        if (*s == c)
 40a:	00f58763          	beq	a1,a5,418 <strchr+0x1a>
    for (; *s; s++)
 40e:	0505                	addi	a0,a0,1
 410:	00054783          	lbu	a5,0(a0)
 414:	fbfd                	bnez	a5,40a <strchr+0xc>
            return (char *)s;
    return 0;
 416:	4501                	li	a0,0
}
 418:	6422                	ld	s0,8(sp)
 41a:	0141                	addi	sp,sp,16
 41c:	8082                	ret
    return 0;
 41e:	4501                	li	a0,0
 420:	bfe5                	j	418 <strchr+0x1a>

0000000000000422 <gets>:

char *
gets(char *buf, int max)
{
 422:	711d                	addi	sp,sp,-96
 424:	ec86                	sd	ra,88(sp)
 426:	e8a2                	sd	s0,80(sp)
 428:	e4a6                	sd	s1,72(sp)
 42a:	e0ca                	sd	s2,64(sp)
 42c:	fc4e                	sd	s3,56(sp)
 42e:	f852                	sd	s4,48(sp)
 430:	f456                	sd	s5,40(sp)
 432:	f05a                	sd	s6,32(sp)
 434:	ec5e                	sd	s7,24(sp)
 436:	1080                	addi	s0,sp,96
 438:	8baa                	mv	s7,a0
 43a:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 43c:	892a                	mv	s2,a0
 43e:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 440:	4aa9                	li	s5,10
 442:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 444:	89a6                	mv	s3,s1
 446:	2485                	addiw	s1,s1,1
 448:	0344d863          	bge	s1,s4,478 <gets+0x56>
        cc = read(0, &c, 1);
 44c:	4605                	li	a2,1
 44e:	faf40593          	addi	a1,s0,-81
 452:	4501                	li	a0,0
 454:	00000097          	auipc	ra,0x0
 458:	19a080e7          	jalr	410(ra) # 5ee <read>
        if (cc < 1)
 45c:	00a05e63          	blez	a0,478 <gets+0x56>
        buf[i++] = c;
 460:	faf44783          	lbu	a5,-81(s0)
 464:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 468:	01578763          	beq	a5,s5,476 <gets+0x54>
 46c:	0905                	addi	s2,s2,1
 46e:	fd679be3          	bne	a5,s6,444 <gets+0x22>
    for (i = 0; i + 1 < max;)
 472:	89a6                	mv	s3,s1
 474:	a011                	j	478 <gets+0x56>
 476:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 478:	99de                	add	s3,s3,s7
 47a:	00098023          	sb	zero,0(s3)
    return buf;
}
 47e:	855e                	mv	a0,s7
 480:	60e6                	ld	ra,88(sp)
 482:	6446                	ld	s0,80(sp)
 484:	64a6                	ld	s1,72(sp)
 486:	6906                	ld	s2,64(sp)
 488:	79e2                	ld	s3,56(sp)
 48a:	7a42                	ld	s4,48(sp)
 48c:	7aa2                	ld	s5,40(sp)
 48e:	7b02                	ld	s6,32(sp)
 490:	6be2                	ld	s7,24(sp)
 492:	6125                	addi	sp,sp,96
 494:	8082                	ret

0000000000000496 <stat>:

int stat(const char *n, struct stat *st)
{
 496:	1101                	addi	sp,sp,-32
 498:	ec06                	sd	ra,24(sp)
 49a:	e822                	sd	s0,16(sp)
 49c:	e426                	sd	s1,8(sp)
 49e:	e04a                	sd	s2,0(sp)
 4a0:	1000                	addi	s0,sp,32
 4a2:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 4a4:	4581                	li	a1,0
 4a6:	00000097          	auipc	ra,0x0
 4aa:	170080e7          	jalr	368(ra) # 616 <open>
    if (fd < 0)
 4ae:	02054563          	bltz	a0,4d8 <stat+0x42>
 4b2:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 4b4:	85ca                	mv	a1,s2
 4b6:	00000097          	auipc	ra,0x0
 4ba:	178080e7          	jalr	376(ra) # 62e <fstat>
 4be:	892a                	mv	s2,a0
    close(fd);
 4c0:	8526                	mv	a0,s1
 4c2:	00000097          	auipc	ra,0x0
 4c6:	13c080e7          	jalr	316(ra) # 5fe <close>
    return r;
}
 4ca:	854a                	mv	a0,s2
 4cc:	60e2                	ld	ra,24(sp)
 4ce:	6442                	ld	s0,16(sp)
 4d0:	64a2                	ld	s1,8(sp)
 4d2:	6902                	ld	s2,0(sp)
 4d4:	6105                	addi	sp,sp,32
 4d6:	8082                	ret
        return -1;
 4d8:	597d                	li	s2,-1
 4da:	bfc5                	j	4ca <stat+0x34>

00000000000004dc <atoi>:

int atoi(const char *s)
{
 4dc:	1141                	addi	sp,sp,-16
 4de:	e422                	sd	s0,8(sp)
 4e0:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 4e2:	00054683          	lbu	a3,0(a0)
 4e6:	fd06879b          	addiw	a5,a3,-48
 4ea:	0ff7f793          	zext.b	a5,a5
 4ee:	4625                	li	a2,9
 4f0:	02f66863          	bltu	a2,a5,520 <atoi+0x44>
 4f4:	872a                	mv	a4,a0
    n = 0;
 4f6:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 4f8:	0705                	addi	a4,a4,1
 4fa:	0025179b          	slliw	a5,a0,0x2
 4fe:	9fa9                	addw	a5,a5,a0
 500:	0017979b          	slliw	a5,a5,0x1
 504:	9fb5                	addw	a5,a5,a3
 506:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 50a:	00074683          	lbu	a3,0(a4)
 50e:	fd06879b          	addiw	a5,a3,-48
 512:	0ff7f793          	zext.b	a5,a5
 516:	fef671e3          	bgeu	a2,a5,4f8 <atoi+0x1c>
    return n;
}
 51a:	6422                	ld	s0,8(sp)
 51c:	0141                	addi	sp,sp,16
 51e:	8082                	ret
    n = 0;
 520:	4501                	li	a0,0
 522:	bfe5                	j	51a <atoi+0x3e>

0000000000000524 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 524:	1141                	addi	sp,sp,-16
 526:	e422                	sd	s0,8(sp)
 528:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 52a:	02b57463          	bgeu	a0,a1,552 <memmove+0x2e>
    {
        while (n-- > 0)
 52e:	00c05f63          	blez	a2,54c <memmove+0x28>
 532:	1602                	slli	a2,a2,0x20
 534:	9201                	srli	a2,a2,0x20
 536:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 53a:	872a                	mv	a4,a0
            *dst++ = *src++;
 53c:	0585                	addi	a1,a1,1
 53e:	0705                	addi	a4,a4,1
 540:	fff5c683          	lbu	a3,-1(a1)
 544:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 548:	fee79ae3          	bne	a5,a4,53c <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 54c:	6422                	ld	s0,8(sp)
 54e:	0141                	addi	sp,sp,16
 550:	8082                	ret
        dst += n;
 552:	00c50733          	add	a4,a0,a2
        src += n;
 556:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 558:	fec05ae3          	blez	a2,54c <memmove+0x28>
 55c:	fff6079b          	addiw	a5,a2,-1
 560:	1782                	slli	a5,a5,0x20
 562:	9381                	srli	a5,a5,0x20
 564:	fff7c793          	not	a5,a5
 568:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 56a:	15fd                	addi	a1,a1,-1
 56c:	177d                	addi	a4,a4,-1
 56e:	0005c683          	lbu	a3,0(a1)
 572:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 576:	fee79ae3          	bne	a5,a4,56a <memmove+0x46>
 57a:	bfc9                	j	54c <memmove+0x28>

000000000000057c <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 57c:	1141                	addi	sp,sp,-16
 57e:	e422                	sd	s0,8(sp)
 580:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 582:	ca05                	beqz	a2,5b2 <memcmp+0x36>
 584:	fff6069b          	addiw	a3,a2,-1
 588:	1682                	slli	a3,a3,0x20
 58a:	9281                	srli	a3,a3,0x20
 58c:	0685                	addi	a3,a3,1
 58e:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 590:	00054783          	lbu	a5,0(a0)
 594:	0005c703          	lbu	a4,0(a1)
 598:	00e79863          	bne	a5,a4,5a8 <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 59c:	0505                	addi	a0,a0,1
        p2++;
 59e:	0585                	addi	a1,a1,1
    while (n-- > 0)
 5a0:	fed518e3          	bne	a0,a3,590 <memcmp+0x14>
    }
    return 0;
 5a4:	4501                	li	a0,0
 5a6:	a019                	j	5ac <memcmp+0x30>
            return *p1 - *p2;
 5a8:	40e7853b          	subw	a0,a5,a4
}
 5ac:	6422                	ld	s0,8(sp)
 5ae:	0141                	addi	sp,sp,16
 5b0:	8082                	ret
    return 0;
 5b2:	4501                	li	a0,0
 5b4:	bfe5                	j	5ac <memcmp+0x30>

00000000000005b6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5b6:	1141                	addi	sp,sp,-16
 5b8:	e406                	sd	ra,8(sp)
 5ba:	e022                	sd	s0,0(sp)
 5bc:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 5be:	00000097          	auipc	ra,0x0
 5c2:	f66080e7          	jalr	-154(ra) # 524 <memmove>
}
 5c6:	60a2                	ld	ra,8(sp)
 5c8:	6402                	ld	s0,0(sp)
 5ca:	0141                	addi	sp,sp,16
 5cc:	8082                	ret

00000000000005ce <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5ce:	4885                	li	a7,1
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5d6:	4889                	li	a7,2
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <wait>:
.global wait
wait:
 li a7, SYS_wait
 5de:	488d                	li	a7,3
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5e6:	4891                	li	a7,4
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <read>:
.global read
read:
 li a7, SYS_read
 5ee:	4895                	li	a7,5
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <write>:
.global write
write:
 li a7, SYS_write
 5f6:	48c1                	li	a7,16
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <close>:
.global close
close:
 li a7, SYS_close
 5fe:	48d5                	li	a7,21
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <kill>:
.global kill
kill:
 li a7, SYS_kill
 606:	4899                	li	a7,6
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <exec>:
.global exec
exec:
 li a7, SYS_exec
 60e:	489d                	li	a7,7
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <open>:
.global open
open:
 li a7, SYS_open
 616:	48bd                	li	a7,15
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 61e:	48c5                	li	a7,17
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 626:	48c9                	li	a7,18
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 62e:	48a1                	li	a7,8
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <link>:
.global link
link:
 li a7, SYS_link
 636:	48cd                	li	a7,19
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 63e:	48d1                	li	a7,20
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 646:	48a5                	li	a7,9
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <dup>:
.global dup
dup:
 li a7, SYS_dup
 64e:	48a9                	li	a7,10
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 656:	48ad                	li	a7,11
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 65e:	48b1                	li	a7,12
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 666:	48b5                	li	a7,13
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 66e:	48b9                	li	a7,14
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <ps>:
.global ps
ps:
 li a7, SYS_ps
 676:	48d9                	li	a7,22
 ecall
 678:	00000073          	ecall
 ret
 67c:	8082                	ret

000000000000067e <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 67e:	48dd                	li	a7,23
 ecall
 680:	00000073          	ecall
 ret
 684:	8082                	ret

0000000000000686 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 686:	48e1                	li	a7,24
 ecall
 688:	00000073          	ecall
 ret
 68c:	8082                	ret

000000000000068e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 68e:	1101                	addi	sp,sp,-32
 690:	ec06                	sd	ra,24(sp)
 692:	e822                	sd	s0,16(sp)
 694:	1000                	addi	s0,sp,32
 696:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 69a:	4605                	li	a2,1
 69c:	fef40593          	addi	a1,s0,-17
 6a0:	00000097          	auipc	ra,0x0
 6a4:	f56080e7          	jalr	-170(ra) # 5f6 <write>
}
 6a8:	60e2                	ld	ra,24(sp)
 6aa:	6442                	ld	s0,16(sp)
 6ac:	6105                	addi	sp,sp,32
 6ae:	8082                	ret

00000000000006b0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6b0:	7139                	addi	sp,sp,-64
 6b2:	fc06                	sd	ra,56(sp)
 6b4:	f822                	sd	s0,48(sp)
 6b6:	f426                	sd	s1,40(sp)
 6b8:	f04a                	sd	s2,32(sp)
 6ba:	ec4e                	sd	s3,24(sp)
 6bc:	0080                	addi	s0,sp,64
 6be:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6c0:	c299                	beqz	a3,6c6 <printint+0x16>
 6c2:	0805c963          	bltz	a1,754 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6c6:	2581                	sext.w	a1,a1
  neg = 0;
 6c8:	4881                	li	a7,0
 6ca:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 6ce:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6d0:	2601                	sext.w	a2,a2
 6d2:	00000517          	auipc	a0,0x0
 6d6:	52650513          	addi	a0,a0,1318 # bf8 <digits>
 6da:	883a                	mv	a6,a4
 6dc:	2705                	addiw	a4,a4,1
 6de:	02c5f7bb          	remuw	a5,a1,a2
 6e2:	1782                	slli	a5,a5,0x20
 6e4:	9381                	srli	a5,a5,0x20
 6e6:	97aa                	add	a5,a5,a0
 6e8:	0007c783          	lbu	a5,0(a5)
 6ec:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6f0:	0005879b          	sext.w	a5,a1
 6f4:	02c5d5bb          	divuw	a1,a1,a2
 6f8:	0685                	addi	a3,a3,1
 6fa:	fec7f0e3          	bgeu	a5,a2,6da <printint+0x2a>
  if(neg)
 6fe:	00088c63          	beqz	a7,716 <printint+0x66>
    buf[i++] = '-';
 702:	fd070793          	addi	a5,a4,-48
 706:	00878733          	add	a4,a5,s0
 70a:	02d00793          	li	a5,45
 70e:	fef70823          	sb	a5,-16(a4)
 712:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 716:	02e05863          	blez	a4,746 <printint+0x96>
 71a:	fc040793          	addi	a5,s0,-64
 71e:	00e78933          	add	s2,a5,a4
 722:	fff78993          	addi	s3,a5,-1
 726:	99ba                	add	s3,s3,a4
 728:	377d                	addiw	a4,a4,-1
 72a:	1702                	slli	a4,a4,0x20
 72c:	9301                	srli	a4,a4,0x20
 72e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 732:	fff94583          	lbu	a1,-1(s2)
 736:	8526                	mv	a0,s1
 738:	00000097          	auipc	ra,0x0
 73c:	f56080e7          	jalr	-170(ra) # 68e <putc>
  while(--i >= 0)
 740:	197d                	addi	s2,s2,-1
 742:	ff3918e3          	bne	s2,s3,732 <printint+0x82>
}
 746:	70e2                	ld	ra,56(sp)
 748:	7442                	ld	s0,48(sp)
 74a:	74a2                	ld	s1,40(sp)
 74c:	7902                	ld	s2,32(sp)
 74e:	69e2                	ld	s3,24(sp)
 750:	6121                	addi	sp,sp,64
 752:	8082                	ret
    x = -xx;
 754:	40b005bb          	negw	a1,a1
    neg = 1;
 758:	4885                	li	a7,1
    x = -xx;
 75a:	bf85                	j	6ca <printint+0x1a>

000000000000075c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 75c:	715d                	addi	sp,sp,-80
 75e:	e486                	sd	ra,72(sp)
 760:	e0a2                	sd	s0,64(sp)
 762:	fc26                	sd	s1,56(sp)
 764:	f84a                	sd	s2,48(sp)
 766:	f44e                	sd	s3,40(sp)
 768:	f052                	sd	s4,32(sp)
 76a:	ec56                	sd	s5,24(sp)
 76c:	e85a                	sd	s6,16(sp)
 76e:	e45e                	sd	s7,8(sp)
 770:	e062                	sd	s8,0(sp)
 772:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 774:	0005c903          	lbu	s2,0(a1)
 778:	18090c63          	beqz	s2,910 <vprintf+0x1b4>
 77c:	8aaa                	mv	s5,a0
 77e:	8bb2                	mv	s7,a2
 780:	00158493          	addi	s1,a1,1
  state = 0;
 784:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 786:	02500a13          	li	s4,37
 78a:	4b55                	li	s6,21
 78c:	a839                	j	7aa <vprintf+0x4e>
        putc(fd, c);
 78e:	85ca                	mv	a1,s2
 790:	8556                	mv	a0,s5
 792:	00000097          	auipc	ra,0x0
 796:	efc080e7          	jalr	-260(ra) # 68e <putc>
 79a:	a019                	j	7a0 <vprintf+0x44>
    } else if(state == '%'){
 79c:	01498d63          	beq	s3,s4,7b6 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 7a0:	0485                	addi	s1,s1,1
 7a2:	fff4c903          	lbu	s2,-1(s1)
 7a6:	16090563          	beqz	s2,910 <vprintf+0x1b4>
    if(state == 0){
 7aa:	fe0999e3          	bnez	s3,79c <vprintf+0x40>
      if(c == '%'){
 7ae:	ff4910e3          	bne	s2,s4,78e <vprintf+0x32>
        state = '%';
 7b2:	89d2                	mv	s3,s4
 7b4:	b7f5                	j	7a0 <vprintf+0x44>
      if(c == 'd'){
 7b6:	13490263          	beq	s2,s4,8da <vprintf+0x17e>
 7ba:	f9d9079b          	addiw	a5,s2,-99
 7be:	0ff7f793          	zext.b	a5,a5
 7c2:	12fb6563          	bltu	s6,a5,8ec <vprintf+0x190>
 7c6:	f9d9079b          	addiw	a5,s2,-99
 7ca:	0ff7f713          	zext.b	a4,a5
 7ce:	10eb6f63          	bltu	s6,a4,8ec <vprintf+0x190>
 7d2:	00271793          	slli	a5,a4,0x2
 7d6:	00000717          	auipc	a4,0x0
 7da:	3ca70713          	addi	a4,a4,970 # ba0 <malloc+0x192>
 7de:	97ba                	add	a5,a5,a4
 7e0:	439c                	lw	a5,0(a5)
 7e2:	97ba                	add	a5,a5,a4
 7e4:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 7e6:	008b8913          	addi	s2,s7,8
 7ea:	4685                	li	a3,1
 7ec:	4629                	li	a2,10
 7ee:	000ba583          	lw	a1,0(s7)
 7f2:	8556                	mv	a0,s5
 7f4:	00000097          	auipc	ra,0x0
 7f8:	ebc080e7          	jalr	-324(ra) # 6b0 <printint>
 7fc:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7fe:	4981                	li	s3,0
 800:	b745                	j	7a0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 802:	008b8913          	addi	s2,s7,8
 806:	4681                	li	a3,0
 808:	4629                	li	a2,10
 80a:	000ba583          	lw	a1,0(s7)
 80e:	8556                	mv	a0,s5
 810:	00000097          	auipc	ra,0x0
 814:	ea0080e7          	jalr	-352(ra) # 6b0 <printint>
 818:	8bca                	mv	s7,s2
      state = 0;
 81a:	4981                	li	s3,0
 81c:	b751                	j	7a0 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 81e:	008b8913          	addi	s2,s7,8
 822:	4681                	li	a3,0
 824:	4641                	li	a2,16
 826:	000ba583          	lw	a1,0(s7)
 82a:	8556                	mv	a0,s5
 82c:	00000097          	auipc	ra,0x0
 830:	e84080e7          	jalr	-380(ra) # 6b0 <printint>
 834:	8bca                	mv	s7,s2
      state = 0;
 836:	4981                	li	s3,0
 838:	b7a5                	j	7a0 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 83a:	008b8c13          	addi	s8,s7,8
 83e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 842:	03000593          	li	a1,48
 846:	8556                	mv	a0,s5
 848:	00000097          	auipc	ra,0x0
 84c:	e46080e7          	jalr	-442(ra) # 68e <putc>
  putc(fd, 'x');
 850:	07800593          	li	a1,120
 854:	8556                	mv	a0,s5
 856:	00000097          	auipc	ra,0x0
 85a:	e38080e7          	jalr	-456(ra) # 68e <putc>
 85e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 860:	00000b97          	auipc	s7,0x0
 864:	398b8b93          	addi	s7,s7,920 # bf8 <digits>
 868:	03c9d793          	srli	a5,s3,0x3c
 86c:	97de                	add	a5,a5,s7
 86e:	0007c583          	lbu	a1,0(a5)
 872:	8556                	mv	a0,s5
 874:	00000097          	auipc	ra,0x0
 878:	e1a080e7          	jalr	-486(ra) # 68e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 87c:	0992                	slli	s3,s3,0x4
 87e:	397d                	addiw	s2,s2,-1
 880:	fe0914e3          	bnez	s2,868 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 884:	8be2                	mv	s7,s8
      state = 0;
 886:	4981                	li	s3,0
 888:	bf21                	j	7a0 <vprintf+0x44>
        s = va_arg(ap, char*);
 88a:	008b8993          	addi	s3,s7,8
 88e:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 892:	02090163          	beqz	s2,8b4 <vprintf+0x158>
        while(*s != 0){
 896:	00094583          	lbu	a1,0(s2)
 89a:	c9a5                	beqz	a1,90a <vprintf+0x1ae>
          putc(fd, *s);
 89c:	8556                	mv	a0,s5
 89e:	00000097          	auipc	ra,0x0
 8a2:	df0080e7          	jalr	-528(ra) # 68e <putc>
          s++;
 8a6:	0905                	addi	s2,s2,1
        while(*s != 0){
 8a8:	00094583          	lbu	a1,0(s2)
 8ac:	f9e5                	bnez	a1,89c <vprintf+0x140>
        s = va_arg(ap, char*);
 8ae:	8bce                	mv	s7,s3
      state = 0;
 8b0:	4981                	li	s3,0
 8b2:	b5fd                	j	7a0 <vprintf+0x44>
          s = "(null)";
 8b4:	00000917          	auipc	s2,0x0
 8b8:	2e490913          	addi	s2,s2,740 # b98 <malloc+0x18a>
        while(*s != 0){
 8bc:	02800593          	li	a1,40
 8c0:	bff1                	j	89c <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 8c2:	008b8913          	addi	s2,s7,8
 8c6:	000bc583          	lbu	a1,0(s7)
 8ca:	8556                	mv	a0,s5
 8cc:	00000097          	auipc	ra,0x0
 8d0:	dc2080e7          	jalr	-574(ra) # 68e <putc>
 8d4:	8bca                	mv	s7,s2
      state = 0;
 8d6:	4981                	li	s3,0
 8d8:	b5e1                	j	7a0 <vprintf+0x44>
        putc(fd, c);
 8da:	02500593          	li	a1,37
 8de:	8556                	mv	a0,s5
 8e0:	00000097          	auipc	ra,0x0
 8e4:	dae080e7          	jalr	-594(ra) # 68e <putc>
      state = 0;
 8e8:	4981                	li	s3,0
 8ea:	bd5d                	j	7a0 <vprintf+0x44>
        putc(fd, '%');
 8ec:	02500593          	li	a1,37
 8f0:	8556                	mv	a0,s5
 8f2:	00000097          	auipc	ra,0x0
 8f6:	d9c080e7          	jalr	-612(ra) # 68e <putc>
        putc(fd, c);
 8fa:	85ca                	mv	a1,s2
 8fc:	8556                	mv	a0,s5
 8fe:	00000097          	auipc	ra,0x0
 902:	d90080e7          	jalr	-624(ra) # 68e <putc>
      state = 0;
 906:	4981                	li	s3,0
 908:	bd61                	j	7a0 <vprintf+0x44>
        s = va_arg(ap, char*);
 90a:	8bce                	mv	s7,s3
      state = 0;
 90c:	4981                	li	s3,0
 90e:	bd49                	j	7a0 <vprintf+0x44>
    }
  }
}
 910:	60a6                	ld	ra,72(sp)
 912:	6406                	ld	s0,64(sp)
 914:	74e2                	ld	s1,56(sp)
 916:	7942                	ld	s2,48(sp)
 918:	79a2                	ld	s3,40(sp)
 91a:	7a02                	ld	s4,32(sp)
 91c:	6ae2                	ld	s5,24(sp)
 91e:	6b42                	ld	s6,16(sp)
 920:	6ba2                	ld	s7,8(sp)
 922:	6c02                	ld	s8,0(sp)
 924:	6161                	addi	sp,sp,80
 926:	8082                	ret

0000000000000928 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 928:	715d                	addi	sp,sp,-80
 92a:	ec06                	sd	ra,24(sp)
 92c:	e822                	sd	s0,16(sp)
 92e:	1000                	addi	s0,sp,32
 930:	e010                	sd	a2,0(s0)
 932:	e414                	sd	a3,8(s0)
 934:	e818                	sd	a4,16(s0)
 936:	ec1c                	sd	a5,24(s0)
 938:	03043023          	sd	a6,32(s0)
 93c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 940:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 944:	8622                	mv	a2,s0
 946:	00000097          	auipc	ra,0x0
 94a:	e16080e7          	jalr	-490(ra) # 75c <vprintf>
}
 94e:	60e2                	ld	ra,24(sp)
 950:	6442                	ld	s0,16(sp)
 952:	6161                	addi	sp,sp,80
 954:	8082                	ret

0000000000000956 <printf>:

void
printf(const char *fmt, ...)
{
 956:	711d                	addi	sp,sp,-96
 958:	ec06                	sd	ra,24(sp)
 95a:	e822                	sd	s0,16(sp)
 95c:	1000                	addi	s0,sp,32
 95e:	e40c                	sd	a1,8(s0)
 960:	e810                	sd	a2,16(s0)
 962:	ec14                	sd	a3,24(s0)
 964:	f018                	sd	a4,32(s0)
 966:	f41c                	sd	a5,40(s0)
 968:	03043823          	sd	a6,48(s0)
 96c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 970:	00840613          	addi	a2,s0,8
 974:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 978:	85aa                	mv	a1,a0
 97a:	4505                	li	a0,1
 97c:	00000097          	auipc	ra,0x0
 980:	de0080e7          	jalr	-544(ra) # 75c <vprintf>
}
 984:	60e2                	ld	ra,24(sp)
 986:	6442                	ld	s0,16(sp)
 988:	6125                	addi	sp,sp,96
 98a:	8082                	ret

000000000000098c <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 98c:	1141                	addi	sp,sp,-16
 98e:	e422                	sd	s0,8(sp)
 990:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 992:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 996:	00000797          	auipc	a5,0x0
 99a:	6727b783          	ld	a5,1650(a5) # 1008 <freep>
 99e:	a02d                	j	9c8 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 9a0:	4618                	lw	a4,8(a2)
 9a2:	9f2d                	addw	a4,a4,a1
 9a4:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 9a8:	6398                	ld	a4,0(a5)
 9aa:	6310                	ld	a2,0(a4)
 9ac:	a83d                	j	9ea <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 9ae:	ff852703          	lw	a4,-8(a0)
 9b2:	9f31                	addw	a4,a4,a2
 9b4:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 9b6:	ff053683          	ld	a3,-16(a0)
 9ba:	a091                	j	9fe <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9bc:	6398                	ld	a4,0(a5)
 9be:	00e7e463          	bltu	a5,a4,9c6 <free+0x3a>
 9c2:	00e6ea63          	bltu	a3,a4,9d6 <free+0x4a>
{
 9c6:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9c8:	fed7fae3          	bgeu	a5,a3,9bc <free+0x30>
 9cc:	6398                	ld	a4,0(a5)
 9ce:	00e6e463          	bltu	a3,a4,9d6 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9d2:	fee7eae3          	bltu	a5,a4,9c6 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 9d6:	ff852583          	lw	a1,-8(a0)
 9da:	6390                	ld	a2,0(a5)
 9dc:	02059813          	slli	a6,a1,0x20
 9e0:	01c85713          	srli	a4,a6,0x1c
 9e4:	9736                	add	a4,a4,a3
 9e6:	fae60de3          	beq	a2,a4,9a0 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 9ea:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 9ee:	4790                	lw	a2,8(a5)
 9f0:	02061593          	slli	a1,a2,0x20
 9f4:	01c5d713          	srli	a4,a1,0x1c
 9f8:	973e                	add	a4,a4,a5
 9fa:	fae68ae3          	beq	a3,a4,9ae <free+0x22>
        p->s.ptr = bp->s.ptr;
 9fe:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 a00:	00000717          	auipc	a4,0x0
 a04:	60f73423          	sd	a5,1544(a4) # 1008 <freep>
}
 a08:	6422                	ld	s0,8(sp)
 a0a:	0141                	addi	sp,sp,16
 a0c:	8082                	ret

0000000000000a0e <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 a0e:	7139                	addi	sp,sp,-64
 a10:	fc06                	sd	ra,56(sp)
 a12:	f822                	sd	s0,48(sp)
 a14:	f426                	sd	s1,40(sp)
 a16:	f04a                	sd	s2,32(sp)
 a18:	ec4e                	sd	s3,24(sp)
 a1a:	e852                	sd	s4,16(sp)
 a1c:	e456                	sd	s5,8(sp)
 a1e:	e05a                	sd	s6,0(sp)
 a20:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 a22:	02051493          	slli	s1,a0,0x20
 a26:	9081                	srli	s1,s1,0x20
 a28:	04bd                	addi	s1,s1,15
 a2a:	8091                	srli	s1,s1,0x4
 a2c:	0014899b          	addiw	s3,s1,1
 a30:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 a32:	00000517          	auipc	a0,0x0
 a36:	5d653503          	ld	a0,1494(a0) # 1008 <freep>
 a3a:	c515                	beqz	a0,a66 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 a3c:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 a3e:	4798                	lw	a4,8(a5)
 a40:	02977f63          	bgeu	a4,s1,a7e <malloc+0x70>
    if (nu < 4096)
 a44:	8a4e                	mv	s4,s3
 a46:	0009871b          	sext.w	a4,s3
 a4a:	6685                	lui	a3,0x1
 a4c:	00d77363          	bgeu	a4,a3,a52 <malloc+0x44>
 a50:	6a05                	lui	s4,0x1
 a52:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 a56:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 a5a:	00000917          	auipc	s2,0x0
 a5e:	5ae90913          	addi	s2,s2,1454 # 1008 <freep>
    if (p == (char *)-1)
 a62:	5afd                	li	s5,-1
 a64:	a895                	j	ad8 <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 a66:	00000797          	auipc	a5,0x0
 a6a:	7aa78793          	addi	a5,a5,1962 # 1210 <base>
 a6e:	00000717          	auipc	a4,0x0
 a72:	58f73d23          	sd	a5,1434(a4) # 1008 <freep>
 a76:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 a78:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 a7c:	b7e1                	j	a44 <malloc+0x36>
            if (p->s.size == nunits)
 a7e:	02e48c63          	beq	s1,a4,ab6 <malloc+0xa8>
                p->s.size -= nunits;
 a82:	4137073b          	subw	a4,a4,s3
 a86:	c798                	sw	a4,8(a5)
                p += p->s.size;
 a88:	02071693          	slli	a3,a4,0x20
 a8c:	01c6d713          	srli	a4,a3,0x1c
 a90:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 a92:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 a96:	00000717          	auipc	a4,0x0
 a9a:	56a73923          	sd	a0,1394(a4) # 1008 <freep>
            return (void *)(p + 1);
 a9e:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 aa2:	70e2                	ld	ra,56(sp)
 aa4:	7442                	ld	s0,48(sp)
 aa6:	74a2                	ld	s1,40(sp)
 aa8:	7902                	ld	s2,32(sp)
 aaa:	69e2                	ld	s3,24(sp)
 aac:	6a42                	ld	s4,16(sp)
 aae:	6aa2                	ld	s5,8(sp)
 ab0:	6b02                	ld	s6,0(sp)
 ab2:	6121                	addi	sp,sp,64
 ab4:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 ab6:	6398                	ld	a4,0(a5)
 ab8:	e118                	sd	a4,0(a0)
 aba:	bff1                	j	a96 <malloc+0x88>
    hp->s.size = nu;
 abc:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 ac0:	0541                	addi	a0,a0,16
 ac2:	00000097          	auipc	ra,0x0
 ac6:	eca080e7          	jalr	-310(ra) # 98c <free>
    return freep;
 aca:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 ace:	d971                	beqz	a0,aa2 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 ad0:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 ad2:	4798                	lw	a4,8(a5)
 ad4:	fa9775e3          	bgeu	a4,s1,a7e <malloc+0x70>
        if (p == freep)
 ad8:	00093703          	ld	a4,0(s2)
 adc:	853e                	mv	a0,a5
 ade:	fef719e3          	bne	a4,a5,ad0 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 ae2:	8552                	mv	a0,s4
 ae4:	00000097          	auipc	ra,0x0
 ae8:	b7a080e7          	jalr	-1158(ra) # 65e <sbrk>
    if (p == (char *)-1)
 aec:	fd5518e3          	bne	a0,s5,abc <malloc+0xae>
                return 0;
 af0:	4501                	li	a0,0
 af2:	bf45                	j	aa2 <malloc+0x94>
