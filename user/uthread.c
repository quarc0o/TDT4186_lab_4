#include "kernel/types.h"
#include "user.h"
#include "stddef.h"
#define LIB_PREFIX "[UTHREAD]: "
#define ulog() printf("%s%s\n", LIB_PREFIX, __FUNCTION__)

static struct thread *threads[16];
static struct thread *current_thread;

void tsched()
{
    // TODO: Implement a userspace round robin scheduler that switches to the next thread

    int current_index = 0;
    for (int i = 0; i < 16; i++) {
        if (threads[i] == current_thread) {
            current_index = i;
            break;
        }
    }

    struct thread *next_thread = NULL;
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
        tswtch(&prev_thread->tcontext, &current_thread->tcontext);
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
    //(*thread)->next = 0;
    //(*thread)->tid = func;
}

int tjoin(int tid, void *status, uint size)
{
    // TODO: Wait for the thread with TID to finish. If status and size are non-zero,
    // copy the result of the thread to the memory, status points to. Copy size bytes.
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
    return 0;
}
