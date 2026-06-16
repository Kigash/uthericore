page 50051 Charges
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = Charge;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Charge Code"; Rec."Charge Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Charge Amount"; Rec."Charge Amount")
                {
                    ApplicationArea = All;
                }

                field("Use Percentage"; Rec."Use Percentage")
                {
                    ApplicationArea = All;
                }
                field("Percentage of Amount"; Rec."Percentage of Amount")
                {
                    ApplicationArea = All;
                }
                field("GL Account"; Rec."GL Account")
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
                field("Deduct Excise"; Rec."Deduct Excise")
                {
                    ApplicationArea = All;
                }
                field("Excise %"; Rec."Excise %")
                {
                    ApplicationArea = All;
                }
                field("Excise G/L Account"; Rec."Excise G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                }
                field(Interbranch; Rec.Interbranch)
                {
                    ApplicationArea = All;
                }
                field("Settlement Amount"; Rec."Settlement Amount")
                {
                    ApplicationArea = All;
                }
                field("Settlement GL Account"; Rec."Settlement GL Account")
                {
                    ApplicationArea = All;
                }
                field(Mobile; Rec.Mobile)
                {
                    ApplicationArea = All;
                }
                field(Classified; Rec.Classified)
                {
                    ApplicationArea = All;
                }
                field("Stamp Duty"; Rec."Stamp Duty")
                {
                    ApplicationArea = All;
                }
                field("Stamp Duty G/L Account"; Rec."Stamp Duty G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Safaricom Account"; Rec."Safaricom Account")
                {
                    ApplicationArea = All;
                }
                field("Safaricom Amount"; Rec."Safaricom Amount")
                {
                    ApplicationArea = All;
                }
                field("Pinno Account"; Rec."Pinno Account")
                {
                    ApplicationArea = All;
                }
                field("Pinno Amount"; Rec."Pinno Amount")
                {
                    ApplicationArea = All;
                }
                field("Agent Store"; Rec."Agent Store")
                {
                    ApplicationArea = All;
                }
                field("Agent Settlement Amount"; Rec."Agent Settlement Amount")
                {
                    ApplicationArea = All;
                }
                field("Settlement Bank"; Rec."Settlement Bank")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
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

