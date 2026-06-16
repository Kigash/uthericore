page 52000 "B2B Setup"
{
    PageType = List;
    SourceTable = "B2B setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("TL settlement AC"; Rec."TL settlement AC")
                {
                    ApplicationArea = All;
                }
                field("Coop settlement AC"; Rec."Coop settlement AC")
                {
                }
                field("Sacco settlement AC"; Rec."Sacco settlement AC")
                {
                    ApplicationArea = All;
                }
                field("TL Commission"; Rec."TL Commission")
                {
                    ApplicationArea = All;
                }
                field("Coop Commission"; Rec."Coop Commission")
                {
                    ApplicationArea = All;
                }
                field("Sacco Commission"; Rec."Sacco Commission")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax"; Rec."Withholding Tax")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax AC"; Rec."Withholding Tax AC")
                {
                    ApplicationArea = All;
                }
                field("Accounty Type"; Rec."Accounty Type")
                {
                    ApplicationArea = All;
                }
                field("Account Code"; Rec."Account Code")
                {
                    ApplicationArea = All;
                }
                field("B2B Bank"; Rec."B2B Bank")
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

