page 50600 "Cash Management Setup"
{
    // version TL2.0

    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "Cash Management Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Payment Template Name"; Rec."Payment Template Name")
                {
                    ApplicationArea = All;
                }
                field("Payment Batch Name"; Rec."Payment Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Receipt Template Name"; Rec."Receipt Template Name")
                {
                    ApplicationArea = All;
                }
                field("Receipt Batch Name"; Rec."Receipt Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Imprest Surr. Template Name"; Rec."Imprest Surr. Template Name")
                {
                    ApplicationArea = All;
                }
                field("Imprest Surr. Batch Name"; Rec."Imprest Surr. Batch Name")
                {
                    ApplicationArea = All;
                }
                field("PettyCash Template Name"; Rec."PettyCash Template Name")
                {
                    ApplicationArea = All;
                }
                field("PettyCash Batch Name"; Rec."PettyCash Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Checkoff Template Name"; Rec."Checkoff Template Name")
                {
                    ApplicationArea = All;
                }
                field("Checkoff Batch Name"; Rec."Checkoff Batch Name")
                {
                    ApplicationArea = All;
                }

                field("Payment Voucher Nos."; Rec."Payment Voucher Nos.")
                {
                    ApplicationArea = All;
                }
                field("Checkoff Receipt Voucher Nos."; Rec."Checkoff Receipt Voucher Nos.")
                {
                    ApplicationArea = All;
                }
                field("Checkoff Nos."; Rec."Checkoff Nos.")
                {
                    ApplicationArea = All;
                }
                field("Imprest Nos."; Rec."Imprest Nos.")
                {
                    ApplicationArea = All;
                }


                field("Imprest Surrender Nos."; Rec."Imprest Surrender Nos.")
                {
                    ApplicationArea = All;
                }
                field("Claim Nos."; Rec."Claim Nos.")
                {
                    ApplicationArea = All;
                }
                field("PettyCash Nos."; Rec."PettyCash Nos.")
                {
                    ApplicationArea = All;
                }
                field("Payroll NetPay Transfer Nos."; Rec."Payroll NetPay Transfer Nos.")
                {
                    ApplicationArea = All;
                }
                field("Receipt Voucher Nos."; Rec."Receipt Voucher Nos.")
                {
                    ApplicationArea = All;
                }
                field("Salary Advance"; Rec."Salary Advance")
                {
                    ApplicationArea = All;
                }

                field("Imprest Path"; Rec."Imprest Path")
                {
                    ApplicationArea = All;
                }
                field("PettyCash Bank"; Rec."PettyCash Bank")
                {
                    ApplicationArea = All;
                }
                field("Budget Admin"; Rec."Budget Admin")
                {
                    ApplicationArea = All;
                }
                field("Use Budget"; Rec."Use Budget")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    actions
    {
    }
    trigger OnOpenPage()
    begin
        CashManagementSetup.Reset();
        if not CashManagementSetup.FindFirst then begin
            if CashManagementSetup."Budget Admin" = '' then begin
                CashManagementSetup."Budget Admin" := UserId;
                CashManagementSetup.Insert();
                Message('Success!');
            end;
        end;
    end;

    var
        CashManagementSetup: Record "Cash Management Setup";
}

