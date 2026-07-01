codeunit 50914 "Update Usersetup Posting To"
{
    var
        Usersetup: Record "User Setup";

    trigger OnRun()
    begin
        Usersetup.Reset();
        if Usersetup.FindSet() then begin
            repeat
                Usersetup."Allow Posting To" := Today;
                Usersetup.Modify();
            until Usersetup.Next = 0;
        end;
    end;

}
