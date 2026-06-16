page 50177 "Vehicle Register card"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Vehicle Register";

    layout
    {
        area(content)
        {
            group("Vehicle Registry")
            {
                field("No."; Rec."No.")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Fixed Asset Car No."; Rec."Fixed Asset Car No.")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Responsible Driver"; Rec."Responsible Driver")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    TableRelation = "Driver Setup";
                }
                field(Insured; Rec.Insured)
                {
                    ApplicationArea = All;
                }
                field("Date of Insurance"; Rec."Date of Insurance")
                {
                    ApplicationArea = All;
                }
                field(Months; Rec.Months)
                {
                    ApplicationArea = All;
                }
                field("Insurance Expiry Date"; Rec."Insurance Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Number Plate"; Rec."Number Plate")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Chassis No"; Rec."Chassis No")
                {
                    ApplicationArea = All;
                }
                field("Body Type"; Rec."Body Type")
                {
                    ApplicationArea = All;
                }
                field(Colour; Rec.Colour)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Color; Rec.Color)
                {
                    ApplicationArea = All;
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                }
                field("Engine No"; Rec."Engine No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(YOM; Rec.YOM)
                {
                    ApplicationArea = All;
                    Caption = 'Year Of Manufacture-Year';
                }
                field("YOM-Month"; Rec."YOM-Month")
                {
                    ApplicationArea = All;
                    Caption = 'Year Of Manufacture-Month';
                }
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                }
                field(Booked; Rec.Booked)
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                }
                field("Condition of Vehicle"; Rec."Condition of Vehicle")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Add Vehicle to Registry")
            {
                Image = BookingsLogo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    AdminManagement.RegisterVehicle(Rec);
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    var
        AdminManagement: Codeunit "Admin Management";
}

