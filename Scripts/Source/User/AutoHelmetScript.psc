{ MIT License
; Copyright (c) 2017 Oskar Sveinsen
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.
}

Scriptname AutoHelmetScript extends Quest
{Automatically equip and unequip the player's helmet according to the combat state.}

Keyword Property HelmetKeyword Auto Const Mandatory
{indicates that the item is a helmet}
Keyword Property AutoHelmetKeyword Auto Const Mandatory
{links the helmet to be equipped and unequipped automatically}

event OnInit()
	Actor player = Game.GetPlayer()
	self.RegisterForRemoteEvent(player, "OnItemEquipped")
	self.RegisterForRemoteEvent(player, "OnItemUnequipped")
	self.RegisterForRemoteEvent(player, "OnCombatStateChanged")
endevent

event Actor.OnItemEquipped(Actor akSender, Form akBaseObject, ObjectReference akReference)
	if (akReference.HasKeyword(HelmetKeyword))
		akSender.SetLinkedRef(akReference, AutoHelmetKeyword)
	endif
endevent

event Actor.OnItemUnequipped(Actor akSender, Form akBaseObject, ObjectReference akReference)
	if (akReference.HasKeyword(HelmetKeyword))
		akSender.SetLinkedRef(akReference, AutoHelmetKeyword)
	endif
endevent

event Actor.OnCombatStateChanged(Actor akSender, Actor akTarget, int aeCombatState)
	ObjectReference helmet = akSender.GetLinkedRef(AutoHelmetKeyword)
	if (helmet != NONE)
		if (akSender.GetCombatState() == 0)
			akSender.UnequipItem(helmet)
		else
			akSender.EquipItem(helmet)
		endif
	endif
endevent
