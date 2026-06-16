page 50793 "Payment Terms List"
{
    PageType = ListPart;
    SourceTable = "Procurement Payment Terms";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Process No."; Rec."Process No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ApplicationArea = All;
                }
                field("Payment Option"; Rec."Payment Option")
                {
                    ApplicationArea = All;
                }
                field("Fixed Amount"; Rec."Fixed Amount")
                {
                    ApplicationArea = All;
                }
                field("Percentage On Cost"; Rec."Percentage On Cost")
                {
                    ApplicationArea = All;
                }
                field("Percentage Amount"; Rec."Percentage Amount")
                {
                    ApplicationArea = All;
                }
                field("LPO Generated"; Rec."LPO Generated")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("LPO No."; Rec."LPO No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate LPO")
            {
                Image = "Order";
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //CurrPage.SETSELECTIONFILTER(Rec);
                    //Rec.MARKEDONLY(TRUE);
                    ProcurementManagement.GenerateLPO(Rec);
                    //Rec. CLEARMARKS;
                end;
            }
        }
    }

    var
        ProcurementManagement: Codeunit "Procurement Management";
}

