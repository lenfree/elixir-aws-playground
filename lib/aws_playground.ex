defmodule AwsPlayground do
  alias ExAws.S3, as: S3
  alias ExAws.Route53, as: R53

  @moduledoc """
  Documentation for AwsPlayground.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AwsPlayground.hello
      :world

  """
  def hello do
    :world
  end

  def list_buckets do
    buckets =
      S3.list_buckets()
      |> ExAws.request!()

    buckets.body.buckets
    |> Enum.filter(fn x -> String.contains?(x.name, "lenfree") end)
    |> Enum.each(&IO.puts(&1.name))
  end

  def list_buckets_stream do
    buckets =
      S3.list_buckets()
      |> ExAws.request!()

    buckets.body.buckets
    |> Stream.filter(fn x -> String.contains?(x.name, "lenfree") end)
    |> Enum.each(&IO.puts(&1.name))
  end

  def list_hosted_zones do
    {:ok, hosted_zones} = R53.list_hosted_zones() |> ExAws.request(region: "us-east-1")
    hosted_zones.body.hosted_zones |> Enum.map(&IO.puts(&1.name <> " : " <> &1.id))
  end

  def get_records(id) do
    {:ok, records} = R53.list_record_sets(id) |> ExAws.request(region: "us-east-1")

    records.body.record_sets
    |> Stream.filter(fn x -> String.contains?(x.name, "feedback") end)
    |> Enum.each(&IO.puts(&1.name))
  end
end
