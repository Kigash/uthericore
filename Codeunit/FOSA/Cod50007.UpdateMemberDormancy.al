codeunit 50007 UpdateMemberDormancy
{
    trigger OnRun()
    var
        Member: Record Member;
        Vend: Record Vendor;
        DVend: Record "Detailed Vendor Ledg. Entry";
        BosaM: Codeunit "BOSA Management";
    begin
        Member.Reset();
        if Member.FindSet() then begin
            repeat
                if (Member.Status = Member.Status::Active) or (Member.Status = Member.Status::Dormant) then begin
                    // Member.Status := Member.Status::Active;
                    //Member.Modify();

                    Vend.Reset();
                    Vend.SetRange(Vend."Member No.", Member."No.");
                    Vend.SetRange(Vend."Account Type", '02');
                    Vend.SetRange(Vend.Status, Vend.Status::Active);
                    if Vend.FindFirst() then begin
                        DVend.Reset();
                        DVend.SetRange(DVend."Vendor No.", Vend."No.");
                        DVend.SetFilter(DVend."Credit Amount", '>%1', 0);
                        If DVend.FindLast() then begin
                            if CalcDate('-3M', Today) = DVend."Posting Date" then begin
                                Vend.Status := Vend.Status::Dormant;
                                //if StrLen(Member."Phone No.") <= 20 then
                                // BosaM.SendDormancyNotification(Member);
                            end;
                        end;
                        DVend.Reset();
                        DVend.SetRange(DVend."Vendor No.", Vend."No.");
                        DVend.SetFilter(DVend."Credit Amount", '>%1', 0);
                        If not DVend.FindLast() then begin
                            if CalcDate('-3M', Today) = Member."Registration Date" then
                                Vend.Status := Vend.Status::Dormant;
                            //if StrLen(Member."Phone No.") <= 20 then
                            // BosaM.SendDormancyNotification(Member);
                        end;
                        Vend.Modify();
                    end;
                end;
            until Member.Next = 0;
        end;
    end;
}
