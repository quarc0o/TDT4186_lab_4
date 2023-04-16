
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	0080                	addi	s0,sp,64
  int i;

  for(i = 1; i < argc; i++){
  12:	4785                	li	a5,1
  14:	06a7d863          	bge	a5,a0,84 <main+0x84>
  18:	00858493          	addi	s1,a1,8
  1c:	3579                	addiw	a0,a0,-2
  1e:	02051793          	slli	a5,a0,0x20
  22:	01d7d513          	srli	a0,a5,0x1d
  26:	00a48a33          	add	s4,s1,a0
  2a:	05c1                	addi	a1,a1,16
  2c:	00a589b3          	add	s3,a1,a0
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  30:	00001a97          	auipc	s5,0x1
  34:	a40a8a93          	addi	s5,s5,-1472 # a70 <malloc+0xf0>
  38:	a819                	j	4e <main+0x4e>
  3a:	4605                	li	a2,1
  3c:	85d6                	mv	a1,s5
  3e:	4505                	li	a0,1
  40:	00000097          	auipc	ra,0x0
  44:	528080e7          	jalr	1320(ra) # 568 <write>
  for(i = 1; i < argc; i++){
  48:	04a1                	addi	s1,s1,8
  4a:	03348d63          	beq	s1,s3,84 <main+0x84>
    write(1, argv[i], strlen(argv[i]));
  4e:	0004b903          	ld	s2,0(s1)
  52:	854a                	mv	a0,s2
  54:	00000097          	auipc	ra,0x0
  58:	2d0080e7          	jalr	720(ra) # 324 <strlen>
  5c:	0005061b          	sext.w	a2,a0
  60:	85ca                	mv	a1,s2
  62:	4505                	li	a0,1
  64:	00000097          	auipc	ra,0x0
  68:	504080e7          	jalr	1284(ra) # 568 <write>
    if(i + 1 < argc){
  6c:	fd4497e3          	bne	s1,s4,3a <main+0x3a>
    } else {
      write(1, "\n", 1);
  70:	4605                	li	a2,1
  72:	00001597          	auipc	a1,0x1
  76:	a0658593          	addi	a1,a1,-1530 # a78 <malloc+0xf8>
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	4ec080e7          	jalr	1260(ra) # 568 <write>
    }
  }
  exit(0);
  84:	4501                	li	a0,0
  86:	00000097          	auipc	ra,0x0
  8a:	4c2080e7          	jalr	1218(ra) # 548 <exit>

000000000000008e <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  8e:	1141                	addi	sp,sp,-16
  90:	e422                	sd	s0,8(sp)
  92:	0800                	addi	s0,sp,16
    lk->name = name;
  94:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  96:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  9a:	57fd                	li	a5,-1
  9c:	00f50823          	sb	a5,16(a0)
}
  a0:	6422                	ld	s0,8(sp)
  a2:	0141                	addi	sp,sp,16
  a4:	8082                	ret

00000000000000a6 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  a6:	00054783          	lbu	a5,0(a0)
  aa:	e399                	bnez	a5,b0 <holding+0xa>
  ac:	4501                	li	a0,0
}
  ae:	8082                	ret
{
  b0:	1101                	addi	sp,sp,-32
  b2:	ec06                	sd	ra,24(sp)
  b4:	e822                	sd	s0,16(sp)
  b6:	e426                	sd	s1,8(sp)
  b8:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  ba:	01054483          	lbu	s1,16(a0)
  be:	00000097          	auipc	ra,0x0
  c2:	172080e7          	jalr	370(ra) # 230 <twhoami>
  c6:	2501                	sext.w	a0,a0
  c8:	40a48533          	sub	a0,s1,a0
  cc:	00153513          	seqz	a0,a0
}
  d0:	60e2                	ld	ra,24(sp)
  d2:	6442                	ld	s0,16(sp)
  d4:	64a2                	ld	s1,8(sp)
  d6:	6105                	addi	sp,sp,32
  d8:	8082                	ret

00000000000000da <acquire>:

void acquire(struct lock *lk)
{
  da:	7179                	addi	sp,sp,-48
  dc:	f406                	sd	ra,40(sp)
  de:	f022                	sd	s0,32(sp)
  e0:	ec26                	sd	s1,24(sp)
  e2:	e84a                	sd	s2,16(sp)
  e4:	e44e                	sd	s3,8(sp)
  e6:	e052                	sd	s4,0(sp)
  e8:	1800                	addi	s0,sp,48
  ea:	8a2a                	mv	s4,a0
    if (holding(lk))
  ec:	00000097          	auipc	ra,0x0
  f0:	fba080e7          	jalr	-70(ra) # a6 <holding>
  f4:	e919                	bnez	a0,10a <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  f6:	ffca7493          	andi	s1,s4,-4
  fa:	003a7913          	andi	s2,s4,3
  fe:	0039191b          	slliw	s2,s2,0x3
 102:	4985                	li	s3,1
 104:	012999bb          	sllw	s3,s3,s2
 108:	a015                	j	12c <acquire+0x52>
        printf("re-acquiring lock we already hold");
 10a:	00001517          	auipc	a0,0x1
 10e:	97650513          	addi	a0,a0,-1674 # a80 <malloc+0x100>
 112:	00000097          	auipc	ra,0x0
 116:	7b6080e7          	jalr	1974(ra) # 8c8 <printf>
        exit(-1);
 11a:	557d                	li	a0,-1
 11c:	00000097          	auipc	ra,0x0
 120:	42c080e7          	jalr	1068(ra) # 548 <exit>
    {
        // give up the cpu for other threads
        tyield();
 124:	00000097          	auipc	ra,0x0
 128:	0f4080e7          	jalr	244(ra) # 218 <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
 12c:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 130:	0127d7bb          	srlw	a5,a5,s2
 134:	0ff7f793          	zext.b	a5,a5
 138:	f7f5                	bnez	a5,124 <acquire+0x4a>
    }

    __sync_synchronize();
 13a:	0ff0000f          	fence

    lk->tid = twhoami();
 13e:	00000097          	auipc	ra,0x0
 142:	0f2080e7          	jalr	242(ra) # 230 <twhoami>
 146:	00aa0823          	sb	a0,16(s4)
}
 14a:	70a2                	ld	ra,40(sp)
 14c:	7402                	ld	s0,32(sp)
 14e:	64e2                	ld	s1,24(sp)
 150:	6942                	ld	s2,16(sp)
 152:	69a2                	ld	s3,8(sp)
 154:	6a02                	ld	s4,0(sp)
 156:	6145                	addi	sp,sp,48
 158:	8082                	ret

000000000000015a <release>:

void release(struct lock *lk)
{
 15a:	1101                	addi	sp,sp,-32
 15c:	ec06                	sd	ra,24(sp)
 15e:	e822                	sd	s0,16(sp)
 160:	e426                	sd	s1,8(sp)
 162:	1000                	addi	s0,sp,32
 164:	84aa                	mv	s1,a0
    if (!holding(lk))
 166:	00000097          	auipc	ra,0x0
 16a:	f40080e7          	jalr	-192(ra) # a6 <holding>
 16e:	c11d                	beqz	a0,194 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 170:	57fd                	li	a5,-1
 172:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 176:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 17a:	0ff0000f          	fence
 17e:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 182:	00000097          	auipc	ra,0x0
 186:	096080e7          	jalr	150(ra) # 218 <tyield>
}
 18a:	60e2                	ld	ra,24(sp)
 18c:	6442                	ld	s0,16(sp)
 18e:	64a2                	ld	s1,8(sp)
 190:	6105                	addi	sp,sp,32
 192:	8082                	ret
        printf("releasing lock we are not holding");
 194:	00001517          	auipc	a0,0x1
 198:	91450513          	addi	a0,a0,-1772 # aa8 <malloc+0x128>
 19c:	00000097          	auipc	ra,0x0
 1a0:	72c080e7          	jalr	1836(ra) # 8c8 <printf>
        exit(-1);
 1a4:	557d                	li	a0,-1
 1a6:	00000097          	auipc	ra,0x0
 1aa:	3a2080e7          	jalr	930(ra) # 548 <exit>

00000000000001ae <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 1ae:	1141                	addi	sp,sp,-16
 1b0:	e422                	sd	s0,8(sp)
 1b2:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 1b4:	00001717          	auipc	a4,0x1
 1b8:	e4c73703          	ld	a4,-436(a4) # 1000 <current_thread>
 1bc:	47c1                	li	a5,16
 1be:	c319                	beqz	a4,1c4 <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 1c0:	37fd                	addiw	a5,a5,-1
 1c2:	fff5                	bnez	a5,1be <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 1c4:	6422                	ld	s0,8(sp)
 1c6:	0141                	addi	sp,sp,16
 1c8:	8082                	ret

00000000000001ca <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 1ca:	7179                	addi	sp,sp,-48
 1cc:	f406                	sd	ra,40(sp)
 1ce:	f022                	sd	s0,32(sp)
 1d0:	ec26                	sd	s1,24(sp)
 1d2:	e84a                	sd	s2,16(sp)
 1d4:	e44e                	sd	s3,8(sp)
 1d6:	1800                	addi	s0,sp,48
 1d8:	84aa                	mv	s1,a0
 1da:	89b2                	mv	s3,a2
 1dc:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 1de:	09000513          	li	a0,144
 1e2:	00000097          	auipc	ra,0x0
 1e6:	79e080e7          	jalr	1950(ra) # 980 <malloc>
 1ea:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 1ec:	478d                	li	a5,3
 1ee:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 1f0:	609c                	ld	a5,0(s1)
 1f2:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 1f6:	609c                	ld	a5,0(s1)
 1f8:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 1fc:	70a2                	ld	ra,40(sp)
 1fe:	7402                	ld	s0,32(sp)
 200:	64e2                	ld	s1,24(sp)
 202:	6942                	ld	s2,16(sp)
 204:	69a2                	ld	s3,8(sp)
 206:	6145                	addi	sp,sp,48
 208:	8082                	ret

000000000000020a <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 20a:	1141                	addi	sp,sp,-16
 20c:	e422                	sd	s0,8(sp)
 20e:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 210:	4501                	li	a0,0
 212:	6422                	ld	s0,8(sp)
 214:	0141                	addi	sp,sp,16
 216:	8082                	ret

0000000000000218 <tyield>:

void tyield()
{
 218:	1141                	addi	sp,sp,-16
 21a:	e422                	sd	s0,8(sp)
 21c:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 21e:	00001797          	auipc	a5,0x1
 222:	de27b783          	ld	a5,-542(a5) # 1000 <current_thread>
 226:	470d                	li	a4,3
 228:	dfb8                	sw	a4,120(a5)
    tsched();
}
 22a:	6422                	ld	s0,8(sp)
 22c:	0141                	addi	sp,sp,16
 22e:	8082                	ret

0000000000000230 <twhoami>:

uint8 twhoami()
{
 230:	1141                	addi	sp,sp,-16
 232:	e422                	sd	s0,8(sp)
 234:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 236:	4501                	li	a0,0
 238:	6422                	ld	s0,8(sp)
 23a:	0141                	addi	sp,sp,16
 23c:	8082                	ret

000000000000023e <tswtch>:
 23e:	00153023          	sd	ra,0(a0)
 242:	00253423          	sd	sp,8(a0)
 246:	e900                	sd	s0,16(a0)
 248:	ed04                	sd	s1,24(a0)
 24a:	03253023          	sd	s2,32(a0)
 24e:	03353423          	sd	s3,40(a0)
 252:	03453823          	sd	s4,48(a0)
 256:	03553c23          	sd	s5,56(a0)
 25a:	05653023          	sd	s6,64(a0)
 25e:	05753423          	sd	s7,72(a0)
 262:	05853823          	sd	s8,80(a0)
 266:	05953c23          	sd	s9,88(a0)
 26a:	07a53023          	sd	s10,96(a0)
 26e:	07b53423          	sd	s11,104(a0)
 272:	0005b083          	ld	ra,0(a1)
 276:	0085b103          	ld	sp,8(a1)
 27a:	6980                	ld	s0,16(a1)
 27c:	6d84                	ld	s1,24(a1)
 27e:	0205b903          	ld	s2,32(a1)
 282:	0285b983          	ld	s3,40(a1)
 286:	0305ba03          	ld	s4,48(a1)
 28a:	0385ba83          	ld	s5,56(a1)
 28e:	0405bb03          	ld	s6,64(a1)
 292:	0485bb83          	ld	s7,72(a1)
 296:	0505bc03          	ld	s8,80(a1)
 29a:	0585bc83          	ld	s9,88(a1)
 29e:	0605bd03          	ld	s10,96(a1)
 2a2:	0685bd83          	ld	s11,104(a1)
 2a6:	8082                	ret

00000000000002a8 <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 2a8:	1101                	addi	sp,sp,-32
 2aa:	ec06                	sd	ra,24(sp)
 2ac:	e822                	sd	s0,16(sp)
 2ae:	e426                	sd	s1,8(sp)
 2b0:	e04a                	sd	s2,0(sp)
 2b2:	1000                	addi	s0,sp,32
 2b4:	84aa                	mv	s1,a0
 2b6:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 2b8:	09000513          	li	a0,144
 2bc:	00000097          	auipc	ra,0x0
 2c0:	6c4080e7          	jalr	1732(ra) # 980 <malloc>

    main_thread->tid = 0;
 2c4:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 2c8:	85ca                	mv	a1,s2
 2ca:	8526                	mv	a0,s1
 2cc:	00000097          	auipc	ra,0x0
 2d0:	d34080e7          	jalr	-716(ra) # 0 <main>
    exit(res);
 2d4:	00000097          	auipc	ra,0x0
 2d8:	274080e7          	jalr	628(ra) # 548 <exit>

00000000000002dc <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 2dc:	1141                	addi	sp,sp,-16
 2de:	e422                	sd	s0,8(sp)
 2e0:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 2e2:	87aa                	mv	a5,a0
 2e4:	0585                	addi	a1,a1,1
 2e6:	0785                	addi	a5,a5,1
 2e8:	fff5c703          	lbu	a4,-1(a1)
 2ec:	fee78fa3          	sb	a4,-1(a5)
 2f0:	fb75                	bnez	a4,2e4 <strcpy+0x8>
        ;
    return os;
}
 2f2:	6422                	ld	s0,8(sp)
 2f4:	0141                	addi	sp,sp,16
 2f6:	8082                	ret

00000000000002f8 <strcmp>:

int strcmp(const char *p, const char *q)
{
 2f8:	1141                	addi	sp,sp,-16
 2fa:	e422                	sd	s0,8(sp)
 2fc:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 2fe:	00054783          	lbu	a5,0(a0)
 302:	cb91                	beqz	a5,316 <strcmp+0x1e>
 304:	0005c703          	lbu	a4,0(a1)
 308:	00f71763          	bne	a4,a5,316 <strcmp+0x1e>
        p++, q++;
 30c:	0505                	addi	a0,a0,1
 30e:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 310:	00054783          	lbu	a5,0(a0)
 314:	fbe5                	bnez	a5,304 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 316:	0005c503          	lbu	a0,0(a1)
}
 31a:	40a7853b          	subw	a0,a5,a0
 31e:	6422                	ld	s0,8(sp)
 320:	0141                	addi	sp,sp,16
 322:	8082                	ret

0000000000000324 <strlen>:

uint strlen(const char *s)
{
 324:	1141                	addi	sp,sp,-16
 326:	e422                	sd	s0,8(sp)
 328:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 32a:	00054783          	lbu	a5,0(a0)
 32e:	cf91                	beqz	a5,34a <strlen+0x26>
 330:	0505                	addi	a0,a0,1
 332:	87aa                	mv	a5,a0
 334:	86be                	mv	a3,a5
 336:	0785                	addi	a5,a5,1
 338:	fff7c703          	lbu	a4,-1(a5)
 33c:	ff65                	bnez	a4,334 <strlen+0x10>
 33e:	40a6853b          	subw	a0,a3,a0
 342:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 344:	6422                	ld	s0,8(sp)
 346:	0141                	addi	sp,sp,16
 348:	8082                	ret
    for (n = 0; s[n]; n++)
 34a:	4501                	li	a0,0
 34c:	bfe5                	j	344 <strlen+0x20>

000000000000034e <memset>:

void *
memset(void *dst, int c, uint n)
{
 34e:	1141                	addi	sp,sp,-16
 350:	e422                	sd	s0,8(sp)
 352:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 354:	ca19                	beqz	a2,36a <memset+0x1c>
 356:	87aa                	mv	a5,a0
 358:	1602                	slli	a2,a2,0x20
 35a:	9201                	srli	a2,a2,0x20
 35c:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 360:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 364:	0785                	addi	a5,a5,1
 366:	fee79de3          	bne	a5,a4,360 <memset+0x12>
    }
    return dst;
}
 36a:	6422                	ld	s0,8(sp)
 36c:	0141                	addi	sp,sp,16
 36e:	8082                	ret

0000000000000370 <strchr>:

char *
strchr(const char *s, char c)
{
 370:	1141                	addi	sp,sp,-16
 372:	e422                	sd	s0,8(sp)
 374:	0800                	addi	s0,sp,16
    for (; *s; s++)
 376:	00054783          	lbu	a5,0(a0)
 37a:	cb99                	beqz	a5,390 <strchr+0x20>
        if (*s == c)
 37c:	00f58763          	beq	a1,a5,38a <strchr+0x1a>
    for (; *s; s++)
 380:	0505                	addi	a0,a0,1
 382:	00054783          	lbu	a5,0(a0)
 386:	fbfd                	bnez	a5,37c <strchr+0xc>
            return (char *)s;
    return 0;
 388:	4501                	li	a0,0
}
 38a:	6422                	ld	s0,8(sp)
 38c:	0141                	addi	sp,sp,16
 38e:	8082                	ret
    return 0;
 390:	4501                	li	a0,0
 392:	bfe5                	j	38a <strchr+0x1a>

0000000000000394 <gets>:

char *
gets(char *buf, int max)
{
 394:	711d                	addi	sp,sp,-96
 396:	ec86                	sd	ra,88(sp)
 398:	e8a2                	sd	s0,80(sp)
 39a:	e4a6                	sd	s1,72(sp)
 39c:	e0ca                	sd	s2,64(sp)
 39e:	fc4e                	sd	s3,56(sp)
 3a0:	f852                	sd	s4,48(sp)
 3a2:	f456                	sd	s5,40(sp)
 3a4:	f05a                	sd	s6,32(sp)
 3a6:	ec5e                	sd	s7,24(sp)
 3a8:	1080                	addi	s0,sp,96
 3aa:	8baa                	mv	s7,a0
 3ac:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 3ae:	892a                	mv	s2,a0
 3b0:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 3b2:	4aa9                	li	s5,10
 3b4:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 3b6:	89a6                	mv	s3,s1
 3b8:	2485                	addiw	s1,s1,1
 3ba:	0344d863          	bge	s1,s4,3ea <gets+0x56>
        cc = read(0, &c, 1);
 3be:	4605                	li	a2,1
 3c0:	faf40593          	addi	a1,s0,-81
 3c4:	4501                	li	a0,0
 3c6:	00000097          	auipc	ra,0x0
 3ca:	19a080e7          	jalr	410(ra) # 560 <read>
        if (cc < 1)
 3ce:	00a05e63          	blez	a0,3ea <gets+0x56>
        buf[i++] = c;
 3d2:	faf44783          	lbu	a5,-81(s0)
 3d6:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 3da:	01578763          	beq	a5,s5,3e8 <gets+0x54>
 3de:	0905                	addi	s2,s2,1
 3e0:	fd679be3          	bne	a5,s6,3b6 <gets+0x22>
    for (i = 0; i + 1 < max;)
 3e4:	89a6                	mv	s3,s1
 3e6:	a011                	j	3ea <gets+0x56>
 3e8:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 3ea:	99de                	add	s3,s3,s7
 3ec:	00098023          	sb	zero,0(s3)
    return buf;
}
 3f0:	855e                	mv	a0,s7
 3f2:	60e6                	ld	ra,88(sp)
 3f4:	6446                	ld	s0,80(sp)
 3f6:	64a6                	ld	s1,72(sp)
 3f8:	6906                	ld	s2,64(sp)
 3fa:	79e2                	ld	s3,56(sp)
 3fc:	7a42                	ld	s4,48(sp)
 3fe:	7aa2                	ld	s5,40(sp)
 400:	7b02                	ld	s6,32(sp)
 402:	6be2                	ld	s7,24(sp)
 404:	6125                	addi	sp,sp,96
 406:	8082                	ret

0000000000000408 <stat>:

int stat(const char *n, struct stat *st)
{
 408:	1101                	addi	sp,sp,-32
 40a:	ec06                	sd	ra,24(sp)
 40c:	e822                	sd	s0,16(sp)
 40e:	e426                	sd	s1,8(sp)
 410:	e04a                	sd	s2,0(sp)
 412:	1000                	addi	s0,sp,32
 414:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 416:	4581                	li	a1,0
 418:	00000097          	auipc	ra,0x0
 41c:	170080e7          	jalr	368(ra) # 588 <open>
    if (fd < 0)
 420:	02054563          	bltz	a0,44a <stat+0x42>
 424:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 426:	85ca                	mv	a1,s2
 428:	00000097          	auipc	ra,0x0
 42c:	178080e7          	jalr	376(ra) # 5a0 <fstat>
 430:	892a                	mv	s2,a0
    close(fd);
 432:	8526                	mv	a0,s1
 434:	00000097          	auipc	ra,0x0
 438:	13c080e7          	jalr	316(ra) # 570 <close>
    return r;
}
 43c:	854a                	mv	a0,s2
 43e:	60e2                	ld	ra,24(sp)
 440:	6442                	ld	s0,16(sp)
 442:	64a2                	ld	s1,8(sp)
 444:	6902                	ld	s2,0(sp)
 446:	6105                	addi	sp,sp,32
 448:	8082                	ret
        return -1;
 44a:	597d                	li	s2,-1
 44c:	bfc5                	j	43c <stat+0x34>

000000000000044e <atoi>:

int atoi(const char *s)
{
 44e:	1141                	addi	sp,sp,-16
 450:	e422                	sd	s0,8(sp)
 452:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 454:	00054683          	lbu	a3,0(a0)
 458:	fd06879b          	addiw	a5,a3,-48
 45c:	0ff7f793          	zext.b	a5,a5
 460:	4625                	li	a2,9
 462:	02f66863          	bltu	a2,a5,492 <atoi+0x44>
 466:	872a                	mv	a4,a0
    n = 0;
 468:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 46a:	0705                	addi	a4,a4,1
 46c:	0025179b          	slliw	a5,a0,0x2
 470:	9fa9                	addw	a5,a5,a0
 472:	0017979b          	slliw	a5,a5,0x1
 476:	9fb5                	addw	a5,a5,a3
 478:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 47c:	00074683          	lbu	a3,0(a4)
 480:	fd06879b          	addiw	a5,a3,-48
 484:	0ff7f793          	zext.b	a5,a5
 488:	fef671e3          	bgeu	a2,a5,46a <atoi+0x1c>
    return n;
}
 48c:	6422                	ld	s0,8(sp)
 48e:	0141                	addi	sp,sp,16
 490:	8082                	ret
    n = 0;
 492:	4501                	li	a0,0
 494:	bfe5                	j	48c <atoi+0x3e>

0000000000000496 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 496:	1141                	addi	sp,sp,-16
 498:	e422                	sd	s0,8(sp)
 49a:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 49c:	02b57463          	bgeu	a0,a1,4c4 <memmove+0x2e>
    {
        while (n-- > 0)
 4a0:	00c05f63          	blez	a2,4be <memmove+0x28>
 4a4:	1602                	slli	a2,a2,0x20
 4a6:	9201                	srli	a2,a2,0x20
 4a8:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 4ac:	872a                	mv	a4,a0
            *dst++ = *src++;
 4ae:	0585                	addi	a1,a1,1
 4b0:	0705                	addi	a4,a4,1
 4b2:	fff5c683          	lbu	a3,-1(a1)
 4b6:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 4ba:	fee79ae3          	bne	a5,a4,4ae <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 4be:	6422                	ld	s0,8(sp)
 4c0:	0141                	addi	sp,sp,16
 4c2:	8082                	ret
        dst += n;
 4c4:	00c50733          	add	a4,a0,a2
        src += n;
 4c8:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 4ca:	fec05ae3          	blez	a2,4be <memmove+0x28>
 4ce:	fff6079b          	addiw	a5,a2,-1
 4d2:	1782                	slli	a5,a5,0x20
 4d4:	9381                	srli	a5,a5,0x20
 4d6:	fff7c793          	not	a5,a5
 4da:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 4dc:	15fd                	addi	a1,a1,-1
 4de:	177d                	addi	a4,a4,-1
 4e0:	0005c683          	lbu	a3,0(a1)
 4e4:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 4e8:	fee79ae3          	bne	a5,a4,4dc <memmove+0x46>
 4ec:	bfc9                	j	4be <memmove+0x28>

00000000000004ee <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 4ee:	1141                	addi	sp,sp,-16
 4f0:	e422                	sd	s0,8(sp)
 4f2:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 4f4:	ca05                	beqz	a2,524 <memcmp+0x36>
 4f6:	fff6069b          	addiw	a3,a2,-1
 4fa:	1682                	slli	a3,a3,0x20
 4fc:	9281                	srli	a3,a3,0x20
 4fe:	0685                	addi	a3,a3,1
 500:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 502:	00054783          	lbu	a5,0(a0)
 506:	0005c703          	lbu	a4,0(a1)
 50a:	00e79863          	bne	a5,a4,51a <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 50e:	0505                	addi	a0,a0,1
        p2++;
 510:	0585                	addi	a1,a1,1
    while (n-- > 0)
 512:	fed518e3          	bne	a0,a3,502 <memcmp+0x14>
    }
    return 0;
 516:	4501                	li	a0,0
 518:	a019                	j	51e <memcmp+0x30>
            return *p1 - *p2;
 51a:	40e7853b          	subw	a0,a5,a4
}
 51e:	6422                	ld	s0,8(sp)
 520:	0141                	addi	sp,sp,16
 522:	8082                	ret
    return 0;
 524:	4501                	li	a0,0
 526:	bfe5                	j	51e <memcmp+0x30>

0000000000000528 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 528:	1141                	addi	sp,sp,-16
 52a:	e406                	sd	ra,8(sp)
 52c:	e022                	sd	s0,0(sp)
 52e:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 530:	00000097          	auipc	ra,0x0
 534:	f66080e7          	jalr	-154(ra) # 496 <memmove>
}
 538:	60a2                	ld	ra,8(sp)
 53a:	6402                	ld	s0,0(sp)
 53c:	0141                	addi	sp,sp,16
 53e:	8082                	ret

0000000000000540 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 540:	4885                	li	a7,1
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <exit>:
.global exit
exit:
 li a7, SYS_exit
 548:	4889                	li	a7,2
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <wait>:
.global wait
wait:
 li a7, SYS_wait
 550:	488d                	li	a7,3
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 558:	4891                	li	a7,4
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <read>:
.global read
read:
 li a7, SYS_read
 560:	4895                	li	a7,5
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <write>:
.global write
write:
 li a7, SYS_write
 568:	48c1                	li	a7,16
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <close>:
.global close
close:
 li a7, SYS_close
 570:	48d5                	li	a7,21
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <kill>:
.global kill
kill:
 li a7, SYS_kill
 578:	4899                	li	a7,6
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <exec>:
.global exec
exec:
 li a7, SYS_exec
 580:	489d                	li	a7,7
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <open>:
.global open
open:
 li a7, SYS_open
 588:	48bd                	li	a7,15
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 590:	48c5                	li	a7,17
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 598:	48c9                	li	a7,18
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5a0:	48a1                	li	a7,8
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <link>:
.global link
link:
 li a7, SYS_link
 5a8:	48cd                	li	a7,19
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5b0:	48d1                	li	a7,20
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5b8:	48a5                	li	a7,9
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5c0:	48a9                	li	a7,10
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5c8:	48ad                	li	a7,11
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5d0:	48b1                	li	a7,12
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5d8:	48b5                	li	a7,13
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5e0:	48b9                	li	a7,14
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <ps>:
.global ps
ps:
 li a7, SYS_ps
 5e8:	48d9                	li	a7,22
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 5f0:	48dd                	li	a7,23
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 5f8:	48e1                	li	a7,24
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 600:	1101                	addi	sp,sp,-32
 602:	ec06                	sd	ra,24(sp)
 604:	e822                	sd	s0,16(sp)
 606:	1000                	addi	s0,sp,32
 608:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 60c:	4605                	li	a2,1
 60e:	fef40593          	addi	a1,s0,-17
 612:	00000097          	auipc	ra,0x0
 616:	f56080e7          	jalr	-170(ra) # 568 <write>
}
 61a:	60e2                	ld	ra,24(sp)
 61c:	6442                	ld	s0,16(sp)
 61e:	6105                	addi	sp,sp,32
 620:	8082                	ret

0000000000000622 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 622:	7139                	addi	sp,sp,-64
 624:	fc06                	sd	ra,56(sp)
 626:	f822                	sd	s0,48(sp)
 628:	f426                	sd	s1,40(sp)
 62a:	f04a                	sd	s2,32(sp)
 62c:	ec4e                	sd	s3,24(sp)
 62e:	0080                	addi	s0,sp,64
 630:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 632:	c299                	beqz	a3,638 <printint+0x16>
 634:	0805c963          	bltz	a1,6c6 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 638:	2581                	sext.w	a1,a1
  neg = 0;
 63a:	4881                	li	a7,0
 63c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 640:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 642:	2601                	sext.w	a2,a2
 644:	00000517          	auipc	a0,0x0
 648:	4ec50513          	addi	a0,a0,1260 # b30 <digits>
 64c:	883a                	mv	a6,a4
 64e:	2705                	addiw	a4,a4,1
 650:	02c5f7bb          	remuw	a5,a1,a2
 654:	1782                	slli	a5,a5,0x20
 656:	9381                	srli	a5,a5,0x20
 658:	97aa                	add	a5,a5,a0
 65a:	0007c783          	lbu	a5,0(a5)
 65e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 662:	0005879b          	sext.w	a5,a1
 666:	02c5d5bb          	divuw	a1,a1,a2
 66a:	0685                	addi	a3,a3,1
 66c:	fec7f0e3          	bgeu	a5,a2,64c <printint+0x2a>
  if(neg)
 670:	00088c63          	beqz	a7,688 <printint+0x66>
    buf[i++] = '-';
 674:	fd070793          	addi	a5,a4,-48
 678:	00878733          	add	a4,a5,s0
 67c:	02d00793          	li	a5,45
 680:	fef70823          	sb	a5,-16(a4)
 684:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 688:	02e05863          	blez	a4,6b8 <printint+0x96>
 68c:	fc040793          	addi	a5,s0,-64
 690:	00e78933          	add	s2,a5,a4
 694:	fff78993          	addi	s3,a5,-1
 698:	99ba                	add	s3,s3,a4
 69a:	377d                	addiw	a4,a4,-1
 69c:	1702                	slli	a4,a4,0x20
 69e:	9301                	srli	a4,a4,0x20
 6a0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6a4:	fff94583          	lbu	a1,-1(s2)
 6a8:	8526                	mv	a0,s1
 6aa:	00000097          	auipc	ra,0x0
 6ae:	f56080e7          	jalr	-170(ra) # 600 <putc>
  while(--i >= 0)
 6b2:	197d                	addi	s2,s2,-1
 6b4:	ff3918e3          	bne	s2,s3,6a4 <printint+0x82>
}
 6b8:	70e2                	ld	ra,56(sp)
 6ba:	7442                	ld	s0,48(sp)
 6bc:	74a2                	ld	s1,40(sp)
 6be:	7902                	ld	s2,32(sp)
 6c0:	69e2                	ld	s3,24(sp)
 6c2:	6121                	addi	sp,sp,64
 6c4:	8082                	ret
    x = -xx;
 6c6:	40b005bb          	negw	a1,a1
    neg = 1;
 6ca:	4885                	li	a7,1
    x = -xx;
 6cc:	bf85                	j	63c <printint+0x1a>

00000000000006ce <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6ce:	715d                	addi	sp,sp,-80
 6d0:	e486                	sd	ra,72(sp)
 6d2:	e0a2                	sd	s0,64(sp)
 6d4:	fc26                	sd	s1,56(sp)
 6d6:	f84a                	sd	s2,48(sp)
 6d8:	f44e                	sd	s3,40(sp)
 6da:	f052                	sd	s4,32(sp)
 6dc:	ec56                	sd	s5,24(sp)
 6de:	e85a                	sd	s6,16(sp)
 6e0:	e45e                	sd	s7,8(sp)
 6e2:	e062                	sd	s8,0(sp)
 6e4:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6e6:	0005c903          	lbu	s2,0(a1)
 6ea:	18090c63          	beqz	s2,882 <vprintf+0x1b4>
 6ee:	8aaa                	mv	s5,a0
 6f0:	8bb2                	mv	s7,a2
 6f2:	00158493          	addi	s1,a1,1
  state = 0;
 6f6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6f8:	02500a13          	li	s4,37
 6fc:	4b55                	li	s6,21
 6fe:	a839                	j	71c <vprintf+0x4e>
        putc(fd, c);
 700:	85ca                	mv	a1,s2
 702:	8556                	mv	a0,s5
 704:	00000097          	auipc	ra,0x0
 708:	efc080e7          	jalr	-260(ra) # 600 <putc>
 70c:	a019                	j	712 <vprintf+0x44>
    } else if(state == '%'){
 70e:	01498d63          	beq	s3,s4,728 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 712:	0485                	addi	s1,s1,1
 714:	fff4c903          	lbu	s2,-1(s1)
 718:	16090563          	beqz	s2,882 <vprintf+0x1b4>
    if(state == 0){
 71c:	fe0999e3          	bnez	s3,70e <vprintf+0x40>
      if(c == '%'){
 720:	ff4910e3          	bne	s2,s4,700 <vprintf+0x32>
        state = '%';
 724:	89d2                	mv	s3,s4
 726:	b7f5                	j	712 <vprintf+0x44>
      if(c == 'd'){
 728:	13490263          	beq	s2,s4,84c <vprintf+0x17e>
 72c:	f9d9079b          	addiw	a5,s2,-99
 730:	0ff7f793          	zext.b	a5,a5
 734:	12fb6563          	bltu	s6,a5,85e <vprintf+0x190>
 738:	f9d9079b          	addiw	a5,s2,-99
 73c:	0ff7f713          	zext.b	a4,a5
 740:	10eb6f63          	bltu	s6,a4,85e <vprintf+0x190>
 744:	00271793          	slli	a5,a4,0x2
 748:	00000717          	auipc	a4,0x0
 74c:	39070713          	addi	a4,a4,912 # ad8 <malloc+0x158>
 750:	97ba                	add	a5,a5,a4
 752:	439c                	lw	a5,0(a5)
 754:	97ba                	add	a5,a5,a4
 756:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 758:	008b8913          	addi	s2,s7,8
 75c:	4685                	li	a3,1
 75e:	4629                	li	a2,10
 760:	000ba583          	lw	a1,0(s7)
 764:	8556                	mv	a0,s5
 766:	00000097          	auipc	ra,0x0
 76a:	ebc080e7          	jalr	-324(ra) # 622 <printint>
 76e:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 770:	4981                	li	s3,0
 772:	b745                	j	712 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 774:	008b8913          	addi	s2,s7,8
 778:	4681                	li	a3,0
 77a:	4629                	li	a2,10
 77c:	000ba583          	lw	a1,0(s7)
 780:	8556                	mv	a0,s5
 782:	00000097          	auipc	ra,0x0
 786:	ea0080e7          	jalr	-352(ra) # 622 <printint>
 78a:	8bca                	mv	s7,s2
      state = 0;
 78c:	4981                	li	s3,0
 78e:	b751                	j	712 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 790:	008b8913          	addi	s2,s7,8
 794:	4681                	li	a3,0
 796:	4641                	li	a2,16
 798:	000ba583          	lw	a1,0(s7)
 79c:	8556                	mv	a0,s5
 79e:	00000097          	auipc	ra,0x0
 7a2:	e84080e7          	jalr	-380(ra) # 622 <printint>
 7a6:	8bca                	mv	s7,s2
      state = 0;
 7a8:	4981                	li	s3,0
 7aa:	b7a5                	j	712 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 7ac:	008b8c13          	addi	s8,s7,8
 7b0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7b4:	03000593          	li	a1,48
 7b8:	8556                	mv	a0,s5
 7ba:	00000097          	auipc	ra,0x0
 7be:	e46080e7          	jalr	-442(ra) # 600 <putc>
  putc(fd, 'x');
 7c2:	07800593          	li	a1,120
 7c6:	8556                	mv	a0,s5
 7c8:	00000097          	auipc	ra,0x0
 7cc:	e38080e7          	jalr	-456(ra) # 600 <putc>
 7d0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7d2:	00000b97          	auipc	s7,0x0
 7d6:	35eb8b93          	addi	s7,s7,862 # b30 <digits>
 7da:	03c9d793          	srli	a5,s3,0x3c
 7de:	97de                	add	a5,a5,s7
 7e0:	0007c583          	lbu	a1,0(a5)
 7e4:	8556                	mv	a0,s5
 7e6:	00000097          	auipc	ra,0x0
 7ea:	e1a080e7          	jalr	-486(ra) # 600 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ee:	0992                	slli	s3,s3,0x4
 7f0:	397d                	addiw	s2,s2,-1
 7f2:	fe0914e3          	bnez	s2,7da <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 7f6:	8be2                	mv	s7,s8
      state = 0;
 7f8:	4981                	li	s3,0
 7fa:	bf21                	j	712 <vprintf+0x44>
        s = va_arg(ap, char*);
 7fc:	008b8993          	addi	s3,s7,8
 800:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 804:	02090163          	beqz	s2,826 <vprintf+0x158>
        while(*s != 0){
 808:	00094583          	lbu	a1,0(s2)
 80c:	c9a5                	beqz	a1,87c <vprintf+0x1ae>
          putc(fd, *s);
 80e:	8556                	mv	a0,s5
 810:	00000097          	auipc	ra,0x0
 814:	df0080e7          	jalr	-528(ra) # 600 <putc>
          s++;
 818:	0905                	addi	s2,s2,1
        while(*s != 0){
 81a:	00094583          	lbu	a1,0(s2)
 81e:	f9e5                	bnez	a1,80e <vprintf+0x140>
        s = va_arg(ap, char*);
 820:	8bce                	mv	s7,s3
      state = 0;
 822:	4981                	li	s3,0
 824:	b5fd                	j	712 <vprintf+0x44>
          s = "(null)";
 826:	00000917          	auipc	s2,0x0
 82a:	2aa90913          	addi	s2,s2,682 # ad0 <malloc+0x150>
        while(*s != 0){
 82e:	02800593          	li	a1,40
 832:	bff1                	j	80e <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 834:	008b8913          	addi	s2,s7,8
 838:	000bc583          	lbu	a1,0(s7)
 83c:	8556                	mv	a0,s5
 83e:	00000097          	auipc	ra,0x0
 842:	dc2080e7          	jalr	-574(ra) # 600 <putc>
 846:	8bca                	mv	s7,s2
      state = 0;
 848:	4981                	li	s3,0
 84a:	b5e1                	j	712 <vprintf+0x44>
        putc(fd, c);
 84c:	02500593          	li	a1,37
 850:	8556                	mv	a0,s5
 852:	00000097          	auipc	ra,0x0
 856:	dae080e7          	jalr	-594(ra) # 600 <putc>
      state = 0;
 85a:	4981                	li	s3,0
 85c:	bd5d                	j	712 <vprintf+0x44>
        putc(fd, '%');
 85e:	02500593          	li	a1,37
 862:	8556                	mv	a0,s5
 864:	00000097          	auipc	ra,0x0
 868:	d9c080e7          	jalr	-612(ra) # 600 <putc>
        putc(fd, c);
 86c:	85ca                	mv	a1,s2
 86e:	8556                	mv	a0,s5
 870:	00000097          	auipc	ra,0x0
 874:	d90080e7          	jalr	-624(ra) # 600 <putc>
      state = 0;
 878:	4981                	li	s3,0
 87a:	bd61                	j	712 <vprintf+0x44>
        s = va_arg(ap, char*);
 87c:	8bce                	mv	s7,s3
      state = 0;
 87e:	4981                	li	s3,0
 880:	bd49                	j	712 <vprintf+0x44>
    }
  }
}
 882:	60a6                	ld	ra,72(sp)
 884:	6406                	ld	s0,64(sp)
 886:	74e2                	ld	s1,56(sp)
 888:	7942                	ld	s2,48(sp)
 88a:	79a2                	ld	s3,40(sp)
 88c:	7a02                	ld	s4,32(sp)
 88e:	6ae2                	ld	s5,24(sp)
 890:	6b42                	ld	s6,16(sp)
 892:	6ba2                	ld	s7,8(sp)
 894:	6c02                	ld	s8,0(sp)
 896:	6161                	addi	sp,sp,80
 898:	8082                	ret

000000000000089a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 89a:	715d                	addi	sp,sp,-80
 89c:	ec06                	sd	ra,24(sp)
 89e:	e822                	sd	s0,16(sp)
 8a0:	1000                	addi	s0,sp,32
 8a2:	e010                	sd	a2,0(s0)
 8a4:	e414                	sd	a3,8(s0)
 8a6:	e818                	sd	a4,16(s0)
 8a8:	ec1c                	sd	a5,24(s0)
 8aa:	03043023          	sd	a6,32(s0)
 8ae:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8b2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8b6:	8622                	mv	a2,s0
 8b8:	00000097          	auipc	ra,0x0
 8bc:	e16080e7          	jalr	-490(ra) # 6ce <vprintf>
}
 8c0:	60e2                	ld	ra,24(sp)
 8c2:	6442                	ld	s0,16(sp)
 8c4:	6161                	addi	sp,sp,80
 8c6:	8082                	ret

00000000000008c8 <printf>:

void
printf(const char *fmt, ...)
{
 8c8:	711d                	addi	sp,sp,-96
 8ca:	ec06                	sd	ra,24(sp)
 8cc:	e822                	sd	s0,16(sp)
 8ce:	1000                	addi	s0,sp,32
 8d0:	e40c                	sd	a1,8(s0)
 8d2:	e810                	sd	a2,16(s0)
 8d4:	ec14                	sd	a3,24(s0)
 8d6:	f018                	sd	a4,32(s0)
 8d8:	f41c                	sd	a5,40(s0)
 8da:	03043823          	sd	a6,48(s0)
 8de:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8e2:	00840613          	addi	a2,s0,8
 8e6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8ea:	85aa                	mv	a1,a0
 8ec:	4505                	li	a0,1
 8ee:	00000097          	auipc	ra,0x0
 8f2:	de0080e7          	jalr	-544(ra) # 6ce <vprintf>
}
 8f6:	60e2                	ld	ra,24(sp)
 8f8:	6442                	ld	s0,16(sp)
 8fa:	6125                	addi	sp,sp,96
 8fc:	8082                	ret

00000000000008fe <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 8fe:	1141                	addi	sp,sp,-16
 900:	e422                	sd	s0,8(sp)
 902:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 904:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 908:	00000797          	auipc	a5,0x0
 90c:	7007b783          	ld	a5,1792(a5) # 1008 <freep>
 910:	a02d                	j	93a <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 912:	4618                	lw	a4,8(a2)
 914:	9f2d                	addw	a4,a4,a1
 916:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 91a:	6398                	ld	a4,0(a5)
 91c:	6310                	ld	a2,0(a4)
 91e:	a83d                	j	95c <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 920:	ff852703          	lw	a4,-8(a0)
 924:	9f31                	addw	a4,a4,a2
 926:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 928:	ff053683          	ld	a3,-16(a0)
 92c:	a091                	j	970 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 92e:	6398                	ld	a4,0(a5)
 930:	00e7e463          	bltu	a5,a4,938 <free+0x3a>
 934:	00e6ea63          	bltu	a3,a4,948 <free+0x4a>
{
 938:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 93a:	fed7fae3          	bgeu	a5,a3,92e <free+0x30>
 93e:	6398                	ld	a4,0(a5)
 940:	00e6e463          	bltu	a3,a4,948 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 944:	fee7eae3          	bltu	a5,a4,938 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 948:	ff852583          	lw	a1,-8(a0)
 94c:	6390                	ld	a2,0(a5)
 94e:	02059813          	slli	a6,a1,0x20
 952:	01c85713          	srli	a4,a6,0x1c
 956:	9736                	add	a4,a4,a3
 958:	fae60de3          	beq	a2,a4,912 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 95c:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 960:	4790                	lw	a2,8(a5)
 962:	02061593          	slli	a1,a2,0x20
 966:	01c5d713          	srli	a4,a1,0x1c
 96a:	973e                	add	a4,a4,a5
 96c:	fae68ae3          	beq	a3,a4,920 <free+0x22>
        p->s.ptr = bp->s.ptr;
 970:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 972:	00000717          	auipc	a4,0x0
 976:	68f73b23          	sd	a5,1686(a4) # 1008 <freep>
}
 97a:	6422                	ld	s0,8(sp)
 97c:	0141                	addi	sp,sp,16
 97e:	8082                	ret

0000000000000980 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 980:	7139                	addi	sp,sp,-64
 982:	fc06                	sd	ra,56(sp)
 984:	f822                	sd	s0,48(sp)
 986:	f426                	sd	s1,40(sp)
 988:	f04a                	sd	s2,32(sp)
 98a:	ec4e                	sd	s3,24(sp)
 98c:	e852                	sd	s4,16(sp)
 98e:	e456                	sd	s5,8(sp)
 990:	e05a                	sd	s6,0(sp)
 992:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 994:	02051493          	slli	s1,a0,0x20
 998:	9081                	srli	s1,s1,0x20
 99a:	04bd                	addi	s1,s1,15
 99c:	8091                	srli	s1,s1,0x4
 99e:	0014899b          	addiw	s3,s1,1
 9a2:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 9a4:	00000517          	auipc	a0,0x0
 9a8:	66453503          	ld	a0,1636(a0) # 1008 <freep>
 9ac:	c515                	beqz	a0,9d8 <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 9ae:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 9b0:	4798                	lw	a4,8(a5)
 9b2:	02977f63          	bgeu	a4,s1,9f0 <malloc+0x70>
    if (nu < 4096)
 9b6:	8a4e                	mv	s4,s3
 9b8:	0009871b          	sext.w	a4,s3
 9bc:	6685                	lui	a3,0x1
 9be:	00d77363          	bgeu	a4,a3,9c4 <malloc+0x44>
 9c2:	6a05                	lui	s4,0x1
 9c4:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 9c8:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 9cc:	00000917          	auipc	s2,0x0
 9d0:	63c90913          	addi	s2,s2,1596 # 1008 <freep>
    if (p == (char *)-1)
 9d4:	5afd                	li	s5,-1
 9d6:	a895                	j	a4a <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 9d8:	00000797          	auipc	a5,0x0
 9dc:	63878793          	addi	a5,a5,1592 # 1010 <base>
 9e0:	00000717          	auipc	a4,0x0
 9e4:	62f73423          	sd	a5,1576(a4) # 1008 <freep>
 9e8:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 9ea:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 9ee:	b7e1                	j	9b6 <malloc+0x36>
            if (p->s.size == nunits)
 9f0:	02e48c63          	beq	s1,a4,a28 <malloc+0xa8>
                p->s.size -= nunits;
 9f4:	4137073b          	subw	a4,a4,s3
 9f8:	c798                	sw	a4,8(a5)
                p += p->s.size;
 9fa:	02071693          	slli	a3,a4,0x20
 9fe:	01c6d713          	srli	a4,a3,0x1c
 a02:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 a04:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 a08:	00000717          	auipc	a4,0x0
 a0c:	60a73023          	sd	a0,1536(a4) # 1008 <freep>
            return (void *)(p + 1);
 a10:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 a14:	70e2                	ld	ra,56(sp)
 a16:	7442                	ld	s0,48(sp)
 a18:	74a2                	ld	s1,40(sp)
 a1a:	7902                	ld	s2,32(sp)
 a1c:	69e2                	ld	s3,24(sp)
 a1e:	6a42                	ld	s4,16(sp)
 a20:	6aa2                	ld	s5,8(sp)
 a22:	6b02                	ld	s6,0(sp)
 a24:	6121                	addi	sp,sp,64
 a26:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 a28:	6398                	ld	a4,0(a5)
 a2a:	e118                	sd	a4,0(a0)
 a2c:	bff1                	j	a08 <malloc+0x88>
    hp->s.size = nu;
 a2e:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 a32:	0541                	addi	a0,a0,16
 a34:	00000097          	auipc	ra,0x0
 a38:	eca080e7          	jalr	-310(ra) # 8fe <free>
    return freep;
 a3c:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 a40:	d971                	beqz	a0,a14 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 a42:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 a44:	4798                	lw	a4,8(a5)
 a46:	fa9775e3          	bgeu	a4,s1,9f0 <malloc+0x70>
        if (p == freep)
 a4a:	00093703          	ld	a4,0(s2)
 a4e:	853e                	mv	a0,a5
 a50:	fef719e3          	bne	a4,a5,a42 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 a54:	8552                	mv	a0,s4
 a56:	00000097          	auipc	ra,0x0
 a5a:	b7a080e7          	jalr	-1158(ra) # 5d0 <sbrk>
    if (p == (char *)-1)
 a5e:	fd5518e3          	bne	a0,s5,a2e <malloc+0xae>
                return 0;
 a62:	4501                	li	a0,0
 a64:	bf45                	j	a14 <malloc+0x94>
