from fastapi.testclient import TestClient
from src.main import app
import pytest

client = TestClient(app)


def test_create_task_success():

#Task creation with valid input should return a task with an ID.

    payload = {"title": "Test Title", "done": False}
    response = client.post("/tasks", json=payload)

    assert response.status_code == 201
    data = response.json()
    print(data)
    assert "id" in data
    assert data["title"] == "Test Title"
    assert data["done"] is False


def test_create_task_validation():
    
#Task creation should fail when title is empty

    payload = {"title": "", "done": False}
    response = client.post("/tasks", json=payload)

    assert response.status_code == 422  # Validation error


def test_list_tasks_structure():

#Listing tasks should return a list of tasks with the correct structure.
    response = client.get("/tasks")
    assert response.status_code == 200

    data = response.json()
    assert isinstance(data, list)

    if data:  # Only check structure if tasks exist
        task = data[0]
        assert "id" in task
        assert "title" in task
        assert "done" in task
        assert isinstance(task["title"], str)
        assert isinstance(task["done"], bool)
