page 50214 "Loan Product Charges"
{
    // version TL2.0

    Caption = 'Loan Product Charges';
    PageType = List;
    SourceTable = "Loan Product Charge";
    AutoSplitKey = true;
    RefreshOnActivate = true;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = All;
                }

                field("Maximum Amount"; Rec."Maximum Amount")
                {
                    ApplicationArea = All;
                }

                field("Calculation Mode"; Rec."Calculation Mode")
                {
                    ApplicationArea = All;
                }
                field(Value; Rec.Value)
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

