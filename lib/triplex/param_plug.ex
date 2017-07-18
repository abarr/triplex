defmodule Triplex.ParamPlug do
  @moduledoc """
  This is a basic plug that loads the current tenant assign from a given
  param.

  To plug it on your router, you can use:

      plug Triplex.ParamPlug,
        param: :subdomain,
        tenant_handler: &TenantHelper.tenant_handler/1,
        callback: &TenantHelper.callback/2
        failure_callback: &TenantHelper.failure_callback/2

  See `Triplex.PlugConfig` to check all the allowed configuration flags.
  """

  import Triplex.Plug
  alias Triplex.PlugConfig

  @doc false
  def init(opts), do: PlugConfig.new(opts)

  @doc false
  def call(conn, config) do
    tenant = conn.params[config.param]

    conn
    |> put_tenant(tenant, config)
    |> ensure_tenant(tenant, config)
  end
end

