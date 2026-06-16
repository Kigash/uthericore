page 50400 "Employee Card TL"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Employee;
    Caption = 'Employee Card';

    layout
    {
        area(Content)
        {
            group("Personal Information")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field(Disability; Rec.Disability)
                {
                    ApplicationArea = All;
                }
                field("Blood Type"; Rec."Blood Type")
                {
                    ApplicationArea = All;
                }
                field(Religion; Rec.Religion)
                {
                    ApplicationArea = All;
                }
                field(Tribe; Rec.Tribe)
                {
                    ApplicationArea = All;
                }
            }
            group("Job Information")
            {
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.Testfield("Employment Date");
                    end;
                }
                field("Employee Status"; Rec."Employee Status")
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                }
                field("Probation Period"; Rec."Probation Period")
                {
                    ApplicationArea = All;
                }

                field("Confirmation/Dismissal Date"; Rec."Confirmation/Dismissal Date")
                {
                    Caption = 'Confirmation Date';
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field("Staff Category"; Rec."Staff Category")
                {
                    ApplicationArea = All;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ApplicationArea = All;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Caption = 'Work Phone';
                    ApplicationArea = All;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = All;
                }
            }
            group("Statutory Information")
            {
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = All;
                }
                field("KRA PIN"; Rec."PIN Number")
                {
                    ApplicationArea = All;
                }
                field(NSSF; Rec.NSSF)
                {
                    ApplicationArea = All;
                }
                field(NHIF; Rec.NHIF)
                {
                    ApplicationArea = All;
                }
                field("HELB No."; Rec."HELB No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = All;
                }
            }
            group("Contact Information")
            {
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    Caption = 'Town';
                    ApplicationArea = All;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Resident(Estate)"; Rec."Resident(Estate)")
                {
                    ApplicationArea = All;
                }
                field("Street Address/Court"; Rec."Street Address/Court")
                {
                    ApplicationArea = All;
                }
                field("House No."; Rec."House No.")
                {
                    ApplicationArea = All;
                }

            }
            group("Professional Membership")
            {
                field("Union Code"; Rec."Union Code")
                {
                    ApplicationArea = All;
                }
                field("Union Membership No."; Rec."Union Membership No.")
                {
                    ApplicationArea = All;
                }
            }
            group("Probation Information")
            {

                field("Probation Start Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field("Probation Duration"; Rec."Probation Period")
                {
                    ApplicationArea = All;
                }
                field("Probation End Date"; Rec."Probation End Date")
                {
                    ApplicationArea = All;
                }
            }
            group("Clearance Details")
            {
                field("Certificate No."; Rec."Certificate No.")
                {
                    ApplicationArea = All;
                }
                field("Date of Certificate"; Rec."Date of Certificate")
                {
                    ApplicationArea = All;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = All;
                }
            }
            group(Confirmation)
            {
                field("Confirmation Status"; Rec."Confirmation Status")
                {
                    ApplicationArea = All;
                }
                field("Confirmation_Dismissal Date"; Rec."Confirmation/Dismissal Date")
                {
                    ApplicationArea = All;
                }
                field("Defer Confirmation"; Rec."Defer Confirmation")
                {
                    ApplicationArea = All;
                }
                field("Extension Duration"; Rec."Extension Duration")
                {
                    ApplicationArea = All;
                }
                field("Defer Start Date"; Rec."Defer Start Date")
                {
                    ApplicationArea = All;
                }
                field("Defer End Date"; Rec."Defer End Date")
                {
                    ApplicationArea = All;
                }
            }
        }

        area(factboxes)
        {
            part(Control3; "Employee Picture")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = field("No.");
            }
            part(Control4; "Employee Front ID")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = field("No.");
            }
            part(Control5; "Employee Back ID")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = field("No.");
            }
            part(Control6; "Employee Signature")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = field("No.");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(5200), "No." = field("No.");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }



    actions
    {
        area(Processing)
        {


            action("&Relatives")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Relatives';
                Image = Relatives;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Employee Relatives";
                RunPageLink = "Employee No." = field("No.");
                ToolTip = 'Open the list of relatives that are registered for the employee.';
            }
            action("Mi&sc. Article Information")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Mi&sc. Article Information';
                Image = Filed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Misc. Article Information";
                RunPageLink = "Employee No." = field("No.");
                ToolTip = 'Open the list of miscellaneous articles that are registered for the employee.';
            }
            action("&Confidential Information")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Confidential Information';
                Image = Lock;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Confidential Information";
                RunPageLink = "Employee No." = field("No.");
                ToolTip = 'Open the list of any confidential information that is registered for the employee.';
            }
            action("Q&ualifications")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Q&ualifications';
                Image = Certificate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Employee Qualifications";
                RunPageLink = "Employee No." = field("No.");
                ToolTip = 'Open the list of qualifications that are registered for the employee.';
            }

            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal;
                end;
            }


        }
    }
    var
        SeeProbation: Boolean;

}