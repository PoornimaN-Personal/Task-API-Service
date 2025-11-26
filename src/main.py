
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
from typing import List

app = FastAPI()

## Define Schema

class Task(BaseModel):
    title: str = Field(..., min_length=1, max_length=100)
    done: bool = False

class TaskResponse(Task):
    id: int

## In-Memory Store

tasks: List[TaskResponse] = []
task_id_count = 1

#POST Endpoint

@app.post("/tasks", response_model=TaskResponse, status_code=201)

def create_task(task: Task):
    global task_id_count
    print(task.model_dump())
    new_task = TaskResponse(id=task_id_count, **task.model_dump())
    tasks.append(new_task)
    task_id_count += 1
    return new_task


@app.get("/tasks",response_model=List[TaskResponse])

def get_tasks():
    return tasks


