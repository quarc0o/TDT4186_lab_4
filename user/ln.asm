
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
  if(argc != 3){
   a:	478d                	li	a5,3
   c:	02f50063          	beq	a0,a5,2c <main+0x2c>
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	a3058593          	addi	a1,a1,-1488 # a40 <malloc+0xee>
  18:	4509                	li	a0,2
  1a:	00001097          	auipc	ra,0x1
  1e:	852080e7          	jalr	-1966(ra) # 86c <fprintf>
    exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	4f6080e7          	jalr	1270(ra) # 51a <exit>
  2c:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  2e:	698c                	ld	a1,16(a1)
  30:	6488                	ld	a0,8(s1)
  32:	00000097          	auipc	ra,0x0
  36:	548080e7          	jalr	1352(ra) # 57a <link>
  3a:	00054763          	bltz	a0,48 <main+0x48>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	4da080e7          	jalr	1242(ra) # 51a <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  48:	6894                	ld	a3,16(s1)
  4a:	6490                	ld	a2,8(s1)
  4c:	00001597          	auipc	a1,0x1
  50:	a0c58593          	addi	a1,a1,-1524 # a58 <malloc+0x106>
  54:	4509                	li	a0,2
  56:	00001097          	auipc	ra,0x1
  5a:	816080e7          	jalr	-2026(ra) # 86c <fprintf>
  5e:	b7c5                	j	3e <main+0x3e>

0000000000000060 <initlock>:
// Similar to the kernel spinlock but for threads in userspace
#include "kernel/types.h"
#include "user.h"

void initlock(struct lock *lk, char *name)
{
  60:	1141                	addi	sp,sp,-16
  62:	e422                	sd	s0,8(sp)
  64:	0800                	addi	s0,sp,16
    lk->name = name;
  66:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
  68:	00050023          	sb	zero,0(a0)
    lk->tid = -1;
  6c:	57fd                	li	a5,-1
  6e:	00f50823          	sb	a5,16(a0)
}
  72:	6422                	ld	s0,8(sp)
  74:	0141                	addi	sp,sp,16
  76:	8082                	ret

0000000000000078 <holding>:

uint8 holding(struct lock *lk)
{
    return lk->locked && lk->tid == twhoami();
  78:	00054783          	lbu	a5,0(a0)
  7c:	e399                	bnez	a5,82 <holding+0xa>
  7e:	4501                	li	a0,0
}
  80:	8082                	ret
{
  82:	1101                	addi	sp,sp,-32
  84:	ec06                	sd	ra,24(sp)
  86:	e822                	sd	s0,16(sp)
  88:	e426                	sd	s1,8(sp)
  8a:	1000                	addi	s0,sp,32
    return lk->locked && lk->tid == twhoami();
  8c:	01054483          	lbu	s1,16(a0)
  90:	00000097          	auipc	ra,0x0
  94:	172080e7          	jalr	370(ra) # 202 <twhoami>
  98:	2501                	sext.w	a0,a0
  9a:	40a48533          	sub	a0,s1,a0
  9e:	00153513          	seqz	a0,a0
}
  a2:	60e2                	ld	ra,24(sp)
  a4:	6442                	ld	s0,16(sp)
  a6:	64a2                	ld	s1,8(sp)
  a8:	6105                	addi	sp,sp,32
  aa:	8082                	ret

00000000000000ac <acquire>:

void acquire(struct lock *lk)
{
  ac:	7179                	addi	sp,sp,-48
  ae:	f406                	sd	ra,40(sp)
  b0:	f022                	sd	s0,32(sp)
  b2:	ec26                	sd	s1,24(sp)
  b4:	e84a                	sd	s2,16(sp)
  b6:	e44e                	sd	s3,8(sp)
  b8:	e052                	sd	s4,0(sp)
  ba:	1800                	addi	s0,sp,48
  bc:	8a2a                	mv	s4,a0
    if (holding(lk))
  be:	00000097          	auipc	ra,0x0
  c2:	fba080e7          	jalr	-70(ra) # 78 <holding>
  c6:	e919                	bnez	a0,dc <acquire+0x30>
    {
        printf("re-acquiring lock we already hold");
        exit(-1);
    }

    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  c8:	ffca7493          	andi	s1,s4,-4
  cc:	003a7913          	andi	s2,s4,3
  d0:	0039191b          	slliw	s2,s2,0x3
  d4:	4985                	li	s3,1
  d6:	012999bb          	sllw	s3,s3,s2
  da:	a015                	j	fe <acquire+0x52>
        printf("re-acquiring lock we already hold");
  dc:	00001517          	auipc	a0,0x1
  e0:	99450513          	addi	a0,a0,-1644 # a70 <malloc+0x11e>
  e4:	00000097          	auipc	ra,0x0
  e8:	7b6080e7          	jalr	1974(ra) # 89a <printf>
        exit(-1);
  ec:	557d                	li	a0,-1
  ee:	00000097          	auipc	ra,0x0
  f2:	42c080e7          	jalr	1068(ra) # 51a <exit>
    {
        // give up the cpu for other threads
        tyield();
  f6:	00000097          	auipc	ra,0x0
  fa:	0f4080e7          	jalr	244(ra) # 1ea <tyield>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
  fe:	4534a7af          	amoor.w.aq	a5,s3,(s1)
 102:	0127d7bb          	srlw	a5,a5,s2
 106:	0ff7f793          	zext.b	a5,a5
 10a:	f7f5                	bnez	a5,f6 <acquire+0x4a>
    }

    __sync_synchronize();
 10c:	0ff0000f          	fence

    lk->tid = twhoami();
 110:	00000097          	auipc	ra,0x0
 114:	0f2080e7          	jalr	242(ra) # 202 <twhoami>
 118:	00aa0823          	sb	a0,16(s4)
}
 11c:	70a2                	ld	ra,40(sp)
 11e:	7402                	ld	s0,32(sp)
 120:	64e2                	ld	s1,24(sp)
 122:	6942                	ld	s2,16(sp)
 124:	69a2                	ld	s3,8(sp)
 126:	6a02                	ld	s4,0(sp)
 128:	6145                	addi	sp,sp,48
 12a:	8082                	ret

000000000000012c <release>:

void release(struct lock *lk)
{
 12c:	1101                	addi	sp,sp,-32
 12e:	ec06                	sd	ra,24(sp)
 130:	e822                	sd	s0,16(sp)
 132:	e426                	sd	s1,8(sp)
 134:	1000                	addi	s0,sp,32
 136:	84aa                	mv	s1,a0
    if (!holding(lk))
 138:	00000097          	auipc	ra,0x0
 13c:	f40080e7          	jalr	-192(ra) # 78 <holding>
 140:	c11d                	beqz	a0,166 <release+0x3a>
    {
        printf("releasing lock we are not holding");
        exit(-1);
    }

    lk->tid = -1;
 142:	57fd                	li	a5,-1
 144:	00f48823          	sb	a5,16(s1)
    __sync_synchronize();
 148:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
 14c:	0ff0000f          	fence
 150:	00048023          	sb	zero,0(s1)
    tyield(); // yield that other threads that need the lock can grab it
 154:	00000097          	auipc	ra,0x0
 158:	096080e7          	jalr	150(ra) # 1ea <tyield>
}
 15c:	60e2                	ld	ra,24(sp)
 15e:	6442                	ld	s0,16(sp)
 160:	64a2                	ld	s1,8(sp)
 162:	6105                	addi	sp,sp,32
 164:	8082                	ret
        printf("releasing lock we are not holding");
 166:	00001517          	auipc	a0,0x1
 16a:	93250513          	addi	a0,a0,-1742 # a98 <malloc+0x146>
 16e:	00000097          	auipc	ra,0x0
 172:	72c080e7          	jalr	1836(ra) # 89a <printf>
        exit(-1);
 176:	557d                	li	a0,-1
 178:	00000097          	auipc	ra,0x0
 17c:	3a2080e7          	jalr	930(ra) # 51a <exit>

0000000000000180 <tsched>:

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
 180:	1141                	addi	sp,sp,-16
 182:	e422                	sd	s0,8(sp)
 184:	0800                	addi	s0,sp,16
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
 186:	00001717          	auipc	a4,0x1
 18a:	e7a73703          	ld	a4,-390(a4) # 1000 <current_thread>
 18e:	47c1                	li	a5,16
 190:	c319                	beqz	a4,196 <tsched+0x16>
    for (int i = 0; i < 16; i++) {
 192:	37fd                	addiw	a5,a5,-1
 194:	fff5                	bnez	a5,190 <tsched+0x10>
    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
    }
}
 196:	6422                	ld	s0,8(sp)
 198:	0141                	addi	sp,sp,16
 19a:	8082                	ret

000000000000019c <tcreate>:

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
 19c:	7179                	addi	sp,sp,-48
 19e:	f406                	sd	ra,40(sp)
 1a0:	f022                	sd	s0,32(sp)
 1a2:	ec26                	sd	s1,24(sp)
 1a4:	e84a                	sd	s2,16(sp)
 1a6:	e44e                	sd	s3,8(sp)
 1a8:	1800                	addi	s0,sp,48
 1aa:	84aa                	mv	s1,a0
 1ac:	89b2                	mv	s3,a2
 1ae:	8936                	mv	s2,a3
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));
 1b0:	09000513          	li	a0,144
 1b4:	00000097          	auipc	ra,0x0
 1b8:	79e080e7          	jalr	1950(ra) # 952 <malloc>
 1bc:	e088                	sd	a0,0(s1)


    (*thread)->state = RUNNABLE;
 1be:	478d                	li	a5,3
 1c0:	dd3c                	sw	a5,120(a0)
    (*thread)->func = func;
 1c2:	609c                	ld	a5,0(s1)
 1c4:	0937b423          	sd	s3,136(a5)
    (*thread)->arg = arg;
 1c8:	609c                	ld	a5,0(s1)
 1ca:	0927b023          	sd	s2,128(a5)
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}
 1ce:	70a2                	ld	ra,40(sp)
 1d0:	7402                	ld	s0,32(sp)
 1d2:	64e2                	ld	s1,24(sp)
 1d4:	6942                	ld	s2,16(sp)
 1d6:	69a2                	ld	s3,8(sp)
 1d8:	6145                	addi	sp,sp,48
 1da:	8082                	ret

00000000000001dc <tjoin>:

int tjoin(int tid, void *status, uint size)
{
 1dc:	1141                	addi	sp,sp,-16
 1de:	e422                	sd	s0,8(sp)
 1e0:	0800                	addi	s0,sp,16
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
    return 0;
}
 1e2:	4501                	li	a0,0
 1e4:	6422                	ld	s0,8(sp)
 1e6:	0141                	addi	sp,sp,16
 1e8:	8082                	ret

00000000000001ea <tyield>:

void tyield()
{
 1ea:	1141                	addi	sp,sp,-16
 1ec:	e422                	sd	s0,8(sp)
 1ee:	0800                	addi	s0,sp,16
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
 1f0:	00001797          	auipc	a5,0x1
 1f4:	e107b783          	ld	a5,-496(a5) # 1000 <current_thread>
 1f8:	470d                	li	a4,3
 1fa:	dfb8                	sw	a4,120(a5)
    tsched();
}
 1fc:	6422                	ld	s0,8(sp)
 1fe:	0141                	addi	sp,sp,16
 200:	8082                	ret

0000000000000202 <twhoami>:

uint8 twhoami()
{
 202:	1141                	addi	sp,sp,-16
 204:	e422                	sd	s0,8(sp)
 206:	0800                	addi	s0,sp,16
    // TODO: Returns the thread id of the current thread
    return 0;
}
 208:	4501                	li	a0,0
 20a:	6422                	ld	s0,8(sp)
 20c:	0141                	addi	sp,sp,16
 20e:	8082                	ret

0000000000000210 <tswtch>:
 210:	00153023          	sd	ra,0(a0)
 214:	00253423          	sd	sp,8(a0)
 218:	e900                	sd	s0,16(a0)
 21a:	ed04                	sd	s1,24(a0)
 21c:	03253023          	sd	s2,32(a0)
 220:	03353423          	sd	s3,40(a0)
 224:	03453823          	sd	s4,48(a0)
 228:	03553c23          	sd	s5,56(a0)
 22c:	05653023          	sd	s6,64(a0)
 230:	05753423          	sd	s7,72(a0)
 234:	05853823          	sd	s8,80(a0)
 238:	05953c23          	sd	s9,88(a0)
 23c:	07a53023          	sd	s10,96(a0)
 240:	07b53423          	sd	s11,104(a0)
 244:	0005b083          	ld	ra,0(a1)
 248:	0085b103          	ld	sp,8(a1)
 24c:	6980                	ld	s0,16(a1)
 24e:	6d84                	ld	s1,24(a1)
 250:	0205b903          	ld	s2,32(a1)
 254:	0285b983          	ld	s3,40(a1)
 258:	0305ba03          	ld	s4,48(a1)
 25c:	0385ba83          	ld	s5,56(a1)
 260:	0405bb03          	ld	s6,64(a1)
 264:	0485bb83          	ld	s7,72(a1)
 268:	0505bc03          	ld	s8,80(a1)
 26c:	0585bc83          	ld	s9,88(a1)
 270:	0605bd03          	ld	s10,96(a1)
 274:	0685bd83          	ld	s11,104(a1)
 278:	8082                	ret

000000000000027a <_main>:

//
// wrapper so that it's OK if main() does not call exit() and setup main thread.
//
void _main(int argc, char *argv[])
{
 27a:	1101                	addi	sp,sp,-32
 27c:	ec06                	sd	ra,24(sp)
 27e:	e822                	sd	s0,16(sp)
 280:	e426                	sd	s1,8(sp)
 282:	e04a                	sd	s2,0(sp)
 284:	1000                	addi	s0,sp,32
 286:	84aa                	mv	s1,a0
 288:	892e                	mv	s2,a1
    // TODO: Ensure that main also is taken into consideration by the thread scheduler
    // TODO: This function should only return once all threads have finished running

    // Initialize main thread
    struct thread *main_thread = (struct thread *)malloc(sizeof(struct thread));
 28a:	09000513          	li	a0,144
 28e:	00000097          	auipc	ra,0x0
 292:	6c4080e7          	jalr	1732(ra) # 952 <malloc>

    main_thread->tid = 0;
 296:	00050023          	sb	zero,0(a0)

    extern int main(int argc, char *argv[]);
    int res = main(argc, argv);
 29a:	85ca                	mv	a1,s2
 29c:	8526                	mv	a0,s1
 29e:	00000097          	auipc	ra,0x0
 2a2:	d62080e7          	jalr	-670(ra) # 0 <main>
    exit(res);
 2a6:	00000097          	auipc	ra,0x0
 2aa:	274080e7          	jalr	628(ra) # 51a <exit>

00000000000002ae <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 2ae:	1141                	addi	sp,sp,-16
 2b0:	e422                	sd	s0,8(sp)
 2b2:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 2b4:	87aa                	mv	a5,a0
 2b6:	0585                	addi	a1,a1,1
 2b8:	0785                	addi	a5,a5,1
 2ba:	fff5c703          	lbu	a4,-1(a1)
 2be:	fee78fa3          	sb	a4,-1(a5)
 2c2:	fb75                	bnez	a4,2b6 <strcpy+0x8>
        ;
    return os;
}
 2c4:	6422                	ld	s0,8(sp)
 2c6:	0141                	addi	sp,sp,16
 2c8:	8082                	ret

00000000000002ca <strcmp>:

int strcmp(const char *p, const char *q)
{
 2ca:	1141                	addi	sp,sp,-16
 2cc:	e422                	sd	s0,8(sp)
 2ce:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 2d0:	00054783          	lbu	a5,0(a0)
 2d4:	cb91                	beqz	a5,2e8 <strcmp+0x1e>
 2d6:	0005c703          	lbu	a4,0(a1)
 2da:	00f71763          	bne	a4,a5,2e8 <strcmp+0x1e>
        p++, q++;
 2de:	0505                	addi	a0,a0,1
 2e0:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 2e2:	00054783          	lbu	a5,0(a0)
 2e6:	fbe5                	bnez	a5,2d6 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 2e8:	0005c503          	lbu	a0,0(a1)
}
 2ec:	40a7853b          	subw	a0,a5,a0
 2f0:	6422                	ld	s0,8(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret

00000000000002f6 <strlen>:

uint strlen(const char *s)
{
 2f6:	1141                	addi	sp,sp,-16
 2f8:	e422                	sd	s0,8(sp)
 2fa:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 2fc:	00054783          	lbu	a5,0(a0)
 300:	cf91                	beqz	a5,31c <strlen+0x26>
 302:	0505                	addi	a0,a0,1
 304:	87aa                	mv	a5,a0
 306:	86be                	mv	a3,a5
 308:	0785                	addi	a5,a5,1
 30a:	fff7c703          	lbu	a4,-1(a5)
 30e:	ff65                	bnez	a4,306 <strlen+0x10>
 310:	40a6853b          	subw	a0,a3,a0
 314:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 316:	6422                	ld	s0,8(sp)
 318:	0141                	addi	sp,sp,16
 31a:	8082                	ret
    for (n = 0; s[n]; n++)
 31c:	4501                	li	a0,0
 31e:	bfe5                	j	316 <strlen+0x20>

0000000000000320 <memset>:

void *
memset(void *dst, int c, uint n)
{
 320:	1141                	addi	sp,sp,-16
 322:	e422                	sd	s0,8(sp)
 324:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++)
 326:	ca19                	beqz	a2,33c <memset+0x1c>
 328:	87aa                	mv	a5,a0
 32a:	1602                	slli	a2,a2,0x20
 32c:	9201                	srli	a2,a2,0x20
 32e:	00a60733          	add	a4,a2,a0
    {
        cdst[i] = c;
 332:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++)
 336:	0785                	addi	a5,a5,1
 338:	fee79de3          	bne	a5,a4,332 <memset+0x12>
    }
    return dst;
}
 33c:	6422                	ld	s0,8(sp)
 33e:	0141                	addi	sp,sp,16
 340:	8082                	ret

0000000000000342 <strchr>:

char *
strchr(const char *s, char c)
{
 342:	1141                	addi	sp,sp,-16
 344:	e422                	sd	s0,8(sp)
 346:	0800                	addi	s0,sp,16
    for (; *s; s++)
 348:	00054783          	lbu	a5,0(a0)
 34c:	cb99                	beqz	a5,362 <strchr+0x20>
        if (*s == c)
 34e:	00f58763          	beq	a1,a5,35c <strchr+0x1a>
    for (; *s; s++)
 352:	0505                	addi	a0,a0,1
 354:	00054783          	lbu	a5,0(a0)
 358:	fbfd                	bnez	a5,34e <strchr+0xc>
            return (char *)s;
    return 0;
 35a:	4501                	li	a0,0
}
 35c:	6422                	ld	s0,8(sp)
 35e:	0141                	addi	sp,sp,16
 360:	8082                	ret
    return 0;
 362:	4501                	li	a0,0
 364:	bfe5                	j	35c <strchr+0x1a>

0000000000000366 <gets>:

char *
gets(char *buf, int max)
{
 366:	711d                	addi	sp,sp,-96
 368:	ec86                	sd	ra,88(sp)
 36a:	e8a2                	sd	s0,80(sp)
 36c:	e4a6                	sd	s1,72(sp)
 36e:	e0ca                	sd	s2,64(sp)
 370:	fc4e                	sd	s3,56(sp)
 372:	f852                	sd	s4,48(sp)
 374:	f456                	sd	s5,40(sp)
 376:	f05a                	sd	s6,32(sp)
 378:	ec5e                	sd	s7,24(sp)
 37a:	1080                	addi	s0,sp,96
 37c:	8baa                	mv	s7,a0
 37e:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;)
 380:	892a                	mv	s2,a0
 382:	4481                	li	s1,0
    {
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 384:	4aa9                	li	s5,10
 386:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;)
 388:	89a6                	mv	s3,s1
 38a:	2485                	addiw	s1,s1,1
 38c:	0344d863          	bge	s1,s4,3bc <gets+0x56>
        cc = read(0, &c, 1);
 390:	4605                	li	a2,1
 392:	faf40593          	addi	a1,s0,-81
 396:	4501                	li	a0,0
 398:	00000097          	auipc	ra,0x0
 39c:	19a080e7          	jalr	410(ra) # 532 <read>
        if (cc < 1)
 3a0:	00a05e63          	blez	a0,3bc <gets+0x56>
        buf[i++] = c;
 3a4:	faf44783          	lbu	a5,-81(s0)
 3a8:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 3ac:	01578763          	beq	a5,s5,3ba <gets+0x54>
 3b0:	0905                	addi	s2,s2,1
 3b2:	fd679be3          	bne	a5,s6,388 <gets+0x22>
    for (i = 0; i + 1 < max;)
 3b6:	89a6                	mv	s3,s1
 3b8:	a011                	j	3bc <gets+0x56>
 3ba:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 3bc:	99de                	add	s3,s3,s7
 3be:	00098023          	sb	zero,0(s3)
    return buf;
}
 3c2:	855e                	mv	a0,s7
 3c4:	60e6                	ld	ra,88(sp)
 3c6:	6446                	ld	s0,80(sp)
 3c8:	64a6                	ld	s1,72(sp)
 3ca:	6906                	ld	s2,64(sp)
 3cc:	79e2                	ld	s3,56(sp)
 3ce:	7a42                	ld	s4,48(sp)
 3d0:	7aa2                	ld	s5,40(sp)
 3d2:	7b02                	ld	s6,32(sp)
 3d4:	6be2                	ld	s7,24(sp)
 3d6:	6125                	addi	sp,sp,96
 3d8:	8082                	ret

00000000000003da <stat>:

int stat(const char *n, struct stat *st)
{
 3da:	1101                	addi	sp,sp,-32
 3dc:	ec06                	sd	ra,24(sp)
 3de:	e822                	sd	s0,16(sp)
 3e0:	e426                	sd	s1,8(sp)
 3e2:	e04a                	sd	s2,0(sp)
 3e4:	1000                	addi	s0,sp,32
 3e6:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 3e8:	4581                	li	a1,0
 3ea:	00000097          	auipc	ra,0x0
 3ee:	170080e7          	jalr	368(ra) # 55a <open>
    if (fd < 0)
 3f2:	02054563          	bltz	a0,41c <stat+0x42>
 3f6:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 3f8:	85ca                	mv	a1,s2
 3fa:	00000097          	auipc	ra,0x0
 3fe:	178080e7          	jalr	376(ra) # 572 <fstat>
 402:	892a                	mv	s2,a0
    close(fd);
 404:	8526                	mv	a0,s1
 406:	00000097          	auipc	ra,0x0
 40a:	13c080e7          	jalr	316(ra) # 542 <close>
    return r;
}
 40e:	854a                	mv	a0,s2
 410:	60e2                	ld	ra,24(sp)
 412:	6442                	ld	s0,16(sp)
 414:	64a2                	ld	s1,8(sp)
 416:	6902                	ld	s2,0(sp)
 418:	6105                	addi	sp,sp,32
 41a:	8082                	ret
        return -1;
 41c:	597d                	li	s2,-1
 41e:	bfc5                	j	40e <stat+0x34>

0000000000000420 <atoi>:

int atoi(const char *s)
{
 420:	1141                	addi	sp,sp,-16
 422:	e422                	sd	s0,8(sp)
 424:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 426:	00054683          	lbu	a3,0(a0)
 42a:	fd06879b          	addiw	a5,a3,-48
 42e:	0ff7f793          	zext.b	a5,a5
 432:	4625                	li	a2,9
 434:	02f66863          	bltu	a2,a5,464 <atoi+0x44>
 438:	872a                	mv	a4,a0
    n = 0;
 43a:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 43c:	0705                	addi	a4,a4,1
 43e:	0025179b          	slliw	a5,a0,0x2
 442:	9fa9                	addw	a5,a5,a0
 444:	0017979b          	slliw	a5,a5,0x1
 448:	9fb5                	addw	a5,a5,a3
 44a:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 44e:	00074683          	lbu	a3,0(a4)
 452:	fd06879b          	addiw	a5,a3,-48
 456:	0ff7f793          	zext.b	a5,a5
 45a:	fef671e3          	bgeu	a2,a5,43c <atoi+0x1c>
    return n;
}
 45e:	6422                	ld	s0,8(sp)
 460:	0141                	addi	sp,sp,16
 462:	8082                	ret
    n = 0;
 464:	4501                	li	a0,0
 466:	bfe5                	j	45e <atoi+0x3e>

0000000000000468 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 468:	1141                	addi	sp,sp,-16
 46a:	e422                	sd	s0,8(sp)
 46c:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst)
 46e:	02b57463          	bgeu	a0,a1,496 <memmove+0x2e>
    {
        while (n-- > 0)
 472:	00c05f63          	blez	a2,490 <memmove+0x28>
 476:	1602                	slli	a2,a2,0x20
 478:	9201                	srli	a2,a2,0x20
 47a:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 47e:	872a                	mv	a4,a0
            *dst++ = *src++;
 480:	0585                	addi	a1,a1,1
 482:	0705                	addi	a4,a4,1
 484:	fff5c683          	lbu	a3,-1(a1)
 488:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 48c:	fee79ae3          	bne	a5,a4,480 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 490:	6422                	ld	s0,8(sp)
 492:	0141                	addi	sp,sp,16
 494:	8082                	ret
        dst += n;
 496:	00c50733          	add	a4,a0,a2
        src += n;
 49a:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 49c:	fec05ae3          	blez	a2,490 <memmove+0x28>
 4a0:	fff6079b          	addiw	a5,a2,-1
 4a4:	1782                	slli	a5,a5,0x20
 4a6:	9381                	srli	a5,a5,0x20
 4a8:	fff7c793          	not	a5,a5
 4ac:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 4ae:	15fd                	addi	a1,a1,-1
 4b0:	177d                	addi	a4,a4,-1
 4b2:	0005c683          	lbu	a3,0(a1)
 4b6:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 4ba:	fee79ae3          	bne	a5,a4,4ae <memmove+0x46>
 4be:	bfc9                	j	490 <memmove+0x28>

00000000000004c0 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 4c0:	1141                	addi	sp,sp,-16
 4c2:	e422                	sd	s0,8(sp)
 4c4:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0)
 4c6:	ca05                	beqz	a2,4f6 <memcmp+0x36>
 4c8:	fff6069b          	addiw	a3,a2,-1
 4cc:	1682                	slli	a3,a3,0x20
 4ce:	9281                	srli	a3,a3,0x20
 4d0:	0685                	addi	a3,a3,1
 4d2:	96aa                	add	a3,a3,a0
    {
        if (*p1 != *p2)
 4d4:	00054783          	lbu	a5,0(a0)
 4d8:	0005c703          	lbu	a4,0(a1)
 4dc:	00e79863          	bne	a5,a4,4ec <memcmp+0x2c>
        {
            return *p1 - *p2;
        }
        p1++;
 4e0:	0505                	addi	a0,a0,1
        p2++;
 4e2:	0585                	addi	a1,a1,1
    while (n-- > 0)
 4e4:	fed518e3          	bne	a0,a3,4d4 <memcmp+0x14>
    }
    return 0;
 4e8:	4501                	li	a0,0
 4ea:	a019                	j	4f0 <memcmp+0x30>
            return *p1 - *p2;
 4ec:	40e7853b          	subw	a0,a5,a4
}
 4f0:	6422                	ld	s0,8(sp)
 4f2:	0141                	addi	sp,sp,16
 4f4:	8082                	ret
    return 0;
 4f6:	4501                	li	a0,0
 4f8:	bfe5                	j	4f0 <memcmp+0x30>

00000000000004fa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4fa:	1141                	addi	sp,sp,-16
 4fc:	e406                	sd	ra,8(sp)
 4fe:	e022                	sd	s0,0(sp)
 500:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 502:	00000097          	auipc	ra,0x0
 506:	f66080e7          	jalr	-154(ra) # 468 <memmove>
}
 50a:	60a2                	ld	ra,8(sp)
 50c:	6402                	ld	s0,0(sp)
 50e:	0141                	addi	sp,sp,16
 510:	8082                	ret

0000000000000512 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 512:	4885                	li	a7,1
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <exit>:
.global exit
exit:
 li a7, SYS_exit
 51a:	4889                	li	a7,2
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <wait>:
.global wait
wait:
 li a7, SYS_wait
 522:	488d                	li	a7,3
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 52a:	4891                	li	a7,4
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <read>:
.global read
read:
 li a7, SYS_read
 532:	4895                	li	a7,5
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <write>:
.global write
write:
 li a7, SYS_write
 53a:	48c1                	li	a7,16
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <close>:
.global close
close:
 li a7, SYS_close
 542:	48d5                	li	a7,21
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <kill>:
.global kill
kill:
 li a7, SYS_kill
 54a:	4899                	li	a7,6
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <exec>:
.global exec
exec:
 li a7, SYS_exec
 552:	489d                	li	a7,7
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <open>:
.global open
open:
 li a7, SYS_open
 55a:	48bd                	li	a7,15
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 562:	48c5                	li	a7,17
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 56a:	48c9                	li	a7,18
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 572:	48a1                	li	a7,8
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <link>:
.global link
link:
 li a7, SYS_link
 57a:	48cd                	li	a7,19
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 582:	48d1                	li	a7,20
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 58a:	48a5                	li	a7,9
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <dup>:
.global dup
dup:
 li a7, SYS_dup
 592:	48a9                	li	a7,10
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 59a:	48ad                	li	a7,11
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5a2:	48b1                	li	a7,12
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5aa:	48b5                	li	a7,13
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5b2:	48b9                	li	a7,14
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <ps>:
.global ps
ps:
 li a7, SYS_ps
 5ba:	48d9                	li	a7,22
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <schedls>:
.global schedls
schedls:
 li a7, SYS_schedls
 5c2:	48dd                	li	a7,23
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <schedset>:
.global schedset
schedset:
 li a7, SYS_schedset
 5ca:	48e1                	li	a7,24
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5d2:	1101                	addi	sp,sp,-32
 5d4:	ec06                	sd	ra,24(sp)
 5d6:	e822                	sd	s0,16(sp)
 5d8:	1000                	addi	s0,sp,32
 5da:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5de:	4605                	li	a2,1
 5e0:	fef40593          	addi	a1,s0,-17
 5e4:	00000097          	auipc	ra,0x0
 5e8:	f56080e7          	jalr	-170(ra) # 53a <write>
}
 5ec:	60e2                	ld	ra,24(sp)
 5ee:	6442                	ld	s0,16(sp)
 5f0:	6105                	addi	sp,sp,32
 5f2:	8082                	ret

00000000000005f4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5f4:	7139                	addi	sp,sp,-64
 5f6:	fc06                	sd	ra,56(sp)
 5f8:	f822                	sd	s0,48(sp)
 5fa:	f426                	sd	s1,40(sp)
 5fc:	f04a                	sd	s2,32(sp)
 5fe:	ec4e                	sd	s3,24(sp)
 600:	0080                	addi	s0,sp,64
 602:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 604:	c299                	beqz	a3,60a <printint+0x16>
 606:	0805c963          	bltz	a1,698 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 60a:	2581                	sext.w	a1,a1
  neg = 0;
 60c:	4881                	li	a7,0
 60e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 612:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 614:	2601                	sext.w	a2,a2
 616:	00000517          	auipc	a0,0x0
 61a:	50a50513          	addi	a0,a0,1290 # b20 <digits>
 61e:	883a                	mv	a6,a4
 620:	2705                	addiw	a4,a4,1
 622:	02c5f7bb          	remuw	a5,a1,a2
 626:	1782                	slli	a5,a5,0x20
 628:	9381                	srli	a5,a5,0x20
 62a:	97aa                	add	a5,a5,a0
 62c:	0007c783          	lbu	a5,0(a5)
 630:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 634:	0005879b          	sext.w	a5,a1
 638:	02c5d5bb          	divuw	a1,a1,a2
 63c:	0685                	addi	a3,a3,1
 63e:	fec7f0e3          	bgeu	a5,a2,61e <printint+0x2a>
  if(neg)
 642:	00088c63          	beqz	a7,65a <printint+0x66>
    buf[i++] = '-';
 646:	fd070793          	addi	a5,a4,-48
 64a:	00878733          	add	a4,a5,s0
 64e:	02d00793          	li	a5,45
 652:	fef70823          	sb	a5,-16(a4)
 656:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 65a:	02e05863          	blez	a4,68a <printint+0x96>
 65e:	fc040793          	addi	a5,s0,-64
 662:	00e78933          	add	s2,a5,a4
 666:	fff78993          	addi	s3,a5,-1
 66a:	99ba                	add	s3,s3,a4
 66c:	377d                	addiw	a4,a4,-1
 66e:	1702                	slli	a4,a4,0x20
 670:	9301                	srli	a4,a4,0x20
 672:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 676:	fff94583          	lbu	a1,-1(s2)
 67a:	8526                	mv	a0,s1
 67c:	00000097          	auipc	ra,0x0
 680:	f56080e7          	jalr	-170(ra) # 5d2 <putc>
  while(--i >= 0)
 684:	197d                	addi	s2,s2,-1
 686:	ff3918e3          	bne	s2,s3,676 <printint+0x82>
}
 68a:	70e2                	ld	ra,56(sp)
 68c:	7442                	ld	s0,48(sp)
 68e:	74a2                	ld	s1,40(sp)
 690:	7902                	ld	s2,32(sp)
 692:	69e2                	ld	s3,24(sp)
 694:	6121                	addi	sp,sp,64
 696:	8082                	ret
    x = -xx;
 698:	40b005bb          	negw	a1,a1
    neg = 1;
 69c:	4885                	li	a7,1
    x = -xx;
 69e:	bf85                	j	60e <printint+0x1a>

00000000000006a0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6a0:	715d                	addi	sp,sp,-80
 6a2:	e486                	sd	ra,72(sp)
 6a4:	e0a2                	sd	s0,64(sp)
 6a6:	fc26                	sd	s1,56(sp)
 6a8:	f84a                	sd	s2,48(sp)
 6aa:	f44e                	sd	s3,40(sp)
 6ac:	f052                	sd	s4,32(sp)
 6ae:	ec56                	sd	s5,24(sp)
 6b0:	e85a                	sd	s6,16(sp)
 6b2:	e45e                	sd	s7,8(sp)
 6b4:	e062                	sd	s8,0(sp)
 6b6:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6b8:	0005c903          	lbu	s2,0(a1)
 6bc:	18090c63          	beqz	s2,854 <vprintf+0x1b4>
 6c0:	8aaa                	mv	s5,a0
 6c2:	8bb2                	mv	s7,a2
 6c4:	00158493          	addi	s1,a1,1
  state = 0;
 6c8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6ca:	02500a13          	li	s4,37
 6ce:	4b55                	li	s6,21
 6d0:	a839                	j	6ee <vprintf+0x4e>
        putc(fd, c);
 6d2:	85ca                	mv	a1,s2
 6d4:	8556                	mv	a0,s5
 6d6:	00000097          	auipc	ra,0x0
 6da:	efc080e7          	jalr	-260(ra) # 5d2 <putc>
 6de:	a019                	j	6e4 <vprintf+0x44>
    } else if(state == '%'){
 6e0:	01498d63          	beq	s3,s4,6fa <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 6e4:	0485                	addi	s1,s1,1
 6e6:	fff4c903          	lbu	s2,-1(s1)
 6ea:	16090563          	beqz	s2,854 <vprintf+0x1b4>
    if(state == 0){
 6ee:	fe0999e3          	bnez	s3,6e0 <vprintf+0x40>
      if(c == '%'){
 6f2:	ff4910e3          	bne	s2,s4,6d2 <vprintf+0x32>
        state = '%';
 6f6:	89d2                	mv	s3,s4
 6f8:	b7f5                	j	6e4 <vprintf+0x44>
      if(c == 'd'){
 6fa:	13490263          	beq	s2,s4,81e <vprintf+0x17e>
 6fe:	f9d9079b          	addiw	a5,s2,-99
 702:	0ff7f793          	zext.b	a5,a5
 706:	12fb6563          	bltu	s6,a5,830 <vprintf+0x190>
 70a:	f9d9079b          	addiw	a5,s2,-99
 70e:	0ff7f713          	zext.b	a4,a5
 712:	10eb6f63          	bltu	s6,a4,830 <vprintf+0x190>
 716:	00271793          	slli	a5,a4,0x2
 71a:	00000717          	auipc	a4,0x0
 71e:	3ae70713          	addi	a4,a4,942 # ac8 <malloc+0x176>
 722:	97ba                	add	a5,a5,a4
 724:	439c                	lw	a5,0(a5)
 726:	97ba                	add	a5,a5,a4
 728:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 72a:	008b8913          	addi	s2,s7,8
 72e:	4685                	li	a3,1
 730:	4629                	li	a2,10
 732:	000ba583          	lw	a1,0(s7)
 736:	8556                	mv	a0,s5
 738:	00000097          	auipc	ra,0x0
 73c:	ebc080e7          	jalr	-324(ra) # 5f4 <printint>
 740:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 742:	4981                	li	s3,0
 744:	b745                	j	6e4 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 746:	008b8913          	addi	s2,s7,8
 74a:	4681                	li	a3,0
 74c:	4629                	li	a2,10
 74e:	000ba583          	lw	a1,0(s7)
 752:	8556                	mv	a0,s5
 754:	00000097          	auipc	ra,0x0
 758:	ea0080e7          	jalr	-352(ra) # 5f4 <printint>
 75c:	8bca                	mv	s7,s2
      state = 0;
 75e:	4981                	li	s3,0
 760:	b751                	j	6e4 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 762:	008b8913          	addi	s2,s7,8
 766:	4681                	li	a3,0
 768:	4641                	li	a2,16
 76a:	000ba583          	lw	a1,0(s7)
 76e:	8556                	mv	a0,s5
 770:	00000097          	auipc	ra,0x0
 774:	e84080e7          	jalr	-380(ra) # 5f4 <printint>
 778:	8bca                	mv	s7,s2
      state = 0;
 77a:	4981                	li	s3,0
 77c:	b7a5                	j	6e4 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 77e:	008b8c13          	addi	s8,s7,8
 782:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 786:	03000593          	li	a1,48
 78a:	8556                	mv	a0,s5
 78c:	00000097          	auipc	ra,0x0
 790:	e46080e7          	jalr	-442(ra) # 5d2 <putc>
  putc(fd, 'x');
 794:	07800593          	li	a1,120
 798:	8556                	mv	a0,s5
 79a:	00000097          	auipc	ra,0x0
 79e:	e38080e7          	jalr	-456(ra) # 5d2 <putc>
 7a2:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7a4:	00000b97          	auipc	s7,0x0
 7a8:	37cb8b93          	addi	s7,s7,892 # b20 <digits>
 7ac:	03c9d793          	srli	a5,s3,0x3c
 7b0:	97de                	add	a5,a5,s7
 7b2:	0007c583          	lbu	a1,0(a5)
 7b6:	8556                	mv	a0,s5
 7b8:	00000097          	auipc	ra,0x0
 7bc:	e1a080e7          	jalr	-486(ra) # 5d2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7c0:	0992                	slli	s3,s3,0x4
 7c2:	397d                	addiw	s2,s2,-1
 7c4:	fe0914e3          	bnez	s2,7ac <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 7c8:	8be2                	mv	s7,s8
      state = 0;
 7ca:	4981                	li	s3,0
 7cc:	bf21                	j	6e4 <vprintf+0x44>
        s = va_arg(ap, char*);
 7ce:	008b8993          	addi	s3,s7,8
 7d2:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 7d6:	02090163          	beqz	s2,7f8 <vprintf+0x158>
        while(*s != 0){
 7da:	00094583          	lbu	a1,0(s2)
 7de:	c9a5                	beqz	a1,84e <vprintf+0x1ae>
          putc(fd, *s);
 7e0:	8556                	mv	a0,s5
 7e2:	00000097          	auipc	ra,0x0
 7e6:	df0080e7          	jalr	-528(ra) # 5d2 <putc>
          s++;
 7ea:	0905                	addi	s2,s2,1
        while(*s != 0){
 7ec:	00094583          	lbu	a1,0(s2)
 7f0:	f9e5                	bnez	a1,7e0 <vprintf+0x140>
        s = va_arg(ap, char*);
 7f2:	8bce                	mv	s7,s3
      state = 0;
 7f4:	4981                	li	s3,0
 7f6:	b5fd                	j	6e4 <vprintf+0x44>
          s = "(null)";
 7f8:	00000917          	auipc	s2,0x0
 7fc:	2c890913          	addi	s2,s2,712 # ac0 <malloc+0x16e>
        while(*s != 0){
 800:	02800593          	li	a1,40
 804:	bff1                	j	7e0 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 806:	008b8913          	addi	s2,s7,8
 80a:	000bc583          	lbu	a1,0(s7)
 80e:	8556                	mv	a0,s5
 810:	00000097          	auipc	ra,0x0
 814:	dc2080e7          	jalr	-574(ra) # 5d2 <putc>
 818:	8bca                	mv	s7,s2
      state = 0;
 81a:	4981                	li	s3,0
 81c:	b5e1                	j	6e4 <vprintf+0x44>
        putc(fd, c);
 81e:	02500593          	li	a1,37
 822:	8556                	mv	a0,s5
 824:	00000097          	auipc	ra,0x0
 828:	dae080e7          	jalr	-594(ra) # 5d2 <putc>
      state = 0;
 82c:	4981                	li	s3,0
 82e:	bd5d                	j	6e4 <vprintf+0x44>
        putc(fd, '%');
 830:	02500593          	li	a1,37
 834:	8556                	mv	a0,s5
 836:	00000097          	auipc	ra,0x0
 83a:	d9c080e7          	jalr	-612(ra) # 5d2 <putc>
        putc(fd, c);
 83e:	85ca                	mv	a1,s2
 840:	8556                	mv	a0,s5
 842:	00000097          	auipc	ra,0x0
 846:	d90080e7          	jalr	-624(ra) # 5d2 <putc>
      state = 0;
 84a:	4981                	li	s3,0
 84c:	bd61                	j	6e4 <vprintf+0x44>
        s = va_arg(ap, char*);
 84e:	8bce                	mv	s7,s3
      state = 0;
 850:	4981                	li	s3,0
 852:	bd49                	j	6e4 <vprintf+0x44>
    }
  }
}
 854:	60a6                	ld	ra,72(sp)
 856:	6406                	ld	s0,64(sp)
 858:	74e2                	ld	s1,56(sp)
 85a:	7942                	ld	s2,48(sp)
 85c:	79a2                	ld	s3,40(sp)
 85e:	7a02                	ld	s4,32(sp)
 860:	6ae2                	ld	s5,24(sp)
 862:	6b42                	ld	s6,16(sp)
 864:	6ba2                	ld	s7,8(sp)
 866:	6c02                	ld	s8,0(sp)
 868:	6161                	addi	sp,sp,80
 86a:	8082                	ret

000000000000086c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 86c:	715d                	addi	sp,sp,-80
 86e:	ec06                	sd	ra,24(sp)
 870:	e822                	sd	s0,16(sp)
 872:	1000                	addi	s0,sp,32
 874:	e010                	sd	a2,0(s0)
 876:	e414                	sd	a3,8(s0)
 878:	e818                	sd	a4,16(s0)
 87a:	ec1c                	sd	a5,24(s0)
 87c:	03043023          	sd	a6,32(s0)
 880:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 884:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 888:	8622                	mv	a2,s0
 88a:	00000097          	auipc	ra,0x0
 88e:	e16080e7          	jalr	-490(ra) # 6a0 <vprintf>
}
 892:	60e2                	ld	ra,24(sp)
 894:	6442                	ld	s0,16(sp)
 896:	6161                	addi	sp,sp,80
 898:	8082                	ret

000000000000089a <printf>:

void
printf(const char *fmt, ...)
{
 89a:	711d                	addi	sp,sp,-96
 89c:	ec06                	sd	ra,24(sp)
 89e:	e822                	sd	s0,16(sp)
 8a0:	1000                	addi	s0,sp,32
 8a2:	e40c                	sd	a1,8(s0)
 8a4:	e810                	sd	a2,16(s0)
 8a6:	ec14                	sd	a3,24(s0)
 8a8:	f018                	sd	a4,32(s0)
 8aa:	f41c                	sd	a5,40(s0)
 8ac:	03043823          	sd	a6,48(s0)
 8b0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8b4:	00840613          	addi	a2,s0,8
 8b8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8bc:	85aa                	mv	a1,a0
 8be:	4505                	li	a0,1
 8c0:	00000097          	auipc	ra,0x0
 8c4:	de0080e7          	jalr	-544(ra) # 6a0 <vprintf>
}
 8c8:	60e2                	ld	ra,24(sp)
 8ca:	6442                	ld	s0,16(sp)
 8cc:	6125                	addi	sp,sp,96
 8ce:	8082                	ret

00000000000008d0 <free>:

static Header base;
static Header *freep;

void free(void *ap)
{
 8d0:	1141                	addi	sp,sp,-16
 8d2:	e422                	sd	s0,8(sp)
 8d4:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 8d6:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8da:	00000797          	auipc	a5,0x0
 8de:	72e7b783          	ld	a5,1838(a5) # 1008 <freep>
 8e2:	a02d                	j	90c <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr)
    {
        bp->s.size += p->s.ptr->s.size;
 8e4:	4618                	lw	a4,8(a2)
 8e6:	9f2d                	addw	a4,a4,a1
 8e8:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 8ec:	6398                	ld	a4,0(a5)
 8ee:	6310                	ld	a2,0(a4)
 8f0:	a83d                	j	92e <free+0x5e>
    }
    else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp)
    {
        p->s.size += bp->s.size;
 8f2:	ff852703          	lw	a4,-8(a0)
 8f6:	9f31                	addw	a4,a4,a2
 8f8:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 8fa:	ff053683          	ld	a3,-16(a0)
 8fe:	a091                	j	942 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 900:	6398                	ld	a4,0(a5)
 902:	00e7e463          	bltu	a5,a4,90a <free+0x3a>
 906:	00e6ea63          	bltu	a3,a4,91a <free+0x4a>
{
 90a:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 90c:	fed7fae3          	bgeu	a5,a3,900 <free+0x30>
 910:	6398                	ld	a4,0(a5)
 912:	00e6e463          	bltu	a3,a4,91a <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 916:	fee7eae3          	bltu	a5,a4,90a <free+0x3a>
    if (bp + bp->s.size == p->s.ptr)
 91a:	ff852583          	lw	a1,-8(a0)
 91e:	6390                	ld	a2,0(a5)
 920:	02059813          	slli	a6,a1,0x20
 924:	01c85713          	srli	a4,a6,0x1c
 928:	9736                	add	a4,a4,a3
 92a:	fae60de3          	beq	a2,a4,8e4 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 92e:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp)
 932:	4790                	lw	a2,8(a5)
 934:	02061593          	slli	a1,a2,0x20
 938:	01c5d713          	srli	a4,a1,0x1c
 93c:	973e                	add	a4,a4,a5
 93e:	fae68ae3          	beq	a3,a4,8f2 <free+0x22>
        p->s.ptr = bp->s.ptr;
 942:	e394                	sd	a3,0(a5)
    }
    else
        p->s.ptr = bp;
    freep = p;
 944:	00000717          	auipc	a4,0x0
 948:	6cf73223          	sd	a5,1732(a4) # 1008 <freep>
}
 94c:	6422                	ld	s0,8(sp)
 94e:	0141                	addi	sp,sp,16
 950:	8082                	ret

0000000000000952 <malloc>:
    return freep;
}

void *
malloc(uint nbytes)
{
 952:	7139                	addi	sp,sp,-64
 954:	fc06                	sd	ra,56(sp)
 956:	f822                	sd	s0,48(sp)
 958:	f426                	sd	s1,40(sp)
 95a:	f04a                	sd	s2,32(sp)
 95c:	ec4e                	sd	s3,24(sp)
 95e:	e852                	sd	s4,16(sp)
 960:	e456                	sd	s5,8(sp)
 962:	e05a                	sd	s6,0(sp)
 964:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 966:	02051493          	slli	s1,a0,0x20
 96a:	9081                	srli	s1,s1,0x20
 96c:	04bd                	addi	s1,s1,15
 96e:	8091                	srli	s1,s1,0x4
 970:	0014899b          	addiw	s3,s1,1
 974:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0)
 976:	00000517          	auipc	a0,0x0
 97a:	69253503          	ld	a0,1682(a0) # 1008 <freep>
 97e:	c515                	beqz	a0,9aa <malloc+0x58>
    {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 980:	611c                	ld	a5,0(a0)
    {
        if (p->s.size >= nunits)
 982:	4798                	lw	a4,8(a5)
 984:	02977f63          	bgeu	a4,s1,9c2 <malloc+0x70>
    if (nu < 4096)
 988:	8a4e                	mv	s4,s3
 98a:	0009871b          	sext.w	a4,s3
 98e:	6685                	lui	a3,0x1
 990:	00d77363          	bgeu	a4,a3,996 <malloc+0x44>
 994:	6a05                	lui	s4,0x1
 996:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 99a:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 99e:	00000917          	auipc	s2,0x0
 9a2:	66a90913          	addi	s2,s2,1642 # 1008 <freep>
    if (p == (char *)-1)
 9a6:	5afd                	li	s5,-1
 9a8:	a895                	j	a1c <malloc+0xca>
        base.s.ptr = freep = prevp = &base;
 9aa:	00000797          	auipc	a5,0x0
 9ae:	66678793          	addi	a5,a5,1638 # 1010 <base>
 9b2:	00000717          	auipc	a4,0x0
 9b6:	64f73b23          	sd	a5,1622(a4) # 1008 <freep>
 9ba:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 9bc:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits)
 9c0:	b7e1                	j	988 <malloc+0x36>
            if (p->s.size == nunits)
 9c2:	02e48c63          	beq	s1,a4,9fa <malloc+0xa8>
                p->s.size -= nunits;
 9c6:	4137073b          	subw	a4,a4,s3
 9ca:	c798                	sw	a4,8(a5)
                p += p->s.size;
 9cc:	02071693          	slli	a3,a4,0x20
 9d0:	01c6d713          	srli	a4,a3,0x1c
 9d4:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 9d6:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 9da:	00000717          	auipc	a4,0x0
 9de:	62a73723          	sd	a0,1582(a4) # 1008 <freep>
            return (void *)(p + 1);
 9e2:	01078513          	addi	a0,a5,16
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
 9e6:	70e2                	ld	ra,56(sp)
 9e8:	7442                	ld	s0,48(sp)
 9ea:	74a2                	ld	s1,40(sp)
 9ec:	7902                	ld	s2,32(sp)
 9ee:	69e2                	ld	s3,24(sp)
 9f0:	6a42                	ld	s4,16(sp)
 9f2:	6aa2                	ld	s5,8(sp)
 9f4:	6b02                	ld	s6,0(sp)
 9f6:	6121                	addi	sp,sp,64
 9f8:	8082                	ret
                prevp->s.ptr = p->s.ptr;
 9fa:	6398                	ld	a4,0(a5)
 9fc:	e118                	sd	a4,0(a0)
 9fe:	bff1                	j	9da <malloc+0x88>
    hp->s.size = nu;
 a00:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 a04:	0541                	addi	a0,a0,16
 a06:	00000097          	auipc	ra,0x0
 a0a:	eca080e7          	jalr	-310(ra) # 8d0 <free>
    return freep;
 a0e:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 a12:	d971                	beqz	a0,9e6 <malloc+0x94>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 a14:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits)
 a16:	4798                	lw	a4,8(a5)
 a18:	fa9775e3          	bgeu	a4,s1,9c2 <malloc+0x70>
        if (p == freep)
 a1c:	00093703          	ld	a4,0(s2)
 a20:	853e                	mv	a0,a5
 a22:	fef719e3          	bne	a4,a5,a14 <malloc+0xc2>
    p = sbrk(nu * sizeof(Header));
 a26:	8552                	mv	a0,s4
 a28:	00000097          	auipc	ra,0x0
 a2c:	b7a080e7          	jalr	-1158(ra) # 5a2 <sbrk>
    if (p == (char *)-1)
 a30:	fd5518e3          	bne	a0,s5,a00 <malloc+0xae>
                return 0;
 a34:	4501                	li	a0,0
 a36:	bf45                	j	9e6 <malloc+0x94>
