module LotteryHelper
  def list_awards(lottery)
    lottery.awards.map(&:name).join("\n")
  end

  def awards_map(lottery)
    lottery.awards.map { |award| award.name }
  end
end
