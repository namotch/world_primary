# -*- coding: utf-8 -*-

Plugin.create :world_primary do

  # 起動時に登録したアカウントに変更する
  onboot do |service|
    # 3.6.7 ではアカウント取得出来ないため、１秒だけ遅らせた
    # アカウントがロードされてから処理を実行する何かいい方法があれば教えて下さい
    Reserver.new(1) {
      world = Enumerator.new{|y| Plugin.filtering(:worlds, y) }.find{ |w|
        w.slug.to_sym == UserConfig[:world_primary_account].to_s.to_sym
      }
      Plugin.call(:world_change_current, world)
    }
  end

  # 設定画面
  settings _("起動アカウント") do
    select("起動時のアカウント", :world_primary_account) do
      Enumerator.new{|y| Plugin.filtering(:worlds, y) }.each do |world|
        option(world.slug, world.title)
      end
    end
  end

end
