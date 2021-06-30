defmodule Bonfire.UI.ValueFlows.ProcessHeroLive do
  use Bonfire.Web, :stateless_component
  alias Bonfire.Social.{Likes}

  prop process, :map


  def update(assigns, socket) do
    # IO.inspect(assigns.process.id)
    # my_like = Likes.liked?(assigns.__context__.current_user.character.id, assigns.process.id)
    # IO.inspect(Likes.liked?(assigns.__context__.current_user.character.id, assigns.process.id))
    tasks = e(assigns.process, :intended_outputs, [])

    tasks_total = Enum.count(tasks)

    tasks_completed =
      tasks
      |> Enum.filter(fn x -> x.finished end)
      |> Enum.count() # FIXME - get a count from DB query instead

    percentage = if tasks_total >0, do: ceil(tasks_completed / tasks_total * 100)

    {:ok, socket |>
      assigns_merge(assigns,
        process: assigns.process
          |> Map.put(:tasks_total, tasks_total)
          |> Map.put(:tasks_completed, tasks_completed)
          |> Map.put(:percentage, percentage)
      )
    }
  end

  def generate_test_template(assigns) do
    tasks = e(assigns.process, :intended_outputs, [])
    tests = Enum.map(tasks, &task_test_template(&1))

    """
  describe "#{assigns.process.name}"
  #{tests}

  end
    """

  end

  defp task_test_template(task) do

    """

    @tag :todo # remove the tag when starting work on this test
    test "#{task.name}" do


    end

    """

  end

end
