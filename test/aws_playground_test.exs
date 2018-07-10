defmodule AwsPlaygroundTest do
  use ExUnit.Case
  doctest AwsPlayground

  test "greets the world" do
    assert AwsPlayground.hello() == :world
  end
end
