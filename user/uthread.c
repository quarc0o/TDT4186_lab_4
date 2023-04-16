#include "kernel/types.h"
#include "user.h"
#include "stddef.h"
#define LIB_PREFIX "[UTHREAD]: "
#define ulog() printf("%s%s\n", LIB_PREFIX, __FUNCTION__)

struct thread *threads[16];
struct thread *current_thread;

static int next_tid = 1;

void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread
    struct thread *next_thread = NULL;
    int current_index = 0;
    for (int i = 1; i < 16; i++) {
        int next_index = (current_index + i) % 16;
        if (threads[next_index] && threads[next_index]->state == RUNNABLE) {
            next_thread = threads[next_index];
            break;
        }
    }

    for (int i = 0; i < 16; i++) {
        if ((current_index + i) > 16) {
            break;
        }
        if (threads[current_index + i]->state != RUNNABLE) {
            break;
        }
        next_thread = threads[current_index + i];
        break;
    }

    if (next_thread) {
        struct thread *prev_thread = current_thread;
        current_thread = next_thread;
        printf("Switching from thread %d to thread %d\n", prev_thread->tid, current_thread->tid);
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
        printf("Thread switch complete\n");
    }
}

void tcreate(struct thread **thread, struct thread_attr *attr, void *(*func)(void *arg), void *arg)
{
    // TODO: Create a new process and add it as runnable, such that it starts running
    // once the scheduler schedules it the next time

    // Allocate memory for the thread
    *thread = (struct thread *)malloc(sizeof(struct thread));


    (*thread)->state = RUNNABLE;
    (*thread)->func = func;
    (*thread)->arg = arg;
    (*thread)->tid = next_tid;
    next_tid += 1;
    for (int i = 0; i < 16; i++) {
    if (threads[i] == NULL) {
        threads[i] = *thread;
        printf("Thread %d created and added to scheduler\n", (*thread)->tid);
        break;
    }
}

}

int tjoin(int tid, void *status, uint size)
{
    struct thread *target_thread = NULL;
    for (int i = 0; i < 16; i++) {
        if (threads[i] && threads[i]->tid == tid) {
            target_thread = threads[i];
            break;
        }
    }

    if (!target_thread) {
        return -1;
    }

    while (target_thread->state != EXITED) {
        printf("Waiting for thread %d to exit\n", target_thread->tid);
        tsched();
    }


    /* if (status && size > 0) {
        memcpy(status, target_thread->tcontext.sp, size);
    } */

    return 0;
}


void tyield()
{
    // TODO: Implement the yielding behaviour of the thread
    current_thread->state = RUNNABLE;
    tsched();
}

uint8 twhoami()
{
    // TODO: Returns the thread id of the current thread
    return current_thread->tid;
    return 0;
}
