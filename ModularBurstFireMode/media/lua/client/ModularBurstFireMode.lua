local Burst = {}

function Burst.OnWeaponSwing(character,weapon)
    if weapon:getFireMode() ~= "modBurst" then return end

    character:setVariable("FireMode", weapon:getModData().modBurst_AnimFireMode or "Auto")
    character:setVariable("autoShootSpeed", (tonumber(weapon:getModData().modBurst_Speed) or 4) * GameTime.getAnimSpeedFix())
    character:setVariable("autoShootVarX", -9000)

end

function Burst.OnWeaponSwingHitPoint(character,weapon)
    if weapon:getFireMode() ~= "modBurst" then return end
    local data = weapon:getModData()
    data.modBurst_ShotsFired = (data.modBurst_ShotsFired or 0) + 1
end

function Burst.OnPlayerAttackFinished(character,weapon)
    if weapon:getFireMode() ~= "modBurst" then return end
    local data = weapon:getModData()

    if data.modBurst_ShotsFired > (data.modBurst_Shots or 3) then
        data.modBurst_ShotsFired = 0
        character:setRecoilDelay(data.modBurst_Delay or 10)
    end
end

Events.OnWeaponSwing.Add(Burst.OnWeaponSwing)
Events.OnWeaponSwingHitPoint.Add(Burst.OnWeaponSwingHitPoint)
Events.OnPlayerAttackFinished.Add(Burst.OnPlayerAttackFinished)
