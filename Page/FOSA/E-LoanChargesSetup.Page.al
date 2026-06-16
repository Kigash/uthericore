page 50304 "E-Loan Charges Setup"
{
    PageType = List;
    SourceTable = "E-Loan Charges Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Min; Rec.Min)
                {
                    ApplicationArea = All;
                }
                field(Max; Rec.Max)
                {
                    ApplicationArea = All;
                }
                field("Safaricom Charge"; Rec."Safaricom Charge")
                {
                    ApplicationArea = All;
                }
                field("TL Charge"; Rec."TL Charge")
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

