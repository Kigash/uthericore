page 50201 "Member Loan Account Card"
{
    // version TL2.0

    Caption = 'Member Loan Account Card';
    PageType = Card;
    SourceTable = Customer;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
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
    var
        LoanApplication: Record "Loan Application";
}

