local _, ns = ...

local feature = {
  key = "AutoRepair",
  name = "Automatically initiates gear repairs upon interacting with a merchant.",
  enabled = true,
  frame = nil,
  config = {}
}

tinsert(ns.Features, feature)

if feature.enabled then
  feature.frame = CreateFrame("Frame")
  feature.frame:RegisterEvent("MERCHANT_SHOW")

  feature.frame:SetScript("OnEvent", function(self, event)
    if IsShiftKeyDown() then return end
    if CanMerchantRepair() then
      local RepairCost, CanRepair = GetRepairAllCost()
      if RepairCost > 0 and GetMoney() >= RepairCost then
        RepairAllItems()
        print("Gear has been repaired.", string.format("(%s)", GetCoinText(RepairCost)))
      end
    end
  end)
end
