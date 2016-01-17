include_recipe "default"

[node[:ruby][:version], "#{node[:ruby][:version]}-dev"].each do |pkg|
  apt_package pkg do
    action :upgrade
  end
end
