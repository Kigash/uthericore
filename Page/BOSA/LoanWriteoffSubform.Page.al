page 50327 "Loan Writeoff Subform"
{
    // version TL2.0

    AutoSplitKey = true;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Loan Writeoff Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = All;
                }
                field("Total Arrears"; Rec."Total Arrears")
                {
                    ApplicationArea = All;
                }
                field("No. of Days in Arrears"; Rec."No. of Days in Arrears")
                {
                    ApplicationArea = All;
                }
                field("No. of Installment Defaulted"; Rec."No. of Installment Defaulted")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

