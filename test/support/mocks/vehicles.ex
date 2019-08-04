defmodule VehiclesMock do
  use GenServer

  defstruct [:pid]
  alias __MODULE__, as: State

  # API

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: Keyword.fetch!(opts, :name))
  end

  def restart(name), do: GenServer.call(name, :restart)

  # Callbacks

  @impl true
  def init(opts) do
    {:ok, %State{pid: Keyword.fetch!(opts, :pid)}}
  end

  @impl true
  def handle_call(:restart, _from, %State{pid: pid} = state) do
    send(pid, {VehiclesMock, :restart})
    {:reply, :ok, state}
  end
end