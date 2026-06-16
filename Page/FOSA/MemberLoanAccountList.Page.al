page 50202 "Member Loan Account List"
{
    // version TL2.0

    Caption = 'Member Loan Accounts';
    CardPageID = "Member Loan Account Card";
    PageType = List;
    SourceTable = Customer;
    SourceTableView = WHERE("Member No." = FILTER(<> ''));
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    Editable = false;
                    ApplicationArea = All;

                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Reporting)
        {
            group(Reports)
            {


                action(LoanStatement)
                {
                    Caption = 'Loan Statement';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        LoanApplication.FILTERGROUP(10);
                        LoanApplication.SETRANGE("Member No.", Rec."Member No.");
                        LoanApplication.SetRange("No.", Rec."No.");
                        LoanApplication.FILTERGROUP(0);
                        Report.RUN(50081, true, false, LoanApplication);
                    end;
                }

            }

        }
    }
    trigger OnAfterGetRecord()
    var
        Memb: Record Member;
    begin
        If Memb.Get(Rec."Member No.") then begin
            if Rec."Global Dimension 1 Code" = '' then begin
                Rec."Global Dimension 1 Code" := Memb."Global Dimension 1 Code";
                Rec.Modify();
            end;
        end;
    end;

    var
        LoanApplication: Record "Loan Application";
}
