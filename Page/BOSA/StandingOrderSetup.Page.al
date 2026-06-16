page 50184 "Standing Order Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Standing Order Setup";
    UsageCategory = Administration;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {

                field("Standing Order Nos."; Rec."Standing Order Nos.")
                {
                    ApplicationArea = All;
                }
            }
            group(Charges)
            {

                field("Charge Transaction"; Rec."Charge Transaction")
                {
                    ApplicationArea = All;
                }
                field("Charges Calculation Method"; Rec."Charges Calculation Method")
                {
                    ApplicationArea = All;
                }
                field("Charges Value"; Rec."Charges Value")
                {
                    ApplicationArea = All;
                }

                field("Charges G/L Account"; Rec."Charges G/L Account")
                {
                    ApplicationArea = All;
                }
            }


            group(Penalty)
            {
                Caption = 'Penalty';
                field("Charge Penalty"; Rec."Charge Penalty")
                {
                    ApplicationArea = All;
                }
                field("Penalty Calculation Method"; Rec."Penalty Calculation Method")
                {
                    ApplicationArea = All;
                }
                field("Penalty Value"; Rec."Penalty Value")
                {
                    ApplicationArea = All;
                }
                field("Penalty G/L Account"; Rec."Penalty G/L Account")
                {
                    ApplicationArea = All;
                }

            }
            group(Notification)
            {
                Caption = 'Notification';
                field("Notify Source Member"; Rec."Notify Source Member")
                {
                    ApplicationArea = All;
                }
                field("Source SMS Template"; Rec."Source SMS Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Source Email Template"; Rec."Source Email Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Notify Destination Member"; Rec."Notify Destination Member")
                {
                    ApplicationArea = All;
                }
                field("Destination SMS Template"; Rec."Destination SMS Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Destination Email Template"; Rec."Destination Email Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Notification Channel"; Rec."Notification Channel")
                {
                    ApplicationArea = All;
                }
            }


            group(Posting)
            {
                field("Standing Order Template Name"; Rec."Standing Order Template Name")
                {
                    ApplicationArea = All;
                }
                field("Standing Order Batch Name"; Rec."Standing Order Batch Name")
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

