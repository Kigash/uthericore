page 50702 "Procurement Plan Lines"
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = "Procurement Plan Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Plan No"; Rec."Plan No")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Current Budget"; Rec."Current Budget")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Source Of Funds"; Rec."Source Of Funds")
                {
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("G/L Name"; Rec."G/L Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Procurement Type"; Rec."Procurement Type")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Procurement Sub Type"; Rec."Procurement Sub Type")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit On Measure"; Rec."Unit On Measure")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = All;
                }
                field("Budget Amount"; Rec."Budget Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Committed Amount"; Rec."Committed Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Advertisement Date"; Rec."Advertisement Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Completion Date"; Rec."Expected Completion Date")
                {
                    ApplicationArea = All;
                }
                field("Procurement Method"; Rec."Procurement Method")
                {
                    ApplicationArea = All;
                }
                field("Distribution Type"; Rec."Distribution Type")
                {
                    ApplicationArea = All;
                }
                field("1st Quarter"; Rec."1st Quarter")
                {
                    ApplicationArea = All;
                }
                field("2nd Quarter"; Rec."2nd Quarter")
                {
                    ApplicationArea = All;
                }
                field("3rd Quarter"; Rec."3rd Quarter")
                {
                    ApplicationArea = All;
                }
                field("4th Quarter"; Rec."4th Quarter")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    trigger OnInit();
    begin
        IF ProcurementPlanHeader.GET(Rec."Plan No") THEN BEGIN
            //IF ProcurementPlanHeader."Budget Period" = ProcurementPlanHeader."Budget Period"::
        END;
    end;

    var
        CancelMessage: Label 'Page Closed';
        Quarterly: Boolean;
        ProcurementPlanHeader: Record "Procurement Plan Header";
}

