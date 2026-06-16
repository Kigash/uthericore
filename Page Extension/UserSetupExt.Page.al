pageextension 50810 "User Setup Ext" extends "User Setup"
{
    layout
    {
        addafter("Allow Posting To")
        {
            field("Employee No."; Rec."Employee No.")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
            field("User Name"; Rec."User Name")
            {
                ApplicationArea = All;
            }
            field(Signature; Rec.Signature)
            {
                ApplicationArea = All;
            }
            field("View Payroll"; Rec."View Payroll")
            {
                ApplicationArea = All;
            }
            field("View Companies"; Rec."View Companies")
            {
                ApplicationArea = All;
            }
            field("System Admin"; Rec."System Admin")
            {
                ApplicationArea = All;
            }
            field("Approve Board Payments"; Rec."Approve Board Payments")
            {
                ApplicationArea = All;
            }
            field("Pause Loan Charges"; Rec."Pause Loan Charges")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            if UserSetup."System Admin" = false then begin
                Error('You do not have permission to view this page');
            end;
        end;
    end;
}