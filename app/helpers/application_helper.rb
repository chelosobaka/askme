module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def declension(number, krokodil, krokodila, krokodilov)
    if number == nil || !number.is_a?(Numeric)
      number = 0
    end

    arr = number.digits(100)
    if (11..20).include?(arr[0])
      return krokodilov
    end

    surplus = number % 10

    if surplus == 1
      return krokodil
    end
    if surplus >= 2 && surplus <= 4
      return krokodila
    end
    if (surplus >= 5 && surplus <= 9) || surplus == 0
      return krokodilov
    end
  end

  def questions_size(questions)
    if questions.nil?
      return 0
    else
      questions.size
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
