function plugin_update
    for plugin in $plugins
        set --local plugin_name (path basename $plugin)
        set --local plugin_dir $_plugins_dir/$plugin_name

        if contains $plugin_name $plugins_pinned
            echo Skip updating (set_color --bold)$plugin_name(set_color normal)
            continue
        end

        echo Updating (set_color --bold)$plugin_name(set_color normal)

        git -C $plugin_dir pull --quiet

        for conf in $plugin_dir/conf.d/*.fish
            source $conf
            emit (path basename $conf | path change-extension '')_update
        end
    end
end
